provider "aws"  {
	profile = "default"
	region = "us-west-2"
}

resource "aws_s3_bucket" "tf_course" {
	bucket = "tftesting2022-10-31"
	acl    = "private"
}
