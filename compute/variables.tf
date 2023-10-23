variable "subnet_id" {
  type = string
}

variable "sg_id" {
  type = list(any)
}

variable "host_os" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "node_name" {
  type = string

}