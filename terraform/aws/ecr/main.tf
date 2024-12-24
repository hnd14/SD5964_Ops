module "frontend_ecr" {
  source = "../modules/ecr"
  name = "frontend"
  project = "NT-devops"
  environment = "dev"
  owner = "NT-devops"
}

module "backend_ecr" {
  source = "../modules/ecr"
  name = "backend"
  project = "NT-devops"
  environment = "dev"
  owner = "NT-devops"
}