variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "docker_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8fi36p3gm30r61n7jn"
}
variable "docker_name" {
  description = "Application name"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
variable "vm_count" {
  description = "Count of running instances"
  default     = 2
}
