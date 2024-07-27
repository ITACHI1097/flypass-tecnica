module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "terraform-vpc-eks"
  cidr = "10.0.0.0/16"

  azs            = ["us-east-1a", "us-east-1b", "us-east-1d"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  create_igw = true
  enable_nat_gateway   = true
  enable_vpn_gateway   = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Username    = "daniel.munoz"
  }

  # public_subnet_tags = {
  #   "kubernetes.io/role/elb" = "1"
  #   "kubernetes.io/cluster/terraform-eks" = "shared"
  # }

  # private_subnet_tags = {
  #   "kubernetes.io/role/internal-elb" = "1"
  #   "kubernetes.io/cluster/terraform-eks" = "shared"
  # }
}