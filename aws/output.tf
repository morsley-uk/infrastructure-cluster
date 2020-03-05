#######################################################################################################################
# Various Outputs
#######################################################################################################################

//output "public_dns" {
//    
//    value = aws_instance.k8s[*].public_dns
//    
//}

//output "private_ips" {
//    
//    value = aws_instance.k8s[*].private_ip
//    
//}

output "ssh_command" {

  value = "chmod 400 rancher/morsley-uk-k8s.* && ssh -i \"rancher/morsley-uk-k8s.pem\" ubuntu@${aws_instance.k8s.public_dns}"

}

