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
    Application = "__applicationname__"
    Environment = "__environmentname__"
  }
}

/*
  Variables to inform user about the backend storage location of the terraform state.
  ATTENTION: Do not use this variables in main file. Backend configuration block requires static values!
*/
variable "terraformstorageaccount" {
  description = "Caches the name of the terraform storrage account used for safing the state. Used for output information only!"
  default     = "__terraformstorageaccount__"
}

variable "terraformcontainername" {
  description = "Output cache of the container name storring the terraform state file. Used for output information only!"
  default     = "__terraformcontainername__"
}

variable "key" {
  description = "Output cache of the terraform state file name. Used for output information only!"
  default     = "__applicationname__-__environmentname__-terraform.tfstate"
}

/*
  Block for SQL variables
*/
variable "SQLSA" {
  description = "The SA user name for the azure sql server"
  default     = "__sqlAdministrator__"
}

variable "SQLPassword" {
  description = "The SA user password for the azure sql server"
  default     = "__sqlPasswordSaUser__"
}
