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

variable "node_count" {
  description = "Number of game server nodes"
  type = number
}

variable "creator_node_count" {
  description = "Number of creator game server nodes"
  type = number
}


// Accounts
variable "accounts_auth_token" {
  description = "Accounts API token for NP_AUTH_TOKEN"
  type = string
  sensitive = true
}
variable "event_logging_mongodb_url" {
  description = "Event Logging MongoDB Connection URI"
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