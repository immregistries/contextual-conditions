# The Concept

## Definitions

A **Contextual Condition** is a Schedule Authority-defined input, with an
assigned meaning and datatype, that may influence an immunization evaluation or
recommendation.

A **Contextual Condition assertion** is the value that a requesting system
supplies for that input as part of a particular recommendation request.

<!-- anchor: definition-vs-assertion -->

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

<!-- anchor: date-as-own-condition -->

When a date is meaningful to a condition, the date is modeled as a Contextual
Condition of its own, with a date value. It is not carried in a
representation's own date fields; see
[Representing Contextual Conditions](07-representations.md).

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

<!-- anchor: assertion-not-evidence -->

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

<!-- anchor: determination-still-required -->

It is not a complete end-to-end solution. Systems must still determine
Contextual Condition values from the information available to them.
