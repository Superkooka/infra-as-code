variable "raspi-debian-distribution-name" {
  type      = string
  default   = "bullseye"
}

variable "username" {
  type      = string
  default   = ""
}

variable "password" {
  type      = string
  default   = ""
  sensitive = true
}

variable "ssh-public-key" {
  type      = string
  default   = ""
}