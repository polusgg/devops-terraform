variable "host" {
  description = "Docker Engine host URI address"
  type = string
}

variable "registry" {
  description = "Docker Registry configuration"
  type = object({
    address = string
    username = string
    password = string
  })
}

variable "image" {
  description = "Docker container image"
  type = string
}

variable "name" {
  description = "Docker container name"
  type = string
}

variable "env" {
  description = "Docker container environment"
  type = list(string)
}

// SSH
variable "priv_key" {
  description = "SSH private key"
  type = string
}