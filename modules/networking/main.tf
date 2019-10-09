resource "google_compute_network" "vpc" {
  name                    = "${var.vpc_name}"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "allow" {
  name          = "${var.firewall_name}"
  network       = "${google_compute_network.vpc.name}"
  
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}
