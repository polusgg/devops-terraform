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


// Accounts
variable "accounts_auth_token" {
  description = "Accounts API token for NP_AUTH_TOKEN"
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