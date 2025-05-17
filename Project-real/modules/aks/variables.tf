variable "kubernetes_version" {
  type    = string
  default = ""
}

variable "environment" {
  description = "Deployment environment name (e.g., dev, stage, prod)"
  type        = string
}

