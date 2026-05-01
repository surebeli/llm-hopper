# 🐰 llm-hopper

**穷鬼多LLM跳台协同开发神器**  
*在 Claude、GPT、Gemini、Kimi……之间疯狂 tab 切换，却永远不用再手动 copy-paste 任务和结果*

[![GitHub stars](https://img.shields.io/github/stars/yourusername/llm-hopper)](https://github.com/yourusername/llm-hopper)
[![License](https://img.shields.io/github/license/yourusername/llm-hopper)](LICENSE)

---

## ✨ 为什么需要 llm-hopper？

你是不是也这样：

- 每月只舍得开 **Claude 20刀 + GPT 20刀 + Gemini 99刀/年 + Kimi 便宜 coding plan**
- **Claude** 负责写 Spec、架构、开发计划、测试计划（它最强）
- 剩下脏活累活扔给 GPT / Gemini / Kimi 各自发挥（它们便宜啊！）
- 最后再拉回 **Claude** 做最终验收
- **痛苦点**：你得在十几个网页 tab 里像只兔子一样跳来跳去，疯狂 `Ctrl+C / Ctrl+V`，任务描述、代码片段、反馈结果全靠手动……

**llm-hopper 就是来解决这个痛点的**！

它把 **Git 仓库** 当作唯一中央枢纽，让所有 LLM 在同一个“营地”里半自动化接力：
- 你在任意 LLM 网页里敲一句命令 → Hopper 自动把任务/结果同步到 Git
- Claude 发号施令 → 其他模型低成本打工 → Claude 最后验收
- 人类只负责执行最简单的 “skill / command”，剩下全自动

---

## 🚀 核心特性

- **🐰 Hopper 跳跃模式**：支持 Claude / ChatGPT / Gemini / Kimi / 通义千问 等任意网页版 LLM
- **Git 中央轴**：所有 prompt、代码、评审意见、验收结果全部落在仓库里，可追溯、可分支、可 PR
- **半自动化工作流**：`@hopper` 指令 + 简单 skill 即可驱动多模型协作
- **穷鬼友好**：零 API Key 依赖，完全吃你已有的网页订阅套餐
- **Claude 总指挥**：天然支持“Claude 写计划 → 其他模型执行 → Claude 验收”闭环
- **极简上手**：5 分钟配置完成，零学习成本

---

## 📋 工作流示例（30秒看懂）

```mermaid
graph TD
    A[Claude 写 Spec + 任务拆解] --> B[Git Issue / Task]
    B --> C{Git 触发 Hopper}
    C --> D[GPT 执行前端任务]
    C --> E[Gemini 写后端逻辑]
    C --> F[Kimi 写测试用例]
    D & E & F --> G[结果自动 PR 到 Git]
    G --> H[Claude 统一验收 & 合并]
