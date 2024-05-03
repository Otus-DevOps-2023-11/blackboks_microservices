terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.107.0"
    }

  }
}

resource "yandex_vpc_network" "reddit-cluster" {
  name = "reddit-cluster-network"
  folder_id = var.folder_id
  labels = {
    app = "reddit"
  }
}

resource "yandex_vpc_subnet" "reddit-cluster-subnet" {
  name           = "reddit-cluster-subnet"
  zone           = var.yandex_compute_instance_zone
  network_id     = yandex_vpc_network.reddit-cluster.id
  v4_cidr_blocks = var.subnet_cidr
}

resource "yandex_iam_service_account" "k8s-master" {
  name = "k8s-master"
}

resource "yandex_iam_service_account" "k8s-node" {
  name = "k8s-node"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-master" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-master.id}"
  }

resource "yandex_resourcemanager_folder_iam_member" "k8s-node" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-node.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-master.id}"
}

resource "yandex_vpc_security_group" "k8s-reddit-sec-group" {
  name       = "k8s-reddit-sec-group"
  network_id = yandex_vpc_network.reddit-cluster.id
}


resource "yandex_vpc_security_group_rule" "in" {
  security_group_binding = yandex_vpc_security_group.k8s-reddit-sec-group.id
  direction              = "ingress"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  protocol               = "TCP"
}

resource "yandex_vpc_security_group_rule" "out" {
  security_group_binding = yandex_vpc_security_group.k8s-reddit-sec-group.id
  direction              = "egress"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  protocol               = "TCP"
}



resource "yandex_logging_group" "reddit-logs" {
  name      = "reddit-logs"
  folder_id = var.folder_id
}

resource "null_resource" "sleep" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

resource "yandex_kubernetes_cluster" "reddit-cluster" {
  name                    = "reddit"
  description             = "Cluster for reddit app"
  service_account_id      = yandex_iam_service_account.k8s-master.id
  node_service_account_id = yandex_iam_service_account.k8s-node.id
  network_id              = yandex_vpc_network.reddit-cluster.id
  cluster_ipv4_range      = var.pod_cidr
  service_ipv4_range      = var.service_cidr



  master {
    version = "1.29"
    zonal {
      zone      = var.yandex_compute_instance_zone
      subnet_id = yandex_vpc_subnet.reddit-cluster-subnet.id
    }


    security_group_ids = [yandex_vpc_security_group.k8s-reddit-sec-group.id]
    public_ip = true

    master_logging {
      enabled = true
      log_group_id = yandex_logging_group.reddit-logs.id
      kube_apiserver_enabled = true
      cluster_autoscaler_enabled = true
      events_enabled = true
      audit_enabled = true
    }
  }
  release_channel = "RAPID"
  network_policy_provider = "CALICO"
}



resource "yandex_kubernetes_node_group" "reddit-worker-nodes" {
  cluster_id  = yandex_kubernetes_cluster.reddit-cluster.id
  name        = "reddit-worker-node"
  description = "Cluster nodes"
  version     = "1.29"

  labels = {
    "app" = "reddit"
  }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.reddit-cluster-subnet.id]
      security_group_ids = [yandex_vpc_security_group.k8s-reddit-sec-group.id]

    }

    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = var.yandex_compute_instance_zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }
  }
}
