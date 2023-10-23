resource "aws_vpc" "dev_vpc" {

  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "dev_public_sub" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "gt" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-igt"
  }

}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev_public_rt"
  }

}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gt.id
}

resource "aws_route_table_association" "dev_public_ass" {
  subnet_id      = aws_subnet.dev_public_sub.id
  route_table_id = aws_route_table.rt_public.id

}

resource "aws_security_group" "dev_sg" {
  name        = "my_dev_sg"
  description = "dev security group"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    description = "TLS to VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }


}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "my-ec2-key-pair"
  public_key = file("my_key_ec2.pub")
}

resource "aws_instance" "dev_ec2" {

  ami           = data.aws_ami.ubuntu_18.id
  instance_type = "t2.micro"

  subnet_id              = aws_subnet.dev_public_sub.id
  vpc_security_group_ids = [aws_security_group.dev_sg.id]

  key_name  = aws_key_pair.ec2_key_pair.key_name
  user_data = file("userdata.tpl")

  tags = {
    Name = "dev_ec2"
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

