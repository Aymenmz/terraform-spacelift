output "public_ip" {
  value = aws_instance.dev_ec2.public_ip
}

output "connection_script" {

    value = templatefile("${var.host_os}-ssh-config.tpl", {
        hostname     = aws_instance.dev_ec2.public_ip
        user         = "ubuntu"
        identityFile = "~/.ssh/my_key_ec2"

  })
  
}