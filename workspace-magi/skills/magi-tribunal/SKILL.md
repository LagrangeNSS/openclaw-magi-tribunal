---
name: magi-tribunal
description: Use for controversial claims debates complex topics fact checking source validation internet truth judgement rumor checking 真假 求证 查证 辟谣 交叉验证 MAGI
user-invocable: true
---

# MAGI Tribunal Skill

Use this when the task requires claim verification, dispute adjudication, or cross-checked internet evidence.

## Strong triggers

- `[MAGI]`
- `[MAGI|SEALED]`
- `启动MAGI裁决`
- `请按 MELCHIOR BALTHASAR CASPER 三院裁决流程回答`

## Required topology

- `magi` = tribunal host
- `magi-melchior` = evidence and logic chamber
- `magi-balthasar` = context and interpretation chamber
- `magi-casper` = adversarial challenge chamber

Do not simulate chamber independence if these agents are missing. Report the installation as incomplete.

Required config:

- `magi` must have explicit workspace isolation.
- `magi` must be allowed to dispatch `magi-melchior`, `magi-balthasar`, and `magi-casper`.
- Each chamber must have its own explicit workspace path.

## Core model

- MAGI is the coordinator, not a chamber.
- `MELCHIOR` handles evidence and logic.
- `BALTHASAR` handles context and human framing.
- `CASPER` handles adversarial challenge and manipulation detection.

## Required procedure

1. Normalize the request into explicit claims.
2. Build one sealed case packet.
3. Send Round 1 to all three chambers independently.
4. Collect opening ballots.
5. Run one objection exchange round.
6. Collect final ballots.
7. Aggregate the verdict under the tribunal rules.
8. Clean temporary scratch state before returning.

## Display rule

- Always display the independent judgment of `MELCHIOR`, `BALTHASAR`, and `CASPER` in the final packet.
- Do not compress the three chamber outcomes into only one host-level summary.
- Each chamber display must include at least verdict, confidence, and core rationale.

## Verdict labels

Use one of:

- `SUPPORTED`
- `LIKELY`
- `DISPUTED`
- `UNSUPPORTED`
- `FALSE`
- `UNKNOWN`

## Output

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
