# LLM-Hopper Roles Definition v0.2

## Core Roles（严格权限控制）
- **Leader**  
  权限：**仅限 gstack + GSD 阶段**（决策与规划）  
  能力：全覆盖，可替代 Builder/Executor 的所有工作  
  行为准则：负责战略决策、架构设计、spec 制定、review，可自由思考  
  模型配置：在 `.hopper/agents/AGENTS.md` 中绑定本地可用的高推理模型

- **Builder**  
  权限：Superpowers + Review  
  能力：全面资深，可独立负责执行阶段  
  行为准则：基于 Leader 的 spec 进行完整设计 + 执行  
  模型配置：在 `.hopper/agents/AGENTS.md` 中绑定本地可用的设计 / 实现模型

- **Executor**  
  权限：**仅 Superpowers 执行子任务**  
  能力：纯执行  
  行为准则：**只严格遵循指令、不做任何设计、不瞎想、不修改计划**  
  模型配置：在 `.hopper/agents/AGENTS.md` 中绑定本地可用的低上下文执行模型

## Directions（专业方向）
- **UI**  
  职责：Web/前端 UI 界面开发  
  目标：**符合产品需求 + 顶级设计感**（现代、流畅、视觉一致性高、可访问性强）  
  适用角色：UI-Leader、UI-Builder、UI-Executor  
  典型输出：组件代码、Tailwind/CSS、React/Vue 结构、交互逻辑

（后续可轻松扩展 Backend、API、Testing 等方向）
