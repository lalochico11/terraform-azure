terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo" {    
  name     = "demo-resources"    
  location = "eastus"    
}   

resource "azurerm_app_service_plan" "example" {  
  name                = "example-appserviceplan"  
  location            = azurerm_resource_group.demo.location  
  resource_group_name = azurerm_resource_group.demo.name  
  
  sku {  
    tier = "Standard"  
    size = "S1"  
  }  
}  

resource "azurerm_app_service" "helloworld" {  
  name                = "my-app-hello-world"  
  location            = "eastus"  
  resource_group_name = azurerm_resource_group.demo.name  
  app_service_plan_id = azurerm_app_service_plan.example.id  
  
  app_settings = {  
    "DeviceName" = "SampleDevice",  
    "DeviceId" = "2"  
  }  

  # source_control {
  #   repo_url           = "https://github.com/Azure-Samples/html-docs-hello-world.git"
  #   branch             = "master"
  #   manual_integration = true
  #   use_mercurial      = false
  # } 
}  

resource "azurerm_app_service_slot" "slot" {
  name                = "staging"
  app_service_name    = azurerm_app_service.helloworld.name
  location            = "eastus"
  resource_group_name = azurerm_resource_group.demo.name
  app_service_plan_id = azurerm_app_service_plan.example.id
  https_only = true
}

