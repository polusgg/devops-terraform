variable "digitalocean_token" {
  description = "DigitalOcean API Token"
  type = string
}

variable "region_slug" {
  description = "Droplet region as a slug"
  type = string
}

variable "digitalocean_tags" {
  description = "Tags for resources on DigitalOcean"
  type = list(string)
}

// SSH
variable "ssh_key_name" {
  description = "DigitalOcean SSH key name"
  type = string
}
variable "priv_key_file_path" {
  description = "Private key file path"
  type = string
}