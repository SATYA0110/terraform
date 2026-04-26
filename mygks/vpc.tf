resource "google_compute_network" "vpc" {
    name = "vpc1"
    auto_create_subnetwork = false
}

resource "google_compute_subnetwork" "public_network" {
    name = "public_subnet"
    cidr_range = "10.0.0.0/16"
    region = var.region
    network = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "private_network" {
    name = "private_subnate"
    cidr_range = "10.0.5.0/16"
    network = google_compute_network.vpc.id
    region = var.region
}

resource "google_compute_firewall" "inbound" {
    name = "ingress"
    network = google_compute_network.vpc.id
    allow {
        protocol = "all"
    }
    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "outbound" {
    name = "egress"
    network = google_compute_network.vpc.id

    allow {
        protocol = ["tcp", "icmp"]
        ports = ["22", "3379"]
    }
    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "gke_firewall" {
    name = "gke-ip"
    network = google_compute_network.vpc.id

    allow {
        protocol = "tcp"
        ports = ["22", "443", "10250", "15017"]
    }
    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_router" "router" {
    name = "router"
    region = var.region
    network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "gke-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
