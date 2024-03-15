terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.107.0"
    }
  }
}

resource "yandex_compute_instance" "docker" {
  name = var.docker_name
  labels = {
    tags = "reddit-app"
  allow_stopping_for_update = true
  }

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.docker_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
