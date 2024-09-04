resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.name

  tags = {
    Name = var.name
  }
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}
