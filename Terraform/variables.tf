variable "bucket_name" {

 type = string 
 default = "yousry-state-bucket"
}

variable "encryption" {

 type = string 
 default = "AES256"
}

variable "table_name" {

 type = string
 default = "terraform-state-locking"
}

variable "payway" {

 type = string
 default = "PAY_PER_REQUEST"
}

variable "vpc_name" {
 
 type = string 
 default = "Ivolve-vpc"

}
variable "subnet_name" {
  type = string 
  default = "Ivolve-subnet"
}
variable "cidrblocks" {
 
 default = ["0.0.0.0/0"]
}

variable "igw_name" {

 type = string 
 default = "Ivolve"
}

variable "rt_name" {

 type = string 
 default = "Ivolve-RT"
}
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
variable "protocol" {

 type = string 
 default = "email"

}

variable "email" {

 type = string 
 default = "Mohammed.yousry510@gmail.com"
}



