variable "bucket_name" {
    description = "The state Bucket name"
    default = "<Enter your bucker name>"
}

variable "dynamodb_name" {
    description = "The DynamoDB table name for locking"
    default = "<Enter your dynamo db table name>"
}