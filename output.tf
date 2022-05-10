output "url" {
    value = azurerm_app_service.helloworld.default_site_hostname
}

output "name" {
    value = azurerm_app_service.helloworld.name
}

output "resource_group_name" {
    value = azurerm_resource_group.demo.name
}
