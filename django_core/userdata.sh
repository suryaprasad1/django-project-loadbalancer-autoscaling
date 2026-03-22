#!/bin/bash
set -e

# Replace {YOUR_GIT_REOPO_URL} with your actual Git repository URL
#GIT_REPO_URL="https://github.com/codewithmuh/django-aws-ec2-autoscaling.git"
#git@github.com:suryaprasad1/django-project-loadbalancer-autoscaling.git
##GIT_REPO_URL="https://suryaprasad1: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@github.com/codewithmuh/django-aws-ec2-autoscaling.git"
#GIT_REPO_URL="https://suryaprasad1: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git@github.com:suryaprasad1/django-project-loadbalancer-autoscaling.git"

# Replace {YOUR_PROJECT_MAIN_DIR_NAME} with your actual project directory name
PROJECT_MAIN_DIR_NAME="django-aws-ec2-autoscaling"

# Clone repository
git clone "$GIT_REPO_URL" "/home/ubuntu/$PROJECT_MAIN_DIR_NAME"

cd "/home/ubuntu/$PROJECT_MAIN_DIR_NAME"

# Make all .sh files executable
chmod +x scripts/*.sh

# Execute scripts for OS dependencies, Python dependencies, Gunicorn, Nginx, and starting the application
./scripts/instance_os_dependencies.sh
./scripts/python_dependencies.sh
./scripts/gunicorn.sh
./scripts/start_app.sh