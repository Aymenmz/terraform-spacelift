module "networking" {
  source = "./networking"

}

module "compute" {
  source    = "./compute"
  subnet_id = module.networking.subnet_id
  sg_id     = [module.networking.sg_id]
  host_os   = var.host_os
}