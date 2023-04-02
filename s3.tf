locals {
  files = fileset("./myfiles", "*")
}

resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${var.bucket_name}"
  acl    = "public-read"
  policy = data.aws_iam_policy_document.allow_public_s3_read.json

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["www.${var.domain_name}"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags = var.common_tags
}

resource "aws_s3_bucket" "root_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    redirect_all_requests_to = "www.${var.domain_name}"
  }

  tags = var.common_tags
}

resource "aws_s3_bucket_object" "www_bucket_objects" {
  for_each = {
    for file in local.files :
    file => {
      content_type = lookup(var.content_types, regex("\\.([^.]+)$", file)[0], "application/octet-stream")
      source       = "./myfiles/${file}"
    }
  }

  bucket       = aws_s3_bucket.www_bucket.id
  key          = each.key
  source       = each.value.source
  content_type = each.value.content_type
  depends_on   = [aws_s3_bucket.www_bucket]
}

data "aws_iam_policy_document" "allow_public_s3_read" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:s3:::www.${var.bucket_name}/*",
    ]
  }
}
