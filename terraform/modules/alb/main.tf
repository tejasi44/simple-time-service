resource "aws_lb" "alb" {
  name               = "simpletimeservice-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
}

resource "aws_lb_target_group" "tg" {
  name     = "simpletimeservice-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
