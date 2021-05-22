/*
 *  Database
 */
module "redis_db" {
  source = "./redis_db"

  redis_name               = "redis-na"
  digitalocean_region_slug = var.digitalocean_region_slug
  digitalocean_region_tags = [ "na" ]
}


/*
 *  Loadbalancer
 */
module "master-na-west" {
  source = "./docker_droplet"
  
  // SSH Keys
  digitalocean_key_name      = var.digitalocean_key_name
  digitalocean_priv_key_file = var.digitalocean_priv_key_file

  droplet_name             = "master-na-west"
  digitalocean_region_slug = var.digitalocean_region_slug
  digitalocean_region_tags = concat(var.digitalocean_region_tags, ["game-master"])
}

resource "digitalocean_floating_ip" "na-west-fip" {
  droplet_id = module.master-na-west.id
  region     = module.master-na-west.digitalocean_region_slug
}

resource "digitalocean_record" "na-west-domain" {
  domain = "polus.gg"
  type   = "A"
  // TODO: This must be changed after a region is put into a module (name = "${var.master_name}.public.play")
  name   = "master-na-west.public.play"
  value  = digitalocean_floating_ip.na-west-fip.ip_address
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