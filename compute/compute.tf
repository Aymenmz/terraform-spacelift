

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_name
  public_key = file("/mnt/workspace/mtckey.pub")
}

resource "aws_instance" "dev_ec2" {

  ami           = data.aws_ami.ubuntu_18.id
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_id

  key_name  = aws_key_pair.ec2_key_pair.key_name
  user_data = file("${path.module}/userdata.tpl")

  tags = {
    Name = "${node_name}-dev-node"
  }

  # provisioner "local-exec" {
  #   command = templatefile("${var.host_os}-ssh-config.tpl", {
  #     hostname     = self.public_ip
  #     user         = "ubuntu"
  #     identityFile = "~/.ssh/my_key_ec2"

  #   })
  #   interpreter = var.host_os == "linux" ? ["bash", "-c"] : ["powershell", "-command"]

  # }

}

