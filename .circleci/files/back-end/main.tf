provider "google" {
  credentials = file("/tmp/workspace/service-account-key.json")
  project     = "carbon-poet-377100"
  region      = "us-central1"
}

resource "google_compute_instance" "vm_instance" {
  name         = "back-end"
  machine_type = "c3-highmem-8"
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
  name        = "back-end-firewall"
  network     = "default"
  description = "Allow inbound traffic on port 3030, 9100 and 22"

  allow {
    protocol = "tcp"
    ports    = ["3030", "5532", "9100", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["recommendation-sys"]
}