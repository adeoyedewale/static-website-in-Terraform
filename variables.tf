/* variable "content_types" {
  type = map(string)
  default = {
    "404" = "text/html"
    "index" = "text/html"
    "error" = "image/jpg"
  }
} */

variable "content_types" {
  type = map(string)
  default = {
    "html" : "text/html",
    "css"  : "text/css",
    "js"   : "application/javascript",
    "jpg"  : "image/jpeg",
    "jpeg" : "image/jpeg",
    "png"  : "image/png",
    "gif"  : "image/gif",
    "ico"  : "image/vnd.microsoft.icon",
    "svg"  : "image/svg+xml",
    "json" : "application/json",
    "xml"  : "application/xml",
    "txt"  : "text/plain",
    # Add more content types as needed
  }
}


 variable "domain_name" {
  type        = string
  description = "The domain name for the website."
  default = "eruobodo.xyz" #var.domain_name
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
  default = "eruobodo.xyz"
}

 variable "common_tags" {
  type = map(string)
  default = {
    Environment = "production"
    Owner       = "John Doe"
  }
  description = "Static website."
}