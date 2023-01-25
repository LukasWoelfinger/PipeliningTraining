/*
  Defines the variables for the main terraform file
*/
variable "SUBSCRIPTION" {
  description = "The subscription id where the ressources will be deployed"
}

/* 
  General settings for infrastructure deployment 
*/
variable "LOCATION" {
  description = "The Azure location where all resource should be created (e.g. northeurope, westeurope, centralus)"
  default     = "westeurope"
}

variable "TAGS" {
  description = "The tags for all resources. Will be used for resource name generation, too."
  type        = map(any)
  default = {
    Application = "DEMOAPP"
    Environment = "DEV"
  }
}
