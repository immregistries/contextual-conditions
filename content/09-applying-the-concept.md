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
