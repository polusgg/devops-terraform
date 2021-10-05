resource "digitalocean_database_cluster" "redis" {
  name            = var.name
  engine          = "redis"
  version         = "6"
  size            = "db-s-1vcpu-1gb"
  region          = var.region_slug
  node_count      = 1
  tags            = concat(var.tags, [ "terraform" ])
  eviction_policy = "noeviction"
  maintenance_window {
    day = "wednesday"
    hour = "05:00:00"
  }  
}

/*
 *  Firewall
 */
resource "digitalocean_database_firewall" "redis_fw" {
  cluster_id = digitalocean_database_cluster.redis.id

  rule {
    type  = "tag"
    value = "game-master"
  }

  rule {
    type  = "tag"
    value = "game-node"
  }

  rule {
    type = "ip_addr"
    value = "72.68.129.83"
  }

  rule {
    type = "ip_addr"
    value = "86.243.182.143"
  }
}