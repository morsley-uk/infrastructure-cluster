#     ____        _               _       
#    / __ \      | |             | |      
#   | |  | |_   _| |_ _ __  _   _| |_ ___ 
#   | |  | | | | | __| '_ \| | | | __/ __|
#   | |__| | |_| | |_| |_) | |_| | |_\__ \
#    \____/ \__,_|\__| .__/ \__,_|\__|___/
#                    | |                  
#                    |_|                  

output "public-dns" {

  value = aws_instance.k8s[*].public_dns

}

output "ssh-command" {

  value = "chmod 400 generated/${var.domain_name}-${var.name}.* && ssh -i \"generated/${var.domain_name}-${var.name}.pem\" ubuntu@${aws_instance.k8s.public_dns}"

}

