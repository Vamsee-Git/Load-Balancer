resource "aws_lb_target_group" "tg" {
  count    = 3
  name     = "tg-${count.index}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "attachment" {
  count            = 3
  target_group_arn = element(aws_lb_target_group.tg[*].arn, count.index)
  target_id        = element(var.instance_ids, count.index)
  port             = 80
}

output "target_group_arns" {
  value = aws_lb_target_group.tg[*].arn
}
