# Flutter + Firebase + Terraform + Fastlane Roadmap

This roadmap is focused on a **working prototype delivery pipeline**: basic Flutter app, Firebase backend, Terraform-managed cloud resources, and automatic store delivery with Fastlane through ACI.

## Phase 0 — Product and Delivery Baseline

- [x] Define prototype scope (single happy-path interaction only).
- [x] Define target platforms for release (`android`, `ios`, or both).
- [x] Confirm delivery channel strategy (internal testing vs production tracks).
- [x] Define ACI pipeline success criteria (build, sign, upload, notify).

## Phase 1 — Flutter App Foundation

- [x] Create Flutter app structure with environments (`dev`, `staging`, `prod`).
- [x] Add minimal navigation and one basic interactive screen.
- [x] Add state management (simple provider/bloc choice) for maintainability.
- [x] Add app configuration layer for Firebase and backend toggles.

## Phase 2 — Firebase Backend

- [x] Create Firebase project strategy.
- [x] Enable Authentication (OAuth).
- [x] Enable Firestore with minimal data model.
- [x] Add one Cloud Function/API endpoint for basic interaction.
- [x] Configure Firebase security rules and basic monitoring/logging.

## Phase 3 — Terraform Infrastructure as Code

- [x] Create Terraform root modules and environment folders.
- [x] Manage Firebase/GCP resources through Terraform where supported.
- [x] Add remote state backend and state locking strategy.
- [x] Add variables/secrets strategy (`tfvars` + secret manager).
- [ ] Add Terraform `fmt` / `validate` / `plan` checks in CI (requires GCP service-account secret).

## Phase 4 — Fastlane for Store Delivery

- [x] Configure Android Fastlane lanes (`beta`, `production`).
- [x] Configure iOS Fastlane lanes (`testflight`, `production`) if iOS is in scope.
- [x] Implement code signing strategy (keystore, certificates, profiles).
- [x] Add metadata/screenshots automation placeholders.
- [ ] Verify upload to Play Console / App Store Connect test tracks.

## Phase 5 — ACI Automation (Build + Release)

- [x] Create ACI workflow to run Flutter analyze & test steps (CI passes on every push/PR).
- [ ] Add Terraform `fmt` / `validate` / `plan` stage in CI.
- [ ] Add Fastlane `test` lane in CI (dry-run, no Play upload).
- [x] Add Fastlane stage gated by branch/tag policy (release workflow).
- [x] Add artifact retention and version tagging convention.
- [x] Add release notifications (Slack/Email/Git provider).

## Phase 6 — Security, Quality, and Operations

- [x] Add secret management for Firebase, signing keys, and store credentials.
- [x] Add static analysis and unit tests for Flutter code.
- [ ] Add smoke tests for Firebase interaction.
- [ ] Add rollback/recovery runbook for bad releases.

## Phase 7 — Go-Live Readiness

- [x] Complete store listing minimum content.
- [ ] Validate policy compliance (privacy, data usage, permissions).
- [ ] Run end-to-end release rehearsal from clean commit.
- [ ] Freeze prototype scope and ship v0.1.

## Definition of Done (Prototype)

- [ ] Flutter app installs and runs on target platform(s).
- [ ] App performs one complete basic interaction against Firebase.
- [ ] Terraform can reproduce infrastructure for each environment.
- [ ] ACI pipeline builds and triggers Fastlane delivery automatically.
- [ ] Build arrives in intended store track (internal/testflight/beta).

