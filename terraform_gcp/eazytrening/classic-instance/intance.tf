provider "google" {
  project = "traefikproject"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-instance"
  machine_type = "f1-micro"

  tags = ["team", "backend"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }

  metadata = {
     ssh-keys = "admin:${file("~/.ssh/compute_enging_key.pub")}"
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
 name    = "flask-app-firewall"
 network = google_compute_network.vpc_network.self_link

 allow {
   protocol = "tcp"
   ports    = ["22"]
 }

  allow {
   protocol = "tcp"
   ports    = ["443"]
 }
}