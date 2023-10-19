# variable "google_credentials" {
#   description = "Google Cloud Platform credentials in JSON format"
#   type        = string
# }

provider "google" {
  credentials = jsondecode("/tmp/workspace/service-account-key.json")
  project     = "carbon-poet-377100"
  region      = "us-central1"
}

variable "ID" {
  description = "Unique identifier."
  type        = string
}

resource "google_storage_bucket" "website_bucket" {
  name     = "udapeople-${var.ID}"
  location = "us-central1"  # Replace with your desired location
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_iam_member" "bucket_policy" {
  bucket = google_storage_bucket.website_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

output "website_url" {
  value       = google_storage_bucket.website_bucket.url
  description = "URL for the website hosted on Google Cloud Storage"
}