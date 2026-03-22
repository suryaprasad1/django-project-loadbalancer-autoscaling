# 🚀 Deploy Django App on AWS using EC2 + Auto Scaling + Load Balancer + Route53

<img width="1024" height="1536" alt="image" src="https://github.com/user-attachments/assets/6f3a6105-647c-4685-8fec-896023afbe82" />


## 📌 Architecture Overview

* EC2 (Django App)
* Launch Template
* Target Group
* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* Route53 (DNS)

---

# 🧩 Step 1: Prepare Django App (on EC2)

### Install dependencies

```bash
sudo apt update
sudo apt install python3-pip python3-venv nginx -y
```

### Setup project

```bash
git clone <your-repo>
cd project
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Run with Gunicorn

```bash
gunicorn django_core.wsgi:application --bind 0.0.0.0:8000
```

---

# 🧩 Step 2: Create AMI

1. Go to EC2 → Instances
2. Select configured instance
3. Click **Create Image (AMI)**

---

# 🧩 Step 3: Create Launch Template

1. Go to EC2 → Launch Templates → Create
2. Select AMI
3. Instance type: t2.micro
4. Key pair
5. Security group:

   * Allow 8000 (or 80)
6. Add **User Data**:

```bash
#!/bin/bash
cd /home/ubuntu/project
source venv/bin/activate
nohup gunicorn django_core.wsgi:application --bind 0.0.0.0:8000 &
```

---

# 🧩 Step 4: Create Target Group

1. Go to EC2 → Target Groups
2. Target type: Instances
3. Protocol: HTTP
4. Port: 8000
5. Health check path: `/`

---

# 🧩 Step 5: Create Application Load Balancer

1. Go to EC2 → Load Balancers → Create ALB
2. Scheme: Internet-facing
3. Listener: HTTP (80)
4. Select subnets
5. Security Group:

   * Allow HTTP (80)
6. Attach Target Group

---

# 🧩 Step 6: Create Auto Scaling Group

1. Go to EC2 → Auto Scaling Groups → Create
2. Select Launch Template
3. Choose VPC & Subnets
4. Attach Load Balancer
5. Set capacity:

   * Desired: 2
   * Min: 1
   * Max: 3

---

# 🧩 Step 7: Configure Scaling Policy

1. Add policy
2. Target tracking:

   * CPU Utilization 50%

---

# 🧩 Step 8: Configure Route53

1. Go to Route53 → Hosted Zones
2. Create domain (or use existing)
3. Create record:

   * Type: A
   * Alias → ALB DNS

---

# 🧩 Step 9: Verify Deployment

* Open Load Balancer DNS
* Check app running
* Check Target Group → Healthy

---

# 🔥 Troubleshooting

### Target Unhealthy

* Check port (8000)
* Check security group
* Check gunicorn running

### 502 Error

* App not running
* Wrong path

---

# ✅ Best Practices

* Use Nginx + Gunicorn
* Use HTTPS (ACM + ALB)
* Store secrets in .env
* Enable CloudWatch monitoring

---

# 🎯 Outcome

Highly available Django app with:

* Load balancing
* Auto scaling
* Domain routing

---

<img width="1905" height="1523" alt="django-loadbalancer-project-2077564480 us-east-1 elb amazonaws com_8000_" src="https://github.com/user-attachments/assets/d519fe62-75f8-418e-a3fd-868312838e7b" />



**Author: Surya Prasad**
