module "cname" {
  source = "./modules/cname"

  cf_target  = aws_lb.load-balancer.dns_name
  cf_cname   = var.cf_cname
  cf_zone_id = data.cloudflare_zones.website.zones[0].id
  cf_ttl     = var.cf_ttl
  cf_proxied = var.cf_proxied
}



module "apache-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc-name
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]


  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



