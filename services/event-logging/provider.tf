terraform {
  backend "remote" {
    organization = "polus"

    workspaces {
      name = "event-logging"
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