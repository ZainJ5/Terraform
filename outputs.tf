output "server_public_ips" {
  description = "The public IP addresses of the 3 environments"
  value = {
    for env, server in aws_instance.app_servers : env => server.public_ip
  }
}