provider "docker" {}

variable "container_name" {
  description = "Name of the Docker container"
  type        = string
  default     = "terraform-nginx"
}

variable "port" {
  description = "Port to expose"
  type        = number
  default     = 9101
  
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name
  ports {
    internal = 80
    external = var.port
  }
}

output "container_id" {
  value = docker_container.nginx.id
  
}

output "image_id" {
  value = docker_image.nginx.image_id
}
