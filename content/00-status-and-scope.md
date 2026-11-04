# Status and Scope

> **Status:** Working proposal for community discussion. Nothing in this
> document is a published standard, an HL7 ballot, or a final decision.
> Working decisions are recorded so the community can see, question, and
> improve them, and any of them may change.

## In brief

A Contextual Condition is an input that immunization clinical decision support
(CDS) needs in order to apply its guidance. It is defined by a Schedule
Authority with a specific meaning and datatype, such as "patient is pregnant"
or "birth mother received RSV vaccine during the relevant pregnancy." The
requesting system determines the value from the information available to it
and supplies it with the recommendation request. The CDS engine uses the value
without reconstructing the evidence behind it. A condition that is not supplied
is unknown, not No.

Contextual Conditions give immunization CDS a shared, stable input contract.
New guidance can be supported by adding vocabulary rather than redesigning
interfaces, and clinical, self-service, and public health systems can all
supply the same inputs.

## Purpose

This document develops the concept of Contextual Conditions: the inputs,
defined by immunization Schedule Authorities, that a requesting system supplies
to immunization CDS alongside patient demographics and immunization history.
Its deliverable is a shared contract for what those inputs mean and how they
are conveyed.

The goal is to make the concept clear, well reasoned, and strong enough for
others to build on, through open discussion with the immunization
interoperability community.

## What this project covers

- The definitions of a Contextual Condition and a Contextual Condition
  assertion, and what a published definition must make clear.
- The concept's principles and boundaries: what it is, what it is not, and how
  it relates to source information, Schedule Authorities, Knowledge Bases, and
  CDS engines.
- What any representation of the concept, such as HL7 v2 or FHIR, must convey,
  described at a general level.
- The working decisions reached on the concept, the reasoning behind them, and
  the questions that remain open.

## What this project does not cover

- **Publishing Contextual Condition codes.** Code systems and their values are
  operational publications. The Immunization Vocabularies Collaborative (IVC)
  is exploring how to publish them at <https://ivci.org/contextual-conditions/>,
  under a [naming rule](https://github.com/IVC-NUVA/IVC-Website/blob/main/discussion/identifiers-and-namespaces.md) it proposes for the resources it publishes. Both are
  proposals under discussion.
- **Clinical policy and forecasting logic.** Schedule Authorities decide which
  factors affect their guidance and what each condition means. Knowledge Bases
  decide how conditions affect recommendations.
- **Collection and determination in a particular workflow:** how information
  is collected, how a value is derived from it, and who creates, determines, or
  stores Contextual Conditions. Storage, expiration, correction, and retraction
  of stored conditions belong to topics 140 and 141 (WD-7).
- **A longitudinal record,** or a historical model of the conditions that
  applied when past doses were given. See
  [Evaluation, Time, and Representation](05-evaluation-and-time.md#prospective-model).
- **A single, globally harmonized code system.** See
  [authority-specific code systems](03-the-concept.md#authority-specific-code-systems).
- **CDS interface behavior:** Knowledge Base selection and versioning,
  capability negotiation, and how a response reports the conditions it used.
- **Detailed HL7 v2 and FHIR specifications.** These belong to the related
  topics below, which depend on this concept (WD-5).

## Related work {#related-work}

Contextual Conditions began as a need within immunization CDS interface work
and are now relied on by several related efforts. Each is tracked as its own
InteropHub topic and may develop documentation of its own.

| Topic | Relationship to this work |
|---|---|
| [Immunization CDS (ImmDS + HALO), topic 1](https://informatics.immregistries.org/hub/es/topic/1) | The FHIR-based CDS interface work that created the need for Contextual Conditions. HALO factors are Contextual Conditions as defined here (WD-6). Defines the FHIR representation, including how a CDS engine reports which conditions it supports. |
| [HL7 v2 Contextual Conditions Exchange, topic 137](https://informatics.immregistries.org/hub/es/topic/137) | The overall HL7 v2 representation, using coded OBX observations. Parent of topics 140 and 141. |
| [HL7 v2 Contextual Conditions in Immunization Updates, topic 140](https://informatics.immregistries.org/hub/es/topic/140) | Submission of conditions in VXU messages, including whether and how an IIS may retain or use them. IIS storage rules belong here. |
| [HL7 v2 Contextual Conditions in Immunization Queries, topic 141](https://informatics.immregistries.org/hub/es/topic/141) | Conditions supplied with a QBP query to influence the forecast returned in the RSP. Also touches on storage, and is likely to prohibit storing conditions supplied in a query. |
| [CDS Contextual Conditions, topic 7](https://informatics.immregistries.org/hub/es/topic/7) | This work: the concept itself. |

The US Clinical Decision Support for Immunization (CDSi) resources and the
French immunization work are earlier, independent operationalizations of the
same idea; see [Formalizing an existing practice](02-the-problem.md#formalizing-an-existing-abstraction).
