locals {
  environments = ["development", "staging", "production"]
}

# Create 3 servers using a loop 
resource "aws_instance" "app_servers" {
  for_each = toset(local.environments)

  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro" 

  vpc_security_group_ids = [aws_security_group.web_ssh_access.id]

  tags = {
    Name        = "App-Server-${title(each.key)}"
    Environment = each.key
  }
}