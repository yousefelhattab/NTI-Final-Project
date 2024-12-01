
---

# NTI Project

This project automates the deployment of a cloud-based application using **Docker**, **Terraform**, **Kubernetes (EKS)**, **Jenkins**, and **AWS Services**.

### Overview
- **Docker**: Containerizes frontend and backend applications.
- **Terraform**: Automates infrastructure setup on **AWS** (EKS, VPC, IAM, S3, ECR).
- **Kubernetes (EKS)**: Orchestrates containers on **AWS EKS** for scalable and managed deployments.
- **Jenkins**: Automates the **CI/CD pipeline** for building Docker images, pushing them to ECR, and deploying to EKS.

### Setup Instructions

1. **Deploy AWS Resources** with Terraform:
   ```bash
   terraform init
   terraform apply
   ```

2. **Build Docker Images** for frontend and backend:
   ```bash
   docker build -t nti-project-frontend ./frontend
   docker build -t nti-project-backend ./backend
   ```

3. **Push Docker Images to ECR**:
   ```bash
   docker push <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/nti-project-frontend
   docker push <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/nti-project-backend
   ```

4. **Deploy to Kubernetes (EKS)**:
   ```bash
   kubectl apply -f kubernetes/
   ```

5. **Run Jenkins Pipeline**: The pipeline automates the build, push, and deployment process on every GitHub push, deploying to **AWS EKS**.

---

