variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "gitlab_disk_image" {
  description = "Disk image for reddit gitlab"
  default     = "fd8eg73l9tpbsolqm4m2"
}
variable "gitlab_name" {
  description = "gitlab name"
  default = "gitlab-vm"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
