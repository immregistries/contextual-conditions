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
  [Evaluation, Time, and Representation](content/05-evaluation-and-time.md#prospective-model).
- **A single, globally harmonized code system.** See
  [authority-specific code systems](content/03-the-concept.md#authority-specific-code-systems).
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
same idea; see [Formalizing an existing practice](content/02-the-problem.md#formalizing-an-existing-abstraction).

---

# Why Contextual Conditions

Immunization CDS depends on more than patient demographics and vaccination
history. Recommendations may also depend on pregnancy, immune status, prior
disease, travel plans, occupational exposure, living circumstances, maternal
vaccination, and other factors identified by immunization Schedule Authorities.

This information may be held in many forms: diagnoses, observations,
immunizations, laboratory results, questionnaires, patient reports, clinician
assessments, public health program data, or local business rules. Those forms
serve their own purposes well, but they do not give immunization CDS engines a
bounded and consistent set of inputs.

Without an intermediate abstraction, a CDS engine must either:

1. receive only demographics and immunization history, leaving important
   factors unknown;
2. interpret an increasingly broad range of clinical and nonclinical
   information; or
3. depend on proprietary inputs negotiated separately between implementations.

The second approach would require an immunization CDS engine to become expert
not only in immunization guidance but in interpreting information from many
other domains. The third causes interface designs to change whenever new
guidance introduces another relevant factor, and leads to local fields,
proprietary extensions, inconsistent use of contraindication and allergy
fields, and repeated mappings among electronic health records (EHRs),
immunization information systems (IIS), and CDS engines. Each integration must
rediscover both what the engine needs and how to produce it.

## A motivating example: maternal RSV vaccination

The need became concrete with maternal respiratory syncytial virus (RSV)
vaccination. When a birth mother receives RSV vaccine during pregnancy, her
infant generally does not need RSV monoclonal antibody. To recommend correctly
for the infant, the CDS engine needs to know about a vaccination recorded on
another person's record.

Sending the mother's clinical record, or enough of it to establish the fact, is
complex for both sender and receiver and discloses more than the evaluation
needs. What the infant's evaluation actually needs is a single assertion:

> Birth mother received RSV vaccine during the relevant pregnancy: Yes.

## A third input to immunization CDS

Immunization exchange has traditionally answered two questions: who the patient
is, and what immunizations the patient has received. Contextual Conditions add
a third:

| Input | Question answered | Typical content |
|---|---|---|
| Patient identification | Who is the patient? | Identifiers and demographics |
| Immunization history | What immunizations has the patient received? | Administered and historical vaccination events |
| Contextual Conditions | What other context, defined by the Schedule Authority, affects this evaluation? | Asserted conditions such as risk, status, prior disease, exposure, relationship, travel, or occupation, with their values |

## Formalizing an existing practice {#formalizing-an-existing-abstraction}

Contextual Conditions formalize an abstraction that immunization CDS already
relies on. At some point, complex clinical and nonclinical information must be
reduced to the inputs that forecasting rules use. This concept makes that input
layer explicit, shareable, and reusable, so other systems have a consistent
target.

The abstraction is already in operational use. The US
[Clinical Decision Support for Immunization (CDSi)](https://www.cdc.gov/iis/cdsi/index.html)
resources from CDC identify the patient-specific inputs that Advisory Committee
on Immunization Practices (ACIP) recommendations depend on, and call them
*patient observations*. The *CDSi Logic Specification for ACIP
Recommendations* describes how evaluation and forecasting use them, and the
*CDSi Supporting Data*, updated as new US guidance is published, carries the
current set. CDSi patient observations are Contextual Conditions as defined here
(WD-9); they were named before this concept was developed. Where a CDSi rule
measures from the date of an observation, such as the onset of pregnancy, that
date corresponds to a separate Contextual Condition with a date value
([Dates are conditions](content/05-evaluation-and-time.md#dates-are-conditions)).

French immunization work has independently identified and coded the statements
that influence its recommendations, using a different underlying model. Both
efforts identified maternal RSV vaccination during pregnancy as a factor in an
infant's recommendation. That convergence is evidence of a shared decision
requirement. It does not establish that the two inputs are equivalent; that
requires comparing their definitions, qualifications, and rules
([mapping is not equivalence](content/03-the-concept.md#mapping-not-equivalence)).
<!-- CONFIRM: French work. The description of the French coded statements, and their inclusion of maternal RSV vaccination, comes from the 3 November 2026 project discussion; where the French codes will be published is not yet known. -->

The value of this earlier work is not the list of factors alone. It lies in
identifying precisely what the guidance needs and connecting each input to the
logic that uses it. A list of clinical concepts without that connection does
not reproduce the accomplishment.

Formalizing the inputs is not an end-to-end solution. It makes explicit, once,
what the engine needs. Each environment must still determine the values from
the information available to it; see
[Source Information and Determination](content/04-source-information.md).

## Incremental adoption {#adoption-and-boundaries}

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
consistent mechanism through which support can grow. Adoption does not depend
on every source already holding the same abstractions.

## Intended outcome

Success means immunization CDS has a bounded, explicitly defined input layer.
Schedule Authorities can identify the factors their guidance requires,
Knowledge Bases can declare which inputs they implement, and requesting systems
can add support incrementally.

As guidance evolves, new factors can be introduced mainly as vocabulary and
Knowledge Base additions rather than as new proprietary interface designs.
Source systems remain free to represent and derive the underlying information
in ways suited to their own purposes, while CDS engines receive only the inputs
they need to answer the recommendation question. The full value is realized as
reliable pathways are built to supply those inputs.

---

# The Concept

## The starting question

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
person; see [what "applies" means](content/05-evaluation-and-time.md#what-applies-means).

A **Contextual Condition** is a Schedule Authority-defined input, with an
assigned meaning and datatype, that may influence an immunization evaluation or
recommendation.

A **Contextual Condition assertion** is the value that a requesting system
supplies for that input as part of a particular recommendation request.

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
[Dates are conditions](content/05-evaluation-and-time.md#dates-are-conditions).
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

For example, diagnoses, medications, laboratory results, and a clinician's
assessment may together support the conclusion that a patient is severely
immunocompromised. Those facts remain important in their own systems. The
Contextual Condition is the assertion that the patient meets the Schedule
Authority's definition.

## What a definition contains

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

### Schedule Authorities

A **Schedule Authority** is an organization or expert body that publishes
immunization recommendations for clinical or public health use.

The Schedule Authority defines the meaning of the Contextual Conditions its
recommendations require. It decides:

- which factors influence its guidance;
- what each condition means;
- what datatype each condition requires; and
- when a condition affects a recommendation.

### Knowledge Bases

A **Knowledge Base** is an identifiable, executable operationalization of
guidance from one or more Schedule Authorities, possibly including
jurisdictional or local adaptations.

A forecast applies one Knowledge Base as a coherent unit. The Knowledge Base
identifies the Contextual Conditions, and their versions, that it supports.
The CDS engine does not redefine a Schedule Authority's conditions; it applies
the rules in its selected Knowledge Base. How a Knowledge Base declares support,
and how an engine reports whether a submitted condition was recognized, are
defined by the CDS interface, such as ImmDS + HALO, not by this concept.

### Authority-specific code systems

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
has been established. Similar labels, or independent identification of the same
factor, are not evidence of equivalence.

Published identifiers and definitions must remain stable. A material change in
meaning results in a new version or a new concept, not a silent change to an
existing code.

### Publication and stewardship

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
this document. IVC's proposed rule for naming the code systems it publishes is
in [IVC Identifiers and Namespaces](https://github.com/IVC-NUVA/IVC-Website/blob/main/discussion/identifiers-and-namespaces.md).

The concept uses three roles: Schedule Authority, terminology steward, and
Knowledge Base (WD-10). Earlier descriptions used four roles, Code System,
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

Whether a set of conditions is complete depends on the guidance, and the
version of it, being operationalized. A condition may change a recommendation
only in combination with other information; it need not change every
evaluation in which it appears.

A proposal that tries to carry a clinical narrative, reproduce a problem list,
or encode a recommendation probably belongs elsewhere. Draft value lists need
definition, datatype, and quality review before production use.

---

# Source Information and Determination

Contextual Conditions define what a recommendation evaluation needs. The
information used to supply them lives elsewhere, in a **source information
model**: the way an EHR, a questionnaire, a self-service application, a public
health system, or another source represents what it knows. A clinical
information model is one important kind of source information model, not the
only one.

The two sides need sound foundations, but they need not share a structure.
Contextual Conditions establish the recommendation side. Judging them by how
closely they resemble an EHR model applies the requirements of the source side
to the wrong task. What connects the two is a set of mappings and determination
processes that let source information satisfy the recommendation's
requirements.

## Separation of responsibilities

Four questions are kept separate:

| Perspective | Question | Contribution |
|---|---|---|
| Recommendation model | What must the engine know to apply this rule? | Identifies the inputs and connects them to decision logic. |
| Meaning of the input | Exactly what does this assertion establish? | Defines the proposition, datatype, qualifications, and temporal or relational scope. |
| Source information model | How is the underlying information represented? | Identifies where the information lives in EHRs, questionnaires, self-service applications, public health systems, and other sources. |
| Determination | How can available evidence establish the required value? | Specifies retrieval, interpretation, inference, or human confirmation under an appropriate policy. |

Contextual Conditions formalize the first two questions and give the other two
a stable target.

The requesting system is responsible for determination. The CDS engine uses the
supplied assertion for the evaluation. It does not independently interpret the
underlying record or decide whether the assertion was correctly derived. It may
still check that an assertion is valid for the condition's definition and
report a condition it does not support; how it handles contradictory
assertions is not yet settled (OQ-9).

Collection, derivation, and provenance remain the responsibility of the
requesting system. A source system may keep the underlying information and its
provenance for clinical, audit, or operational purposes. Who creates,
determines, or stores Contextual Conditions in a given workflow is outside this
concept (WD-7).

This separation lets a source organization improve how it determines a
condition without changing the interface, and lets a Schedule Authority or
Knowledge Base change recommendation logic without redefining the source data.

## Architectural boundary

The same separation sets a boundary among three layers:

1. **Source systems,** clinical or otherwise, collect information, maintain
   any longitudinal records, and determine the values supplied to CDS.
2. **The CDS interface** conveys evaluation-scoped demographics, immunization
   history, and Contextual Condition values.
3. **The CDS engine and its selected Knowledge Base** apply immunization
   guidance and return evaluations and recommendations.

Each layer can evolve without requiring the CDS engine to interpret a full
record, and without requiring source systems to adopt a schedule-specific
information model.

## Clinical information models {#clinical-information}

Contextual Conditions do not replace or reorganize the clinical information
model. They do not replace FHIR Observation, Condition, Immunization, or
QuestionnaireResponse resources, SNOMED CT, diagnosis codes, problem lists, or
other clinical representations. Those remain valuable sources and mapping
targets without becoming the foundation of the recommendation input model.

Clinical systems represent information in relation to the patient and the
broader needs of care. Contextual Conditions represent information in relation
to an immunization recommendation evaluation and the guidance published by a
Schedule Authority. A clinical system may hold the diagnoses, medications, and
laboratory results behind a determination; the schedule may need only the
[resulting assertion](content/03-the-concept.md#assertion-not-evidence).

## Determination outside clinical care

Determination need not take place in an EHR or during a clinical encounter.
Immunization recommendation services arise from public health expertise and
the operationalization of population-level guidance, so their inputs need not
begin with clinical-record modeling. This does not exclude clinical expertise
or clinical use; it explains why the input model is broader than the clinical
encounter.

| Setting | Possible determination pathway |
|---|---|
| Clinical care | Structured records, clinician assessment, and confirmation of missing information. |
| Self-service application | A person's answers to defined questions, interpreted as the guidance and the application require. |
| Public health service | Program information, reported circumstances, and relevant data from clinical or nonclinical sources. |
| Integration or intermediary service | Transformation of available evidence and, where needed, explicit determination rules. |

For example, a self-service application can let a person supply information
that supports a recommendation without first creating a structured clinical
record.
<!-- CONFIRM: Self-service example. The French MesVaccins self-service use was described in the 3 November 2026 project discussion; confirm whether to name it here. -->

The same input contract serves each pathway while keeping its evidence
requirements and determination responsibilities explicit. A self-reported value
and a clinically verified value are not automatically interchangeable. Where
the difference matters to the guidance, it must be preserved, either in the
condition's definition or in the policy that governs its determination (OQ-7).

Making clinical-record structures a prerequisite for participation would
unnecessarily constrain these uses.

## Terminology and evidence

A clinical terminology such as SNOMED CT is not used directly as the Contextual
Condition vocabulary. A terminology supplies meanings used to describe
information; a Contextual Condition specifies which meaning and value a
recommendation evaluation requires and how it connects to decision logic.

An existing terminology concept may express the exact meaning a condition
requires, cover only part of it, be broader or narrower, or serve only as
evidence for a determination. These relationships must be distinguished. The
presence of a SNOMED CT code in a record does not by itself establish that a
condition applies, because the definition may require particular timing,
severity, relationships, or policy qualifications. Where an existing concept is
an exact match, the relationship should be recognized and recorded (OQ-8).

Normalizing equivalent representations is different from determination.
Replacing one code with an equivalent code is a substitution. Combining several
facts to conclude that an authority-defined category applies is a reasoning
step, and belongs to the determination process.

## When mapping exposes a gap

The two sides must be checked together. Mapping work may expose ambiguity in a
definition, or show that a source cannot establish a value reliably. Such
findings lead to a clarification faithful to the guidance, an explicit gap, or
a better determination method. They do not silently redefine the guidance to
match the available data.

---

# Evaluation, Time, and Representation

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

Four states are never interchangeable:

| State | Meaning |
|---|---|
| Unknown | The condition was not supplied. |
| Explicit No | The requesting system asserts that the condition does not apply. |
| Unsupported | The condition was supplied, but the selected Knowledge Base does not use it. |
| Invalid | The condition was supplied with a value that does not fit its definition, such as the wrong datatype. |

How an engine reports unsupported and invalid conditions is defined by each CDS
interface, not by this concept.

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
transplant, that date is a Contextual Condition of its own, with a date value
(WD-8). It is not inferred from, or carried in, a representation's own date
fields, such as HL7 v2 OBX-14 or the date elements of a FHIR Observation. Those
fields describe the record or the message, not the meaning of the condition.

## Representing Contextual Conditions {#representations}

Contextual Conditions are a concept, not a message format. HL7 v2 and FHIR are
the two representations in current use. This section describes what any
representation must convey and which principles it must preserve; detailed
specifications belong to the [related topics](content/00-status-and-scope.md#related-work)
(WD-5).

### What every representation conveys

For each asserted Contextual Condition, a representation conveys:

- **the condition**, identified by its code and by the code system of the
  Schedule Authority that defines it, so that the authority is always explicit;
  and
- **the asserted value**, in the condition's datatype.

### Principles every representation preserves

- **Sparse.** Only asserted conditions are sent. There is no "unknown" value to
  transmit, and a receiver never treats a missing condition as
  [No](#explicit-no-vs-unknown).
- **Dates are conditions.** A meaningful date is sent as its own
  [Contextual Condition](#date-as-own-condition).
- **Vocabulary, not structure.** A new condition is a vocabulary addition. It
  does not need a new segment, element, extension, or message design.
- **Support is reported, not assumed.** Sending a condition does not guarantee
  that it influenced the result. Each representation defines how an engine
  reports the [unsupported and invalid states](#distinct-input-states).

### HL7 v2

In HL7 v2, each Contextual Condition is a standard OBX observation. OBX-3
identifies the condition, using the Schedule Authority's code system, and OBX-5
carries the asserted value. No new segments or message structures are
introduced. Use in immunization updates (VXU) and queries (QBP), including what
an IIS may do with the conditions it receives, is defined by topics 137, 140,
and 141.

### FHIR

In FHIR, Contextual Conditions are supplied as inputs to the immunization CDS
interface defined by the ImmDS + HALO work, where they are known as HALO
factors. The FHIR representation, including how an engine reports supported
conditions, is defined by
[topic 1](https://informatics.immregistries.org/hub/es/topic/1).

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
| WD-4 | Disagreements among sources, and critiques of the concept, are kept visible in this repository rather than resolved privately. | Project scope, October 2026 |
| WD-5 | This document describes the HL7 v2 and FHIR representations at a general level: what a representation must convey and which principles it must preserve. Detailed specifications belong to the related InteropHub topics (1, 137, 140, and 141), which depend on this concept and may develop their own documentation. Resolves OQ-1. | Project direction, October 2026 |
| WD-6 | HALO factors, from the Immunization CDS (ImmDS + HALO) work, are Contextual Conditions as defined in this document. | Project direction, October 2026 |
| WD-7 | This document describes what a Contextual Condition is conceptually. It does not set rules for who creates, determines, or stores Contextual Conditions, or for how they are included in messages and workflows. IIS storage rules belong to topic 140; topic 141 also touches on storage and is likely to prohibit storing conditions supplied in a query. Resolves OQ-2. | Project direction, October 2026 |
| WD-8 | When a date is meaningful to a Contextual Condition, it is modeled as a separate Contextual Condition with a date value. It is not conveyed through a representation's own date fields, such as HL7 v2 OBX-14 or the date elements of a FHIR Observation. This modeling rule applies to every representation and is in scope. | Project direction, October 2026 |
| WD-9 | The patient observations defined by the US CDSi resources are Contextual Conditions as defined in this document; CDSi named them before this concept was developed. | Project direction, November 2026; [CDSi Logic Specification for ACIP Recommendations, version 4.6](https://www.cdc.gov/iis/downloads/logic-spec-acip-rec-4.6.pdf) |
| WD-10 | The concept uses three roles: Schedule Authority, terminology steward, and Knowledge Base. The four roles of earlier sources (Code System, Publishing, Namespace, and CDS Authority) fold into them. Resolves OQ-4. | Project direction, November 2026 |

## Open questions

OQ-1 to OQ-6 were identified by comparing existing sources; see the
[initial source review](review/2026-10-29-initial-source-review.md) for
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
