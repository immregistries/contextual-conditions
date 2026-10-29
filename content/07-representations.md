# Representing Contextual Conditions

Contextual Conditions are a concept, not a message format. They can be
represented in more than one standard, and HL7 v2 and FHIR are the two in
current use. This section describes, at a general level, what any
representation must convey and which principles it must preserve. Detailed
specifications belong to the [related topics](01-related-work.md).

## What every representation conveys

For each asserted Contextual Condition, a representation conveys:

- **the condition**, identified by its code and by the code system of the
  Schedule Authority that defines it, so that the authority is always explicit;
- **the asserted value**, in the condition's datatype: Yes or No for a Boolean
  condition, or a date or number where the condition defines one.

## Principles every representation preserves

- **Sparse.** Only asserted conditions are sent. A condition that is not known
  is not sent; there is no "unknown" value to transmit.
- **Absence is unknown.** A receiver never treats a missing condition as No.
- **Dates are conditions.** A date meaningful to a condition is sent as its own
  Contextual Condition with a date value. It is never carried in a
  representation's own date fields, such as HL7 v2 OBX-14 or the date elements
  of a FHIR Observation, which describe the record or message rather than the
  condition.
- **Vocabulary, not structure.** A new condition is a vocabulary addition. It
  does not need a new segment, element, extension, or message design.
- **Support is reported, not assumed.** Sending a condition does not guarantee
  that it influenced the result. Each representation defines how a CDS engine
  indicates whether a submitted condition was recognized, unsupported, or
  invalid.

## HL7 v2

In HL7 v2, each Contextual Condition is a standard OBX observation. OBX-3
identifies the condition, using the Schedule Authority's code system, and OBX-5
carries the asserted value. No new segments or message structures are
introduced. Use in immunization updates (VXU) and queries (QBP), including what
an IIS may do with the conditions it receives, is defined by
[topics 137, 140, and 141](01-related-work.md).

## FHIR

In FHIR, Contextual Conditions are supplied as inputs to the immunization CDS
interface defined by the ImmDS + HALO work, where they are known as HALO
factors. The FHIR representation, including how an engine reports supported
conditions, is defined by
[topic 1](https://informatics.immregistries.org/hub/es/topic/1).
