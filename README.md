# SimpleTimeService - Application & Infrastructure Setup

## 📌 Overview
SimpleTimeService is a containerized application that provides timestamp-related functionalities. This guide covers both **Application Development** and **Infrastructure Setup** using Terraform.

---

# Application Development

## 📁 Project Structure
```
SimpleTimeService/
│── src/
│   ├── server.js
│── package.json
│── Dockerfile
│── .dockerignore
│── .env
│── README.md
```

## 📌 Application Dependencies
The project uses **Node.js** with the following dependencies:

```json
{
  "name": "simpletimeservice",
  "version": "1.0.0",
  "description": "A simple timestamp service",
  "main": "node src/server.js",
  "scripts": {
    "start": "node src/server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "moment": "^2.29.4"
  }
}
```

## 📌 Running Locally
1. Install dependencies:
   ```sh
   npm install
   ```
2. Start the application:
   ```sh
   npm start
   ```
3. Access the service at:
   ```
   http://localhost:3000/timestamp
   ```

## 📌 Dockerization
1. **Build the Docker image:**
   ```sh
   docker build -t simpletimeservice .
   ```
2. **Run the container:**
   ```sh
   docker run -p 3000:3000 simpletimeservice
   ```

3. **Push to DockerHub** (Optional):
   ```sh
   docker tag simpletimeservice your-dockerhub-username/simpletimeservice:latest
   docker push your-dockerhub-username/simpletimeservice:latest
   ```

---

# Terraform Infrastructure Setup

## 📌 Infrastructure Overview
We will deploy the **SimpleTimeService** on **AWS ECS (Fargate)** using Terraform.

### 🔹 Infrastructure Components
- **VPC** with 2 public and 2 private subnets
- **ECS Cluster (Fargate)** for running the container
- **Application Load Balancer (ALB)** for public access
- **Security Groups** for controlled access

## 📁 Terraform Repository Structure
```
terraform-ecs/
│── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ecs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── security/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│── main.tf
│── variables.tf
│── outputs.tf
│── terraform.tfvars
│── provider.tf
│── README.md
```

## 📌 Terraform Setup Steps

### 1️⃣ Install Terraform
Download and install Terraform from: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

### 2️⃣ Initialize Terraform
```sh
terraform init
```

### 3️⃣ Validate Configuration
```sh
terraform validate
```

### 4️⃣ Plan Changes
```sh
terraform plan
```

### 5️⃣ Deploy Infrastructure
```sh
terraform apply -auto-approve
```

### 6️⃣ Destroy Infrastructure (if needed)
```sh
terraform destroy -auto-approve
```

## 📌 Outputs
After deployment, Terraform will output:
- **VPC ID**
- **ECS Cluster Name**
- **ALB DNS Name** (Public URL to access the service)

Use the **ALB DNS** to access your deployed service:
```sh
http://alb-dns-name/timestamp
```

---
