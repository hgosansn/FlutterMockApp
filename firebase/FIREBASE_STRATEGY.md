# Firebase Project Strategy

## Project Structure

Three Firebase projects — one per environment — map directly to the app environments defined in `DECISIONS.md`.

| Environment | Firebase Project ID | Purpose |
|---|---|---|
| `dev` | `fluttermockapp-dev` | Local development & unit testing |
| `staging` | `fluttermockapp-staging` | Integration and QA |
| `prod` | `fluttermockapp-prod` | Live production data |

## Services Enabled

| Service | Usage |
|---|---|
| Firebase Authentication | Google OAuth sign-in |
| Cloud Firestore | User document with welcome message |
| Cloud Functions | `getWelcomeMessage` HTTP callable |
| Firebase App Distribution | Alternative to Play internal track for dev/staging |
| Cloud Monitoring / Logging | Error alerting via GCP |

## Firestore Data Model

```
users/
  {uid}/
    message: string       // personalised welcome message
    displayName: string   // synced from Firebase Auth at first login
    createdAt: timestamp
```

## Terraform Management

All Firebase resources are declared in `infra/` (see Phase 3).
The Firebase project itself is created via `google_firebase_project` Terraform resource.

## Credential Files

- `app/android/google-services.json` — **NOT committed** (injected by CI via secret).
- Firebase Admin SDK key — stored in GCP Secret Manager, injected at Cloud Function runtime.
