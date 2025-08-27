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
    owner       = "tring_of_char"
    environment = "dev"
  }
}

variable "min_size" {
  description = "VMSS instance count (N+1 requirement uses at least 2)"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM SKU for VMSS instances"
  type        = string
  default     = "Standard_B1ms"
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key (relative to repo root or absolute). Example: keys/id_rsa.pub or C:\\Users\\you\\.ssh\\id_rsa.pub"
  type        = string
  default     = "keys/id_rsa.pub"
}
