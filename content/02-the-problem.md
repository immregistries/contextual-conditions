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

<!-- anchor: intermediate-abstraction -->

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

<!-- anchor: minimum-needed-assertion -->

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
