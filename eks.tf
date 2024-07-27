module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~>19.0"

  cluster_name = "terraform-eks"
  cluster_version = "1.30"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true

  cluster_addons = {

    coredns = {
        resolve_conflict_on_create = "OVERWRITE"
    }

    vpc-cni = {
        resolve_conflict_on_create = "OVERWRITE"
    }

    kube-proxy = {
        resolve_conflict_on_create = "OVERWRITE"
    }

    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    node_group = {
        desired_capacity = 1
        max_capacity = 2
        min_capacity = 1
        instance_type = ["t2.micro"]
        tags = {
            Username = "daniel.munoz"
        }

    }
  }

}

resource "kubernetes_deployment_v1" "test" {
  metadata {
    name = "test2"
    labels = {
      app = "test2"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "test2"
      }
    }
    template {
      metadata {
        labels = {
          app = "test2"
        }
      }
      spec {
        service_account_name= "pod-identitie-sa"
        container {
          image = "public.ecr.aws/p5a8f8s8/container1:latest"
          name = "container1"
          volume_mount {
            name = "script-volume"
            mount_path = "/root/output/"
          }
        }
        container {
          image = "public.ecr.aws/p5a8f8s8/container2:latest"
          name = "container2"
          volume_mount {
            name = "script-volume"
            mount_path = "/root/output/"
          }
        }
        volume {
          name = "script-volume"
          empty_dir {
            size_limit = "500Mi"
          }
      }
      }
      
    }
  }
}