terraform {
  backend "remote" {
    organization = "polus"

    workspaces {
      name = "staging-na"
    }
  }
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.8.0"
    }
    docker = {
      source = "polusgg/docker"
      version = "1.0.2"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

provider "docker" {
  
}