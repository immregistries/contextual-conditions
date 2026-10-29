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
