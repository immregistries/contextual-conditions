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

Feedback is welcome as a GitHub issue, a Confluence comment, or in community
meetings. Accepted changes are made here first, then the Confluence pages are
regenerated.
