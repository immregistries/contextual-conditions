# Repository Instructions

## Public repository

- This repository is public. Everything committed here may be read, copied,
  and indexed by anyone.
- Do not commit private material: internal plans, funding or partner
  proposals, contact information, email, meeting recordings, unpublished
  partner data, credentials, or personal metadata in Office files.
- Source material in private working folders is not copied here. Draw on it by
  writing reviewed, public-safe prose in `content/`.

## Authority

- Markdown in `content/`, with `ContextualConditions.qmd`, `_quarto.yml`, and
  cited assets, is the canonical source for the core document.
- `ContextualConditions.qmd` defines section order. `CoreDocument.md` is
  generated; never edit it directly.
- Files in `output/` are generated artifacts, not source.
- The Confluence pages are a derived product of this repository. Comments made
  there, in GitHub issues, or in meetings are review inputs. Adjudicate
  accepted changes into `content/` and regenerate the pages.

## Status and certainty

- This is a working proposal. Never describe Contextual Conditions, or any
  part of this document, as a standard, approved, balloted, adopted, or final.
- Working decisions are current positions for discussion. Record each in
  `content/90-working-decisions.md` with its basis.
- Do not silently introduce a new claim, decision, commitment, number, owner,
  date, or change in certainty. Mark it with `<!-- CONFIRM: ... -->` beside the
  affected text for human resolution.
- When sources conflict, record an open question rather than choosing silently.
  Later sources are not automatically more authoritative.

## Concept rules

- A Contextual Condition is an operational input to immunization CDS, not a
  diagnosis, a clinical observation, the evidence behind it, a recommendation,
  or an inference rule.
- Omission means unknown, never No. Do not convert a missing value to a
  negative one.
- Keep the assertion separate from the evidence used to determine it, and from
  the recommendation logic that consumes it.
- Name the authority. Never imply a condition is universal or that similar
  labels from different authorities are equivalent.
- Respect datatype. Do not turn a date or number into a Boolean.
- Do not create clinical policy. If guidance does not settle a question, mark it
  as open.
- Keep concept and transport separate. HL7 v2, FHIR, or other representations
  are bindings of the concept, not the concept itself. Describe them only at a
  general level and link to the related InteropHub topics listed in
  `content/01-related-work.md` for detail; do not replicate their
  specifications here.
- A date meaningful to a condition is modeled as a separate Contextual
  Condition with a date value, never through HL7 v2 OBX-14 or FHIR Observation
  date elements.
- Rules for who creates, determines, or stores conditions, and for messaging
  and workflow inclusion, are out of scope; refer to topics 140 and 141.
- Code-system publication is out of scope; refer to IVC rather than restating or
  deciding its publication choices.

## Shared templates

- `process/` is a Git submodule of
  `immregistries/content-publishing-templates`, pinned to a release tag. Do not
  edit or copy files under it. Adopt changes by moving the pointer, rebuilding,
  reviewing the output, and committing.

## Validation

- After editing `content/` or `ContextualConditions.qmd`, run
  `python process/tools/build_core_markdown.py --assembly ContextualConditions.qmd`,
  then `validate.ps1`.
- Run `build.ps1` and open the output before any release.
- Review the `CONFIRM` list printed by the content check.
- Successful generation is a mechanical check, not editorial approval.
- Do not commit, push, publish, or update Confluence without explicit
  instruction.
