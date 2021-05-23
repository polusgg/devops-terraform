variable "name" {
  description = "Redis DB name"
  type = string
}

variable "region_slug" {
  description = "Redis DB region as a slug"
  type = string
}

variable "tags" {
  description = "Redis DB tags"
  type = list(string)
}