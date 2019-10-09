output "master_endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
}

output "master_version" {
  value = "${google_container_cluster.primary.master_version}"
}

output "services_ipv4_cidr" {
  value = "${google_container_cluster.primary.services_ipv4_cidr}"
}
