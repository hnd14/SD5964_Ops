module "dev-network" {
  source = "../../modules/network"
  name = "dev-network"
  vpc_cidr = "10.0.0.0/16"
  subnet_size = "24"
  public_subnets_count = 1
  private_subnets_count = 0
  enable_nat_gateway = false
  single_nat_gateway = false
  one_nat_gateway_per_az = false
}