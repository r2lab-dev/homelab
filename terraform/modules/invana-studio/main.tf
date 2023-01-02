variable "invana_studio_tag" { 
  type = string 
  default = "v0.0.11" 
} 



resource "kubernetes_deployment" "invana_studio" { 

  metadata { 
    name      = "invana-studio" 
    namespace = "default" 
  } 

  spec { 
    replicas = 1 
    
    selector { 
      match_labels = { 
        app = "invana-studio" 
      } 
    } 

    template { 
      metadata { 
        labels = { 
          app = "invana-studio" 
        } 
      } 
      spec { 
        container { 
          image = "invanalabs/invana-studio:${var.invana_studio_tag}" 
          name  = "invana-studio" 
          port { 
            container_port = 8300 
          }
        } 
      } 
    } 
  } 
} 

 

resource "kubernetes_service" "invana_studio_svc" { 
  depends_on = [kubernetes_deployment.invana_studio]

  metadata { 
    name      = "invana-studio-svc" 
    namespace = "default"
  } 

  spec { 
    selector = { 
      app = kubernetes_deployment.invana_studio.spec.0.template.0.metadata.0.labels.app 
    } 
    session_affinity = "ClientIP"

    #type = "ClusterIP" 
    type = "NodePort"

    port { 
      port        = 8300 
      target_port = 8300 
    } 
  } 
} 