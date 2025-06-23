output "site_url" {
  value = "http://${google_storage_bucket.static_site.name}.storage.googleapis.com"
  description = "URL du site déployé"
}