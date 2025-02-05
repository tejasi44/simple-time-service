resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "task" {
  family                   = "simpletimeservice-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecs_execution.arn
  container_definitions = jsonencode([
    {
      name      = "simpletimeservice"
      image     = var.container_image
      cpu       = 256
      memory    = 512
      networkMode = "awsvpc"
      essential = true
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "simpletimeservice-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [var.security_group_id]
  }
  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "simpletimeservice"
    container_port   = 80
  }
}