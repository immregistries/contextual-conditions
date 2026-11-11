# Appendix: Working Decisions and Open Questions

This appendix consolidates the working decisions on the concept and the
questions still open. A working decision is the current position for
discussion, not a final or approved decision. Each records where it came from so
it can be revisited.

## Working decisions

| ID | Working decision | Basis |
|---|---|---|
| WD-1 | This project covers the concept of Contextual Conditions. Publication of code systems and values is operational and is handled separately, currently as an IVC proposal. | Project scope, October 2026 |
| WD-4 | Disagreements among sources, and critiques of the concept, are kept visible in this repository rather than resolved privately. | Project scope, October 2026 |
| WD-5 | This document describes the HL7 v2 and FHIR representations at a general level: what a representation must convey and which principles it must preserve. Detailed specifications belong to the related InteropHub topics (1, 137, 140, and 141), which depend on this concept and may develop their own documentation. Resolves OQ-1. | Project direction, October 2026 |
| WD-6 | HALO factors, from the Immunization CDS (ImmDS + HALO) work, are Contextual Conditions as defined in this document. | Project direction, October 2026 |
| WD-7 | This document describes what a Contextual Condition is conceptually. It does not set rules for who creates, determines, or stores Contextual Conditions, or for how they are included in messages and workflows. IIS storage rules belong to topic 140; topic 141 also touches on storage and is likely to prohibit storing conditions supplied in a query. Resolves OQ-2. | Project direction, October 2026 |
| WD-8 | When a date is meaningful to a Contextual Condition, it is modeled as a separate Contextual Condition with a date value. It is not conveyed through a representation's own date fields, such as HL7 v2 OBX-14 or the date elements of a FHIR Observation. This modeling rule applies to every representation and is in scope. | Project direction, October 2026 |
| WD-9 | The patient observations defined by the US CDSi resources are Contextual Conditions as defined in this document; CDSi named them before this concept was developed. | Project direction, November 2026; [CDSi Logic Specification for ACIP Recommendations, version 4.6](https://www.cdc.gov/iis/downloads/logic-spec-acip-rec-4.6.pdf) |
| WD-10 | The concept uses three roles: Schedule Authority, terminology steward, and Knowledge Base. The four roles of earlier sources (Code System, Publishing, Namespace, and CDS Authority) fold into them. Schedule Authority and Knowledge Base are defined by the Immunization CDS Topic Reference (topic 1); this document describes the terminology steward and the Schedule Authority's role in defining conditions. Resolves OQ-4. | Project direction, November 2026 |

## Open questions

OQ-1 to OQ-6 were identified by comparing existing sources; see the
[initial source review](../review/2026-10-29-initial-source-review.md) for
detail. OQ-7 to OQ-10 arose from the 3 November 2026 project discussion. Each needs discussion before the affected text is settled. Questions
that belong to a related topic are referred there rather than answered here.

| ID | Question | Sources in tension | Status |
|---|---|---|---|
| OQ-1 | Does this document include an HL7 v2 representation, or only the transport-neutral concept, with HL7 v2 and other representations documented elsewhere? | The Confluence concept page lists transport representations as a non-goal; the HL7 v2 Confluence page is a child of it. | Resolved by WD-5 |
| OQ-2 | May an IIS store Contextual Conditions received in a VXU? | The Confluence concept page (September 2026) describes conditions as evaluation-scoped and leaves longitudinal storage to separate work; the HL7 v2 page (June 2026) and the primer allow optional storage under local policy. | Resolved by WD-7; storage rules belong to topic 140 |
| OQ-3 | Which OBX-2 value type carries a Boolean Contextual Condition? | The primer's example uses `ID`; the HL7 v2 Confluence page uses `CE`. | Referred to topic 137 under WD-5 |
| OQ-4 | What are the current names for the governance roles? | The primer names four roles (Code System, Publishing, Namespace, and CDS Authority); the Confluence concept page uses Schedule Authority, terminology steward, and Knowledge Base. | Resolved by WD-10 |
| OQ-5 | Is there a nullified state that removes a previously stored assertion? | The primer describes one; the Confluence concept page's stateless model has none. Depends on OQ-2. | Referred to topic 140 under WD-7 |
| OQ-6 | Is the numeric datatype an integer, or any number? | The Confluence concept page names date or integer values; the draft French inventory includes Number values such as laboratory results, height, and weight. | Open |
| OQ-7 | When the kind of evidence matters to the guidance, such as a self-reported versus a clinically verified value, is that requirement part of the condition's definition, a separate condition, or a determination policy outside the definition? | The concept describes a condition as independent of how it was determined; the 3 November 2026 discussion notes that self-reported and verified values are not automatically interchangeable. | Open |
| OQ-8 | When an existing terminology concept, such as one in SNOMED CT, exactly matches a condition's meaning, may it serve as the condition's identifier, or is it recorded only as a mapping? | The concept does not use clinical terminologies directly as the Contextual Condition vocabulary; the 3 November 2026 discussion says exact matches should be recognized and reused or mapped. | Open |
| OQ-9 | What may a CDS engine do with an assertion beyond using it: validate it against the definition, report it as unsupported, or detect and handle contradictory assertions? | The concept says the engine accepts the assertion without judging how it was derived; the 3 November 2026 discussion treats validation, unsupported-input reporting, and contradiction handling as legitimate engine responsibilities. Reporting belongs to each CDS interface. | Open |
| OQ-10 | Who maintains evidence and determination mappings for a condition, and where are they published? | The 3 November 2026 discussion describes mappings as artifacts maintained alongside definitions; this concept leaves determination to requesting systems, and workflow rules to topics 140 and 141. | Open |
