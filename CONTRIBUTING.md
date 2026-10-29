# Contributing

Contextual Conditions is developed in the open, and discussion is the main way
the concept improves. Questions, objections, examples from implementation, and
proposed wording are all welcome.

## Ways to take part

- **Open an issue** to raise a question, challenge a working decision, or share
  an implementation experience. Issue templates are provided for general
  feedback and for proposing or challenging a working decision.
- **Join the community discussion** on InteropHub,
  [CDS Contextual Conditions, topic 7](https://informatics.immregistries.org/hub/es/topic/7),
  where meetings and discussion notes are tracked.
- **Comment on Confluence.** The HL7 Public Health Work Group pages are copies of
  this document. Comments there are brought back here for consideration.
- **Propose a change** with a pull request against the Markdown in `content/`.
  Explain the reasoning in the pull request description. Substantive changes
  are usually easier to agree on in an issue first.

## How changes are decided

The maintainers consider feedback, discuss it with the community where needed,
and record the outcome in `content/90-working-decisions.md`. A working decision
is the current position for discussion, not a final decision, and it can be
revisited.

## Pull request checklist

- Edit files in `content/`, not `CoreDocument.md` or anything under `process/`.
- Regenerate the reading copy:
  `python process/tools/build_core_markdown.py --assembly ContextualConditions.qmd`.
- Run `validate.ps1`, or let GitHub Actions run the same checks.
- Do not include private, unpublished, or personal information.

By contributing, you agree that your contribution is licensed under this
repository's licenses: CC BY 4.0 for content and Apache 2.0 for code.

## Conduct

Participation is governed by the [Code of Conduct](CODE_OF_CONDUCT.md).
