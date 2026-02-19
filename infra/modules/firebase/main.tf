# Firebase / GCP Terraform module

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
}

# ──────────────────────────────────────────────
# Enable required GCP APIs
# ──────────────────────────────────────────────
resource "google_project_service" "firebase" {
  provider           = google
  project            = var.project_id
  service            = "firebase.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "firestore" {
  provider           = google
  project            = var.project_id
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "identity_toolkit" {
  provider           = google
  project            = var.project_id
  service            = "identitytoolkit.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudfunctions" {
  provider           = google
  project            = var.project_id
  service            = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "secretmanager" {
  provider           = google
  project            = var.project_id
  service            = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

# ──────────────────────────────────────────────
# Firebase project
# ──────────────────────────────────────────────
resource "google_firebase_project" "default" {
  provider = google-beta
  project  = var.project_id

  depends_on = [google_project_service.firebase]
}

# ──────────────────────────────────────────────
# Firestore database (native mode)
# ──────────────────────────────────────────────
resource "google_firestore_database" "default" {
  provider    = google
  project     = var.project_id
  name        = "(default)"
  location_id = var.region
  type        = "FIRESTORE_NATIVE"

  depends_on = [
    google_firebase_project.default,
    google_project_service.firestore,
  ]
}

# ──────────────────────────────────────────────
# Firebase Auth — Google Sign-In
# (Configured via Firebase Console or firebase CLI;
#  Terraform manages the project, not the OAuth client.)
# ──────────────────────────────────────────────

# ──────────────────────────────────────────────
# Secret Manager — store signing keys etc.
# ──────────────────────────────────────────────
resource "google_secret_manager_secret" "android_keystore" {
  provider  = google
  project   = var.project_id
  secret_id = "android-keystore-${var.environment}"

  replication {
    auto {}
  }

  depends_on = [google_project_service.secretmanager]
}
