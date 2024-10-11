provider "aws" {
  region = "us-east-1"
}

# Step 1: Define the security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-0a01953ca2da8cf59"  # Replace with your VPC ID if necessary

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["http://44.202.9.57/32"]  # Replace with your Jenkins IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Step 2: Create the test server instance
resource "aws_instance" "test_server" {
  ami                    = "ami-0e86e20dae9224db8"  # Replace with your desired AMI
  instance_type          = "t2.micro"
  key_name               = "key"  # Replace with the actual key pair name in AWS

  # Use the security group
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "TestServer"
  }
}

# Step 3: Create the production server instance
resource "aws_instance" "prod_server" {
  ami                    = "ami-0e86e20dae9224db8"  # Same or different AMI for production
  instance_type          = "t2.micro"
  key_name               = "key"  # Replace with the actual key pair name in AWS

  # Use the security group
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "ProdServer"
  }
}

# Step 4: Output the public IP addresses
output "test_server_ip" {
  value = aws_instance.test_server.public_ip
}

output "prod_server_ip" {
  value = aws_instance.prod_server.public_ip
}
