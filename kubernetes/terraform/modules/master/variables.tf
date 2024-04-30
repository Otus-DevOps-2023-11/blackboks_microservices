variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "master_disk_image" {
  description = "Disk image for kubernetes master node"
  default     = "fd8tdqhq20pka8ghfg19"
}
variable "master_name" {
  description = "master name"
  default = "master"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
