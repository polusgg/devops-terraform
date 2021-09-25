resource "docker_image" "this" {
  client {
    host = var.host
    private_key = var.priv_key
    registry_address  = var.registry.address
    registry_username = var.registry.username
    registry_password = var.registry.password
  }

  name = var.image
}

resource "docker_container" "this" {
  client {
    host = var.host
    private_key = var.priv_key
    registry_address  = var.registry.address
    registry_username = var.registry.username
    registry_password = var.registry.password
  }

  image   = docker_image.this.latest
  name    = var.name
  env     = var.env
  restart = "always"
  destroy_grace_seconds = 10
  ports {
    internal = 22023
    external = 22023
    protocol = "udp"
  }
}

