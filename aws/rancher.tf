#######################################################################################################################
# RANCHER
#######################################################################################################################

# 1.
# 2.
# 3. 

//resource "null_resource" "install-rancher" {
//
//    depends_on = [ rke_cluster.cluster ]
//
//    connection {
//        type        = "ssh"
//        host        = aws_instance.k8s.public_ip
//        user        = "ubuntu"
//        private_key = join("", tls_private_key.private_key.*.private_key_pem)
//    }
//
//    provisioner "remote-exec" {
//        script = "install_rancher.sh"
//    }
//
//}
//
//resource "null_resource" "is-rancher-running" {
//
//    depends_on = [ null_resource.install-rancher ]
//
//    connection {
//        type        = "ssh"
//        host        = aws_instance.k8s.public_ip
//        user        = "ubuntu"
//        private_key = join("", tls_private_key.private_key.*.private_key_pem)
//    }
//
//    provisioner "remote-exec" {
//        script = "is_rancher_running.sh"
//    } 
//
//}
