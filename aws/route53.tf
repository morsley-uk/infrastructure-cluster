###############################################################################
# Route 53
###############################################################################

# rancher.morsley.io

data "aws_route53_zone" "morsley-io" {
  
  name         = var.domain_name
  private_zone = false
  
}

resource "aws_route53_record" "rancher-a-record" {

  zone_id = data.aws_route53_zone.morsley-io.zone_id
  name    = var.hostname
  type    = "A"
  ttl     = 300
  records = [aws_instance.k8s.public_ip]

}

//resource "aws_route53_record" "rancher-cname-record" {
//  zone_id = data.aws_route53_zone.morsley-io.zone_id
//  name    = var.hostname
//  type    = "CNAME"
//  ttl     = 300
//  records = [aws_instance.k8s.public_dns]
//}

output "route_53_name_servers" {
  value = data.aws_route53_zone.morsley-io.name_servers
}