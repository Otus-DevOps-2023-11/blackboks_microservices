data "yandex_kubernetes_cluster" "reddit" {
  cluster_id = yandex_kubernetes_cluster.reddit-cluster.id
}

output "cluster_external_v4_endpoint" {
  value = data.yandex_kubernetes_cluster.reddit.master[0].external_v4_endpoint
}

data "yandex_kubernetes_node_group" "reddit-worker-nodes" {
  node_group_id = yandex_kubernetes_node_group.reddit-worker-nodes.id
}

output "node_external_ip" {
  value = data.yandex_kubernetes_node_group.reddit-worker-nodes.instance_template
}
