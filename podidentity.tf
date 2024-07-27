# data "aws_eks_cluster" "example" {
#   name = "terraform-eks"

# }

# data "aws_eks_cluster_auth" "example" {
#   name = "terraform-eks"
# }


# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.example.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.example.token
# }

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}


resource "aws_iam_role" "example" {
  name               = "eks-pod-identity-example"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags = {
            Username = "daniel.munoz"
        }
}

resource "aws_iam_role_policy_attachment" "example_s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.example.name
  
}

resource "kubernetes_service_account" "pod-identitie-sa" {
  metadata {
    name      = "pod-identitie-sa"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role-arn"= "arn:aws:iam::111672508881:role/eks-pod-identity-example"
    }
  }
}

resource "aws_eks_pod_identity_association" "association" {
  cluster_name = module.eks.cluster_name
  namespace = var.namespace
  service_account = var.service_account_name
  role_arn = aws_iam_role.example.arn
  tags = {
            Username = "daniel.munoz"
        }
}