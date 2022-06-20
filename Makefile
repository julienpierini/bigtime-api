deploy:
	@if [ ! -f "/usr/bin/terraform" ]; then \
		echo "Getting terraform"; \
		sudo apt install unzip wget; \
		wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip -O terraform.zip; \
		sudo unzip -d /usr/bin -o terraform.zip; \
		sudo rm terraform.zip; \
	fi
	@echo "Initialize backend"
	@cd terraform; terraform init
	@echo "Deploying the bigtime API"
	@cd terraform;terraform apply -auto-approve
destroy:
	@echo "Removal of all deployed resources"
	@cd terraform; terraform destroy --auto-approve