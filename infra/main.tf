resource "google_storage_bucket" "cloudexam" {
  name = var.bucket_name
  location = "UE"
}