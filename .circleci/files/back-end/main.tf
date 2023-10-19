provider "google" {
  credentials = file("/Users/Zedan/carbon-poet-377100-3ec7ee9b8da0.json")
  project     = "carbon-poet-377100"
  region      = "us-central1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "back-end"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"
  tags         = ["recommendation-sys"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20230918"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

}

resource "google_compute_firewall" "back_end_firewall" {
  name        = "back_end_firewall"
  network     = "default"
  description = "Allow inbound traffic on port 3030 and 22"

  allow {
    protocol = "tcp"
    ports    = ["3030", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["recommendation-sys"]
}