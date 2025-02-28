locals {
  tetrate_istio_distribution_helm_config = {
    description = "Tetrate Istio Distribution - Simple, safe enterprise-grade Istio distribution"
  }

  tetrate_istio_distribution_helm_values = {
    cni = tolist([yamlencode({
      "global" : {
        "hub" : "containers.istio.tetratelabs.com",
        "tag" : "${lookup(var.cni_helm_config, "version", local.default_helm_config.version)}-tetrate-v6",
      }
    })])
    istiod = tolist([yamlencode({
      "global" : {
        "hub" : "containers.istio.tetratelabs.com",
        "tag" : "${lookup(var.istiod_helm_config, "version", local.default_helm_config.version)}-tetrate-v6",
      }
    })])
  }
}
