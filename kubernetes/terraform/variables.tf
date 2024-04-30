variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "region_id" {
  description = "Region"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "image_id" {
  description = "Disk image"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "service_account_key_file" {
  description = "key.json"
}
variable "yandex_compute_instance_zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "private_key_path" {
  description = "Path to the private key for provisioners"
}
variable "number_of_instances" {
  description = "Number of instances to create"
  default     = "2"
}
variable "master_disk_image" {
  description = "Disk image for kubernetes"
  default     = "fd8tdqhq20pka8ghfg19"
}
variable "node_disk_image" {
  description = "Disk image for kubernetes"
  default     = "fd8tdqhq20pka8ghfg19"
}
variable "master_name" {
  description = "Master node name"
}
variable "node_name" {
  description = "Node name"
}
