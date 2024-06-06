data "yandex_kubernetes_cluster" "reddit" {
  cluster_id = yandex_kubernetes_cluster.reddit-cluster.id
}

output "cluster_external_v4_endpoint" {
  value = data.yandex_kubernetes_cluster.reddit.master[0].external_v4_endpoint
}
