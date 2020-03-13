#     ____        _               _       
#    / __ \      | |             | |      
#   | |  | |_   _| |_ _ __  _   _| |_ ___ 
#   | |  | | | | | __| '_ \| | | | __/ __|
#   | |__| | |_| | |_| |_) | |_| | |_\__ \
#    \____/ \__,_|\__| .__/ \__,_|\__|___/
#                    | |                  
#                    |_|                  

output "public_dns" {
    
    value = aws_instance.k8s[*].public_dns
    
}

output "ssh_command" {

  value = "chmod 400 generated/morsley-io-k8s.* && ssh -i \"generated/morsley-io-k8s.pem\" ubuntu@${aws_instance.k8s.public_dns}"

}

