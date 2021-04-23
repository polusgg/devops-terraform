output "id" {
  value = digitalocean_database_cluster.redis_database.id
}

output "redis_host" {
  value = digitalocean_database_cluster.redis_database.private_host
}

output "redis_port" {
  value = digitalocean_database_cluster.redis_database.port
}

output "redis_password" {
  value = digitalocean_database_cluster.redis_database.password
  sensitive = true
}