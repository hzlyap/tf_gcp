locals {
  workspaces = merge(local.dev, local.qa, local.staging, local.production)
  workspace  = local.workspaces[terraform.workspace]
}

terraform {
  backend "gcs" {
    credentials = "account.json"
    bucket      = "yap-remote-state-backend"
    prefix      = "terraform/state"
  }
}

provider "google" {
  credentials = "account.json"
  project     = "${local.workspace["gcp_project"]}"
  region      = "${local.workspace["region"]}"
  zone        = "${local.workspace["zone"]}"
}

module "networking" {
  source = "./modules/networking"

  vpc_name      = "${local.workspace["vpc_name"]}"
  firewall_name = "${local.workspace["firewall_name"]}"
}

module "kubernetes" {
  source = "./modules/kubernetes"

  gke_version            = "${local.workspace["gke_version"]}"
  service_account        = "${local.workspace["service_account"]}"
  vpc_name               = "${local.workspace["vpc_name"]}"
  cluster_name           = "${local.workspace["cluster_name"]}"
  location               = "${local.workspace["location"]}"
  disable_dashboard      = "${local.workspace["disable_dashboard"]}"
  node_pool_name         = "${local.workspace["node_pool_name"]}"
  node_count             = "${local.workspace["node_count"]}"
  min_node_count         = "${local.workspace["min_node_count"]}"
  max_node_count         = "${local.workspace["max_node_count"]}"
  node_image_type        = "${local.workspace["node_image_type"]}"
  machine_type           = "${local.workspace["machine_type"]}"
  node_disk_size_gb      = "${local.workspace["node_disk_size_gb"]}"
  network                = "${module.networking.name}"
  master_ipv4_cidr_block = "${local.workspace["master_ipv4_cidr_block"]}"
}
