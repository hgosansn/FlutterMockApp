# FlutterMockApp

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-backend-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform&logoColor=white)](https://www.terraform.io)
[![Fastlane](https://img.shields.io/badge/Fastlane-delivery-00F200?logo=fastlane&logoColor=white)](https://fastlane.tools)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![CI](https://img.shields.io/github/actions/workflow/status/hgosansn/FlutterMockApp/ci.yml?branch=main&label=CI&logo=github)](https://github.com/hgosansn/FlutterMockApp/actions)

A **Flutter prototype** wired to a **Firebase** backend, with cloud infrastructure managed by **Terraform** and automated store delivery through **Fastlane** + **ACI** (Automated CI pipeline).

---

## Overview

FlutterMockApp is a delivery-focused prototype designed to validate a full end-to-end mobile release pipeline. The goal is a single happy-path interaction running on Android (and optionally iOS), deployed automatically from a clean commit to a store test track.

| Layer | Technology |
|---|---|
| Mobile App | Flutter (Dart) |
| Auth & Database | Firebase Authentication + Firestore |
| Serverless | Firebase Cloud Functions |
| Infrastructure as Code | Terraform (GCP/Firebase) |
| Store Delivery | Fastlane (Play Console / App Store Connect) |
| CI/CD | ACI pipeline |

---

## Roadmap

See [`ROADMAP.md`](ROADMAP.md) for the full phased delivery plan:

- **Phase 0** — Product & Delivery Baseline
- **Phase 1** — Flutter App Foundation
- **Phase 2** — Firebase Backend
- **Phase 3** — Terraform Infrastructure as Code
- **Phase 4** — Fastlane Store Delivery
- **Phase 5** — ACI Automation
- **Phase 6** — Security, Quality & Operations
- **Phase 7** — Go-Live Readiness

---

## Getting Started

> 🚧 Project is in early setup phase. Instructions will be updated as each phase is completed.

```bash
# Clone the repo
git clone https://github.com/hgosansn/FlutterMockApp.git
cd FlutterMockApp

# Install Flutter dependencies (once Flutter app is scaffolded)
flutter pub get

# Run on device/emulator
flutter run
```

---

## Project Structure

```
FlutterMockApp/
├── app/                  # Flutter source (added in Phase 1)
├── infra/                # Terraform modules (added in Phase 3)
├── fastlane/             # Fastlane lanes (added in Phase 4)
├── .github/workflows/    # ACI pipeline definitions (added in Phase 5)
├── ROADMAP.md            # Phased delivery checklist
└── AGENTS.md             # Agent operating rules
```

---

## Contributing

This project follows a single-agent delivery loop defined in [`AGENTS.md`](AGENTS.md). Each contribution should map to a checklist item in the roadmap.

---

## License

[MIT](LICENSE)
