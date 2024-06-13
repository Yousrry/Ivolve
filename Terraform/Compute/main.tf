resource "aws_instance" "ec2" {
  ami         		        = var.ami 
  instance_type 		= var.instance_type 
  associate_public_ip_address   = true
  subnet_id    			= var.subnet_public_id
  vpc_security_group_ids 	= [var.sg_id]
  tags = {
      Name = var.servername
     }
}


