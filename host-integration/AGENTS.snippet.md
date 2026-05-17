# Host Routing Snippet

Add the following behavior to your host agent's `AGENTS.md` if you want the host to delegate truth-sensitive work to MAGI.

## MAGI routing

- If the task is controversial, truth-sensitive, or depends on current internet information, route it to `magi`.
- Do not simulate three chamber voices inside the host.
- Expect `magi` to coordinate `magi-melchior`, `magi-balthasar`, and `magi-casper`.
- If the host uses explicit subagent dispatch, its OpenClaw config must allow `magi` through `subagents.allowAgents`.
- After MAGI returns, the host may improve clarity and tone.
- The host may not change the verdict, raise confidence, hide uncertainty, or suppress chamber judgments.

## Expected output shape

- Overall verdict and confidence.
- Claim map.
- Round summaries.
- Independent chamber judgments from `MELCHIOR`, `BALTHASAR`, and `CASPER`.
- Final chamber ballots.
- Sources.
- What could change the verdict.
