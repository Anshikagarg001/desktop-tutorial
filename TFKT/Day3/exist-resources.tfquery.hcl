list "azurerm_resource_group" "imported_rgs"{
    provider=azurerm
    include_resource = true
    config{
        subscription_id= "db032ea8-62d9-47ad-8714-22e7c42714f3"
    }
}

list "azurerm_storage_account" "imported_strgs"{
    provider=azurerm
    include_resource = true
    config{
        subscription_id= "db032ea8-62d9-47ad-8714-22e7c42714f3"
    }
}
