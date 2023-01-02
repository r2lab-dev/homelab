module invana-studio{
  source = "./modules/invana-studio"
}

module default-ingress-service {
  source = "./modules/ingress"
}

#module "traefik" {
#  source  = "sculley/traefik/kubernetes"
#  version = "1.0.2"
#}
