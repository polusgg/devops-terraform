/*
 *  Digitalocean
 */

// Servers
variable "redis_name" {
    type = string
}

variable "digitalocean_region_slug" {
  type = string
}

variable "digitalocean_region_tags" {
  type = list(string)
}