# Adoption, Boundaries, and Intended Outcome

## Incremental support

Publishing a Contextual Condition does not mean every requesting system can
determine its value or every CDS engine can use it. Partial support is
expected, especially early on:

- A requesting system may support only some of the conditions an authority
  defines.
- A CDS engine or Knowledge Base may support only some of them.
- An unsupported condition may become supported without redesigning the
  interface.
- New conditions may be added as guidance evolves.

The benefit of the framework is not immediate universal support. It is a
consistent mechanism through which support can grow.

## Architectural boundary

Contextual Conditions set a boundary among three responsibilities:

1. **Clinical and public health systems** collect information, maintain
   longitudinal records, and determine the values supplied to CDS.
2. **The CDS interface** conveys evaluation-scoped demographics, immunization
   history, and Contextual Condition values.
3. **The CDS engine and its selected Knowledge Base** apply immunization
   guidance and return evaluations and recommendations.

This boundary lets each layer evolve without requiring the CDS engine to
interpret the full clinical record, and without requiring the clinical record
to adopt a schedule-specific information model.

## Non-goals

This concept does not define:

- how clinical or nonclinical information is collected;
- how a requesting system derives a Contextual Condition;
- who creates, determines, or stores Contextual Conditions in a workflow;
- a new longitudinal patient record;
- a complete historical model of conditions affecting past vaccinations;
- how an IIS stores, updates, expires, corrects, or retracts stored
  conditions;
- a single globally harmonized Contextual Condition code system;
- the publication of code systems;
- immunization forecasting logic;
- which clinical factors a Schedule Authority should consider;
- Knowledge Base selection or versioning;
- capability negotiation or response behavior; or
- detailed HL7 v2, FHIR, or other transport specifications, beyond the general
  principles in [Representing Contextual Conditions](07-representations.md).

These subjects belong to related terminology, implementation-guide, transport,
and IIS work.

## Intended outcome

Success does not mean every system immediately supports every Contextual
Condition. Success means immunization CDS has a bounded, explicitly defined
input layer. Schedule Authorities can identify the factors their guidance
requires, Knowledge Bases can declare which inputs they implement, and
requesting systems can add support incrementally.

As guidance evolves, new factors can be introduced mainly as vocabulary and
Knowledge Base additions rather than as new proprietary interface designs.
Clinical systems remain free to represent and derive the underlying information
in ways suited to patient care, while CDS engines receive only the inputs they
need to answer the recommendation question.
