
# Input values - change to match your environment.
prefix                = "autoheal"
location              = "Australia Southeast"
resource_group_name   = "target_resource-grp_name_here" # Please check rg on Azure and update the name here
manage_resource_group_tags = false   # set true if you want Terraform to update RG tags
tags = {
  project     = "autohealing"
  owner       = "String_of_char"
  environment = "dev"
}

vm_size  = "Standard_B1ms"
ssh_public_key_path = "C:\\Folder\\subfolder\\.ssh\\id_rsa.pub" # IMPORTANT: set ssh_public_key_path to point to a real .pub file on your machine
