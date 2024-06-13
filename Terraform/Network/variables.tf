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


