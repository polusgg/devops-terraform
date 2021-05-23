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