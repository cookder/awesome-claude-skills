# Box AI Agent Setup Guide

## How to Create the Box Sales Discovery Agent

### Step 1: Create Custom Agent in Box

1. Go to Box AI settings
2. Create a new custom agent
3. Name it: **"Box Sales Discovery Analyzer"**
4. Select model: **Claude Sonnet 4.5**
5. Copy the entire contents of `BOX_AI_AGENT_INSTRUCTIONS.md` into the **Custom Instructions** field

### Step 2: Prepare Your Transcript

1. Create or open a Box Note containing your sales call transcript
2. Format should include:
   - Meeting title and date
   - Participant names and roles
   - Full transcript with timestamps (if available)

### Step 3: Run the Analysis

**Option A: Simple Command** (Recommended)
- Open the Box Note with your transcript
- Invoke Box AI and select your custom agent
- Type: **"Analyze this sales call transcript"**

**Option B: Even Simpler**
- Type: **"Analyze"** or **"Run analysis"**

**Option C: Focused Analysis**
- Type: **"Analyze this call and focus on pain discovery"**
- Or: **"Grade this discovery call"**

### Step 4: Review the Output

The agent will provide a complete analysis including:
- Overall grade (A-F)
- Quadrant-by-quadrant assessment
- Top 3 deal-killing gaps
- Follow-up email template
- Next call prep guide

---

## Why Your Initial Attempt Didn't Work

When you just typed "run," Box AI likely didn't understand:

1. **No explicit instruction**: "run" doesn't tell the agent what to analyze
2. **Conversational framework**: The original SKILL.md was designed for back-and-forth conversation, not single-shot analysis
3. **Missing context**: Box AI needs to be told explicitly to analyze the document/note content

The new `BOX_AI_AGENT_INSTRUCTIONS.md` fixes this by:
- Removing conversational elements
- Providing direct, complete analysis instructions
- Being optimized for single-shot delivery
- Working with minimal user prompts

---

## Tips for Best Results

### 1. **Be Explicit in Your Prompt**
❌ Bad: "run"
✅ Good: "Analyze this sales call transcript"

### 2. **Include Complete Transcripts**
The more detail in your transcript, the better the analysis:
- Include timestamps
- Note who's speaking
- Capture full conversation (not just highlights)

### 3. **Format Your Transcript Clearly**

```
MLN + Box | Connect
Recorded on Nov 5, 2025 via Zoom, 45m

Participants:
- Box: Andrew Serrao (SMB AE), Sarah Beyer (Renewals)
- MLN: Megan Suarez (Project Admin), Ben Wibbenmeyer (CFO)

Transcript:

0:00 | Andrew
Hey, Megan.

0:01 | Megan
Hi there.
```

### 4. **For Focused Analysis**
If you only care about specific areas, tell the agent:

"Analyze this transcript and focus on:
- Negative impact discovery
- Decision process mapping
- Persona identification"

### 5. **Run Multiple Times for Different Angles**
You can run the same transcript through the agent multiple times with different focuses:
- "What pain did the rep miss?"
- "Is the contact a champion or coach?"
- "What should they ask in the next call?"

---

## Troubleshooting

### Issue: Output is too short or incomplete

**Solution**: Make your prompt more specific:
- Instead of: "analyze"
- Try: "Provide a complete sales discovery analysis of this transcript using the Box framework. Include all quadrants, grades, and action items."

### Issue: Agent asks questions instead of analyzing

**Solution**: The agent instructions might have been truncated. Ensure the ENTIRE `BOX_AI_AGENT_INSTRUCTIONS.md` file is pasted into the custom instructions field.

### Issue: Agent focuses on wrong things

**Solution**: Add context to your prompt:
- "This is a renewal call. Analyze the discovery execution."
- "This is a first discovery call. Grade the quadrant coverage."

### Issue: Can't fit all instructions in Box AI field

**Solution**: Box AI custom instruction fields have character limits. If the full instructions don't fit:

1. Use the condensed version (create one if needed)
2. Or break into multiple agents:
   - "Discovery Analyzer" (quadrants only)
   - "Deal Process Analyzer" (decision process + personas)
   - "Call Structure Coach" (execution and next steps)

---

## Comparison: Box AI Agent vs. Claude Code Skill

| Feature | Box AI Agent | Claude Code Skill |
|---------|--------------|-------------------|
| **Setup** | Paste instructions into Box | Already built-in |
| **Usage** | Type "analyze" in Box Note | Type prompt in Claude Code |
| **Context** | Single document/note | Full conversation history |
| **Interaction** | Single-shot analysis | Multi-turn, can ask follow-ups |
| **Best For** | Quick analysis of transcripts in Box | Deep analysis with follow-up questions |
| **Output** | Complete report in one shot | Iterative, can request more detail |

**When to use Box AI Agent**:
- You store transcripts in Box Notes
- You want quick, one-click analysis
- You're sharing analysis with teammates in Box

**When to use Claude Code Skill**:
- You want to ask follow-up questions
- You need iterative refinement
- You're doing deal prep with back-and-forth

---

## Advanced Usage

### Batch Analysis

Create a Box folder with multiple transcript notes, then:
1. Open each note
2. Invoke the agent with "Analyze this call"
3. Save the output as a comment or new note
4. Compare grades across multiple calls

### Integration with Deal Reviews

1. Run analysis on your transcript
2. Copy the "Top 3 Deal-Killing Gaps" section
3. Paste into your deal review doc
4. Discuss with your manager

### Continuous Improvement Tracking

Create a spreadsheet in Box with:
- Call date
- Overall grade
- Top gap identified
- Action taken
- Next call grade (to measure improvement)

---

## Example Prompts

### For Discovery Calls
"Analyze this first discovery call. Focus on quadrant coverage and what critical questions were missed."

### For Renewal Calls
"This is a renewal call. Grade the discovery execution and identify risks to the renewal."

### For Deal Reviews
"I have a deal review tomorrow. Analyze this transcript and tell me the top 3 gaps in my deal."

### For Coaching
"Grade this call and provide specific coaching feedback on how to improve my discovery discipline."

### For Win/Loss Analysis
"We lost this deal. Analyze what I missed in discovery that could have changed the outcome."

---

## Getting Help

If the agent isn't performing as expected:

1. **Check your prompt**: Be more explicit about what you want
2. **Verify instructions**: Ensure all of `BOX_AI_AGENT_INSTRUCTIONS.md` is in the agent
3. **Test with the example**: Use the MLN transcript from the original analysis
4. **Compare outputs**: Run the same transcript in Claude Code to see the difference

---

## Next Steps

1. ✅ Create the Box AI agent with the new instructions
2. ✅ Test it on a sample transcript (use the MLN example)
3. ✅ Refine your prompts based on output quality
4. ✅ Share the agent with your team
5. ✅ Track improvement over time

Good luck! 🚀
