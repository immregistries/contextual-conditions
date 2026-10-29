<!--
GENERATED FILE. DO NOT EDIT DIRECTLY.

The authoritative source is in content/. Regenerate this reading copy with:
    python process/tools/build_core_markdown.py --assembly ContextualConditions.qmd
-->

# Contextual Conditions for Immunization Decision Support

*Working Proposal for Community Discussion — Not a Standard or Final Decision*

> This is a generated reading copy for GitHub. For review and editing, use the
> [canonical section files](content/README.md).

---

# Status and Scope

> **Status:** Working proposal for community discussion. Nothing in this
> document is a published standard, an HL7 ballot, or a final decision.
> Working decisions are recorded so the community can see, question, and
> improve them, and any of them may change.

## Purpose

This document develops the concept of Contextual Conditions: the bounded set of
inputs, defined by immunization Schedule Authorities, that a requesting system
can supply to immunization clinical decision support (CDS) alongside patient
demographics and immunization history.

The goal is to make the concept clear, well reasoned, and strong enough for
others to build on, through open discussion with the immunization
interoperability community.

## What this project covers

- The definition of a Contextual Condition and a Contextual Condition
  assertion.
- The concept's principles and boundaries: what it is, what it is not, and how
  it relates to clinical information, Schedule Authorities, Knowledge Bases,
  and CDS engines.
- The working decisions reached on the concept, the reasoning behind them, and
  the questions that remain open.

## What this project does not cover

- **Publishing Contextual Condition codes.** Code systems and their values are
  operational publications. The Immunization Vocabularies Collaborative (IVC)
  is exploring how to publish them at <https://ivci.org/contextual-conditions/>.
  That publication is itself a proposal under discussion.
- **Clinical policy.** Schedule Authorities decide which factors affect their
  guidance and what each condition means.
- **Forecasting logic.** CDS engines and their Knowledge Bases decide how
  conditions affect recommendations.

## How this document is maintained

The Markdown source in this repository is the authoritative record of the
concept. The HL7 Public Health Work Group Confluence pages are copies made from
it for sharing and feedback:

- [CDS Contextual Conditions](https://confluence.hl7.org/spaces/PHWG/pages/453920359/CDS+Contextual+Conditions)
- [CDS Contextual Conditions in HL7 v2](https://confluence.hl7.org/spaces/PHWG/pages/468260886/CDS+Contextual+Conditions+in+HL7+v2)

Community coordination, meetings, and discussion notes are tracked on
InteropHub as [CDS Contextual Conditions, topic 7](https://informatics.immregistries.org/hub/es/topic/7).

The concept is still being worked out, and its earlier descriptions do not all
agree. Those disagreements, and critiques of the concept, are recorded openly
in this repository as review inputs and open questions.

Feedback is welcome as a GitHub issue, a Confluence comment, or in community
meetings. Accepted changes are made here first, then the Confluence pages are
regenerated.

---

# Appendix: Working Decisions and Open Questions

This appendix consolidates the working decisions on the concept and the
questions still open. A working decision is the current position for
discussion, not a final or approved decision. Each records where it came from so
it can be revisited.

## Working decisions

| ID | Working decision | Basis |
|---|---|---|
| WD-1 | This project covers the concept of Contextual Conditions. Publication of code systems and values is operational and is handled separately, currently as an IVC proposal. | Project scope, October 2026 |
| WD-2 | This repository is the authoritative source for the concept. Confluence pages are regenerated from it for sharing and feedback. | Project scope, October 2026 |
| WD-3 | Community coordination, meetings, and discussion notes are tracked on InteropHub, [topic 7](https://informatics.immregistries.org/hub/es/topic/7). | Project scope, October 2026 |
| WD-4 | Disagreements among sources, and critiques of the concept, are kept visible in this repository rather than resolved privately. | Project scope, October 2026 |

## Open questions

These were identified by comparing existing sources; see the
[initial source review](review/2026-10-29-initial-source-review.md) for
detail. Each needs discussion before the affected text is settled.

| ID | Question | Sources in tension |
|---|---|---|
| OQ-1 | Does this document include an HL7 v2 representation, or only the transport-neutral concept, with HL7 v2 and other representations documented elsewhere? | The Confluence concept page lists transport representations as a non-goal; the HL7 v2 Confluence page is a child of it. |
| OQ-2 | May an IIS store Contextual Conditions received in a VXU? | The Confluence concept page (September 2026) describes conditions as evaluation-scoped and leaves longitudinal storage to separate work; the HL7 v2 page (June 2026) and the primer allow optional storage under local policy. |
| OQ-3 | Which OBX-2 value type carries a Boolean Contextual Condition? | The primer's example uses `ID`; the HL7 v2 Confluence page uses `CE`. |
| OQ-4 | What are the current names for the governance roles? | The primer names four roles (Code System, Publishing, Namespace, and CDS Authority); the Confluence concept page uses Schedule Authority, terminology steward, and Knowledge Base. |
| OQ-5 | Is there a nullified state that removes a previously stored assertion? | The primer describes one; the Confluence concept page's stateless model has none. Depends on OQ-2. |
