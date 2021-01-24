variable "project_id" {
  description = "This is the Project ID in GCP Project"
  type        = string
}

variable "availability_zone_names" {
  description = "This is the Zone to use"
  type    = string
}

variable "availability_region_names" {
  description = "This is the Region to use"
  type    = string
}

variable "instances_names" {
  description = "This is the Name instance to use"
  type    = string
}

variable "machine_type" {
  description = "This is the Type machine to use"
  type    = string
}

variable "tags_names" {
  description = "This is the tags, to specifie which team use the machine"
  type    = list(string)
}

variable "image_name" {
  description = "Specifie which image to use"
  type    = string
}

variable "vpc_network_name" {
  description = "Specifie which network to use"
  type        = string
}

variable "firewall_name" {
  description = "Specifie which firewall to use"
  type        = string
}