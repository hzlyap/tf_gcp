locals {
  staging = {
    staging = {
      gke_version            = "1.13.10-gke.0"
      service_account        = "terraform@tf-gcp-255200.iam.gserviceaccount.com"

      gcp_project            = "tf-gcp-staging"
      region                 = "asia-southeast1"
      zone                   = "asia-southeast1-a"

      vpc_name               = "main"
      firewall_name          = "allowed-ports"

      cluster_name           = "yap-staging"
      location               = "asia-southeast1"
      master_ipv4_cidr_block = "10.30.0.0/28"
      
      disable_dashboard      = "false"
      
      node_pool_name         = "k8s-node"
      node_count             = 1
      min_node_count         = 1
      max_node_count         = 2
      node_image_type        = "ubuntu"
      machine_type           = "n1-standard-2"
      node_disk_size_gb      = 10
    }
  }
}

