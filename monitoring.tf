resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggers when EC2 CPU utilization is above 80% for 10 minutes"

  dimensions = {
    InstanceId = aws_instance.web_server.id
  }

  tags = {
    Name    = "${var.project_name}-high-cpu-alarm"
    Project = var.project_name
  }

}