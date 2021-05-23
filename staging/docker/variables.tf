// Access Tokens
variable "digitalocean_container_registry_token" {
  description = "DigitalOcean container registry readonly token"
  type = string
}

variable "docker_registry_url" {
  description = "DigitalOcean registry url"
  type = string
  default = "registry.digitalocean.com"
}

// Container environment variables
variable "np_auth_token" {
  description = "NodePolus backend auth token"
  type = string
}