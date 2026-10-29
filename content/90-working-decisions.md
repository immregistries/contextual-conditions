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
[initial source review](../review/2026-10-29-initial-source-review.md) for
detail. Each needs discussion before the affected text is settled.

| ID | Question | Sources in tension |
|---|---|---|
| OQ-1 | Does this document include an HL7 v2 representation, or only the transport-neutral concept, with HL7 v2 and other representations documented elsewhere? | The Confluence concept page lists transport representations as a non-goal; the HL7 v2 Confluence page is a child of it. |
| OQ-2 | May an IIS store Contextual Conditions received in a VXU? | The Confluence concept page (September 2026) describes conditions as evaluation-scoped and leaves longitudinal storage to separate work; the HL7 v2 page (June 2026) and the primer allow optional storage under local policy. |
| OQ-3 | Which OBX-2 value type carries a Boolean Contextual Condition? | The primer's example uses `ID`; the HL7 v2 Confluence page uses `CE`. |
| OQ-4 | What are the current names for the governance roles? | The primer names four roles (Code System, Publishing, Namespace, and CDS Authority); the Confluence concept page uses Schedule Authority, terminology steward, and Knowledge Base. |
| OQ-5 | Is there a nullified state that removes a previously stored assertion? | The primer describes one; the Confluence concept page's stateless model has none. Depends on OQ-2. |
