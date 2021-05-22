/*
 *  Digitalocean
 */

// Access Tokens

variable "digitalocean_container_registry_token" {
  type = string
}

variable "docker_registry_url" {
  type = string
  default = "registry.digitalocean.com"
}

/*
 *  Docker
 */

// Container environment variables
variable "np_auth_token" {
  type = string
}