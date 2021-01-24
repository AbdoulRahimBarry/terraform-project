provider "google" {
  project = var.project_id
  region  = var.availability_region_names
  zone    = var.availability_zone_names
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instances_names
  machine_type = var.machine_type

  tags = var.tags_names

  depends_on = [ google_compute_network.vpc_network ]

  boot_disk {
    initialize_params {
      image = var.image_name
    }
  }

  network_interface {
    # A my-network network is created for all GCP projects
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  metadata = {
     ssh-keys = "admin:${file("~/.ssh/compute_enging_key.pub")}"
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "my_firewall" {
 name    = var.firewall_name
 network = google_compute_network.vpc_network.name

 depends_on = [ google_compute_network.vpc_network ]

 allow {
   protocol = "tcp"
   ports    = ["22"]
 }

  allow {
   protocol = "tcp"
   ports    = ["443"]
 }
}