terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
    }
  }
}


provider "kubernetes" {
  # version = "1.25.4"
  config_path =  var.kube_config_file
}


provider "helm" {
  kubernetes {
    config_path =  var.kube_config_file
  }
}



 