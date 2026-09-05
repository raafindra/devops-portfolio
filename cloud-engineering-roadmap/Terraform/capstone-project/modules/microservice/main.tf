terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

resource "docker_image" "this" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "this" {
  name    = var.name
  image   = docker_image.this.image_id
  env     = var.env_vars
  command = var.command

  networks_advanced {
    name = var.network_name
  }

  dynamic "ports" {
    for_each = var.external_port > 0 ? [1] : []
    content {
      internal = var.internal_port
      external = var.external_port
    }
  }
}