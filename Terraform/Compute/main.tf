
resource "aws_instance" "ec2" {
  ami         		        = var.ami 
  instance_type 		= var.instance_type 
  associate_public_ip_address   = true
  key_name        		= "Ansible"
  subnet_id    			= var.subnet_public_id
  vpc_security_group_ids 	= [var.sg_id]
  
  root_block_device {
    volume_size = 20  # Size in GB
    volume_type = "gp2"
  }
  tags = {
      Name = var.servername
     }
}


