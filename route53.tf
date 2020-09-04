data "aws_route53_zone" "selected" {
  name = var.r53zone
}

resource "aws_route53_record" "codedeploy" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.externaldnshost}.${var.r53zone}"
  type    = "A"
  alias {
    name                   = aws_lb.ealb.dns_name
    zone_id                = aws_lb.ealb.zone_id
    evaluate_target_health = true
  }
}

data "aws_route53_zone" "selectedapp" {
  name = var.r53zone
}
