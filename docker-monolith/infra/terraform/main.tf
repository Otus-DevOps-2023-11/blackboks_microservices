terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.107.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
module "docker" {
  source              = "../terraform/modules/docker"
  public_key_path     = var.public_key_path
  docker_disk_image   = var.docker_disk_image
  subnet_id           = var.subnet_id
  docker_name         = "reddit-docker-app-${count.index}"
  private_key_path    = var.private_key_path
  count               = var.vm_count
}


resource "yandex_storage_bucket" "tf-bucket" {
  access_key = "YCAJEAmejDzga2rhROakPI6z3"
  secret_key = "YCOa587ndli2mNbRASed6MkwTeKn2r3K6NRS5Tmk"
  bucket     = "tf-state-files"
}
