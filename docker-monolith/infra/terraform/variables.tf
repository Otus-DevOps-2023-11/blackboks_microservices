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

variable "docker_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8fi36p3gm30r61n7jn"
}
 variable "docker_name" {
   description = "Application name"
   default     = "reddit-docker-app"
}
variable "vm_count" {
  description = "Count of running instances"
  default     = 2
}
