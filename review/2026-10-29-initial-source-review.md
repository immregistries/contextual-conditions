# Initial Source Review — October 29, 2026

This review was made while setting up the repository. It compares the
existing descriptions of Contextual Conditions with one another. It is kept
public on purpose: the concept is still under discussion, its descriptions are
spread across several places, and bringing them together is the purpose of this
project. The findings are review inputs, not decisions. Items that need
community discussion are carried as open questions in
[the working decisions appendix](../content/90-working-decisions.md).

The review was prepared with AI assistance and has not yet been checked by a
subject-matter reviewer.

## Sources compared

| Short name | Source | Date |
|---|---|---|
| Proposal | *Proposal for Contextual Conditions* v1.0 | February 3, 2026 |
| HL7 v2 page | [CDS Contextual Conditions in HL7 v2](https://confluence.hl7.org/spaces/PHWG/pages/468260886/CDS+Contextual+Conditions+in+HL7+v2) | Updated June 26, 2026 |
| Concept page | [CDS Contextual Conditions](https://confluence.hl7.org/spaces/PHWG/pages/453920359/CDS+Contextual+Conditions) | Updated September 15, 2026 |
| IVC pages | [IVC Contextual Conditions proof of concept](https://ivci.org/contextual-conditions/) | October 2026 |
| Primer | *Contextual Conditions: Primer and Project Orientation*, based on the Proposal and the draft value workbook | October 2026 |
| InteropHub topic | [CDS Contextual Conditions, topic 7](https://informatics.immregistries.org/hub/es/topic/7) | Current |

## Overall finding

The sources do not agree, and no single one is complete. The Concept page is the
most recent and most developed statement of the concept, but it deliberately
leaves out transport, storage, and publication. The Primer and the HL7 v2 page
reflect the earlier Proposal, which combined the concept, an HL7 v2 transport,
and governance in one document. Several differences below come from the
concept being refined after the Proposal, not from contradictory intent, but
the earlier text is still in circulation and is still being read.

## Findings

### 1. Is HL7 v2 part of the concept? (OQ-1)

The Concept page lists "a particular HL7 v2, FHIR, REST, or other transport
representation" as a non-goal. The HL7 v2 page is a child of the Concept page
and defines exactly such a representation. The Proposal and Primer treat the
HL7 v2 binding as part of the proposal. The InteropHub topic says the concept
"may be conveyed using FHIR or HL7 v2". This project needs to decide whether its
core document includes transport bindings or only references them.

### 2. Storage of conditions received in a VXU (OQ-2)

The Concept page describes conditions as evaluation-scoped and stateless, and
says IIS storage would need rules for provenance, effective time, correction,
expiration, and retraction that remain separate work. The HL7 v2 page and the
Primer say an IIS may store conditions received in a VXU under local policy.
These positions can be reconciled, since the Concept page addresses the CDS
engine and the HL7 v2 page addresses the IIS, but the documents do not
currently say so, and a reader could take them as conflicting.

The HL7 v2 page also notes that discussion continues on whether an IIS should
ever retain conditions supplied only in a query.

### 3. OBX-2 value type (OQ-3)

The Proposal and Primer example uses `ID` in OBX-2; the HL7 v2 page example
uses `CE`. Both carry `Y^Yes^HL70136` in OBX-5. The value type needs to be
chosen and checked against the national HL7 v2.5.1 immunization guide.

### 4. Governance roles and terminology (OQ-4)

The Proposal, Primer, and IVC pages describe four roles: Code System Authority,
Publishing Authority, Namespace Authority, and CDS Authority. The Concept page
instead uses Schedule Authority, terminology steward, and Knowledge Base, and
does not use the four-role model. The mapping between the two vocabularies is
not stated.

The role given to IVC has also shifted. The Proposal assigns IVC
responsibility for coordinating namespaces and publication. The Concept page
says IVC "may serve" as a publication and coordination mechanism and is "not
required for the underlying Contextual Conditions architecture."

### 5. Definition of a Contextual Condition

The Primer defines a Contextual Condition as "a standardized, coded assertion."
The Concept page separates two things: a Contextual Condition, which is a
Schedule Authority-defined input with an assigned meaning and datatype, and a
Contextual Condition assertion, which is the value supplied in a particular
request. The Concept page's distinction is sharper, and the earlier wording
should not be repeated without it.

### 6. Nullification and the meaning of absence (OQ-5)

All sources agree that omission means unknown, not No. The Primer, following
the Proposal, also describes a fourth state, "nullified," used to remove a
previously stored assertion. The Concept page has no nullification, which is
consistent with its stateless model, and the HL7 v2 page does not mention it.
Whether nullification survives depends on the answer to OQ-2.

### 7. Evaluation date and temporal meaning

The Concept page introduces the evaluation date and explains that a condition
may concern a past event, present state, future intention, or another person,
always asserted as applicable to the evaluation date. The Proposal and Primer
handle time differently, through OBX-14 rules in VXU, and say comprehensive
temporal modeling is future work. The Concept page's model is newer and not yet
reflected in the HL7 v2 page.

### 8. Strength of the status claims

The HL7 v2 page says community feedback "has generally supported the overall
direction" and that remaining work is "primarily" implementation guidance and
pilot experience. That may be accurate, but the evidence for it (which meetings,
which participants, what was asked) is not recorded anywhere public. The open
questions above suggest that some architectural questions are still unsettled.
Claims about community support should cite where that support was expressed.

### 9. Value inventories and code publication (out of scope)

These belong to code publication, which this project does not cover. They are
recorded so they are not lost and can be passed to the IVC discussion:

- The Primer counts 277 populated US concepts in the draft workbook; the IVC
  pages publish 278 concepts for CDC CDSi version 4.65.
- The Primer notes draft-quality problems in the workbook: titles that imply a
  date or result but are typed Yes/No, and translated rows that appear
  misaligned.
- The Proposal's namespace example `eu/ema` does not fit the IVC pages' rule
  that country segments use ISO 3166-1 alpha-3 codes.
- The IVC pages state that Syadem's license and attribution wording is still to
  be confirmed.

### 10. InteropHub topic description

The InteropHub overview describes the topic as representing "medical,
occupational, and other patient conditions." The Concept page is careful to
say that Contextual Conditions do not represent clinical information itself but
Schedule Authority-defined inputs derived from it. The overview may need
updating once the concept text settles here.

### 11. Process observations

- The concept is described in at least five places with different dates, and
  several of them are working documents that are not publicly linkable. This
  repository is intended to become the single, public statement.
- Automated access to confluence.hl7.org is blocked by a human-verification
  check. Regenerating the Confluence pages from this repository will need either
  an access token that passes that check or a manual paste step.

## Follow-up, October 29, 2026

The project lead set the scope for representations after this review:

- OQ-1 is resolved by working decision WD-5. The core document describes the HL7
  v2 and FHIR representations at a general level and refers to the InteropHub
  topics that own them: [topic 1](https://informatics.immregistries.org/hub/es/topic/1)
  (ImmDS + HALO, FHIR), [topic 137](https://informatics.immregistries.org/hub/es/topic/137)
  (HL7 v2 exchange), [topic 140](https://informatics.immregistries.org/hub/es/topic/140)
  (HL7 v2 updates), and [topic 141](https://informatics.immregistries.org/hub/es/topic/141)
  (HL7 v2 queries).
- WD-6 records that HALO factors are Contextual Conditions.
- OQ-3 (OBX-2 value type) is an HL7 v2 detail and is referred to topic 137.
- The storage rules in OQ-2 fall within topic 140, whose description includes
  "whether and how an IIS may retain or use the information." This document
  still needs to state the boundary between stateless CDS evaluation and IIS
  storage.
- The descriptions of topics 137, 140, and 141 list example conditions such as
  "lifestyle" and "medical or risk factors" and describe conditions as coded
  observations. They should be checked against the concept's definition, which
  treats a condition as a Schedule Authority-defined input rather than a
  clinical observation, once that text settles here (see finding 10).

## Second follow-up, October 29, 2026

The project lead clarified the boundary between concept and workflow:

- WD-7 resolves OQ-2. This project describes what a Contextual Condition is; it
  does not set rules for who creates, determines, or stores conditions, or how
  they are included in messages and workflows. IIS storage rules belong to
  topic 140, and topic 141 is likely to prohibit storing conditions supplied in
  a query. OQ-5 (nullification of stored assertions) is referred to topic 140
  for the same reason.
- WD-8 keeps one overlap in scope: a date meaningful to a condition is modeled
  as a separate Contextual Condition with a date value, not carried in HL7 v2
  OBX-14 or FHIR Observation date elements. This agrees with the Proposal and
  the HL7 v2 page, which already say OBX-14 is not an onset, expiration, or
  validity date, and states the rule for every representation.

