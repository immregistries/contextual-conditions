# Related Work and Representations

Contextual Conditions began as a need within immunization CDS interface work
and are now relied on by several related efforts. This document covers the
concept those efforts share. It describes how the concept is represented in HL7
v2 and FHIR only at a general level and does not repeat their detailed
specifications. Each related effort is tracked as its own InteropHub topic and
may develop documentation of its own.

## Related topics

| Topic | Relationship to this work |
|---|---|
| [Immunization CDS (ImmDS + HALO), topic 1](https://informatics.immregistries.org/hub/es/topic/1) | The FHIR-based CDS interface work that created the need for Contextual Conditions. HALO factors are Contextual Conditions as defined here. Defines the FHIR representation, including how a CDS engine reports which conditions it supports. |
| [HL7 v2 Contextual Conditions Exchange, topic 137](https://informatics.immregistries.org/hub/es/topic/137) | The overall HL7 v2 representation, using coded OBX observations. Parent of topics 140 and 141. |
| [HL7 v2 Contextual Conditions in Immunization Updates, topic 140](https://informatics.immregistries.org/hub/es/topic/140) | Submission of conditions in VXU messages, including whether and how an IIS may retain or use them. IIS storage rules belong here. |
| [HL7 v2 Contextual Conditions in Immunization Queries, topic 141](https://informatics.immregistries.org/hub/es/topic/141) | Conditions supplied with a QBP query to influence the forecast returned in the RSP. Also touches on storage, and is likely to prohibit storing conditions supplied in a query. |
| [CDS Contextual Conditions, topic 7](https://informatics.immregistries.org/hub/es/topic/7) | This work: the concept itself. |

Publication of the code systems that define individual conditions is handled
separately, currently as an Immunization Vocabularies Collaborative proposal at
<https://ivci.org/contextual-conditions/>.

## Representations

HL7 v2 and FHIR are two representations of the same concept. This document
describes, in [Representing Contextual Conditions](07-representations.md), what
any representation needs to convey and the principles it must preserve, such as
modeling a meaningful date as its own Contextual Condition, so that the
representations stay consistent with each other and with the concept.

Out of scope here are the rules for who creates, determines, or stores
Contextual Conditions, and how they are included in messages and workflows.
Message structures, field-level rules, conformance requirements, storage, and
workflow behavior belong to the related topics above.
