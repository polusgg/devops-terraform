variable "digitalocean_token" {
  description = "DigitalOcean API token"
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