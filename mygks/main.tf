resource "google_container_cluster" "cluster" {
    name = "cluster1"
    
    location = var.region
    min_master_version = var.ku8-varsion
    
    remove_default_node_pool = true
    initial_node_count = 1
    networking_mode = "VPC_NATIVE"
    network         = google_compute_network.vpc.id
    subnetwork      = google_compute_subnetwork.private_network.id 

}

resource "google_container_node_pool" "primary-node" {
    name = "node_pool1"
    cluster = google_container_cluster.cluster.name
    location = google_container_cluster.cluster.location
    node_count = 1
    node_version = var.ku8-varsion

    management {
        auto_repair = true
        auto_upgrade = true
    }

    node_config {
        machine_type ="e2-medium"
        image_type = "COS_CONTAINERD"
        disk_size_gb = "50"
        disk_type = "pd-standard"
    }

    autoscaling {
        max_node_count = 3
        min_node_count = 1
    
    }

}
