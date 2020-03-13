#    _____                  _               
#   |  __ \                | |              
#   | |__) |__ _ _ __   ___| |__   ___ _ __ 
#   |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#   | | \ \ (_| | | | | (__| | | |  __/ |   
#   |_|  \_\__,_|_| |_|\___|_| |_|\___|_|   
#                                         

resource "null_resource" "install-rancher" {

  depends_on = [null_resource.is-cluster-ready]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "chmod +x scripts/install_rancher.sh && bash scripts/install_rancher.sh"
  }
  
}