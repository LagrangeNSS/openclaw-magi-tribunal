# Update Existing MAGI Install

## 中文

请只更新我当前 OpenClaw 安装中的 MAGI 子系统，不要改动与 MAGI 无关的主人设、技能或渠道配置，除非存在直接冲突。

我会附上一个 zip。请把 zip 里的文件作为唯一来源，直接在本机完成升级。

目标：

- 把旧版 MAGI 升级为四 agent 结构：
  - `magi`
  - `magi-melchior`
  - `magi-balthasar`
  - `magi-casper`
- 保持三院独立 workspace、独立配置、独立 memory 边界
- 最终输出必须展示三院各自独立判断
- 不要伪造 chamber 独立性

执行要求：

1. 先备份现有 MAGI 相关配置和 workspace
2. 复制新的四个 workspace 到标准 OpenClaw 路径
3. 合并 `openclaw.magi.example.json5`，不要整份覆盖 `openclaw.json`
4. 保留四个 agent 的显式 `workspace` 字段，避免多 agent 共用默认 workspace
5. 保留 `magi.subagents.allowAgents`，允许 `magi` 调度三个 chamber agent
6. 如果 host agent 需要调用 MAGI，把 `host-integration/skills/magi-tribunal/SKILL.md` 放入 host workspace，并按 `host-integration/AGENTS.snippet.md` 更新路由规则
7. 如果 host 通过 subagent 调度 MAGI，请给 host agent 增加 `subagents: { allowAgents: ["magi"] }`
8. 保留现有 channels、bindings、providers、auth 和无关用户设置
9. 如果运行时支持 fresh session / reset / forget / cleanup，为 MAGI 三院启用裁决后清理
10. 完成后只给简洁报告：
   - 修改了哪些路径
   - 备份在哪
   - 是否重启
   - 哪些步骤完成
   - 哪些因运行时限制无法做到

## English

Update only the MAGI subsystem in my current OpenClaw install. Do not modify unrelated host persona files, skills, or channel configuration unless there is a direct conflict.

I will attach a zip. Treat the zip contents as the source of truth and perform the upgrade locally.

Goals:

- upgrade MAGI to a four-agent layout:
  - `magi`
  - `magi-melchior`
  - `magi-balthasar`
  - `magi-casper`
- preserve isolated workspaces, configs, and memory boundaries
- ensure the final output shows each chamber's independent judgment
- do not fake chamber independence

Requirements:

1. Back up the current MAGI-related config and workspaces first
2. Copy the four new workspaces into their standard OpenClaw locations
3. Merge `openclaw.magi.example.json5` instead of overwriting `openclaw.json`
4. Keep the explicit `workspace` field for all four agents so they do not inherit one shared default workspace
5. Keep `magi.subagents.allowAgents` so `magi` can dispatch the three chamber agents
6. If the host agent should call MAGI, copy `host-integration/skills/magi-tribunal/SKILL.md` into the host workspace and update routing according to `host-integration/AGENTS.snippet.md`
7. If the host delegates to MAGI through subagent routing, add `subagents: { allowAgents: ["magi"] }` to the host agent
8. Preserve existing channels, bindings, providers, auth, and unrelated user settings
9. If the runtime supports fresh session, reset, forget, or cleanup, enable post-tribunal cleanup for the chambers
10. Return a short report only:
   - which paths were changed
   - where backups were written
   - whether a restart was needed
   - which steps completed
   - which steps were blocked by runtime limits
