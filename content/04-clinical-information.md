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
[related topics](01-related-work.md).

This separation lets a source organization improve how it determines a
condition without changing the interface, and lets a Schedule Authority or
Knowledge Base change recommendation logic without redefining the clinical
data.
