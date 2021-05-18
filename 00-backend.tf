terraform {
    backend "s3"{
        bucket = "terraform-t"
        key    = "terraform.tfstate"
        region = "us-east-1"
    }
}