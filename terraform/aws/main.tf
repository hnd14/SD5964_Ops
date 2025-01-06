locals {
  project = "nt-devops"
  environment = "dev"
  owner = "NT-devops"
}
module "ecr" {
    source = "./ecr"
}

module "network-tags" {
  source = "./modules/tags"
  name = "nt-devops-network"
  project = local.project
  environment = local.environment
  owner = local.owner
}

module "jenkins-tags" {
  source = "./modules/tags"
  name = "nt-devops-network"
  project = local.project
  environment = local.environment
  owner = local.owner
}

module "network" {
  source = "./modules/network"
  name = "devops-network"
  vpc_cidr = "10.0.0.0/16"
  subnet_size = "24"
  public_subnets_count = 1
  private_subnets_count = 0
  enable_nat_gateway = false
  single_nat_gateway = false
  one_nat_gateway_per_az = false
  tags = module.network-tags.tags
}


module "jenkins-security-groups" {
  source = "terraform-aws-modules/security-group/aws"
  name = "jenkins-sg"
  auto_groups = {"ssh": {
      ingress_rules     = ["ssh-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    } 
    "http-8080": {
      ingress_rules     = ["http-8080-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }}
  vpc_id = module.network.vpc_id
  tags = module.jenkins-tags.tags
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]  # Only AMIs owned by Amazon

  # Filters for Amazon Linux 2
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

module "jenkins-ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = module.network.public_subnets[0]
  vpc_security_group_ids = [module.jenkins-security-groups.security_group_id]
  associate_public_ip_address = true
  create_eip = true
  tags = module.jenkins-tags.tags
  user_data = file("init-jenkins.sh")
  key_name = "NT-hoangdn-ssh"
}

# module "eks" {
#   source  = "./modules/eks"

#   eks_cluster_name = "NT-Devops"
#   vpc_id = module.network.vpc_id
#   eks_node_groups_subnet_ids = module.network.private_subnets
#   control_plane_subnet_ids = module.network.public_subnets
# }