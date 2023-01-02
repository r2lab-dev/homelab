 

resource "kubernetes_ingress_v1" "default-ingress-service" {
    #wait_for_load_balancer = true

    # depends_on = [kubernetes_namespace.your-namespace]
    metadata {
        name = "traefik-ingress"
    }

    spec {
        default_backend {
            service {
                name = "hello-world-svc"
                port {
                    number = 80
                }
            }
        }
    
        rule {
            host = "studio.r2lab.dev"
            http {
                path {
                    path = "/"
                    backend {
                        service {
                            name = "invana-studio-svc"
                            port {
                                number = 8300
                            }
                        }
                    }
                }
            }
        }
        rule {
            host = "studio.invana.io"
            http {
                path {
                    path = "/"
                    backend {
                        service {
                            name = "invana-studio-svc"
                            port {
                                number = 8300
                            }
                        }
                    }
                }
            }
        }
    }
}
 