provider "google" {
    project = "innate-node-413006"
    credentials = "${file("credentials.json")}"
    #region = "us-central1"
    #zone = "us-central-c"
}


resource "google_compute_instance" "my_instance" {
    name = "terraform-instance"
    machine_type = "g2-standard-12"
    zone = "us-central1-a"
    allow_stopping_for_update = true
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    }

    scratch_disk {
        interface = "NVME"
    }

    guest_accelerator {
        type = "nvidia-l4"
        count = "1"
    }

    network_interface {
      network = google_compute_network.terraform-network.self_link
      subnetwork = google_compute_subnetwork.terraform-subnet. self_link
      access_config {
        //necessary even empty
      }
    }
    scheduling {
      on_host_maintenance = "TERMINATE"
      provisioning_model = "SPOT"
      automatic_restart = "false"
      preemptible = "true"
    }
}


resource "google_compute_network" "terraform-network" {
  name = "terraform-network"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "terraform-subnet" {
  name = "terraform-subnetwork"
  ip_cidr_range = "10.20.0.0/16"
  region = "us-central1"
  network = google_compute_network.terraform-network.id
}


resource "google_compute_firewall" "default" {
    name = "default-terraform-firewall"
    network = google_compute_network.terraform-network.id
    direction = "INGRESS"
    allow {
        protocol = "icmp"
    }
    allow {
        protocol = "tcp"
        ports = ["22","80","443","7860"]
    }
    source_ranges = ["75.4.192.68/32","35.235.240.0/20"]
    destination_ranges = []
    source_tags = []
}