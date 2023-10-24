module "networking" {
  source = "./networking"

}

module "compute" {

  source        = "./compute"
  subnet_id     = module.networking.subnet_id
  sg_id         = [module.networking.sg_id]
  host_os       = var.host_os
  key_name      = "my_key_ec2"
  node_name     = "main"
  instance_type = "t2.micro"

}

module "maiziz-compute" {

  source        = "./compute"
  subnet_id     = module.networking.subnet_id
  sg_id         = [module.networking.sg_id]
  host_os       = var.host_os
  key_name      = "my_key_ec2_2"
  node_name     = "maiziz"
  instance_type = "t2.medium"

}
