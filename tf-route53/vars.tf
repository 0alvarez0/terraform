variable "vpccidr" {
  description = "our vpcs cidr"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vpcname" {
  description = "name for our vpc"
  type        = string
  default     = "tfvpc"
}

variable "pubcidr" {
  description = "pub cidr"
  type        = string
  default     = "192.168.1.0/24"
}

variable "pubsubnetname" {
  description = "pub subnet name"
  type        = string
  default     = "tfpublicsubnet1"
}

variable "pubcidr2" {
  description = "pub cidr"
  type        = string
  default     = "192.168.2.0/24"
}

variable "pubsubnetname2" {
  description = "pub subnet name"
  type        = string
  default     = "tfpubsubnet2"
}

variable "igname" {
  description = "our igw name"
  type        = string
  default     = "tfigw"
}

variable "pubroutecidr" {
  description = "our public cidr route where it can communicate"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ngname" {
  description = "our nat gateway"
  type        = string
  default     = "tfngw"
}