# AWS EC2 Setup

## Terraform

To initiate Terraform, run: 

```bash
terraform init
```

Now, you can plan then apply the environment using terraform: 

```bash
terraform plan
terraform apply
```

You can now access your machine on AWS run:

```bash
sudo ssh -v -i key-pair/ec2-setup-key-pair.pem  ec2-user@<public-ip>
```

## Ansible

Create `ansible/inventories/hosts.ini` file:

```
[web]
<ip-address> ansible_user=ec2-user ansible_ssh_private_key_file=/full/path/to/your/project/key-pair/ec2-setup-key-pair.pem ansible_python_interpreter=/usr/bin/python3 ansible_ssh_common_args='-o ForwardAgent=yes'
```

To setup the environment in AWS, run: 

```bash
sudo ansible-playbook -i ansible/inventories/hosts.ini ansible/site.yml --ask-vault-password
```

To encrypt your secrets in Ansible, run:

```bash
ansible-vault encrypt ansible/roles/git_ssh_setup/vars/vault.yml
```

You can edit your secret variables run: 

```bash
ansible-vault edit ansible/roles/git_ssh_setup/vars/vault.yml
```