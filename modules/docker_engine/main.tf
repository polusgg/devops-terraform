resource "docker_image" "this" {
  name = var.image
}

resource "docker_container" "this" {
  image   = docker_image.this.latest
  name    = var.name
  env     = var.env
  restart = "always"
  ports {
    internal = 22023
    external = 22023
    protocol = "udp"
  }
}