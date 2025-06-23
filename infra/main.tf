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
  for_each = {
    for file in fileset("${path.module}/../site", "**/*") :
    file => file
    if !endswith(file, "/")
  }

  name   = each.key 
  source = "${path.module}/../site/${each.key}"
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
    svg  = "image/svg+xml"
  }, lower(regex("\\.([a-z0-9]+)$", each.key)[0]), "application/octet-stream")
}
