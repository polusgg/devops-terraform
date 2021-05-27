terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.8.0"
    }
    docker = {
      source = "cybershard/docker"
      version = "1.0.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

provider "docker" {
  
}