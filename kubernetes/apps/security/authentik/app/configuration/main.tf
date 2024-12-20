terraform {
  required_version = ">= 0.12"
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2024.10.2"
    }
    sops = {
      source = "carlpett/sops"
      version = "1.1.1"
    }
  }
}
