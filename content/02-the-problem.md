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

<!-- anchor: intermediate-abstraction -->

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

<!-- anchor: minimum-needed-assertion -->

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

<!-- anchor: operational-precedent -->

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
([Dates are conditions](05-evaluation-and-time.md#dates-are-conditions)).

French immunization work has independently identified and coded the statements
that influence its recommendations, using a different underlying model. Both
efforts identified maternal RSV vaccination during pregnancy as a factor in an
infant's recommendation. That convergence is evidence of a shared decision
requirement. It does not establish that the two inputs are equivalent; that
requires comparing their definitions, qualifications, and rules
([mapping is not equivalence](03-the-concept.md#mapping-not-equivalence)).
<!-- CONFIRM: French work. The description of the French coded statements, and their inclusion of maternal RSV vaccination, comes from the 3 November 2026 project discussion; where the French codes will be published is not yet known. -->

<!-- anchor: list-and-logic-together -->

The value of this earlier work is not the list of factors alone. It lies in
identifying precisely what the guidance needs and connecting each input to the
logic that uses it. A list of clinical concepts without that connection does
not reproduce the accomplishment.

<!-- anchor: determination-still-required -->

Formalizing the inputs is not an end-to-end solution. It makes explicit, once,
what the engine needs. Each environment must still determine the values from
the information available to it; see
[Source Information and Determination](04-source-information.md).

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

<!-- anchor: support-can-grow -->

The benefit of the framework is not immediate universal support. It is a
consistent mechanism through which support can grow. Adoption does not depend
on every source already holding the same abstractions.

## Intended outcome

Success means immunization CDS has a bounded, explicitly defined input layer.
Schedule Authorities can identify the factors their guidance requires,
Knowledge Bases can declare which inputs they implement, and requesting systems
can add support incrementally.

<!-- anchor: vocabulary-led-growth -->

As guidance evolves, new factors can be introduced mainly as vocabulary and
Knowledge Base additions rather than as new proprietary interface designs.
Source systems remain free to represent and derive the underlying information
in ways suited to their own purposes, while CDS engines receive only the inputs
they need to answer the recommendation question. The full value is realized as
reliable pathways are built to supply those inputs.
