variable "project" {
    description = "project_id"
    type = string 
    default = "satyaproject-487714"
}

variable "region" {
    description = "the region where all resource are created"
    type = string
    default = "us-central1"
}

variable "zone" {
    description = "zone name"
    type = string
    default = "us-cental1-a"
}

variable "ku8-varsion" {
    description = "ku8 version"
    type = string
    default = "1.35.1-gke.1396002"


}

variable "node_count" {
    description = "no of nodes"
    type = number
    default = 2
}
