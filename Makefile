infra:
	git pull
	rm -f .terraform/terraform.tfstate
	terraform init
	terraform apply -auto-approve

ansible:
	git pull
	ansible-playbook -i $(tool_name)-internal.devopsbymanju.shop, tool-setup.yaml -e ansible_user=ec2-user \
	-e ansible_password=DevOps321 -e tool_name=$(tool_name)
	#ansible-playbook -i $(tool_name).devopsbymanju.shop, tool-setup.yaml -e ansible_user=ec2-user \
	-e ansible_password=DevOps321 -e tool_name=$(tool_name)