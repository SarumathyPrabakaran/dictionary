variable "cidr_vpc" {
  description = "The CIDR for the vpc"
  default     = "10.1.0.0/16"
}

variable "cidr_subnet_public" {
  default = "10.1.1.0/24"
}
