data "terraform_remote_state" "digitalocean" {
  backend = "local"

  config = {
    path = "${path.module}/../digitalocean/terraform.tfstate"
  }
}

locals {
  digitalocean = data.terraform_remote_state.digitalocean.outputs
}

/*
 *  Master
 */
locals {
  master_container_image = "registry.digitalocean.com/polusgg/server-loadpolus:v1.0.1-16"
  master_container_name  = "server-loadpolus"
  master_container_env   = [
    "NP_REDIS_HOST=rediss://${local.digitalocean.redis_db.redis_host}",
    "NP_REDIS_PORT=${local.digitalocean.redis_db.redis_port}",
    "NP_REDIS_PASSWORD=${local.digitalocean.redis_db.redis_password}",
    "NP_DROPLET_PORT=22023",
    "NP_AUTH_TOKEN=${var.np_auth_token}",
    "NP_DISABLE_AUTH=false"
  ]
}
module "master-na-west" {
  source = "../../modules/docker_engine"

  providers = {
    docker = docker.master-na-west
  }

  image = locals.master_container_image
  name  = locals.master_container_name
  env   = locals.master_container_name
}

/*
 *  Nodes
 */

locals {
  node_container_image = "registry.digitalocean.com/polusgg/server-nodepolus:v3.0.1-35"
  node_container_name  = "server-nodepolus"
  node_container_env   = [
    "NP_REDIS_HOST=rediss://${local.digitalocean.redis_db.redis_host}",
    "NP_REDIS_PORT=${local.digitalocean.redis_db.redis_port}",
    "NP_REDIS_PASSWORD=${local.digitalocean.redis_db.redis_password}",
    "NP_DROPLET_PORT=22023",
    "NP_AUTH_TOKEN=${var.np_auth_token}",
    "NP_DISABLE_AUTH=false",
    "NP_IS_CREATOR_SERVER=false"
  ]
}

module "node-na-west-1" {
  source = "../../modules/docker_engine"

  providers = {
    docker = docker.node-na-west-1
  }

  image = locals.node_container_image
  name  = locals.node_container_name
  env   = locals.node_container_env
}

module "node-na-west-2" {
  source = "../../modules/docker_engine"

  providers = {
    docker = docker.node-na-west-2
  }

  image = locals.node_container_image
  name  = locals.node_container_name
  env   = locals.node_container_env
}

module "node-na-west-3" {
  source = "../../modules/docker_engine"

  providers = {
    docker = docker.node-na-west-3
  }

  image = locals.node_container_image
  name  = locals.node_container_name
  env   = locals.node_container_env
}
