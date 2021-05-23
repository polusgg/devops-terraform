/*
 *  Redis DB
 */
module "redis_db" {
  source = "../redis_db"

  name        = var.redis.name
  region_slug = var.region_slug
  tags        = var.redis.tags
}


/*
 *  Loadbalancer
 */
module "master" {
  source = "../droplet"

  droplet_name = var.master_node.name
  region_slug  = var.region_slug
  tags         = concat(var.master_node.tags, ["game-master"])

  // SSH Keys
  ssh_key_ids        = var.ssh_key_ids
  priv_key_file_path = var.priv_key_file_path
}

resource "digitalocean_floating_ip" "this" {
  droplet_id = module.master.id
  region     = var.region_slug
}

resource "digitalocean_record" "this" {
  domain = "polus.gg"
  type   = "A"
  // TODO: This must be changed after a region is put into a module (name = "${var.master_name}.public.play")
  name   = "${var.master_node.name}.public.play"
  value  = digitalocean_floating_ip.this.ip_address
}



/*
 *  Nodes
 */
module "node-na-west-1" {
  source = "./docker_droplet"
  
  // SSH Keys
  digitalocean_key_name      = var.digitalocean_key_name
  digitalocean_priv_key_file = var.digitalocean_priv_key_file

  droplet_name             = "node-na-west-1"
  digitalocean_region_slug = var.digitalocean_region_slug
  digitalocean_region_tags = concat(var.digitalocean_region_tags, ["game-node"])
}

module "node-na-west-2" {
  source = "./docker_droplet"

  // SSH Keys
  digitalocean_key_name      = var.digitalocean_key_name
  digitalocean_priv_key_file = var.digitalocean_priv_key_file

  droplet_name             = "node-na-west-2"
  digitalocean_region_slug = var.digitalocean_region_slug
  digitalocean_region_tags = concat(var.digitalocean_region_tags, ["game-node"])
}

module "node-na-west-3" {
  source = "./docker_droplet"
  
  // SSH Keys
  digitalocean_key_name      = var.digitalocean_key_name
  digitalocean_priv_key_file = var.digitalocean_priv_key_file

  droplet_name             = "node-na-west-3"
  digitalocean_region_slug = var.digitalocean_region_slug
  digitalocean_region_tags = concat(var.digitalocean_region_tags, ["game-node"])
}

/*
 *  Firewall
 */
resource "digitalocean_database_firewall" "redis-fw" {
  cluster_id = module.redis_db.id

  rule {
    type  = "droplet"
    value = module.master-na-west.id
  }

  rule {
    type  = "droplet"
    value = module.node-na-west-1.id
  }
  
  rule {
    type  = "droplet"
    value = module.node-na-west-2.id
  }
  
  rule {
    type  = "droplet"
    value = module.node-na-west-3.id
  }
}