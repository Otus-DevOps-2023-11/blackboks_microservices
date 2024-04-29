terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.107.0"
    }

    # ansible = {
    #   source = "ansible/ansible"
    #   version = "~>1.2.0"
    # }

  }
}


resource "yandex_vpc_address" "master" {
  for_each            = toset(["master-1"])
  name                = each.key
  deletion_protection = false
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}


resource "yandex_compute_instance" "master" {
  for_each = toset(["master-1"])
  name     = each.key
  labels   = {
    tags   = "kubernetes"
  allow_stopping_for_update = true
  }

  resources {
    cores  = 4
    memory = 4
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = var.master_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
    nat_ip_address = yandex_vpc_address.master[each.key].external_ipv4_address.0.address
  }


  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    private_key = file(var.private_key_path)
  }

}



# resource "ansible_host" "master" {
#   for_each = toset(["master-1"])
#   name     = yandex_compute_instance.master[each.key].network_interface[0].nat_ip_address
#   groups   = ["master"]
#     variables = {
#       ansible_user                 =  "ubuntu"
#       ansible_ssh_private_key_file =  file(var.private_key_path)

#     }
# }
