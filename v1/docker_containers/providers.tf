terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

provider "docker" {
  alias = "master-na-west"

  host = "ssh://root@${data.terraform_remote_state.bare_metal.outputs.master-na-west.ipv4_address}:22"
  registry_auth {
    address  = var.docker_registry_url
    username = var.digitalocean_container_registry_token
    password = var.digitalocean_container_registry_token
  }
}

provider "docker" {
  alias = "node-na-west-1"
  host = "ssh://root@${data.terraform_remote_state.bare_metal.outputs.node-na-west-1.ipv4_address}:22"
  registry_auth {
    address  = var.docker_registry_url
    username = var.digitalocean_container_registry_token
    password = var.digitalocean_container_registry_token
  }
}

provider "docker" {
  alias = "node-na-west-2"
  host = "ssh://root@${data.terraform_remote_state.bare_metal.outputs.node-na-west-2.ipv4_address}:22"
  registry_auth {
    address  = var.docker_registry_url
    username = var.digitalocean_container_registry_token
    password = var.digitalocean_container_registry_token
  }
}

provider "docker" {
  alias = "node-na-west-3"
  host = "ssh://root@${data.terraform_remote_state.bare_metal.outputs.node-na-west-3.ipv4_address}:22"
  registry_auth {
    address  = var.docker_registry_url
    username = var.digitalocean_container_registry_token
    password = var.digitalocean_container_registry_token
  }
}