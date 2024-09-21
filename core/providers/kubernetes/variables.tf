variable "eks_cluster_id" {
  description = "EKS Cluster ID"
}

variable "eks_cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
}

variable "eks_cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
}
