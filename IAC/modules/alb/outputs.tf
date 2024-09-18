# ALB Outputs
output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.alb.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "alb_target_group_arn" {
  description = "ARN of the ALB Target Group"
  value       = aws_lb_target_group.alb_tg.arn
}

output "alb_listener_arn" {
  description = "ARN of the ALB Listener"
  value       = aws_lb_listener.alb_listener.arn
}

output "alb_zone_id" {
  description = "The ID of the zone the ALB is located in"
  value       = aws_lb.alb.zone_id
}

