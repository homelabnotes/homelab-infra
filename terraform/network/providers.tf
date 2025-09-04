terraform {
  required_providers {
    routeros = {
      source = "terraform-routeros/routeros"
    }
  }
}

provider "routeros" {
  hosturl        = "https://10.10.0.1"        
  username       = "terraform"                        
  password       = var.terraform_password                            
  ca_certificate = "/home/david/certs/rb5009.pem" 
  insecure       = false                          
}