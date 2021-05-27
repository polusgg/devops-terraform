/*
 *  Loadbalancer
 */
module "master" {
  source = "../digitalocean/droplet"

  name = "master-${var.region_name}"
  region_slug  = var.region_slug
  tags         = concat(var.tags, ["game-master"])

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
  name   = "master-${var.region_name}.public.play"
  value  = digitalocean_floating_ip.this.ip_address
}


/*
 *  Nodes
 */
module "node" {
  source = "../digitalocean/droplet"
  count = var.node_count


  name = "node-${var.region_name}-${count.index + 1}"
  region_slug  = var.region_slug
  tags         = concat(var.tags, ["game-node"])


  // SSH Keys
  ssh_key_ids        = var.ssh_key_ids
  priv_key_file_path = var.priv_key_file_path
}

/*
 *  Firewall
 */
resource "digitalocean_database_firewall" "redis_fw" {
  depends_on = [
    module.master,
    module.node
  ]

  cluster_id = var.redis_db_id

  rule {
    type  = "droplet"
    value = module.master.id
  }

  dynamic "rule" {
    for_each = module.node[*]
    content {
      type  = "droplet"
      value = rule.value.id
    }
  }
}

/*
 *  Docker
 */
module "master_docker" {
  source = "../docker_engine"

  host     = "ssh://root@${module.master.ipv4_addr}:22"
  registry = var.registry

  image    = var.master_docker.image
  name     = "server-loadpolus"
  env      = var.master_docker.env
}

module "node_docker" {
  source = "../docker_engine"
  count  = var.node_count

  host     = "ssh://root@${module.node[count.index].ipv4_addr}:22"
  registry = var.registry

  image    = var.node_docker.image
  name     = "server-nodepolus"
  env      = var.node_docker.env
}