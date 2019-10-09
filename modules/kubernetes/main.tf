resource "google_container_cluster" "primary" {
  name                     = "${var.cluster_name}"

  min_master_version       = "${var.gke_version}"
  node_version             = "${var.gke_version}"
  location                 = "${var.location}"
  network                  = "${var.vpc_name}"

  remove_default_node_pool = true
  initial_node_count       = 1 

  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  addons_config {
    kubernetes_dashboard {
      disabled = "${var.disable_dashboard}"
    }
  }

  ip_allocation_policy {
    use_ip_aliases = true
  }

  master_authorized_networks_config {
    cidr_blocks {
        cidr_block   = "116.50.163.210/32"
        display_name = "personal"
    }
  }

  private_cluster_config {
    enable_private_nodes   = true
    master_ipv4_cidr_block = "${var.master_ipv4_cidr_block}"
  }
}

resource "google_container_node_pool" "nodes" {
  name              = "${var.node_pool_name}"

  version           = "${var.gke_version}"
  cluster           = "${google_container_cluster.primary.name}"
  location          = "${var.location}"
  node_count        = "${var.node_count}"

  autoscaling {
    min_node_count  = "${var.min_node_count}"
    max_node_count  = "${var.max_node_count}"
  }

  node_config {
    image_type      = "${var.node_image_type}"
    machine_type    = "${var.machine_type}"
    disk_size_gb    = "${var.node_disk_size_gb}"

    oauth_scopes    = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write", 
      "https://www.googleapis.com/auth/monitoring",
    ]

    service_account = "${var.service_account}"
    metadata        = {
      disable-legacy-endpoints = "true"
    }
  }
}
