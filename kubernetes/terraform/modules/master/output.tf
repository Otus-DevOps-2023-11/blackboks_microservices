output "master_external_ip" {
 value = values(yandex_compute_instance.master)[*].network_interface[0].nat_ip_address
}
