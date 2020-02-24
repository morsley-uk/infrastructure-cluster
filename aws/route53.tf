###############################################################################
# Route 53
###############################################################################

# control.morsley.io

//data "aws_route53_zone" "morsley" {
//  name         = "morsley.io."
//  private_zone = false
//}
//
//output "route_53_name_servers" {
//  value = data.aws_route53_zone.morsley.name_servers
//}