variable "project_id" {
  description = "This is the Project ID in GCP Project"
  type        = string
  default = "traefikproject"
}

variable "availability_zone_names" {
  description = "This is the Zone to use"
  type    = string
  default = "europe-west1-b"
}

variable "availability_region_names" {
  description = "This is the Region to use"
  type    = string
  default = "europe-west1-b"
}

variable "instances_names" {
  description = "This is the Name instance to use"
  type    = string
  default = "my-instance"
}

variable "machine_type" {
  description = "This is the Type machine to use"
  type    = string
  default = "f1-micro"
}

variable "tags_names" {
  description = "This is the tags, to specifie which team use the machine"
  type    = list(string)
  default = ["team", "backend"]
}

variable "image_name" {
  description = "Specifie which image to use"
  type    = string
  default = "debian-cloud/debian-9"
}

variable "vpc_network_name" {
  description = "Specifie which network to use"
  type        = string
  default = "fran-my-network"
}

variable "firewall_name" {
  description = "Specifie which firewall to use"
  type        = string
  default = "flask-app-firewall"
}