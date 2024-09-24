resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  name  = "Andrii"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8080
  }
}
