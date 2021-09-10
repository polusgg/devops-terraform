terraform {
  backend "remote" {
    organization = "polus"

    workspaces {
      name = "staging-europe"
    }
  }
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.8.0"
    }
    docker = {
      source = "polusgg/docker"
      version = "1.0.3"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

provider "docker" {
  
}