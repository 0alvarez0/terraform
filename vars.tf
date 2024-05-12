// s3 variables
variable "bucketname" {
  description = "the name of my bucket"
  type        = string
  default     = "jptf-state-bucket"
}

variable "versstatus" {
  description = "status of versioning"
  type        = string
  #   default     = "Enabled"
}

// vpc variables
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

variable "privcidr" {
  description = "pri cidr"
  type        = string
  default     = "192.168.2.0/24"
}

variable "privsubnetname" {
  description = "pri subnet name"
  type        = string
  default     = "tfprivatesubnet1"
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