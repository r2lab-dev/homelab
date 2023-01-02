variable "invana_studio_tag" { 
  type = string 
  default = "v0.0.11" 
} 



resource "kubernetes_deployment" "invana-studio" { 

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

 

resource "kubernetes_service" "invana_studio" { 
  metadata { 
    name      = "invana-studio" 
    namespace = "default"
  } 
  #session_affinity = "ClientIP"

  spec { 
    selector = { 
      app = kubernetes_deployment.invana-studio.spec.0.template.0.metadata.0.labels.app 
    } 
    type = "ClusterIP" 
    port { 
      port        = 8300 
      target_port = 8300 
    } 
  } 
} 