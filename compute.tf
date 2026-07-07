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
                
                cat > /var/www/html/index.html <<'HTML'
                ${file("${path.module}/website/index.html")}
                HTML

                cat > /var/www/html/style.css <<'CSS'
                ${file("${path.module}/website/style.css")}
                CSS

                cat > /var/www/html/script.js <<'JS'
                ${file("${path.module}/website/script.js")}
                JS
                EOF

  tags = {
    Name    = "${var.project_name}-web-server"
    Project = var.project_name
  }
}