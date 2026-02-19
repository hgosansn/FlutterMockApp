output "project_id" {
  value = google_firebase_project.default.project
}

output "firestore_database" {
  value = google_firestore_database.default.name
}
