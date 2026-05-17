---
name: magi-tribunal
description: Use for disputed claims, fact checking, source verification, internet-dependent answers, rumor checking, and multi-angle adjudication.
user-invocable: true
---

# MAGI Tribunal

Use this skill when:

- the user asks whether a claim is true
- the topic is controversial
- the answer depends on current internet information
- multiple evidence chains or interpretations must be compared
- the user explicitly invokes `MAGI`

## Required topology

- `magi` is the tribunal host
- `magi-melchior` is the evidence and logic chamber
- `magi-balthasar` is the context and interpretation chamber
- `magi-casper` is the adversarial challenge chamber

Do not fake chamber independence if those agents are missing.

The host agent must be allowed to dispatch `magi` if it uses explicit subagent routing. The `magi` agent must be allowed to dispatch:

- `magi-melchior`
- `magi-balthasar`
- `magi-casper`

## Required procedure

1. Break the request into explicit claims.
2. Build one sealed case packet.
3. Send Round 1 to the three chamber agents independently.
4. Exchange objections.
5. Collect final ballots.
6. Aggregate the verdict.
7. Return the sealed packet to the host layer.
8. Do not ask chambers to persist case notes or write memory files.

## Host contract

The host layer may improve readability and tone, but may not:

- change the verdict
- inflate confidence
- hide uncertainty
- remove critical risk notes
- hide the independent chamber judgments

## Output shape

```text
Verdict: ...
Confidence: High | Medium | Low
Short answer: ...
Claim map:
- ...

Round 1 Summary
- ...

Round 2 Objections
- ...

Independent Chamber Judgments
MELCHIOR
- Verdict: ...
- Confidence: ...
- Core rationale: ...

BALTHASAR
- Verdict: ...
- Confidence: ...
- Core rationale: ...

CASPER
- Verdict: ...
- Confidence: ...
- Core rationale: ...

Final Chamber Ballots
MELCHIOR
- ...

BALTHASAR
- ...

CASPER
- ...

What could change the verdict
- ...

Sources
- ...
```
