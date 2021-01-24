provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "gke_traefikproject_us-central1-c_traefikv6"
}

resource "helm_release" "prometheus" {
  name       = "prometheus-helm"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"

  #values = [
  #  "${file("values.yaml")}"
  #]

  namespace = "monitoring"
}

resource "helm_release" "grafana" {
  name       = "grafana-helm"

  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"

  values = [
    "${file("grafana-values.yaml")}"
  ]

  namespace = "monitoring"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}


# apiVersion: traefik.containo.us/v1alpha1
# kind: IngressRoute
# metadata:
#   name: grafana
#   namespace: monitoring
# spec:
#   entryPoints:
#     - websecure
#   routes:
#     - kind: Rule
#       match: Host(`grafana.demo.telemaque.fr`)
#       services:
#         - name: grafana-helm
#           port: 80
#   tls:
#     certResolver: myresolver