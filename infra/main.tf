resource "google_storage_bucket" "cloudexam" {
  name = var.bucket_name
  location = var.gcp_region
}

resource "google_storage_bucket_object" "sitesrc" {
  name = "index.html"
  source = "../site/index.html"
  bucket = google_storage_bucket.cloudexam.name
}

resource "google_storage_bucket_object" "sitesrc" {
  name = "script.js"
  source = "../site/script.js"
  bucket = google_storage_bucket.cloudexam.name
}

resource "google_storage_bucket_object" "sitesrc" {
  name = "styles.css"
  source = "../site/styles.css"
  bucket = google_storage_bucket.cloudexam.name
}