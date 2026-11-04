# Source Information and Determination

Contextual Conditions define what a recommendation evaluation needs. The
information used to supply them lives elsewhere, in a **source information
model**: the way an EHR, a questionnaire, a self-service application, a public
health system, or another source represents what it knows. A clinical
information model is one important kind of source information model, not the
only one.

<!-- anchor: two-foundations -->

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

<!-- anchor: engine-consumes-assertion -->

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

<!-- anchor: responsibilities-evolve-independently -->

This separation lets a source organization improve how it determines a
condition without changing the interface, and lets a Schedule Authority or
Knowledge Base change recommendation logic without redefining the source data.

## Architectural boundary

<!-- anchor: layers-evolve-independently -->

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

<!-- anchor: clinical-vs-evaluation-context -->

Clinical systems represent information in relation to the patient and the
broader needs of care. Contextual Conditions represent information in relation
to an immunization recommendation evaluation and the guidance published by a
Schedule Authority. A clinical system may hold the diagnoses, medications, and
laboratory results behind a determination; the schedule may need only the
[resulting assertion](03-the-concept.md#assertion-not-evidence).

## Determination outside clinical care

<!-- anchor: beyond-clinical-settings -->

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

<!-- anchor: evidence-qualification -->

The same input contract serves each pathway while keeping its evidence
requirements and determination responsibilities explicit. A self-reported value
and a clinically verified value are not automatically interchangeable. Where
the difference matters to the guidance, it must be preserved, either in the
condition's definition or in the policy that governs its determination (OQ-7).

Making clinical-record structures a prerequisite for participation would
unnecessarily constrain these uses.

## Terminology and evidence

<!-- anchor: terminology-relationships -->

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

<!-- anchor: normalization-vs-determination -->

Normalizing equivalent representations is different from determination.
Replacing one code with an equivalent code is a substitution. Combining several
facts to conclude that an authority-defined category applies is a reasoning
step, and belongs to the determination process.

## When mapping exposes a gap

<!-- anchor: mapping-feedback -->

The two sides must be checked together. Mapping work may expose ambiguity in a
definition, or show that a source cannot establish a value reliably. Such
findings lead to a clarification faithful to the guidance, an explicit gap, or
a better determination method. They do not silently redefine the guidance to
match the available data.
