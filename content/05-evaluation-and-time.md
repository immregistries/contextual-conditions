# Evaluation Scope, Absence, and Time

## Evaluation-scoped and stateless

Contextual Conditions are supplied as part of a single recommendation request.
Each request is a complete and independent evaluation snapshot. The CDS engine:

- considers only the information supplied in that request;
- retains no patient-specific information between requests;
- does not retrieve values from previous evaluations; and
- does not treat omission as an instruction to keep an earlier value.

<!-- anchor: independent-evaluation-snapshot -->

After the engine returns its evaluations and recommendations, the supplied
Contextual Conditions have no continuing role within the engine. A later
request is evaluated solely from the information supplied with it.

<!-- anchor: longitudinal-record-boundary -->

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

<!-- anchor: explicit-no-vs-unknown -->

A requesting system may explicitly supply No when it knows that a Boolean
condition does not apply. False and unknown sometimes produce the same
recommendation, but they mean different things and some guidance treats them
differently.

## Evaluation date

Every recommendation request has an evaluation date: the clinical date for
which recommendations are calculated. In routine use this is normally the
current date. Contextual Condition values are asserted as applicable to the
evaluation performed for that date.

<!-- anchor: simulation-date-limits -->

The evaluation date may be changed for testing or simulation. It is not:

- a way to select a historical Knowledge Base;
- a request to reconstruct the patient's historical clinical context;
- a way to discover future guidance that has not been published; or
- a request to determine which conditions applied when each past immunization
  was given.

Knowledge Base identity and version are separate from the evaluation date.

<!-- anchor: prospective-model -->

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

<!-- anchor: applicability-in-definition -->

What they share is that the requesting system asserts the value as applicable
to the evaluation date. The relationship or temporal meaning the engine needs
is contained in the definition of the condition. The engine does not receive a
separate model of the related person, pregnancy, travel event, or underlying
evidence.

<!-- anchor: minimum-related-information -->

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
