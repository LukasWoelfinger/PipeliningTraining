/*
  Defines the variables for the main terraform file
*/
variable "subscription" {
  description = "The subscription id where the ressources will be deployed"
  default     = "__subscriptionid__"
}

/* 
  General settings for infrastructure deployment 
*/
variable "location" {
  description = "The Azure location where all resource should be created (e.g. northeurope, westeurope, centralus)"
  default     = "__location__"
}

variable "tags" {
  description = "The tags for all resources. Will be used for resource name generation, too."
  type        = map(any)
  default = {
    # Used for service name generation
    Application = "__tf_applicationname__"
    Environment = "__tf_environmentname__"
  }
}

/*
  Variables to inform user about the backend storage location of the terraform state.
  ATTENTION: Do not use this variables in main file. Backend configuration block requires static values!
*/
variable "tf_storageaccount" {
  description = "Caches the name of the terraform storrage account used for safing the state. Used for output information only!"
  default     = "__tf_storageaccount__"
}

variable "tf_containername" {
  description = "Output cache of the container name storring the terraform state file. Used for output information only!"
  default     = "__tf_containername__"
}

variable "key" {
  description = "Output cache of the terraform state file name. Used for output information only!"
  default     = "__tf_applicationname__-__tf_environmentname__-terraform.tfstate"
}
