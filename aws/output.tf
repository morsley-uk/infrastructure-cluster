#######################################################################################################################
# Various Outputs
#######################################################################################################################

# ssh -i "morsley-uk-k8s.pem" ubuntu@ec2-3-8-194-244.eu-west-2.compute.amazonaws.com

//output "public_dns" {
//    
//    value = aws_instance.k8s[*].public_dns
//    
//}
//
//output "private_ips" {
//    
//    value = aws_instance.k8s[*].private_ip
//    
//}
//
output "ssh_command" {

    value = "ssh -i \"morsley-uk-k8s.pem\" ubuntu@${aws_instance.k8s.public_dns}"

}

