module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "terraform-vpc-eks"
  cidr = "10.0.0.0/16"

  azs            = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.104.0/24", "10.0.105.0/24", "10.0.106.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  create_igw = true
  enable_nat_gateway   = true
  enable_vpn_gateway   = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Username    = "daniel.munoz"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/terraform-eks" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/terraform-eks" = "shared"
  }
}