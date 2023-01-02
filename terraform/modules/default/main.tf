resource "kubernetes_deployment" "hello_world" { 

  metadata { 
    name      = "hello-world" 
    namespace = "default" 
  } 

  spec { 
    replicas = 1 
    
    selector { 
      match_labels = { 
        app = "hello-world" 
      } 
    } 

    template { 
      metadata { 
        labels = { 
          app = "hello-world" 
        } 
      } 
      spec { 
        container { 
          image = "rancher/hello-world" 
          name  = "hello-world" 
          port { 
            container_port = 80 
          }
        } 
      } 
    } 
  } 
} 

 

resource "kubernetes_service" "hello_world_svc" { 
  depends_on = [kubernetes_deployment.hello_world]

  metadata { 
    name      = "hello-world-svc" 
    namespace = "default"
  } 

  spec { 
    selector = { 
      app = kubernetes_deployment.hello_world.spec.0.template.0.metadata.0.labels.app 
    } 
    session_affinity = "ClientIP"

    type = "NodePort"

    port { 
      port        = 80 
      target_port = 80 
    } 
  } 
} 