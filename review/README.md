# Review Inputs

Feedback arrives as GitHub issues, Confluence comments, meeting discussion, and
comments on generated Word or HTML documents. None of it changes the concept
until it is adjudicated into `content/`.

- **GitHub issues** are the preferred record. Link the issue from the working
  decision or content change it produced.
- **Confluence comments, InteropHub discussion notes, and meeting feedback** are summarized as a GitHub issue,
  or, when several points arrive together, in a dated file here such as
  `2026-11-phwg-call.md`. Record the substance and source, not personal
  details.
- **Comments made on the web guide** are downloaded as JSON and turned into a
  dated review record with
  `python process/tools/import_guide_comments.py <files>`.
- **Comments in generated documents** are transcribed the same way. Do not edit
  the generated document as if it were source.

Current review records:

- [2026-10-29-initial-source-review.md](2026-10-29-initial-source-review.md):
  comparison of the existing sources made while setting up the repository.
- [2026-10-29-v0.1-drafting-notes.md](2026-10-29-v0.1-drafting-notes.md):
  where the version 0.1 concept text came from and the choices made in drafting it.

When a review input is resolved, note the outcome: accepted into `content/`,
recorded as a working decision, kept as an open question, or declined with a
reason.
