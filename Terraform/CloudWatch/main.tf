############################## CLOUD-WATCH MONITORING ##############################
resource "aws_sns_topic" "email_topic" {
  name = "EmailAlertTopic"
}

# Subscribe Gmail address to the SNS topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.email_topic.arn
  protocol  = "email"
  endpoint  = "Mohammed.yousry510@gmail.com" 
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name                = "EC2-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 70
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  alarm_actions = [aws_sns_topic.email_topic.arn]

  dimensions = {
    InstanceId = aws_instance.ec2.id
   }
  
}

