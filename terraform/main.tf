module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

module "security" {
  source      = "./modules/security"
  vpc_id      = module.vpc.vpc_id
}

module "ecs" {
  source             = "./modules/ecs"
  vpc_id             = module.vpc.vpc_id
  private_subnets    = module.vpc.private_subnets
  ecs_cluster_name   = var.ecs_cluster_name
  container_image    = var.container_image
  security_group_id  = module.security.ecs_sg_id
  alb_target_group_arn = module.alb.target_group_arn
}