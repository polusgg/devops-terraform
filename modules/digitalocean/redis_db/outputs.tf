output "id" {
  description = "DigitalOcean resource ID for the Redis DB"
  value = digitalocean_database_cluster.redis.id
}

output "host" {
  description = "Redis DB host address"
  value = digitalocean_database_cluster.redis.private_host
}

output "port" {
  description = "Port that the Redis DB is listening on"
  value = digitalocean_database_cluster.redis.port
}

output "password" {
  description = "Redis DB default password"
  value = digitalocean_database_cluster.redis.password
  sensitive = true
}