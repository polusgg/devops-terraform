/*
 *  Digitalocean
 */

/*
 *  Docker
 */

variable "docker_image" { 
  type = string
}

variable "container_name" { 
  type = string
}

variable "container_env" {
  type = list(string)
}