cd ../terraform/stage
terraform destroy -auto-approve=true
terraform apply -auto-approve=true
terraform output  inventory_yml > ../../ansible/inventory.yml
cd ../../ansible
