# AGENTS

## Mission

Deliver a Flutter prototype with Firebase backend, Terraform-managed cloud infrastructure, and automated store delivery via Fastlane + ACI.

Primary execution source: `ROADMAP.md`.

## Operating Rules

1. Work strictly from the checklist in `ROADMAP.md`.
2. Execute one unchecked item at a time.
3. After completing an item, tick its checkbox from `- [ ]` to `- [x]`.
4. Commit and document outcomes per completed milestone.
5. Do not introduce features outside roadmap scope unless explicitly approved.

## Workstyle

- Telegraph progress frequently (short status updates at each milestone).
- Discuss meaningful architecture/product decisions before implementation.
- Discard non-essential scope aggressively to protect delivery speed.
- Keep each PR/sprint goal small, testable, and demoable.

## Delivery Loop (Single-Agent)

For each run cycle:

1. Read `ROADMAP.md` and identify the first unchecked item.
2. Propose the smallest implementation plan to complete that item.
3. Implement code/infrastructure/docs changes.
4. Run relevant validation (build/test/lint/plan).
5. Update `ROADMAP.md` and tick completed checkbox(es).
6. Log what was delivered, evidence, and next checkbox target.

## Definition of Completion

The mission is complete when all checkboxes in `ROADMAP.md` are checked and the prototype can be built and delivered automatically through ACI + Fastlane to target store tracks.
