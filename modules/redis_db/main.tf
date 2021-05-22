resource "digitalocean_database_cluster" "redis" {
  name            = var.name
  engine          = "redis"
  version         = "6"
  size            = "db-s-1vcpu-1gb"
  region          = var.region_slug
  node_count      = 1
  eviction_policy = "noeviction"
  maintenance_window {
    day = "wednesday"
    hour = "05:00:00"
  }

  tags            = var.tags
}