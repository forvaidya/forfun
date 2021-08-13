resource "aws_instance" "apache_ec2" {


  count = var.instance_count


  

  instance_type   = var.apache_ec2-instance_type
  ami             = var.ami
  subnet_id       = module.apache-vpc.public_subnets[count.index]
  security_groups = [aws_security_group.apache_sg.id, ]
  key_name        = var.ec2_pem_file
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 16
    volume_type           = "gp2"

  }

  tags = {
    Name = format("Apache-Member-%d", (count.index))
  }

}


