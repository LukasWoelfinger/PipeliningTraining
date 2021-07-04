
/*
  Block for SQL variables
*/
variable "rg_name" {}
variable "tags" {}
variable "location" {}

variable "SQLSA" {
  description = "The SA user name for the azure sql server"
  default     = "__sqlAdministrator__"
}

variable "SQLPassword" {
  description = "The SA user password for the azure sql server"
  default     = "__sqlPasswordSaUser__"
}
