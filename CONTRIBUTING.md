# Contributing to Listing Forge

Thanks for thinking about contributing. This project started as one maker's tool and got cleaned up for the community. PRs welcome.

## Ways to help

### Report bugs

Open an issue with:
- What you were trying to do
- What happened instead
- Screenshots if helpful (redact API keys!)
- Your n8n version and OS

### Improve the docs

The docs are written for non-technical readers. If something tripped you up, that's a doc bug worth fixing. Open a PR or an issue describing what was unclear.

### Share customizations

Built a great prompt? A new voice anchor? A workflow extension? Open a PR or share in the discussions tab.

### Build for a new platform

If you wire up a publish-to-Etsy or publish-to-Shopify branch and want to share, that's a great PR.

## Pull request guidelines

- Keep changes small and focused. One PR = one change.
- Test your change end-to-end before submitting (run a real forge, see real output).
- Update the CHANGELOG.md with a note about what you changed.
- If you're adding a feature, add a section to the relevant doc file.
- Don't break existing functionality. If your change requires existing users to migrate, document the migration steps.

## What to avoid

- Don't add tracking, analytics, or telemetry of any kind. The whole point is local-first.
- Don't add a paywall or "premium" features.
- Don't hardcode anyone's branding. The workflow should work for any maker.
- Don't add features that would lock users into a specific vendor (e.g. requiring a specific Shopify plan).

## Local development

To work on the GUI:
1. Edit `gui/index.html`
2. Hard-refresh your browser to test
3. The nginx config disables caching in dev mode, so changes are instant

To work on the workflow:
1. Open n8n
2. Make your changes in the workflow editor
3. Export the workflow (top-right menu → Download)
4. Replace `workflow/listing-forge.json` with your export
5. Diff it against the original to see your changes

## Questions?

Open an issue with the "question" label or ping in discussions.

Thanks for helping makers ship better listings faster.
