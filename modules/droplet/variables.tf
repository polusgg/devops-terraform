// Droplet common configuration
variable "name" {
  description = "Name of the droplet"
  type = string
}

variable "region_slug" {
  description = "Droplet region as a slug"
  type = string
}

variable "image" {
  description = "Droplet base disk image"
  type    = string
  default = "docker-20-04"
}

variable "size_slug" {
  description = "Droplet size as a slug"
  type    = string
  default = "s-2vcpu-2gb"
}

variable "tags" {
  description = "Droplet tags"
  type = list(string)
}


// SSH
variable "ssh_key_ids" {
  type = list(number) 
}
variable "priv_key_file_path" {
    type = string
}