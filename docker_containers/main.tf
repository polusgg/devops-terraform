data "terraform_remote_state" "bare_metal" {
  backend = "local"

  config = {
    path = "${path.module}/../bare_metal/terraform.tfstate"
  }
}

/*
 *  Master
 */
module "master-na-west" {
  source = "./docker_engine"

  providers = {
    docker = docker.master-na-west
  }

  docker_image = "registry.digitalocean.com/polusgg/server-loadpolus:v1.0.1-16"
  container_name = "server-loadpolus"
  container_env = [
    "NP_REDIS_HOST=rediss://${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_host}",
    "NP_REDIS_PORT=${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_port}",
    "NP_REDIS_PASSWORD=${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_password}",
    "NP_DROPLET_PORT=22023",
    "NP_AUTH_TOKEN=${var.np_auth_token}",
    "NP_DISABLE_AUTH=false"
  ]
}

module "node-na-west-1" {
  source = "./docker_engine"

  providers = {
    docker = docker.node-na-west-1
  }

  docker_image = "registry.digitalocean.com/polusgg/server-nodepolus:v3.0.1-26"
  container_name = "server-nodepolus"
  container_env = [
    "NP_REDIS_HOST=rediss://${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_host}",
    "NP_REDIS_PORT=${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_port}",
    "NP_REDIS_PASSWORD=${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_password}",
    "NP_DROPLET_PORT=22023",
    "NP_AUTH_TOKEN=${var.np_auth_token}",
    "NP_DISABLE_AUTH=false"
  ]
}

module "node-na-west-2" {
  source = "./docker_engine"

  providers = {
    docker = docker.node-na-west-2
  }

  docker_image = "registry.digitalocean.com/polusgg/server-nodepolus:v3.0.1-26"
  container_name = "server-nodepolus"
  container_env = [
    "NP_REDIS_HOST=rediss://${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_host}",
    "NP_REDIS_PORT=${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_port}",
    "NP_REDIS_PASSWORD=${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_password}",
    "NP_DROPLET_PORT=22023",
    "NP_AUTH_TOKEN=${var.np_auth_token}",
    "NP_DISABLE_AUTH=false"
  ]
}

module "node-na-west-3" {
  source = "./docker_engine"

  providers = {
    docker = docker.node-na-west-3
  }

  docker_image = "registry.digitalocean.com/polusgg/server-nodepolus:v3.0.1-26"
  container_name = "server-nodepolus"
  container_env = [
    "NP_REDIS_HOST=rediss://${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_host}",
    "NP_REDIS_PORT=${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_port}",
    "NP_REDIS_PASSWORD=${data.terraform_remote_state.bare_metal.outputs.redis_db.redis_password}",
    "NP_DROPLET_PORT=22023",
    "NP_AUTH_TOKEN=${var.np_auth_token}",
    "NP_DISABLE_AUTH=false"
  ]
}
