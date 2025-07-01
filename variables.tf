variable "region" {
    description = "represent regions"
    default = "ap-south-1"
    type = string
}
variable "instance_type" {
    description = "instance_type"
    default = "t2.micro"
}
variable "ami_id" {
    description = "ami-id"
    default = "ami-0d03cb826412c6b0f"
}  