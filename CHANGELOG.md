# Changelog

All notable changes to Listing Forge will be documented in this file.

## [1.1.0] - 2026-04-29

### Fixed
- **Critical**: HTTP Request nodes for Vision, Research, Claude, GPT, and SEO no longer use templated JSON bodies. All request bodies are now built in upstream Code nodes using JS template literals, then passed to the HTTP node as a clean serialized object. This eliminates the entire class of "JSON Body is not valid JSON" errors that bit the original release whenever input contained quotes or special characters.
- GUI now correctly handles array-wrapped responses from n8n (n8n's "Respond with all incoming items" wraps the response in an array; the GUI now unwraps it).
- GUI tag rendering no longer escapes HTML when displaying tag chips.

### Changed
- Workflow architecture: Code-node-first pattern for all HTTP request bodies.
- Brand defaults made generic ("Your Shop") so the workflow works out of the box for anyone, not just Lumaisla.

## [1.0.0] - 2026-04-29

### Added
- Initial public release.
- Multi-model AI pipeline: Gemini Vision + Gemini Pro (grounded research) + Claude Opus + GPT + Gemini Pro (SEO).
- Single-page HTML GUI with image drop-zone, brief title, notes, product type chips, marketplace selector, voice anchors.
- n8n workflow with webhook entry, ping-test branch, full pipeline, and structured response.
- Docker compose deployment for the static GUI behind nginx.
- Full documentation chain (00–10) covering everything from prerequisites to customization.
- Quick-install helper script.
