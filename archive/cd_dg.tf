resource "aws_codedeploy_app" "cloudguarder_app" {
  name             = "cloudguarder_app"
  compute_platform = "Server"
}

resource "aws_sns_topic" "cloudguarder_sns_topic" {
  name = "cloudguarder_sns_topic"
}

resource "aws_codedeploy_deployment_config" "cloudguarder_config" {
  deployment_config_name = "CodeDeployDefault2.EC2AllAtOnce"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 2
  }
}

resource "aws_codedeploy_deployment_group" "cd_dg1" {
  app_name              = aws_codedeploy_app.cloudguarder_app.name
  deployment_group_name = "cd_dg1"
  service_role_arn      = aws_iam_role.devops_codedeploy_role.arn


  trigger_configuration {
    trigger_events = ["DeploymentFailure", "DeploymentSuccess", "DeploymentFailure", "DeploymentStop",
    "InstanceStart", "InstanceSuccess", "InstanceFailure"]
    trigger_name       = "event-trigger"
    trigger_target_arn = aws_sns_topic.cloudguarder_sns_topic.arn
  }

  auto_rollback_configuration {
    enabled = false
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    alarms  = ["my-alarm-name"]
    enabled = true
  }

  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.external_alb_tg_app1.name
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  autoscaling_groups = [aws_autoscaling_group.devops_web_asg.id]
}