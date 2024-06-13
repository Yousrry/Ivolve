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

