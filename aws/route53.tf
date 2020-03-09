###############################################################################
# Route 53
###############################################################################

# control.morsley.io

data "aws_route53_zone" "morsley-io" {
  name         = "morsley.io"
  private_zone = false
}

resource "aws_route53_record" "rancher-a-record" {
  zone_id = data.aws_route53_zone.morsley-io.zone_id
  name    = "rancher.morsley.io"
  type    = "A"
  ttl     = 300
  records = [aws_instance.k8s.public_dns]
}

output "route_53_name_servers" {
  value = data.aws_route53_zone.morsley-io.name_servers
}