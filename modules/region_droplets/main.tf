/*
 *  Loadbalancer
 */
module "master" {
  source = "../digitalocean/droplet"

  name = "master-${var.region_name}"
  region_slug  = var.region_slug
  tags         = concat(var.tags, ["game-master", "terraform"])

  // SSH Keys
  ssh_key_ids = var.ssh_key_ids
  priv_key    = var.priv_key
}

resource "digitalocean_floating_ip" "this" {
  droplet_id = module.master.id
  region     = var.region_slug
}

resource "digitalocean_record" "this" {
  domain = "polus.gg"
  type   = "A"
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
  tags         = concat(var.tags, ["game-node", "terraform"])


  // SSH Keys
  ssh_key_ids = var.ssh_key_ids
  priv_key    = var.priv_key
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
  priv_key = var.priv_key
  registry = var.registry

  image    = var.master_docker.image
  name     = "server-loadpolus"
  env      = concat(var.master_docker.env, ["NP_DROPLET_ADDRESS=${module.master.ipv4_addr}"])
}

module "node_docker" {
  source = "../docker_engine"
  count  = var.node_count

  host     = "ssh://root@${module.node[count.index].ipv4_addr}:22"
  priv_key = var.priv_key
  registry = var.registry

  image    = var.node_docker.image
  name     = "server-nodepolus"
  env      = concat(var.master_docker.env, ["NP_DROPLET_ADDRESS=${module.node[count.index].ipv4_addr}"])
}