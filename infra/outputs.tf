output "firebase_project_id" {
  description = "Firebase project ID."
  value       = module.firebase.project_id
}

output "firestore_database" {
  description = "Firestore database name."
  value       = module.firebase.firestore_database
}
