provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraform_instance" {
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"
  tags = {
    Name = "TerraformSampleInstance"
  }
}
