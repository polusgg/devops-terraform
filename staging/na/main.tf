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

  name        = "redis-na"
  region_slug = "sfo3"
  tags        = [ "na" ]
}

module "na_west_droplets" {
  source = "../../modules/region_droplets"

  region_slug        = "sfo3"
  region_name        = "na-west"

  node_count         = var.node_count
  creator_node_count = var.creator_node_count
  tags               = [ "na", "na-west" ]

  master_docker = {
    image    = "registry.digitalocean.com/polusgg/server-loadpolus:v1.0.1-23"
    env      = [
      "NP_REDIS_HOST=rediss://${module.redis_db.private_host}",
      "NP_REDIS_PORT=${module.redis_db.port}",
      "NP_REDIS_PASSWORD=${module.redis_db.password}",
      "NP_AUTH_TOKEN=${var.accounts_auth_token}",
      "NP_DISABLE_AUTH=false"
    ]
  }

  node_docker = {
    image    = "registry.digitalocean.com/polusgg/server-nodepolus:v3.0.1-121"
    env      = [
      "NP_REDIS_HOST=rediss://${module.redis_db.private_host}",
      "NP_REDIS_PORT=${module.redis_db.port}",
      "NP_REDIS_PASSWORD=${module.redis_db.password}",
      "NP_AUTH_TOKEN=${var.accounts_auth_token}",
      "MONGO_URL=${var.event_logging_mongodb_url}",
      "NP_REGION_NAME=NA [WEST]",
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

module "na_east_droplets" {
  source = "../../modules/region_droplets"

  region_slug        = "nyc3"
  region_name        = "na-east"

  node_count         = var.node_count
  creator_node_count = var.creator_node_count
  tags               = [ "na", "na-east" ]

  master_docker = {
    image    = "registry.digitalocean.com/polusgg/server-loadpolus:v1.0.1-23"
    env      = [
      "NP_REDIS_HOST=rediss://${module.redis_db.host}",
      "NP_REDIS_PORT=${module.redis_db.port}",
      "NP_REDIS_PASSWORD=${module.redis_db.password}",
      "NP_AUTH_TOKEN=${var.accounts_auth_token}",
      "NP_DISABLE_AUTH=false"
    ]
  }

  node_docker = {
    image    = "registry.digitalocean.com/polusgg/server-nodepolus:v3.0.1-121"
    env      = [
      "NP_REDIS_HOST=rediss://${module.redis_db.host}",
      "NP_REDIS_PORT=${module.redis_db.port}",
      "NP_REDIS_PASSWORD=${module.redis_db.password}",
      "NP_AUTH_TOKEN=${var.accounts_auth_token}",
      "MONGO_URL=${var.event_logging_mongodb_url}",
      "NP_REGION_NAME=NA [EAST]",
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
