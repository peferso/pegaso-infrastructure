resource "aws_s3_bucket" "pegaso_bucket" {
    bucket = "pegaso-repository-bucket" 
    #acl = "${var.acl_value}"   
}

output "bucket_arn" {
    value = aws_s3_bucket.pegaso_bucket.arn
}