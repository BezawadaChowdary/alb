variable "name" {
  default = "dev-alb"
}

// If this is set to "true", the ALB will be private, and will not have an
// elastic IP assigned to it. The default is "false", which gives the ELB an
// elastic (public) IP.
variable "internal_alb" {
  type    = "string"
  default = "false"
}

// The listener subnet IDs.
variable "subnet_ids" {
  type = "list"
}

// We use this hack to detect the vpc_id we are running in and not ask for it.
data "aws_subnet" "primary_subnet" {
  id = "${var.subnet_ids[0]}"
}

variable "security_groups" {
  type = "list"
}

// The external port that the ALB will listen to requests on.
variable "listener_port" {
  type    = "string"
  default = "80"
}

// The listener protocol. Can be one of HTTP or HTTPS.
variable "listener_protocol" {
  type    = "string"
  default = "HTTP"
}

// The ARN of the server certificate you want to use with the listener.
// Required for HTTPS listeners.
variable "listener_certificate_arn" {
  type    = "string"
  default = ""
}

// The port that the default target group will pass requests to.
variable "default_target_group_port" {
  type    = "string"
  default = "80"
}

// The protocol for the default target group.
variable "default_target_group_protocol" {
  type    = "string"
  default = "HTTP"
}

// health_check related variables
variable "health_check_interval" {
  description = "(Optional) The approximate amount of time, in seconds, between health checks of an individual target"
  default     = "30"
}

variable "health_check_port" {
  description = " (Optional) The port to use to connect with the target."
  default     = "traffic-port"
}

variable "health_check_path" {
  description = "(Optional) The destination for the health check request"
  default     = "/"
}

variable "healthy_threshold" {
  description = "(Optional) The number of checks before the instance is declared healthy."
  default     = "2"
}

variable "unhealthy_threshold" {
  description = "(Optional) The number of checks before the instance is declared unhealthy"
  default     = "2"
}

variable "health_check_timeout" {
  description = "(Optional) The amount of time, in seconds, during which no response means a failed health check"
  default     = "5"
}

variable "environment" {
  type        = "string"
  description = "The environment the resources belong to, dev, stage, prod, defaults to unknown"
  default     = "unknown"
}

variable "service" {
  type        = "string"
  description = "The specific service this ALB provides an endpoint for, defaults to unknown"
  default     = "unknown"
}

variable "role" {
  type        = "string"
  description = "The general role this ALB provides an endpoint for, defaults to unknown"
  default     = "unknown"
}

variable "team" {
  type        = "string"
  description = "The AWS tag 'Team' used to associate with an Auction.com team, example"
  default     = "unknown"
}

variable "owner" {
  type        = "string"
  description = "team/contact email address"
  default     = "unknown"
}

variable "product" {
  type        = "string"
  description = "name of the product which the service belongs"
  default     = "unknown"
}

// logging is disabled by default; set a bucket name to enable this.
variable "s3_access_logs_bucket" {
  description = "The s3 bucket to use for ELB access logs"
  default = ""
}

variable "s3_access_logs_bucket_prefix" {
  description = "The s3 bucket prefix to put access logs under"
  default = "logs"
}
