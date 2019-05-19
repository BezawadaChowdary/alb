// The security group ID for the alb.
output "alb_security_group_id" {
  value = "${var.security_groups}"
}

// The ARN of the created Application Load Balancer.
output "alb_arn" {
  value = "${aws_alb.alb.arn}"
}

// The ARN suffix of the created Application Load Balancer.
output "alb_arn_suffix" {
  value = "${aws_alb.alb.arn_suffix}"
}

// The ARN of the created Application Load Balancer Listener.
output "alb_listener_arn" {
  value = "${aws_alb_listener.alb_listener.arn}"
}

// The ARN of the default target group
output "alb_default_target_group_arn" {
  value = "${aws_alb_target_group.alb_default_target_group.arn}"
}

// The ARN suffix of the default target group with CloudWatch Metrics.
output "alb_default_target_group_arn_suffix" {
  value = "${aws_alb_target_group.alb_default_target_group.arn_suffix}"
}

// The DNS name of the created Application Load Balancer.
output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}

// The route 53 zone ID that can be used to route alias records sets to.
//
// Note that these are not CNAMEs, but a route that allows Route 53 to
// respond to A record requests with the actual IP addresses of the ALB.
output "alb_zone_id" {
  value = "${aws_alb.alb.zone_id}"
}

//The name of the Application Load Balancer.
output "alb_name" {
  value = "${aws_alb.alb.name}"
}

//The ARN of the Application Load Balancer.
output "alb_id" {
  value = "${aws_alb.alb.id}"
}
