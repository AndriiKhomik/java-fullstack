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
    path       = "../nginx/"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8080
  }
  networks_advanced {
    name = docker_network.network.name
  }
  depends_on = [docker_container.frontend]
}

resource "docker_image" "frontend" {
  name = "frontend_image"
  build {
    path       = "../frontend/"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "frontend" {
  name  = "frontend"
  image = docker_image.frontend.image_id
  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = docker_network.network.name
  }
}
