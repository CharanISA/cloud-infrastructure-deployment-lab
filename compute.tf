data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "cloud-lab-key"

  user_data = <<-EOF
                #!/bin/bash
                dnf update -y
                dnf install -y httpd
                systemctl enable httpd
                systemctl start httpd
                echo "<h1>Cloud Infrastructure Deployment Lab</h1><p>Provisioned with Terraform. Hosted on AWS EC2. Built by Charan.</p>" > /var/www/html/index.html
                EOF

  tags = {
    Name    = "${var.project_name}-web-server"
    Project = var.project_name
  }

}