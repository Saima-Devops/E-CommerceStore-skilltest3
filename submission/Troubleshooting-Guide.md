# 🔧 Troubleshooting Guide

This section documents common issues encountered during containerization, image publishing, Terraform provisioning, and AWS deployment, along with their solutions.

---

## Issue 1: Docker Build Fails

### Error

```bash
npm ERR! missing script: start
```

### Cause

The `package.json` file does not contain a valid `start` script.

### Solution

Verify the scripts section in `package.json`:

```json
{
  "scripts": {
    "start": "node server.js"
  }
}
```

Rebuild the image:

```bash
docker build -t user-service:v1 .
```

---

## Issue 2: Docker Container Exits Immediately

### Error

```bash
docker ps -a
```

Shows:

```text
Exited (1)
```

### Cause

Application startup failure or missing dependencies.

### Solution

Inspect container logs:

```bash
docker logs <container-id>
```

Verify:

* Environment variables
* Application port configuration
* Dependency installation

---

## Issue 3: Unable to Push Images to Docker Hub

### Error

```bash
denied: requested access to the resource is denied
```

### Cause

Docker authentication failed or incorrect repository name.

### Solution

Login again:

```bash
docker login
```

Verify image tags:

```bash
docker images
```

Correct format:

```bash
docker tag user-service:v1 saim2026/e-commercestore:user-service-v1
```

Push again:

```bash
docker push saim2026/e-commercestore:user-service-v1
```

---

## Issue 4: Terraform Init Fails

### Error

```bash
Failed to query available provider packages
```

### Cause

Internet connectivity issue or Terraform provider download failure.

### Solution

Verify internet access:

```bash
ping google.com
```

Retry:

```bash
terraform init -upgrade
```

---

## Issue 5: Terraform Apply Fails

### Error

```bash
InvalidKeyPair.NotFound
```

### Cause

Specified EC2 key pair does not exist in AWS.

### Solution

Verify available key pairs:

AWS Console → EC2 → Key Pairs

Update:

```hcl
terraform.tfvars
```

```hcl
key_name = "your-valid-keypair"
```

Run:

```bash
terraform apply
```

---

## Issue 6: EC2 Instance Created but Containers Not Running

### Cause

User data script execution failed.

### Solution

SSH into EC2:

```bash
ssh -i key.pem ubuntu@PUBLIC_IP
```

Check cloud-init logs:

```bash
sudo cat /var/log/cloud-init-output.log
```

Check Docker service:

```bash
sudo systemctl status docker
```

Restart Docker if required:

```bash
sudo systemctl restart docker
```

---

## Issue 7: Frontend Not Accessible

### Symptoms

Browser displays:

```text
This site can't be reached
```

### Possible Causes

* Docker container not running
* Security Group port blocked
* Application listening on wrong port

### Solution

Verify running containers:

```bash
docker ps
```

Verify listening ports:

```bash
sudo netstat -tulpn
```

Verify Security Group:

```text
Inbound Rules

3000/TCP → 0.0.0.0/0
```

Test locally:

```bash
curl localhost:3000
```

---

## Issue 8: Backend Services Not Responding

### Error

```bash
curl localhost:3001
```

Returns:

```text
Connection refused
```

### Solution

Verify container status:

```bash
docker ps
```

Check logs:

```bash
docker logs user-service
```

Verify port mapping:

```bash
docker inspect user-service
```

Expected:

```text
3001:3001
```

---

## Issue 9: Docker Image Pull Fails on EC2

### Error

```bash
manifest unknown
```

### Cause

Image tag does not exist on Docker Hub.

### Solution

Verify image availability:

```bash
docker pull saim2026/e-commercestore:user-service-v1
```

Ensure the exact tag exists in Docker Hub.

---

## Issue 10: Terraform Output Does Not Show Public IP

### Cause

EC2 instance creation failed or state file not updated.

### Solution

Refresh Terraform state:

```bash
terraform refresh
```

Check resources:

```bash
terraform state list
```

Retrieve output again:

```bash
terraform output
```

---

## Useful Verification Commands

### Check Terraform Resources

```bash
terraform state list
```

### Check Docker Containers

```bash
docker ps -a
```

### Check Docker Images

```bash
docker images
```

### Check EC2 Public IP

```bash
terraform output public_ip
```

### Check Frontend Accessibility

```bash
curl http://PUBLIC_IP:3000
```

### Check Backend Services

```bash
curl http://PUBLIC_IP:3001
curl http://PUBLIC_IP:3002
curl http://PUBLIC_IP:3003
curl http://PUBLIC_IP:3004
```

---

## Lessons Learned

During this project, the following DevOps concepts were reinforced:

* Docker image creation and optimization
* Container lifecycle management
* Docker Hub image publishing
* Infrastructure as Code using Terraform
* AWS networking (VPC, Subnets, Security Groups)
* EC2 provisioning and bootstrapping
* Automated application deployment using User Data scripts
* Infrastructure troubleshooting and operational validation

----

## Author
**Saima Usman** \
Jr. DevOps & Cloud Engineer 

----
