provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "test_server" {
  ami           = "ami-0c55b159cbfafe01e"  # Replace with your desired AMI
  instance_type = "t2.micro"

  tags = {
    Name = "TestServer"
  }
}

resource "aws_instance" "prod_server" {
  ami           = "ami-0c55b159cbfafe01e"  # Same or different AMI for production
  instance_type = "t2.micro"

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
