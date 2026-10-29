# Contextual Conditions

> **Status:** Working proposal for community discussion. This is not a published
> standard, an HL7 ballot, or a final decision.

Immunization recommendations increasingly depend on more than a patient's
demographics and vaccination history: pregnancy, immune status, prior disease,
travel, occupation, maternal vaccination, and other factors that immunization
Schedule Authorities identify. **Contextual Conditions** are a proposed,
bounded set of inputs, defined by those authorities, that a requesting system
supplies to immunization clinical decision support (CDS) so that each new
factor becomes a vocabulary addition rather than a new interface design.

This repository develops the concept in the open and records the working
decisions reached on it.

## Start here

1. Read the complete [GitHub reading copy](CoreDocument.md), or browse the
   [canonical source sections](content/README.md).
2. See the [working decisions and open questions](content/90-working-decisions.md).
3. Read [how to contribute](CONTRIBUTING.md).

## What belongs here, and what does not

This project covers the **concept**: its definition, principles, boundaries,
and working decisions. It describes the HL7 v2 and FHIR representations only at
a general level; their detailed specifications belong to the related
[InteropHub topics](content/01-related-work.md), which depend on this concept.
It does not publish Contextual Condition codes or
values. That is an operational activity, currently being explored by the
Immunization Vocabularies Collaborative at <https://ivci.org/contextual-conditions/>
and itself still a proposal.

## Source of truth and Confluence

The Markdown in `content/` is the authoritative source. The HL7 Public Health
Work Group Confluence pages are regenerated from it for sharing and feedback:

- [CDS Contextual Conditions](https://confluence.hl7.org/spaces/PHWG/pages/453920359/CDS+Contextual+Conditions)
- [CDS Contextual Conditions in HL7 v2](https://confluence.hl7.org/spaces/PHWG/pages/468260886/CDS+Contextual+Conditions+in+HL7+v2)

Comments made on Confluence are welcome. They are brought back here as review
inputs; the Confluence text is not edited independently.

## Community coordination

The community works on this topic through InteropHub:
[CDS Contextual Conditions, topic 7](https://informatics.immregistries.org/hub/es/topic/7).
Meetings, agendas, and discussion notes are tracked there.

## Work in progress, in the open

The concept is still under discussion, and its existing descriptions disagree in
places. This project brings them together and keeps the disagreements visible:
see the [initial source review](review/2026-10-29-initial-source-review.md) and
the [open questions](content/90-working-decisions.md#open-questions).

## Next steps

1. Draft the concept sections in `content/`, starting from the September 2026
   Confluence concept page and bringing in material from the earlier proposal
   and primer that is still relevant, with conflicts carried as open questions.
2. Build the regeneration step for the Confluence pages.
3. Cross-link this repository from the Confluence pages, the related InteropHub
   topics (1, 7, 137, 140, and 141), the IVC pages, and the ImmDS + HALO FHIR
   implementation guide.

## Repository structure

```text
content/                  canonical Markdown for the core document
products/                 derived products, including the Confluence pages
review/                   review inputs awaiting adjudication
sources/                  list of source material and how it is used
process/                  submodule: shared public templates and tools
output/                   generated DOCX and HTML; not committed
ContextualConditions.qmd  assembly authority for section order
CoreDocument.md           generated single-file reading copy
```

## Build and validate

Clone with the shared templates:

```powershell
git clone --recurse-submodules https://github.com/immregistries/contextual-conditions.git
```

In an existing clone, run `git submodule update --init`. Quarto and Python 3.12
or later are required to build.

```powershell
# Regenerate the reading copy after editing content/
python process/tools/build_core_markdown.py --assembly ContextualConditions.qmd

# Run the repository checks (also run in GitHub Actions)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\validate.ps1

# Build Word and HTML into output/
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\build.ps1
```

Templates and tools come from
[content-publishing-templates](https://github.com/immregistries/content-publishing-templates),
pinned as a submodule at `process/`. Do not edit files under `process/`.

## License

- Document content is licensed under
  [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). See
  [LICENSE-CONTENT.md](LICENSE-CONTENT.md).
- Code and build configuration are licensed under the
  [Apache License 2.0](LICENSE).
