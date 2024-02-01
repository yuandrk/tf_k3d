terraform {
  required_providers {
    k3d = {
      source  = "pvotal-tech/k3d"
      version = "0.0.7"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "1.2.2"
    }
  }
}

provider "k3d" {
  # Конфігурація провайдера k3d
}

resource "k3d_cluster" "dev" {
  name = "dev"
  servers = 1
  agents = 1


}

resource "null_resource" "kubeconfig" {
  depends_on = [k3d_cluster.dev]

  provisioner "local-exec" {
    command = "cat $(k3d kubeconfig write ${k3d_cluster.dev.name}) > ${path.module}/kubeconfig"
  }
}

provider "flux" {
  kubernetes = {
      config_path = "${path.module}/kubeconfig"
  }
  git = {
    url  = "https://github.com/${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}.git"
    http = {
      username    = "git"
      password    =  var.GITHUB_TOKEN
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path = "clusters/${var.CLUSTER_NAME}"
}

