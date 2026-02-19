# Flutter + Firebase + Terraform + Fastlane Roadmap

This roadmap is focused on a **working prototype delivery pipeline**: basic Flutter app, Firebase backend, Terraform-managed cloud resources, and automatic store delivery with Fastlane through ACI.

## Phase 0 — Product and Delivery Baseline

- [x] Define prototype scope (single happy-path interaction only).
- [x] Define target platforms for release (`android`, `ios`, or both).
- [x] Confirm delivery channel strategy (internal testing vs production tracks).
- [x] Define ACI pipeline success criteria (build, sign, upload, notify).

## Phase 1 — Flutter App Foundation

- [ ] Create Flutter app structure with environments (`dev`, `staging`, `prod`).
- [ ] Add minimal navigation and one basic interactive screen.
- [ ] Add state management (simple provider/bloc choice) for maintainability.
- [ ] Add app configuration layer for Firebase and backend toggles.

## Phase 2 — Firebase Backend

- [ ] Create Firebase project strategy.
- [ ] Enable Authentication (OAuth).
- [ ] Enable Firestore with minimal data model.
- [ ] Add one Cloud Function/API endpoint for basic interaction.
- [ ] Configure Firebase security rules and basic monitoring/logging.

## Phase 3 — Terraform Infrastructure as Code

- [ ] Create Terraform root modules and environment folders.
- [ ] Manage Firebase/GCP resources through Terraform where supported.
- [ ] Add remote state backend and state locking strategy.
- [ ] Add variables/secrets strategy (`tfvars` + secret manager).
- [ ] Add validation and plan checks in CI.

## Phase 4 — Fastlane for Store Delivery

- [ ] Configure Android Fastlane lanes (`beta`, `production`).
- [ ] Configure iOS Fastlane lanes (`testflight`, `production`) if iOS is in scope.
- [ ] Implement code signing strategy (keystore, certificates, profiles).
- [ ] Add metadata/screenshots automation placeholders.
- [ ] Verify upload to Play Console / App Store Connect test tracks.

## Phase 5 — ACI Automation (Build + Release)

- [ ] Create ACI workflow to run Flutter build/test steps.
- [ ] Add Terraform `fmt` / `validate` / `plan` stage.
- [ ] Add Fastlane stage gated by branch/tag policy.
- [ ] Add artifact retention and version tagging convention.
- [ ] Add release notifications (Slack/Email/Git provider).

## Phase 6 — Security, Quality, and Operations

- [ ] Add secret management for Firebase, signing keys, and store credentials.
- [ ] Add static analysis and unit tests for Flutter code.
- [ ] Add smoke tests for Firebase interaction.
- [ ] Add rollback/recovery runbook for bad releases.

## Phase 7 — Go-Live Readiness

- [ ] Complete store listing minimum content.
- [ ] Validate policy compliance (privacy, data usage, permissions).
- [ ] Run end-to-end release rehearsal from clean commit.
- [ ] Freeze prototype scope and ship v0.1.

## Definition of Done (Prototype)

- [ ] Flutter app installs and runs on target platform(s).
- [ ] App performs one complete basic interaction against Firebase.
- [ ] Terraform can reproduce infrastructure for each environment.
- [ ] ACI pipeline builds and triggers Fastlane delivery automatically.
- [ ] Build arrives in intended store track (internal/testflight/beta).

