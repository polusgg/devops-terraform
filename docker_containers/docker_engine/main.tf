/*
 *  Docker
 */

resource "docker_image" "container_image" {
  name = var.docker_image
}

resource "docker_container" "container" {
  image   = docker_image.container_image.latest
  name    = var.container_name
  env     = var.container_env
  restart = "always"
  ports {
    internal = 22023
    external = 22023
    protocol = "udp"
  }
}