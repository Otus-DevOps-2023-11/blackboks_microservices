output "nodes_external_ip" {
  value = values(yandex_compute_instance.node)[*].network_interface[0].nat_ip_address
}
