variable "name" {
  description = "Droplet name"
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
  description = "DigitalOcean SSH key ids"
  type = list(number) 
}
variable "priv_key_file_path" {
  description = "Private key file path"
  type = string
}