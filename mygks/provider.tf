terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "7.28.0"
        
        }
    }
}

provider "google" {
    region = var.region
    project = var.project
    credential = "./key.json"
    zone  = var.zone
    
}

terraform {
    backend "gcs" {
        prefix = "terraform/state"
        bucket = "gke-cluster-2"
        credential = "./key.json"
    
}
}
