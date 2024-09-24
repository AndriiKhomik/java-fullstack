resource "docker_image" "nginx_image" {
  name = "nginx_image"
  build {
    context    = "../../../nginx/"
    dockerfile = "Dockerfile"
  }
}


resource "docker_container" "nginx_container" {
  name  = "nginx"
  image = docker_image.nginx_image.image_id
  networks_advanced {
    name = var.network.network
  }
  ports {
    internal = 80
    external = 80
  }
}
