resource "aws_ebs_volume" "ebsvolume" {
  availability_zone = var.myzone
  size              = var.mysize
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebsvolume.id
  instance_id = var.ebs_var_id
}
