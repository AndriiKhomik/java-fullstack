module "nginx" {
  source = "./modules/nginx"

  providers = {
    docker = docker
  }
}
