terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.0"
    }
  }
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
}

output "vpc_id" {
  value = aws_vpc.this.id
}
