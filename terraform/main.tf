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
  depends_on = [docker_container.backend]
}

resource "docker_image" "backend" {
  name = "frontend_image"
  build {
    path       = "../"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "backend" {
  name  = "backend"
  image = docker_image.backend.image_id
  ports {
    internal = 8080
    external = 800
  }

  environment = {
    MONGO_LOCAL_CURRENT_DATABASE = var.mongodb_local_current_database
    DEFAULT_SERVER_CLUSTER       = var.default_server_cluster
  }

  networks_advanced {
    name = docker_network.network.name
  }

  depends_on = [docker_container.postgres, docker_container.redis, docker_container.mongodb]
}

resource "docker_image" "postgres" {
  name         = "postgres:15"
  keep_locally = true
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.image_id
  environment = {
    POSTGRES_USER     = var.postgres_user
    POSTGRES_PASSWORD = var.postgres_password
    POSTGRES_DB       = var.postgres_db
  }

  networks_advanced {
    name = docker_network.network.name
  }

  ports {
    internal = var.postgres_port_internal
    external = var.postgres_port_external
  }

  volumes {
    volume_name = "postgres_data"
    destination = "/var/lib/postgresql/data"
  }
}

resource "docker_image" "redis" {
  name         = "redis:latest"
  keep_locally = true
}

resource "docker_container" "redis" {
  name  = "redis"
  image = docker_image.redis.image_id

  networks_advanced {
    name = docker_network.network.name
  }

  ports {
    internal = var.redis_port_internal
    external = var.redis_port_external
  }

  volumes {
    volume_name = "redis_data"
    destination = "/data"
  }
}

resource "docker_image" "mongodb" {
  name         = "mongo:4.4"
  keep_locally = true
}

resource "docker_container" "mongodb" {
  name  = "mongodb"
  image = docker_image.mongodb.image_id

  environment = {
    MONGO_INITDB_ROOT_USERNAME = var.mongo_initdb_root_username
    POSTGRES_PASSWORD          = var.mongo_initdb_root_password
  }

  networks_advanced {
    name = docker_network.network.name
  }

  ports {
    internal = var.mongodb_port_internal
    external = var.mongodb_port_external
  }

  volumes {
    volume_name = "mongodb_data"
    destination = "/data/db"
  }
}

resource "docker_volume" "postgres_data" {
  name = "postgres_data"
}

resource "docker_volume" "mongodb_data" {
  name = "mongodb_data"
}

resource "docker_volume" "redis_data" {
  name = "redis_data"
}
