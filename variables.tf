variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

#dataresources
variable "availability_domain_name" {
  default = ""
}

variable "compartment_ocid" {}

variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Canonical Ubuntu"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "18.04"
}

variable "instance_shape" {
  default = "VM.Standard.E4.Flex"
}

#compute
variable "instance_shape_flex_ocpus" {
  default = 2
}

variable "instance_shape_flex_memory" {
  default = 8
}

variable "ssh_public_key" {
  default = ""
}

variable "opc_user_name" {
  default = "ubuntu"
}

#network
variable "vcn_cidr_block" {
  default = "10.0.0.0/16"
}

variable "internet_geteway" {
  default = "ZDM-GateWay"
}

variable "subnet_cidr_block" {
  default = "10.0.0.0/24"
}

locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex"
  ]
}

locals {
  is_flexible_node_shape = contains(local.compute_flexible_shapes, var.instance_shape)
}
