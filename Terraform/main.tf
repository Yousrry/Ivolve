terraform {  
   #backend "s3" {
    # bucket         = "yousry-state-bucket"
    # key            = "terraform.tfstate"
    # region         = "us-east-1"
    # dynamodb_table = "terraform-state-locking" 
   #  encrypt        = true
  #}
  required_providers {
    aws = {
     source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region             = "us-east-1"
}

module "RemoteBackend" {
  source         = "./RemoteBackend"

}

module "Network" {

 source 	= "./Network"
}

module "Compute" {

 source 	= "./Compute"
 subnet_public_id    	= module.Network.subnet_public_id
 sg_id 			= module.Network.sg_id
}
module "Monitoring" {

  source	= "./Monitoring"
  instance_id   = module.Compute.instance_id
  
}
