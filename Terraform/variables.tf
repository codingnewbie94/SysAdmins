variable "projectname" {
  description = "Name of the project"
  type	  = string
  default = "primal-pod-291618"
}

variable "zone" {
  type    = string
  default = "europe-west3-a"
}

variable "region" {
  type    = string
  default = "europe-west3"
}

variable "diskimage" {
  description = "Image of the disk which will be used to spin VMs, in this case its pre-built image with Packer"
  type    = string
  default = "packer-1602952086"
}

variable "interface" {
  type    = string
  default = "default"
}

variable "instancename" {
  description = "Name of the instance template"
  type    = string
  default = "instance-app-template"
}

variable "vmtype" {
  description = "Virtual machine type, in this case it will be f1-micro 2 vCPU, 1GB memory"
  type    = string
  default = "f1-micro"
}

variable "migname" {
  description = "Name of the managed instance group"
  type    = string
  default = "app-servers-managed"
}

variable "vmname" {
  description = "Name of the virtual machines"
  type    = string
  default = "appserver"
}

variable "quantity" {
  description = "Number of virtual machines created in instance managed group"
  type    = number
  default = "3"
}

variable "autoscalername" {
  description = "Name of created auto scaler"
  type    = string
  default = "http-autoscaler"
}

variable "maxreplicas" {
  description = "Maximum number of autoscaled VMs"
  type    = number
  default = "3"
}

variable "minreplicas" {
  description = "Minimum number of autoscaled VMs"
  type    = number
  default = "1"
}

variable "cooldown" {
  type    = number
  default = "60"
}

variable "usage" {
  type    = number
  default = "0.5"
}

variable "lbname" {
  type    = string
  default = "appservers-lb"
}

variable "backendname" {
  type    = string
  default = "app-servers-backend"
}

variable "hcname" {
  type    = string
  default = "app-servers-healthcheck"
}

variable "checkinterval" {
  type    = number
  default = "10"
}

variable "timeout" {
  type    = number
  default = "1"
}

variable "portcheck" {
  type    = number
  default = "80"
}
