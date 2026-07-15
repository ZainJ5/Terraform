# Fetch the latest Ubuntu 22.04 LTS image from AWS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's official AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Define our environments as a local variable
locals {
  environments = ["development", "staging", "production"]
}

# Create 3 servers using a loop
resource "aws_instance" "app_servers" {
  for_each = toset(local.environments)

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro" # <-- Changed from t2.micro

  vpc_security_group_ids = [aws_security_group.web_ssh_access.id]

  tags = {
    Name        = "App-Server-${title(each.key)}"
    Environment = each.key
  }
}