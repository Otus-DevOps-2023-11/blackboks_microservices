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

resource "yandex_vpc_address" "node" {
  for_each            = toset(["node-1", "node-2"])
  name                = each.key
  deletion_protection = false
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

resource "yandex_compute_instance" "node" {
  for_each = toset(["node-1", "node-2"])
  name     = each.key
  labels = {
    tags                      = "kubernetes"
    allow_stopping_for_update = true
  }
  resources {
    cores         = 4
    memory        = 4
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = var.node_disk_image
    }
  }

  network_interface {
    subnet_id      = var.subnet_id
    nat            = true
    nat_ip_address = yandex_vpc_address.node[each.key].external_ipv4_address.0.address

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



#resource "local_file" "inventory" {
# content = templatefile("inventory.yml", { content = tomap({
#   for node in yandex_compute_instance.node : node.name => node })
# })
# filename = format("%s/%s", abspath(path.root), "inventory.yaml")
#}
