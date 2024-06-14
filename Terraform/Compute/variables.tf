variable "servername" {

 type = string 
 default = "ivolve-server"

}

variable "instance_type" {

 type = string 
 default = "t2.medium"

}

variable "ami" {

 type = string 
 default = "ami-04b70fa74e45c3917"  #Canonical, Ubuntu, 24.04 LTS, amd64

}


variable "sg_id" {


 type = string 

}


variable "subnet_public_id" {

 type = string 
}
