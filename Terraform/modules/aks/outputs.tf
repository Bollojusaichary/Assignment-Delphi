output "cluster_name" { 
value = azurerm_kubernetes_cluster.this.name 
}

output "kubelet_identity_object_id" { 
value = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id 
}

output "kubeconfig_raw" { 
value = azurerm_kubernetes_cluster.this.kube_config_raw 
}
