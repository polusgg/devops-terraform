resource "digitalocean_database_cluster" "redis_database" {
  name            = var.redis_name
  engine          = "redis"
  version         = "6"
  size            = "db-s-1vcpu-1gb"
  region          = var.digitalocean_region_slug
  node_count      = 1
  eviction_policy = "noeviction"
  maintenance_window {
    day = "wednesday"
    hour = "05:00:00"
  }
}