resource "google_cpntainer_cluster" "cluster" {
    name = "cluster1"
    
    location = var.region
    version = var.version
    
    remove_default_node_pool = true
    initial_node_count = 1
    networking_mode = "VPC_NATIVE"
    network         = google_compute_network.vpc.id
    subnetwork      = google_compute_subnetwork.private_network.id 

}

resource "google_node_pool_group" "primary-node" {
    name = "node_pool1"
    cluster = google_container_cluster.cluster.name
    location = google_container_cluster.cluster.location
    nade_count = 1
    version = var.version

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
