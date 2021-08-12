// DigitalOcean
variable "digitalocean_token" {
  description = "DigitalOcean API token"
  type = string
  sensitive = true
}

variable "digitalocean_registry_token" {
  description = "DigitalOcean Docker Registry token"
  type = string
  sensitive = true
}

// Docker
variable "docker_image" {
  description = "Docker container image"
  type = string
}

// Accounts
variable "accounts_auth_token" {
  description = "Polus.gg accounts API token"
  type = string
  sensitive = true
}
variable "steam_publisher_key" {
  description = "Steam WebAPI publisher authentication token"
  type = string
  sensitive = true
}

// SSH
variable "ssh_key_name" {
  description = "DigitalOcean SSH key name"
  type = string
}

variable "priv_key" {
  description = "SSH private key"
  type = string
  sensitive = true
}