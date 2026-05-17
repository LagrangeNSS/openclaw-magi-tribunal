# Install MAGI Tribunal From Zip

## 中文

我会附上一个 `openclaw-magi-tribunal` zip。请把它作为唯一来源，在本机完成 OpenClaw MAGI Tribunal 的安装。

请执行：

1. 解压 zip，并定位仓库根目录。
2. 备份现有 `~/.openclaw/openclaw.json` 和所有已存在的 MAGI workspace。
3. 安装四个工作区：
   - `workspace-magi` -> `~/.openclaw/workspace-magi`
   - `workspace-magi-melchior` -> `~/.openclaw/workspace-magi-melchior`
   - `workspace-magi-balthasar` -> `~/.openclaw/workspace-magi-balthasar`
   - `workspace-magi-casper` -> `~/.openclaw/workspace-magi-casper`
4. 将 `openclaw.magi.example.json5` 合并进 `~/.openclaw/openclaw.json`，不要覆盖无关配置。
5. 保留四个 agent 的显式 `workspace` 字段。
6. 保留 `magi.subagents.allowAgents`，允许 `magi` 调度 `magi-melchior`、`magi-balthasar`、`magi-casper`。
7. 如我要求自定义四个 agent 的模型，请参考 `configs/magi-models.example.json5`，把我提供或现有可用的 `provider/model` 写入四个 MAGI agent 的 `model` 字段。
8. 如果默认 host agent 需要调用 MAGI，把 `host-integration/skills/magi-tribunal/SKILL.md` 安装到 host workspace 的 `skills/magi-tribunal/`，并把 `host-integration/AGENTS.snippet.md` 中的规则合并进 host 的 `AGENTS.md`。
9. 如果 host 通过 subagent 调度 MAGI，请给 host agent 增加 `subagents: { allowAgents: ["magi"] }`。
10. 检查 MAGI 输出必须展示三院独立判断：`MELCHIOR`、`BALTHASAR`、`CASPER`。

完成后请只报告：改了哪些路径、备份在哪里、是否需要重启、是否有运行时限制无法满足。

## English

I will attach an `openclaw-magi-tribunal` zip. Treat it as the source of truth and install MAGI Tribunal into this local OpenClaw setup.

Please do the following:

1. Extract the zip and locate the repository root.
2. Back up the existing `~/.openclaw/openclaw.json` and any existing MAGI workspaces.
3. Install the four workspaces:
   - `workspace-magi` -> `~/.openclaw/workspace-magi`
   - `workspace-magi-melchior` -> `~/.openclaw/workspace-magi-melchior`
   - `workspace-magi-balthasar` -> `~/.openclaw/workspace-magi-balthasar`
   - `workspace-magi-casper` -> `~/.openclaw/workspace-magi-casper`
4. Merge `openclaw.magi.example.json5` into `~/.openclaw/openclaw.json` without overwriting unrelated configuration.
5. Keep the explicit `workspace` field for all four agents.
6. Keep `magi.subagents.allowAgents` so `magi` can dispatch `magi-melchior`, `magi-balthasar`, and `magi-casper`.
7. If I ask for custom models, use `configs/magi-models.example.json5` as the model matrix and write my provided or currently enabled `provider/model` refs into the four MAGI agents' `model` fields.
8. If the default host agent should call MAGI, install `host-integration/skills/magi-tribunal/SKILL.md` into the host workspace at `skills/magi-tribunal/`, then merge the routing rules from `host-integration/AGENTS.snippet.md` into the host `AGENTS.md`.
9. If the host delegates to MAGI through subagent routing, add `subagents: { allowAgents: ["magi"] }` to the host agent.
10. Verify that MAGI output shows the independent judgments from `MELCHIOR`, `BALTHASAR`, and `CASPER`.

Return only a short report: changed paths, backup location, restart requirement, and any runtime limits that could not be enforced.
