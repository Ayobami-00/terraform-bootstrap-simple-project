# Datasource: 
data "aws_eks_cluster_auth" "cluster" {
  name = var.eks_cluster_id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_certificate_authority_data)
  token = data.aws_eks_cluster_auth.cluster.token
}

