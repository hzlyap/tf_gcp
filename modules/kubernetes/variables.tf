variable "gke_version" {}
variable "service_account" {}

variable "vpc_name" {}
variable "cluster_name" {}
variable "location" {}

variable "disable_dashboard" {}

variable "node_pool_name" {}
variable "node_count" {}
variable "min_node_count" {}
variable "max_node_count" {}
variable "node_image_type" {}
variable "machine_type" {}
variable "node_disk_size_gb" {}

variable "network" {}
variable "master_ipv4_cidr_block" {}
