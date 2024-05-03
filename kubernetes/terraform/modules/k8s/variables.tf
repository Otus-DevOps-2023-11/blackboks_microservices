variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}

variable "folder_id" {
  description = "Folder"
  default = "b1gkdafp07horpeotfcf"
}

variable "node_disk_image" {
  description = "Disk image for kubernetes node"
  default     = "fd8tdqhq20pka8ghfg19"
}
variable "node_name" {
  description = "node name"
  default     = "node"
}
#variable "private_key_path" {
#  description = "Path to the private key used for ssh access"
#}
variable "ip_count" {
  description = "Ip count"
  default     = "2"
}

variable "network_id" {
  description = "Network"
  default = "enp4cptbrotj57q97egp"
}

variable "pod_cidr" {
  default = "10.244.0.0/16"
  description = "Pod network"
}

variable "service_cidr" {
  default = "10.243.0.0/16"
  description = "Service network"
}

variable "subnet_cidr" {
  default = ["10.10.0.0/16"]
  description = "Subnetwork cidr"
}

variable "yandex_compute_instance_zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
