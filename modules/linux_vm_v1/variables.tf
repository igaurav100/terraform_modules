
// Variables for top-level module under terraform_modules/modules

variable "resource_group_name" {
  description = "Name of the resource group to read/create resources in"
  type        = string
}

variable "vm_count" {
  description = "Number of network interfaces / VMs to create"
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "Optional VM name prefix. If empty, module will use a generated name."
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure location for resources"
  type        = string
  default     = "eastus"
}

variable "ip_configurations" {
  description = <<-EOT
		A list of ip configuration objects for each network interface. Each object should have:
		- name (string)
		- subnet_id (string)
	EOT
  type = list(object({
    name      = string
    subnet_id = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)
  default     = {}
}

