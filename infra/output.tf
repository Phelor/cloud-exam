output "site_url" {
  value = "http://${google_storage_bucket.cloudexam.name}.storage.googleapis.com"
}