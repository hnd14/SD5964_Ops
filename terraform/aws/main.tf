module "ecr" {
    source = "./ecr"
}

module network {
    source = "./networks/dev"
}