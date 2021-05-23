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
module "node" {
  source = "../droplet"
  for_each = var.nodes


  droplet_name = each.value.name
  region_slug  = var.region
  tags         = concat(each.value.tags, ["game-node"])


  // SSH Keys
  ssh_key_ids        = var.ssh_key_ids
  priv_key_file_path = var.priv_key_file_path
}

/*
 *  Firewall
 */
resource "digitalocean_database_firewall" "redis_master_fw" {
  cluster_id = module.redis_db.id
  rule {
    type  = "droplet"
    value = module.master.id
  }
}
resource "digitalocean_database_firewall" "redis_node_fw" {
  for_each = module.node


  cluster_id = module.redis_db.id
  rule {
    type  = "droplet"
    value = each.value.id
  }
}