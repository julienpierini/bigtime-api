deploy:
	@echo "Getting terraform"
	@cd terraform
	@sudo apt get install unzip wget
	@wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip -O terraform.zip
	@unzip -o terraform.zip
	@rm terraform.zip
	@sudo mv terraform /usr/bin/terraform
	@chmod +x /usr/bin/terraform
	@echo "Initialize backend"
	@terraform init
	@echo "Deploying the API"
	@terraform deploy --auto-approve
destroy:
	@echo "Removal of all deployed resources"
	@cd terraform
	@terraform destroy --auto-approve