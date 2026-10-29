<!--
GENERATED FILE. DO NOT EDIT DIRECTLY.

The authoritative source is in content/. Regenerate this reading copy with:
    python process/tools/build_core_markdown.py --assembly ContextualConditions.qmd
-->

# Contextual Conditions for Immunization Decision Support

*Working Proposal for Community Discussion — Not a Standard or Final Decision*

> This is a generated reading copy for GitHub. For review and editing, use the
> [canonical section files](content/README.md).

---

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

Feedback is welcome as a GitHub issue, a Confluence comment, or in community
meetings. Accepted changes are made here first, then the Confluence pages are
regenerated.

---

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
describes, in [Representing Contextual Conditions](content/07-representations.md), what
any representation needs to convey and the principles it must preserve, such as
modeling a meaningful date as its own Contextual Condition, so that the
representations stay consistent with each other and with the concept.

Out of scope here are the rules for who creates, determines, or stores
Contextual Conditions, and how they are included in messages and workflows.
Message structures, field-level rules, conformance requirements, storage, and
workflow behavior belong to the related topics above.

---

# The Problem

Immunization clinical decision support (CDS) depends on more than patient
demographics and vaccination history. Recommendations may also depend on
pregnancy, immune status, prior disease, travel plans, occupational exposure,
living circumstances, maternal vaccination, and other factors identified by
immunization Schedule Authorities.

This information may be represented in clinical systems through diagnoses,
observations, immunizations, laboratory results, questionnaires, patient
reports, clinician assessments, or local business rules. These representations
appropriately support the broader needs of clinical care, but they do not give
immunization CDS engines a bounded and consistent set of inputs.

Without an intermediate abstraction, a CDS engine must either:

1. receive only demographics and immunization history, leaving important
   factors unknown;
2. interpret an increasingly broad range of clinical information; or
3. depend on proprietary inputs negotiated separately between implementations.

The second approach would require an immunization CDS engine to become expert
not only in immunization guidance but in interpreting information from many
other clinical and nonclinical domains. The third causes interface designs to
change whenever new guidance introduces another relevant factor, and leads to
local fields, proprietary extensions, inconsistent use of contraindication and
allergy fields, and repeated mappings among electronic health records (EHRs),
immunization information systems (IIS), and CDS engines.

## A motivating example: maternal RSV vaccination

The need became concrete with maternal respiratory syncytial virus (RSV)
vaccination. When a birth mother receives RSV vaccine during pregnancy, her
infant generally does not need RSV monoclonal antibody. To recommend correctly
for the infant, the CDS engine needs to know about a vaccination recorded on
another person's record.

Sending the mother's clinical record, or enough of it to establish the fact, is
complex for both sender and receiver and discloses more than the evaluation
needs. What the infant's evaluation actually needs is a single assertion:

> Birth mother received RSV vaccine during pregnancy: Yes.

## A third input to immunization CDS

Immunization exchange has traditionally answered two questions: who the patient
is, and what immunizations the patient has received. Contextual Conditions add
a third:

| Input | Question answered | Typical content |
|---|---|---|
| Patient identification | Who is the patient? | Identifiers and demographics |
| Immunization history | What immunizations has the patient received? | Administered and historical vaccination events |
| Contextual Conditions | What other context, defined by the Schedule Authority, affects this evaluation? | Asserted conditions such as risk, status, prior disease, exposure, relationship, travel, or occupation, with their values |

Contextual Conditions provide a tractable layer between detailed source
information and immunization forecasting logic.

---

# The Concept

## Definitions

A **Contextual Condition** is a Schedule Authority-defined input, with an
assigned meaning and datatype, that may influence an immunization evaluation or
recommendation.

A **Contextual Condition assertion** is the value that a requesting system
supplies for that input as part of a particular recommendation request.

Keeping the two apart matters. The Contextual Condition is a stable, published
definition. The assertion is one system's statement, for one evaluation, that
the condition does or does not apply, or has a particular value.

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
requires them. An assertion must use the datatype the condition defines; a date
or number is not reduced to Yes or No.
<!-- CONFIRM: Numeric datatype. The Confluence concept page says "integer"; the draft French inventory includes "Number" values such as laboratory results, height, and weight, which may need decimals. See OQ-6. -->

When a date is meaningful to a condition, the date is modeled as a Contextual
Condition of its own, with a date value. It is not carried in a
representation's own date fields; see
[Representing Contextual Conditions](content/07-representations.md).

## Properties of a Contextual Condition

A Contextual Condition is:

- **Defined by an authority.** A Schedule Authority assigns its meaning, its
  datatype, and a stable identifier.
- **Operational.** It exists because immunization guidance needs it to evaluate
  or recommend. It engages CDS logic; it does not reproduce the clinical record.
- **Bounded.** Its definition states what is, and is not, being asserted.
- **Asserted, not inferred, by the CDS engine.** The requesting system has
  already determined the value. The engine consumes it.
- **Independent of its evidence.** The same assertion might come from
  structured clinical data, a questionnaire, a patient report, clinical
  judgment, another system, or local business rules.

## What a Contextual Condition is not

A Contextual Condition is not, by itself:

- a diagnosis code or problem-list entry;
- a general-purpose clinical observation;
- a complete allergy, precaution, or contraindication record;
- the evidence used to reach a conclusion;
- a clinical recommendation or schedule rule;
- an inference algorithm; or
- a requirement that any particular condition be collected.

For example, diagnoses, medications, laboratory results, and a clinician's
assessment may together support the conclusion that a patient is severely
immunocompromised. Those facts remain important in their proper systems. The
Contextual Condition is the assertion that the patient meets the Schedule
Authority's definition.

This is also why a clinical terminology such as SNOMED CT is not used directly
as the Contextual Condition vocabulary. Clinical terminologies describe evidence
and may be related to Contextual Conditions, but a Contextual Condition is
defined from immunization guidance and keeps its meaning as evidence mappings
and local determination logic improve.

## Formalizing an existing abstraction

Contextual Conditions formalize an abstraction that immunization CDS engines
already require. At some point, complex clinical and nonclinical information
must be reduced to the inputs that forecasting rules use. This concept exposes
and standardizes that input layer so other systems have a consistent target.

It is not a complete end-to-end solution. Systems must still determine
Contextual Condition values from the information available to them.

---

# Relationship to Clinical Information

Contextual Conditions are not intended to replace or reorganize the clinical
information model. They do not replace FHIR Observation, Condition,
Immunization, or QuestionnaireResponse resources, SNOMED CT, diagnosis codes,
problem lists, or other clinical representations.

Clinical systems represent information in relation to the patient and the
broader needs of care. Contextual Conditions represent information in relation
to an immunization recommendation evaluation and the guidance published by a
Schedule Authority.

For example, a clinical system may represent immune status through diagnoses,
medications, laboratory results, procedures, and clinician assessments. An
immunization schedule may need only the resulting determination:

> Patient meets this Schedule Authority's definition of severely
> immunocompromised.

## Separation of responsibilities

The concept separates four activities:

1. **Clinical data capture:** recording diagnoses, observations, treatments,
   questionnaire answers, patient reports, and other evidence.
2. **Determination:** deciding, under appropriate policy, that a Contextual
   Condition applies or what its value is.
3. **Assertion:** supplying the Contextual Condition and its value to CDS.
4. **Decision support:** applying immunization guidance to the assertion.

The requesting system is responsible for determination. The CDS engine accepts
the supplied assertion as authoritative for the evaluation. It does not
independently interpret the underlying clinical record or decide whether the
assertion was correctly derived.

Collection, derivation, validation, and provenance remain the responsibility of
the requesting system. A clinical system or IIS may keep the underlying
information and its provenance for clinical, audit, or operational purposes.
Who creates, determines, or stores Contextual Conditions in a given workflow is
outside this concept and is addressed by the
[related topics](content/01-related-work.md).

This separation lets a source organization improve how it determines a
condition without changing the interface, and lets a Schedule Authority or
Knowledge Base change recommendation logic without redefining the clinical
data.

---

# Evaluation Scope, Absence, and Time

## Evaluation-scoped and stateless

Contextual Conditions are supplied as part of a single recommendation request.
Each request is a complete and independent evaluation snapshot. The CDS engine:

- considers only the information supplied in that request;
- retains no patient-specific information between requests;
- does not retrieve values from previous evaluations; and
- does not treat omission as an instruction to keep an earlier value.

After the engine returns its evaluations and recommendations, the supplied
Contextual Conditions have no continuing role within the engine. A later
request is evaluated solely from the information supplied with it.

Typical immunization CDS installations contain an embedded Knowledge Base but
no patient, immunization, or longitudinal clinical database. Maintaining a
longitudinal record is the responsibility of a clinical system or IIS, not the
CDS engine. Whether and how an IIS stores Contextual Conditions for later
requests is outside this concept; it would need rules for provenance, effective
time, correction, expiration, and retraction, and is addressed by
[topic 140](https://informatics.immregistries.org/hub/es/topic/140).

## Absence means unknown

Omission means the requesting system makes no assertion about a Contextual
Condition. The value is unknown to the CDS engine. Absence is never a No.

A requesting system may explicitly supply No when it knows that a Boolean
condition does not apply. False and unknown sometimes produce the same
recommendation, but they mean different things and some guidance treats them
differently.

## Evaluation date

Every recommendation request has an evaluation date: the clinical date for
which recommendations are calculated. In routine use this is normally the
current date. Contextual Condition values are asserted as applicable to the
evaluation performed for that date.

The evaluation date may be changed for testing or simulation. It is not:

- a way to select a historical Knowledge Base;
- a request to reconstruct the patient's historical clinical context;
- a way to discover future guidance that has not been published; or
- a request to determine which conditions applied when each past immunization
  was given.

Knowledge Base identity and version are separate from the evaluation date.

The model is intentionally prospective. Its primary purpose is to improve
guidance about what the patient should receive next, not to explain or
re-evaluate every past immunization decision. Reconstructing historical
context, such as whether a patient was pregnant when a dose was given years
earlier, would need far more information and modeling. CDS engines already
evaluate histories without knowing every reason earlier doses were given,
delayed, or omitted.

## What "applies" means

A Contextual Condition does not necessarily describe a present clinical state.
Its meaning may concern:

- a past event: "Patient has had varicella disease";
- a present state: "Patient is pregnant";
- a future intention: "Patient plans to travel to Nigeria"; or
- another person: "Birth mother received RSV vaccine during the relevant
  pregnancy."

What they share is that the requesting system asserts the value as applicable
to the evaluation date. The relationship or temporal meaning the engine needs
is contained in the definition of the condition. The engine does not receive a
separate model of the related person, pregnancy, travel event, or underlying
evidence.

This is deliberate. For maternal RSV vaccination, the engine may need only one
or two assertions from the mother's history. Requiring the mother's identity
and record would add complexity and disclose more than the evaluation requires.
The same principle applies to any relationship a Schedule Authority identifies
as relevant. Whether a factor is clinically appropriate is the Schedule
Authority's decision, not the framework's.

## Dates are conditions

When guidance needs a date, such as the start of a pregnancy or the date of a
transplant, that date is its own Contextual Condition with a date value. It is
not inferred from, or carried in, a representation's own timestamp fields.
Those fields describe the record or the message, not the meaning of the
condition.

---

# Schedule Authorities, Knowledge Bases, and Code Systems

## Schedule Authorities

A **Schedule Authority** is an organization or expert body that publishes
immunization recommendations for clinical or public health use.

The Schedule Authority defines the meaning of the Contextual Conditions its
recommendations require. It decides:

- which factors influence its guidance;
- what each condition means;
- what datatype each condition requires; and
- when a condition affects a recommendation.

## Knowledge Bases

A **Knowledge Base** is an identifiable, executable operationalization of
guidance from one or more Schedule Authorities, possibly including
jurisdictional or local adaptations.

A forecast applies one Knowledge Base as a coherent unit. The Knowledge Base
identifies the Contextual Conditions, and their versions, that it supports.
The CDS engine does not redefine a Schedule Authority's conditions; it applies
the rules in its selected Knowledge Base. How a Knowledge Base declares support,
and how an engine reports whether a submitted condition was recognized, are
defined by the CDS interface, such as ImmDS + HALO, not by this concept.

## Authority-specific code systems

The concept does not require a single, internationally harmonized list of
Contextual Conditions. Each Schedule Authority may publish its own definitive,
versioned code system, so it can express exactly the concepts its guidance
needs without first reconciling language, policy, clinical definitions, or
implementation criteria with other authorities.

For example, French and American Schedule Authorities may define conditions
that look similar but differ in subtle and important ways. Forcing them into
one concept would risk hiding those differences, or letting an interoperability
project reinterpret clinical policy.

Future work may identify relationships or mappings between conditions from
different authorities. A mapping must not imply equivalence unless equivalence
has been established. Similar labels are not evidence of equivalence.

Published identifiers and definitions must remain stable. A material change in
meaning results in a new version or a new concept, not a silent change to an
existing code.

## Publication and stewardship

Schedule Authorities own the clinical meaning of their Contextual Conditions.

A terminology steward may provide the technical publication framework: stable
identifiers, namespace management, versioning, and distribution, so that those
definitions are computable and exchangeable. The steward does not create
clinical guidance or reinterpret the authority's intent.

The Immunization Vocabularies Collaborative (IVC) may serve as a publication
and coordination mechanism for these code systems, and may support future work
on relationships between authority-specific concepts. IVC is not part of the
clinical decision-making process and is not required by the Contextual
Conditions architecture. How code systems are actually published is outside
this document.
<!-- CONFIRM: Role vocabulary. Earlier sources describe four roles (Code System, Publishing, Namespace, and CDS Authority); this section follows the September 2026 concept page. See OQ-4. -->

---

# Representing Contextual Conditions

Contextual Conditions are a concept, not a message format. They can be
represented in more than one standard, and HL7 v2 and FHIR are the two in
current use. This section describes, at a general level, what any
representation must convey and which principles it must preserve. Detailed
specifications belong to the [related topics](content/01-related-work.md).

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
[topics 137, 140, and 141](content/01-related-work.md).

## FHIR

In FHIR, Contextual Conditions are supplied as inputs to the immunization CDS
interface defined by the ImmDS + HALO work, where they are known as HALO
factors. The FHIR representation, including how an engine reports supported
conditions, is defined by
[topic 1](https://informatics.immregistries.org/hub/es/topic/1).

---

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
  principles in [Representing Contextual Conditions](content/07-representations.md).

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

---

# Applying the Concept

## Evaluating a candidate condition

A proposed concept is a good Contextual Condition candidate when most of these
questions have clear answers:

- Does immunization guidance need this information to evaluate or recommend
  vaccination?
- Can its meaning be expressed as a bounded assertion?
- Is it distinct from patient identity and immunization history?
- Can a requesting system reasonably determine it before the CDS evaluation?
- Would a stable code reduce proprietary fields or interface-specific logic?
- Is the datatype clear: Boolean, date, number, or another defined type?
- Is No meaningfully different from unknown?
- Is the responsible Schedule Authority identifiable?
- Can it be defined without embedding a particular CDS engine's internal rule?
- Is its temporal meaning, relative to the evaluation date, clear?

A proposal that tries to carry a clinical narrative, reproduce a problem list,
or encode a recommendation probably belongs elsewhere.

## Common pitfalls

1. **Treating omission as No.** Omitted means unknown.
2. **Sending raw diagnoses as if they were Contextual Conditions.** Evidence and
   the assertion are related but distinct.
3. **Making the CDS engine infer the condition.** Determination happens in the
   requesting system.
4. **Assuming similar labels are equivalent across authorities.** Compare
   definitions, datatypes, and authorities, not names.
5. **Carrying a meaningful date in a timestamp field.** Model it as its own
   Contextual Condition with a date value.
6. **Inventing a new interface structure for each condition.** The intended
   way to grow is vocabulary, within a stable representation.
7. **Treating draft value lists as production-ready.** Proposed conditions need
   definition, datatype, and quality review before use.
8. **Embedding clinical policy in a condition's definition.** The condition
   identifies the context; the Schedule Authority's guidance and the Knowledge
   Base determine its effect.
9. **Expanding Contextual Conditions into a general clinical record.** The
   concept is deliberately limited to what immunization guidance needs.

---

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
| WD-5 | This document describes the HL7 v2 and FHIR representations at a general level: what a representation must convey and which principles it must preserve. Detailed specifications belong to the related InteropHub topics (1, 137, 140, and 141), which depend on this concept and may develop their own documentation. Resolves OQ-1. | Project direction, October 2026 |
| WD-6 | HALO factors, from the Immunization CDS (ImmDS + HALO) work, are Contextual Conditions as defined in this document. | Project direction, October 2026 |
| WD-7 | This document describes what a Contextual Condition is conceptually. It does not set rules for who creates, determines, or stores Contextual Conditions, or for how they are included in messages and workflows. IIS storage rules belong to topic 140; topic 141 also touches on storage and is likely to prohibit storing conditions supplied in a query. Resolves OQ-2. | Project direction, October 2026 |
| WD-8 | When a date is meaningful to a Contextual Condition, it is modeled as a separate Contextual Condition with a date value. It is not conveyed through a representation's own date fields, such as HL7 v2 OBX-14 or the date elements of a FHIR Observation. This modeling rule applies to every representation and is in scope. | Project direction, October 2026 |

## Open questions

These were identified by comparing existing sources; see the
[initial source review](review/2026-10-29-initial-source-review.md) for
detail. Each needs discussion before the affected text is settled. Questions
that belong to a related topic are referred there rather than answered here.

| ID | Question | Sources in tension | Status |
|---|---|---|---|
| OQ-1 | Does this document include an HL7 v2 representation, or only the transport-neutral concept, with HL7 v2 and other representations documented elsewhere? | The Confluence concept page lists transport representations as a non-goal; the HL7 v2 Confluence page is a child of it. | Resolved by WD-5 |
| OQ-2 | May an IIS store Contextual Conditions received in a VXU? | The Confluence concept page (September 2026) describes conditions as evaluation-scoped and leaves longitudinal storage to separate work; the HL7 v2 page (June 2026) and the primer allow optional storage under local policy. | Resolved by WD-7; storage rules belong to topic 140 |
| OQ-3 | Which OBX-2 value type carries a Boolean Contextual Condition? | The primer's example uses `ID`; the HL7 v2 Confluence page uses `CE`. | Referred to topic 137 under WD-5 |
| OQ-4 | What are the current names for the governance roles? | The primer names four roles (Code System, Publishing, Namespace, and CDS Authority); the Confluence concept page uses Schedule Authority, terminology steward, and Knowledge Base. | Open |
| OQ-5 | Is there a nullified state that removes a previously stored assertion? | The primer describes one; the Confluence concept page's stateless model has none. Depends on OQ-2. | Referred to topic 140 under WD-7 |
| OQ-6 | Is the numeric datatype an integer, or any number? | The Confluence concept page names date or integer values; the draft French inventory includes Number values such as laboratory results, height, and weight. | Open |
