# Root-level variables (edit terraform.tfvars to change values)

variable "prefix" {
  description = "Name prefix for resources"
  type        = string
  default     = "autoheal"
}

variable "location" {
  description = "Azure location to deploy resources into (must match danny_rg location)"
  type        = string
}

# Due to nature setting in Azure - this build targets an existed resource group.
# There would be a senrio this build will create a new resource group.
variable "resource_group_name" {
  description = "EXISTING resource group name to deploy into"
  type        = string
  default     = "existing_resource_group_name_here"
}

variable "manage_resource_group_tags" {
  description = "If true, Terraform will manage tags on the existing resource group (update tags). Set false to leave RG tags untouched."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags applied to resources (and optionally to RG if manage_resource_group_tags=true)."
  type        = map(string)
  default = {
    project     = "autohealing"
    owner       = "you@example.com"
    environment = "dev"
  }
}
