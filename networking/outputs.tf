output "subnet_id" {
  value = aws_subnet.dev_public_sub.id

}

output "sg_id" {
  value = aws_security_group.dev_sg.id
}