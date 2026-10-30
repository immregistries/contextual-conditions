# Status and Scope

> **Status:** Working proposal for community discussion. Nothing in this
> document is a published standard, an HL7 ballot, or a final decision.
> Working decisions are recorded so the community can see, question, and
> improve them, and any of them may change.

## In brief

A Contextual Condition is an input to immunization clinical decision support,
defined by a Schedule Authority with a specific meaning and datatype, such as
"patient is pregnant" or "birth mother received RSV vaccine during pregnancy."
A requesting system determines whether the condition applies and supplies that
assertion with its recommendation request. The CDS engine uses the assertion
without reinterpreting the clinical record behind it. A condition that is not
supplied is unknown, not No.

Contextual Conditions give immunization CDS a bounded, stable input layer, so
that new guidance can be supported by adding vocabulary rather than redesigning
interfaces.

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
- What any representation of the concept, such as HL7 v2 or FHIR, needs to
  convey, described at a general level, including modeling principles that
  apply to every representation.
- The working decisions reached on the concept, the reasoning behind them, and
  the questions that remain open.

## What this project does not cover

- **Publishing Contextual Condition codes.** Code systems and their values are
  operational publications. The Immunization Vocabularies Collaborative (IVC)
  is exploring how to publish them at <https://ivci.org/contextual-conditions/>.
  That publication is itself a proposal under discussion.
- **Clinical policy.** Schedule Authorities decide which factors affect their
  guidance and what each condition means.
- **Who creates, determines, or stores Contextual Conditions,** and how they
  are included in messages and workflows.
- **Detailed HL7 v2 and FHIR specifications.** These belong to the related
  topics listed in the next section, which depend on this concept.
- **Forecasting logic.** CDS engines and their Knowledge Bases decide how
  conditions affect recommendations.

## How this document is maintained

<!-- anchor: authoritative-source -->

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

<!-- anchor: feedback-adjudication -->

Feedback is welcome as a GitHub issue, a Confluence comment, or in community
meetings. Accepted changes are made here first, then the Confluence pages are
regenerated.
