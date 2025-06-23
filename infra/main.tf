resource "google_storage_bucket" "cloudexam" {
    
  name = var.bucket_name
  location = var.gcp_region

  website {
    main_page_suffix = "index.html"
    not_found_page = "lost.html"
  }
}

resource "google_storage_bucket_iam_member" "publicacacess" {
  bucket = google_storage_bucket.cloudexam.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_object" "sitesrc" {
  for_each = fileset("${path.module}/site", "*/")

  name   = each.value
  source = "${path.module}/site/${each.value}"
  bucket = google_storage_bucket.cloudexam.name
  content_type = lookup({
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    webp = "image/webp"
    gif  = "image/gif"
  }, lower(regex("\\.([a-z0-9]+)$", each.value)[0]), "application/octet-stream")
}

resource "google_storage_bucket_object" "index" {
  name = "index.html"
  source = "../site/index.html"
  bucket = google_storage_bucket.cloudexam.name
}

resource "google_storage_bucket_object" "script" {
  name = "script.js"
  source = "../site/script.js"
  bucket = google_storage_bucket.cloudexam.name
}

resource "google_storage_bucket_object" "styles" {
  name = "styles.css"
  source = "../site/styles.css"
  bucket = google_storage_bucket.cloudexam.name
}