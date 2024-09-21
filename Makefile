ENVIRONMENT ?= dev
COMPANY_NAME ?= mycompany

S3_BUCKET_NAME = $(COMPANY_NAME)-$(ENVIRONMENT)-terraform-state
DYNAMO_DB_TABLE_NAME = $(COMPANY_NAME)-$(ENVIRONMENT)-terraform-state-lock
AWS_REGION = eu-west-1

bootstrap-backend:
	cd bootstrap/backend && \
    terraform init && \
	terraform apply -var="aws_region=$(AWS_REGION)" -var="s3_bucket_name=$(S3_BUCKET_NAME)" -var="dynamodb_table_name=$(DYNAMO_DB_TABLE_NAME)" -auto-approve && \
	rm -rf .terraform* && \
	rm -rf terraform.tfstate*


create-or-update-deployment:
	cd deployments/$(ENVIRONMENT) && \
	echo 'bucket = "$(S3_BUCKET_NAME)"\nregion = "$(AWS_REGION)"\ndynamodb_table = "$(DYNAMO_DB_TABLE_NAME)"\nencrypt = true' > backend.hcl && \
	terraform init -upgrade -backend-config=./backend.hcl && \
	terraform apply -var="aws_region=$(AWS_REGION)" -var="company_name=$(COMPANY_NAME)" -auto-approve

destroy-deployment:
	cd deployments/$(ENVIRONMENT) && \
	terraform destroy -auto-approve && \
	rm -rf .terraform* && \
	rm -rf terraform.tfstate*
