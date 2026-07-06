resource "aws_s3_bucket" "backup_bucket" {
  bucket = "cloud-infrastructure-deployment-lab-charan-backup"

  tags = {
    Name    = "${var.project_name}-backup-bucket"
    Project = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "backup_versioning" {
  bucket = aws_s3_bucket.backup_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}