resource "kubernetes_ingress_v1" "default-ingress-service" {
    # depends_on = [kubernetes_namespace.your-namespace]
    metadata {
        name = "default-ingress-service"
    }

    spec {
        rule {
            host = "proxy.r2lab.dev"
            http {
                path {
                    path = "/"
                    backend {
                        service {
                            name = "invana-studio"
                            port {
                                number = 8300
                            }
                        }
                    }
                }
            }
        }

        # (Optional) Add an SSL Certificate
        # tls {
        #     secret_name = "ssl-certificate-object"
        #     hosts = ["your-domain"]
        # }
    }
}