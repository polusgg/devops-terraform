/*
 *  Digitalocean
 */
// SSH access into the droplet
variable "digitalocean_key_name" {
  type = string
}

variable "digitalocean_priv_key_file" {
  type = string
}


// Servers
variable "droplet_name" {
    type = string
}

variable "digitalocean_region_slug" {
  type = string
}

variable "digitalocean_region_tags" {
  type = list(string) 
}

variable "digitalocean_droplet_size" {
  type    = string
  default = "s-2vcpu-2gb"
}

variable "digitalocean_droplet_image" {
  type    = string
  default = "docker-20-04"
}