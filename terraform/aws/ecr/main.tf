module "frontend_ecr" {
  source = "../modules/ecr"
  name = "frontend"
  project = "nt-devops"
  environment = "dev"
  owner = "NT-devops"
}

module "backend_ecr" {
  source = "../modules/ecr"
  name = "backend"
  project = "nt-devops"
  environment = "dev"
  owner = "NT-devops"
}