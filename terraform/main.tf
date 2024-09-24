terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.23.0"
    }
  }
}

provider "docker" {

}

resource "docker_network" "network" {
  name = "my_network"
}


resource "docker_image" "nginx" {
  name = "nginx_image"
  build {
    context    = "../nginx/"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "nginx" {
  name  = "Andrii"
  image = docker_network.network
  ports {
    internal = 80
    external = 8080
  }
}
