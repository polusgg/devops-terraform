/*
 * SSH Keys
 */
data "digitalocean_ssh_key" "terraform" {
  name = var.ssh_key_name
}

resource "local_file" "ssh_priv_key" {
  content = var.priv_key
  filename = "${path.root}/id_ed25519_polusgg_terraform"
  file_permission = "0600"
}

/*
 * DigitalOcean
 */
module "redis_db" {
  source = "../../modules/digitalocean/redis_db"

  name        = "redis-europe"
  region_slug = "lon1"
  tags        = [ "europe" ]
}

module "europe_droplets" {
  source = "../../modules/region_droplets"

  region_slug        = "lon1"
  region_name        = "europe"

  node_count         = var.node_count
  creator_node_count = var.creator_node_count
  tags               = [ "europe" ]

  master_docker = {
    image    = "registry.digitalocean.com/polusgg/server-loadpolus:v1.0.1-20"
    env      = [
      "NP_REDIS_HOST=rediss://${module.redis_db.private_host}",
      "NP_REDIS_PORT=${module.redis_db.port}",
      "NP_REDIS_PASSWORD=${module.redis_db.password}",
      "NP_AUTH_TOKEN=${var.accounts_auth_token}",
      "NP_DISABLE_AUTH=false"
    ]
  }

  node_docker = {
    image    = "registry.digitalocean.com/polusgg/server-nodepolus:v3.0.1-76"
    env      = [
      "NP_REDIS_HOST=rediss://${module.redis_db.private_host}",
      "NP_REDIS_PORT=${module.redis_db.port}",
      "NP_REDIS_PASSWORD=${module.redis_db.password}",
      "NP_AUTH_TOKEN=${var.accounts_auth_token}",
      "MONGO_URL=${var.event_logging_mongodb_url}",
      "NP_REGION_NAME=EUROPE",
    ]
  }

  registry = {
    address  = "registry.digitalocean.com"
    username = var.digitalocean_registry_token
    password = var.digitalocean_registry_token
  }

  ssh_key_ids = [ data.digitalocean_ssh_key.terraform.id ]
  priv_key    = local_file.ssh_priv_key.filename
}
