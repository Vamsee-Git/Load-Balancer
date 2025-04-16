resource "aws_lb" "main" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arns[0]
  }
}

resource "aws_lb_listener_rule" "default" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = var.target_group_arns[0]
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

resource "aws_lb_listener_rule" "image" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = var.target_group_arns[1]
  }

  condition {
    path_pattern {
      values = ["/image*"]
    }
  }
}

resource "aws_lb_listener_rule" "register" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = var.target_group_arns[2]
  }

  condition {
    path_pattern {
      values = ["/register*"]
    }
  }
}

output "load_balancer_dns_name" {
  value = aws_lb.main.dns_name
}
