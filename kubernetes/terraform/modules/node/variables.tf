variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "node_disk_image" {
  description = "Disk image for kubernetes node"
  default     = "fd8tdqhq20pka8ghfg19"
}
variable "node_name" {
  description = "node name"
  default     = "node"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
variable "ip_count" {
  description = "Ip count"
  default     = "2"
}
