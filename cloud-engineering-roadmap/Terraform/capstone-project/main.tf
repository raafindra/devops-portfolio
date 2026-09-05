terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_network" "private_network" {
  name = local.network_name
}

module "backend_api" {
  source        = "./modules/microservice"
  name          = "${local.prefix}-api"
  image         = "hashicorp/http-echo:latest"
  internal_port = 5678
  external_port = 0
  network_name  = docker_network.private_network.name
  command       = ["-text=Hello from PaySecure Internal API!"]
}

module "frontend_web" {
  source        = "./modules/microservice"
  name          = "${local.prefix}-web"
  image         = "nginx:alpine"
  internal_port = 80
  external_port = 8080
  network_name  = docker_network.private_network.name
}