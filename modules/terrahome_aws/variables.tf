variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)."
  }
}

# variable "bucket_name" {
#   description = "S3 Bucket Name"
#   type        = string

#   validation {
#     condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
#     error_message = "Bucket name must be between 3 and 63 characters and can only contain lowercase letters, numbers, hyphens, and periods."
#   }
# }

variable "public_path" {
  description = "The file path for the public directory"
  type        = string
}

variable "content_version" {
  description = "Content version (positive integer starting at 1)"
  type        = number

  validation {
    condition     = var.content_version >= 1
    error_message = "Content version must be a positive integer starting at 1."
  }
}
