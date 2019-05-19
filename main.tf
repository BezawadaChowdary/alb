// alb creates the AWS Application Load Balancer.
resource "aws_alb" "alb" {
  name            = "${var.name}"
  subnets         = ["${var.subnet_ids}"]
  security_groups = ["${var.security_groups}"]
  internal        = "${var.internal_alb}"

  access_logs {
    bucket = "${var.s3_access_logs_bucket != "" ? var.s3_access_logs_bucket : "none"}"
    prefix = "${var.s3_access_logs_bucket_prefix}"
    enabled = "${var.s3_access_logs_bucket != "" ? true : false}"
  }

  tags {
    Name        = "${var.name}-ALB"
    managed_by  = "terraform"
    Service     = "${var.service}"
    Role        = "${var.role}"
    Environment = "${var.environment}"
    Team        = "${var.team}"
    Owner       = "${var.owner}"
    Product     = "${var.product}"
  }
}

// alb_listener creates the listener that is then attached to the ALB supplied
// by the alb resource.
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"
  ssl_policy        = "${lookup(map("HTTP", ""), var.listener_protocol, "ELBSecurityPolicy-2015-05")}"
  certificate_arn   = "${var.listener_certificate_arn}"

  default_action = {
    target_group_arn = "${aws_alb_target_group.alb_default_target_group.arn}"
    type             = "forward"
  }
}

// alb_default_target_group creates a default target group for the ALB
// listener provided by alb_listener.
resource "aws_alb_target_group" "alb_default_target_group" {
  name     = "default-${var.name}"
  port     = "${var.default_target_group_port}"
  protocol = "${var.default_target_group_protocol}"
  vpc_id   = "${data.aws_subnet.primary_subnet.vpc_id}"

  health_check {
    interval            = "${var.health_check_interval}"
    path                = "${var.health_check_path}"
    port                = "${var.health_check_port}"
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.health_check_timeout}"
    protocol            = "${var.default_target_group_protocol}"
  }

  tags {
    Name        = "${var.name}-ALB"
    managed_by  = "terraform"
    Service     = "${var.service}"
    Role        = "${var.role}"
    Environment = "${var.environment}"
    Team        = "${var.team}"
    Owner       = "${var.owner}"
    Product     = "${var.product}"
  }
}
