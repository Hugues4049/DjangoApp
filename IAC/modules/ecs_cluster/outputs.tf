output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}
# ID du Cluster ECS
output "ecs_cluster_id" {
  description = "ID du cluster ECS"
  value       = aws_ecs_cluster.ecs_cluster.id
}

# ARN de la définition de tâche ECS
output "ecs_task_definition_arn" {
  description = "ARN de la définition de tâche ECS"
  value       = aws_ecs_task_definition.django_task.arn
}

# ID du Service ECS
output "ecs_service_id" {
  description = "ID du service ECS"
  value       = aws_ecs_service.django_service.id
}
