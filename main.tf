provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test_server" {
  ami           = "ami-0e86e20dae9224db8"  # Replace with your desired AMI
  instance_type = "t2.micro"
  key_name      = "key"  # Replace with the actual key pair name in AWS

  # Associate with existing security group
  vpc_security_group_ids = ["sg-0604e268389a6d96c"]

  tags = {
    Name = "TestServer"
  }
}

resource "aws_instance" "prod_server" {
  ami           = "ami-0e86e20dae9224db8"  # Same or different AMI for production
  instance_type = "t2.micro"
  key_name      = "key"  # Replace with the actual key pair name in AWS

  # Associate with existing security group
  vpc_security_group_ids = ["sg-0604e268389a6d96c"]

  tags = {
    Name = "ProdServer"
  }
}

output "test_server_ip" {
  value = aws_instance.test_server.public_ip
}

output "prod_server_ip" {
  value = aws_instance.prod_server.public_ip
}
