variable "region_slug" {
  description = "Droplet region as a slug"
  type = string
}

// Nodes
variable "redis" {
  description = "Redis configuration"
  type = object({
    name = string
    tags = list(string)
  })
}
variable "master_node" {
  description = "Master node configuration"
  type = object({
    name = string
    tags = list(string)
  })
}
variable "nodes" {
  description = "Worker node configuration"
  type = set(object({
    name = string
    tags = list(string)
  }))
}

// SSH
variable "ssh_key_ids" {
  description = "DigitalOcean SSH key ids"
  type = list(number) 
}
variable "priv_key_file_path" {
  description = "Private key file path"
  type = string
}