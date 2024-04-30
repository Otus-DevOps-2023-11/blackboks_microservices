terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.107.0"
    }


    ansible = {
      source = "ansible/ansible"
      version = "~>1.2.0"
    }


  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

module "master" {
  source            = "./modules/master"
  public_key_path   = var.public_key_path
  master_disk_image = var.master_disk_image
  subnet_id         = var.subnet_id
  master_name       = var.master_name
  private_key_path  = var.private_key_path

}


module "node" {
  source           = "./modules/node"
  public_key_path  = var.public_key_path
  node_disk_image  = var.node_disk_image
  subnet_id        = var.subnet_id
  private_key_path = var.private_key_path

}





# resource "local_file" "inventory" {
#   filename = "/../ansible/environments/inven.yml"
#   content = templatefile("inventory.yml", { content = tomap({

#   })

#   })
# }



# resource "yandex_storage_bucket" "tf-bucket" {
#   access_key = "YCAJEAmejDzga2rhROakPI6z3"
#   secret_key = "YCOa587ndli2mNbRASed6MkwTeKn2r3K6NRS5Tmk"
#   bucket     = "tf-state-files"
# }
