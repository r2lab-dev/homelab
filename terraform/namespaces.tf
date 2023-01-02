/*
resource "kubernetes_namespace_v1" "invana-demos" {
  metadata {
    annotations = {
      name = var.invana_demos
    }
    labels = {
      mylabel = var.invana_demos
    }
    name = var.invana_demos
  }
}
*/