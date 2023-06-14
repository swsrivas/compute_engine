resource "google_compute_instance" "vm" {
  name = "terraformvm"
  zone = "europe-west1-b"
  machine_type = "e2-micro"
  tags = ["terraform" , "vm"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size = 20
    } 
  }

  network_interface {
    network = "default"
  }

  labels = {
    "env" = "learning"
  }
 
 scheduling {
   preemptible = false
 }
}
resource "google_compute_disk" "tfdisk" {
  name = "terraform-disk"
  size = 10
  zone = "europe-west1-b"
  type = "pd-ssd"
}

resource "google_compute_attached_disk" "attacheddisk" {
  disk = google_compute_disk.tfdisk.id
  instance = google_compute_instance.vm.id

}