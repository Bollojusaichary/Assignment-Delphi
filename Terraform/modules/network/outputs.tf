output "subnet_ids" {
  value = flatten([for s in module.subnet : s.subnet_id])
}

output "subnet_id" {
  value = module.subnet["private_endpoint_subnet"].subnet_id
}

output "vnet" {
  value = module.vnet.name
}
