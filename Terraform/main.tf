provider "google" {
  version                 = "3.5.0"
  credentials             = file("primal-pod-291618-f7d2c279d3f2.json")
  project                 = var.projectname
  zone                    = var.zone
}


// Instance Template creation
resource "google_compute_instance_template" "instance_template" {
  name                    = var.instancename
  machine_type            = var.vmtype
  region                  = var.region

  disk {
    source_image          = var.diskimage
  }

  network_interface {
    network               = var.interface
  }
}


// Managed Instance Group creation
resource "google_compute_instance_group_manager" "instance_group_manager" {
  name                    = var.migname
  base_instance_name      = var.vmname
  zone                    = var.zone
  target_size             = var.quantity

  version {
    instance_template     = google_compute_instance_template.instance_template.id
  }  
}


// Autoscaler creation
resource "google_compute_autoscaler" "http_autoscaler" {
  name                    = var.autoscalername
  zone                    = var.zone
  target                  = google_compute_instance_group_manager.instance_group_manager.id

  autoscaling_policy {
    max_replicas          = var.maxreplicas
    min_replicas          = var.minreplicas
    cooldown_period       = var.cooldown

    load_balancing_utilization {
      target              = var.usage
    }
  }
}


// LB creation
resource "google_compute_forwarding_rule" "http-lb" {
  name                    = var.lbname
  region                  = var.region

  load_balancing_scheme   = "INTERNAL"
  backend_service         = google_compute_region_backend_service.appservers_backend.id
  all_ports               = true
}

resource "google_compute_region_backend_service" "appservers_backend" {
  name                    = var.backendname
  region                  = var.region
  health_checks           = [google_compute_health_check.healtch_check.id]
  
}

resource "google_compute_health_check" "healtch_check" {
  name                    = var.hcname
  check_interval_sec      = var.checkinterval
  timeout_sec             = var.timeout

  tcp_health_check {
    port                  = var.portcheck
  }
}
