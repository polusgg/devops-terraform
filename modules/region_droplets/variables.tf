variable "region_slug" {
  description = "Droplet region as a slug"
  type = string
}

variable "region_name" {
  description = "Readable name for a region, used in DigitalOcean resource names"
  type = string
}

/*
 *  Nodes
 */
variable "node_count" {
  description = "Number of game server nodes"
  type = number
}

variable "tags" {
  description = "Droplet tags"
  type = list(string)
}

/*
 *  Firewall/Redis DB
 */
variable "redis_db_id" {
  description = "Redis DB ID for firewall rules"
  type = string
}

/*
 *  Docker
 */
variable "master_docker" {
  description = "Master node's docker container configuration"
  type = object({
    image = string
    env   = list(string)
  })
}

variable "node_docker" {
 description = "Game nodes' docker container configuration"
  type = object({
    image = string
    env   = list(string)
  })
}

variable "registry" {
  description = "Docker Registry configuration"
  type = object({
    address  = string
    username = string
    password = string
  })
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