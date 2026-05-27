# AI Skill & Agent Repo Analysis Patterns

Use these patterns to identify and analyze repositories focused on AI skills, agents, prompts, and LLM orchestration.

## Key Identifiers
- **Prompt Files**: `.txt`, `.md`, `.json`, `.yaml` files containing natural language instructions (look for "system", "instruction", "prompt").
- **Tool Definitions**: JSON/YAML schemas for API calls, function calling, or MCP server configurations.
- **Workflow Engines**: Files defining state machines, graphs (e.g., LangGraph), or sequential chains.
- **Agent Definitions**: `AGENTS.md`, `SKILLS.md`, or specific folders like `agents/`, `skills/`.

## Analysis Checklist

### 1. Core Intent & Persona
- Find the main System Prompt. What is the agent's specific role?
- How is the personality or "tone" defined?

### 2. Tooling & Capabilities
- What external tools are exposed to the LLM?
- How are these tools authenticated and invoked?
- Look for `tool_definition`, `get_tools`, or `function` keywords.

### 3. Orchestration Logic
- Is it a single-agent or multi-agent system?
- How is state managed between turns?
- Look for logic handling "router", "planner", or "executor" roles.

### 4. Knowledge Base (RAG)
- Does it use a vector DB or local file search?
- How are documents indexed or retrieved?

### 5. Evaluation & Testing
- Are there "evals" or test cases for the prompts?
- Look for `evals/` or `test_prompts/` folders.

## Specific Examples: gstack
- **Prompt Engineering**: Analyze how it uses "Stack" metaphors for orchestration.
- **Tool Chaining**: How tools are passed through the "stack".
