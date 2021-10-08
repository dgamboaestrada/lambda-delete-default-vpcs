---
AWS delete defaults
---
Delete AWS resouces by default.

Resources soported:
- VPC

# Requirements
- [Terraform](https://www.terraform.io/)

# Setup
1. Clone the project
```bash
git clone git@github.com:dgamboaestrada/aws-delete-defaults.git
```
2. Enter to the project
```bash
cd aws-delete-defaults
```
3. Init terraform
```bash
terraform init
```
4. Create AWS resources
```bash
terraform apply
```

# Testing lambda

## Using Docker
Go to lambda dir:
```bash
cd delete-defaults/vpc/lambda/
```
Run lambda container:
```bash
docker run --rm --name lambda -p 9000:8080 --env-file=.env --volume=$PWD:/var/task public.ecr.aws/lambda/python:3.8 app.handler
```
Execute the lambda code:
```bash
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

## Using python venvs
Go to lambda dir:
```bash
cd delete-defaults/vpc/lambda/
```
Create the venv and activate it.
```bash
python3 -m venv env
pip install -r requirements.txt
source env/bin/activate
```
Execute the lambda code:
```
python -c "import app; app.handler(None,None)"
```
