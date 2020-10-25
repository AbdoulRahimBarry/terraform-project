resource "aws_eip" "lb" {
  instance = var.eip_ident
  vpc      = true

  provisioner "local-exec" {
    command = "echo PUBLIC EIP ${aws_eip.lb.public_ip} >> infos_ec2.txt"
  }

}
