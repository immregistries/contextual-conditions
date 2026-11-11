# The Concept

## The starting question

<!-- anchor: starting-question -->

Every Contextual Condition answers one question:

> What must the recommendation system know to apply this guidance?

The answer comes from the guidance and the logic that operationalizes it. It is
not determined by the fields available in an EHR, the contents of a patient
record, or the conventions of a particular clinical information model.

## Definitions

In this concept, a **condition** is a circumstance relevant to applying
recommendation guidance. It need not be a diagnosis, a problem-list entry, or a
state of the person being evaluated. It may concern a past event, a future
intention, an occupation, an exposure, a household circumstance, or another
person; see [what "applies" means](05-evaluation-and-time.md#what-applies-means).

A **Contextual Condition** is a Schedule Authority-defined input, with an
assigned meaning and datatype, that may influence an immunization evaluation or
recommendation.

A **Contextual Condition assertion** is the value that a requesting system
supplies for that input as part of a particular recommendation request.

<!-- anchor: definition-vs-assertion -->

Three artifacts are kept distinct:

| Artifact | What it establishes |
|---|---|
| Contextual Condition definition | The exact proposition or typed value the recommendation logic requires, with its authority-defined meaning. Stable and published. |
| Contextual Condition assertion | The value supplied for that input in one recommendation evaluation, by one requesting system. |
| Evidence and determination mapping | How information available in a source can support the supplied value. |

Contextual Conditions are organized by their role in recommendation logic, but
each still has a real-world meaning that must be defined precisely.

Examples of Contextual Conditions:

- Patient has had varicella disease.
- Patient is pregnant.
- Patient is severely immunocompromised, as defined by the Schedule Authority.
- Birth mother received RSV vaccine during the relevant pregnancy.
- Patient plans to travel to Nigeria.
- Number of weeks of gestation.

## Datatypes

Most Contextual Conditions are Boolean: the assertion is Yes or No. Some take a
date or a number, such as a pregnancy start date or a number of weeks of
gestation. A Schedule Authority may define other datatypes when its guidance
requires them. An assertion uses the datatype the condition defines; a date or
number is not reduced to Yes or No. A meaningful date is its own condition; see
[Dates are conditions](05-evaluation-and-time.md#dates-are-conditions).
<!-- CONFIRM: Numeric datatype. The Confluence concept page says "integer"; the draft French inventory includes "Number" values such as laboratory results, height, and weight, which may need decimals. See OQ-6. -->

## Properties of a Contextual Condition

A Contextual Condition is:

- **Defined by an authority.** A Schedule Authority assigns its meaning, its
  datatype, and a stable identifier.
- **Operational.** It exists because immunization guidance needs it to evaluate
  or recommend. It engages CDS logic; it does not reproduce the clinical record.
- **Bounded.** Its definition states what is, and is not, being asserted.
- **Asserted, not inferred, by the CDS engine.** The requesting system has
  already determined the value. The engine consumes it.
- **Independent of how it was determined.** The same assertion might come from
  structured clinical data, a questionnaire, a patient's own answers, clinical
  judgment, another system, or local business rules. Where the guidance
  requires a particular kind of evidence, that requirement is part of the
  definition (OQ-7).

## What a Contextual Condition is not

A Contextual Condition is not, by itself:

- a diagnosis code or problem-list entry;
- a general-purpose clinical observation;
- a complete allergy, precaution, or contraindication record;
- the evidence used to reach a conclusion;
- a clinical recommendation or schedule rule;
- an inference algorithm; or
- a requirement that any particular condition be collected.

<!-- anchor: assertion-not-evidence -->

For example, diagnoses, medications, laboratory results, and a clinician's
assessment may together support the conclusion that a patient is severely
immunocompromised. Those facts remain important in their own systems. The
Contextual Condition is the assertion that the patient meets the Schedule
Authority's definition.

## What a definition contains

<!-- anchor: definition-contents -->

The definition of a Contextual Condition is richer than its assertion. A
compact identifier and a typed value stand for a carefully bounded meaning.
"Birth mother received RSV vaccine during the relevant pregnancy" is exchanged
as one input to the infant's evaluation, but its definition must say which
relationship and which pregnancy are meant, and any qualification the consuming
logic depends on. Those details do not become separately exchanged fields
unless the recommendation logic needs them.

Each published definition makes the following clear:

- its stable identifier, defining authority, and version;
- the exact proposition or value being requested;
- the guidance it comes from, traceable to the rules that use it;
- its datatype and, where applicable, permitted values, units, and precision;
- its temporal scope, and any relationship to another person or event;
- for a Boolean condition, what Yes and what No each establish;
- examples and counterexamples that clarify its boundary; and
- any evidence requirement that is part of its meaning.

Evidence and determination mappings are maintained separately (OQ-10), so that
improving how a source determines a value never changes the shared meaning.

## Schedule Authorities, Knowledge Bases, and code systems {#authorities}

**Schedule Authority** and **Knowledge Base** are defined in the
[Immunization CDS Topic Reference](https://immregistries.github.io/immunization-cds/latest/#terms)
(topic 1), because a CDS interface selects, applies, and reports them whether
or not Contextual Conditions are sent. This section covers their part in
Contextual Conditions.

### Schedule Authorities

The Schedule Authority defines the meaning of the Contextual Conditions its
recommendations require. It decides:

- which factors influence its guidance;
- what each condition means;
- what datatype each condition requires; and
- when a condition affects a recommendation.

### Knowledge Bases

A Knowledge Base identifies the Contextual Conditions, and their versions, that
it supports. The CDS engine does not redefine a Schedule Authority's
conditions; it applies the rules in its selected Knowledge Base. How a
Knowledge Base declares support, and how an engine reports whether a submitted
condition was recognized, are defined by the CDS interface in
[topic 1](https://immregistries.github.io/immunization-cds/latest/), not by
this concept.

### Authority-specific code systems

The concept does not require a single, internationally harmonized list of
Contextual Conditions. Each Schedule Authority may publish its own definitive,
versioned code system, so it can express exactly the concepts its guidance
needs without first reconciling language, policy, clinical definitions, or
implementation criteria with other authorities.

<!-- anchor: authority-differences-matter -->

For example, French and American Schedule Authorities may define conditions
that look similar but differ in subtle and important ways. Forcing them into
one concept would risk hiding those differences, or letting an interoperability
project reinterpret clinical policy.

<!-- anchor: mapping-not-equivalence -->

Future work may identify relationships or mappings between conditions from
different authorities. A mapping must not imply equivalence unless equivalence
has been established. Similar labels, or independent identification of the same
factor, are not evidence of equivalence.

<!-- anchor: stable-published-meaning -->

Published identifiers and definitions must remain stable. A material change in
meaning results in a new version or a new concept, not a silent change to an
existing code.

### Publication and stewardship

Schedule Authorities own the clinical meaning of their Contextual Conditions.

<!-- anchor: terminology-steward-role -->

A terminology steward may provide the technical publication framework: stable
identifiers, namespace management, versioning, and distribution, so that those
definitions are computable and exchangeable. The steward does not create
clinical guidance or reinterpret the authority's intent.

<!-- anchor: publication-outside-architecture -->

The Immunization Vocabularies Collaborative (IVC) may serve as a publication
and coordination mechanism for these code systems, and may support future work
on relationships between authority-specific concepts. IVC is not part of the
clinical decision-making process and is not required by the Contextual
Conditions architecture. How code systems are actually published is outside
this document. IVC's proposed rule for naming the code systems it publishes is
in [IVC Identifiers and Namespaces](https://github.com/IVC-NUVA/IVC-Website/blob/main/discussion/identifiers-and-namespaces.md).

<!-- anchor: three-roles -->

The concept uses three roles: the Schedule Authority and Knowledge Base,
defined in topic 1, and the terminology steward, described above (WD-10). Earlier descriptions used four roles, Code System,
Publishing, Namespace, and CDS Authority; the Schedule Authority corresponds to
the first, the terminology steward to the second and third, and the Knowledge
Base to the fourth.

## Evaluating a candidate condition {#applying-the-concept}

A proposed concept is a good Contextual Condition candidate when most of these
questions have clear answers:

- Does the guidance being operationalized need this information to evaluate or
  recommend vaccination?
- Can its meaning be expressed as a bounded assertion, with the content listed
  in [What a definition contains](#definition-contents)?
- Is it distinct from patient identity and immunization history?
- Can a requesting system reasonably determine it before the CDS evaluation?
- Would a stable code reduce proprietary fields or interface-specific logic?
- Is No meaningfully different from unknown?
- Is the responsible Schedule Authority identifiable?
- Can it be defined without embedding a particular CDS engine's internal rule?

<!-- anchor: completeness-is-relative -->

Whether a set of conditions is complete depends on the guidance, and the
version of it, being operationalized. A condition may change a recommendation
only in combination with other information; it need not change every
evaluation in which it appears.

<!-- anchor: candidate-boundary -->

A proposal that tries to carry a clinical narrative, reproduce a problem list,
or encode a recommendation probably belongs elsewhere. Draft value lists need
definition, datatype, and quality review before production use.
