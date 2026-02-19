# Architecture & Delivery Decisions

This document captures the scoped decisions made during Phase 0 to keep the prototype delivery focused and fast.

---

## Phase 0 Decisions

### 1. Prototype Scope

**Single happy-path interaction:**

1. User opens the app and sees a login screen.
2. User taps **Sign in with Google** (Firebase Authentication — Google OAuth).
3. On successful auth, the app fetches a personalised welcome message for that user from **Firestore** (`users/{uid}/message`).
4. The welcome message is displayed on a Home screen.
5. User taps **Sign out** → returns to the login screen.

Everything outside this flow is out of scope for the prototype.

---

### 2. Target Platforms

**Android only** for the prototype.

- Reduces signing, provisioning, and store-setup complexity by ~50 %.
- iOS support can be added post-prototype with the same Fastlane/Firebase scaffolding already in place.

---

### 3. Delivery Channel Strategy

**Android internal testing track** on Google Play Console.

- Internal track allows upload without full Play policy review.
- Testers added via Play Console email list; no public exposure.
- Promotion to `beta` or `production` is a manual gate after internal sign-off.

---

### 4. ACI Pipeline Success Criteria

A pipeline run is considered **successful** when all of the following steps pass:

| Step | Tool | Gate |
|---|---|---|
| Static analysis | `flutter analyze` | Zero errors |
| Unit tests | `flutter test` | All pass |
| Release build | `flutter build apk --release` | Exit 0, APK produced |
| Code signing | Fastlane `sign` action / keystore | Signed APK produced |
| Upload | Fastlane `supply` → internal track | HTTP 200 from Play API |
| Notification | GitHub Actions step summary + PR comment | Posted successfully |

Pipeline is triggered on:
- Every push to `main` (build + test only).
- Every `v*` tag push (full build + sign + upload + notify).
