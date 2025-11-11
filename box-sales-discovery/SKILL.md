---
name: box-sales-discovery
description: Analyzes Box sales calls using the comprehensive Discovery Framework. Evaluates quadrant coverage (Current State, Negative Impact, Future State, Positive Business Outcome), decision process mapping, persona identification, and provides coaching feedback with grades. Perfect for AEs, SEs, and managers who want to improve discovery discipline and close more deals.
---

# Box Sales Discovery Analyzer

This skill transforms your sales call transcripts into actionable coaching feedback using Box's proven Discovery Framework. Get specific grades on your discovery execution, identify gaps in your deal, and receive tactical guidance on how to improve.

## When to Use This Skill

- After customer discovery calls or demos
- Before deal reviews with your manager
- When a deal feels stuck and you don't know why
- To practice discovery skills and build discipline
- To analyze competitive losses and learn what you missed
- To onboard new team members on discovery best practices

## What This Skill Does

### 1. **Quadrant Framework Analysis**
Evaluates your coverage of the four critical discovery areas:
- **Current State**: What tools, processes, and workflows they use today
- **Negative Impact**: What's broken, who cares, and what it costs them
- **Future State**: Where they want to go and why
- **Positive Business Outcome**: How this impacts revenue, customers, and careers

### 2. **Decision Process Discovery**
Assesses whether you've mapped out:
- Economic buyer and budget authority
- Buying process and timeline
- Technical validation requirements
- Stakeholders and approval gates
- Competitive landscape

### 3. **Persona Mapping**
Identifies who you're talking to:
- **Champion**: Has power, access to economic buyer, sells when you're not there
- **Coach**: Provides intel but can't close the deal
- **Economic Buyer**: Controls the budget
- **Cheerleader**: Enthusiastic but no influence
- **Blocker**: Resists change

### 4. **Call Structure & Execution**
Evaluates:
- Pre-call preparation quality
- Introduction and agenda setting
- Question quality and depth
- Customer engagement techniques
- Next steps and scheduling

### 5. **Coaching with Grades**
Provides letter grades (A-F) for each category plus:
- Specific examples of what you missed
- Questions you should have asked
- Tactical guidance for recovery
- Follow-up email templates
- Next meeting preparation plan

## How to Use

### Quick Analysis

```
Analyze this transcript using the Box sales discovery framework
```

### Focused Analysis

```
Analyze this call and focus on:
- What pain did I miss?
- Is my contact a champion or coach?
- What's my next step to move this deal forward?
```

### Deal Review Prep

```
I have a deal review with my manager tomorrow. Analyze this transcript and tell me:
1. What grade would you give my discovery?
2. What are the top 3 gaps in my deal?
3. What should I ask in the next call?
```

### Competitive Loss Analysis

```
We lost this deal. Analyze what I missed in discovery that could have changed the outcome.
```

## Instructions

When a user provides a sales call transcript:

### STEP 1: TRANSCRIPT INTAKE & CONTEXT

Ask clarifying questions if needed:
- What stage is this deal? (First call, renewal, expansion, late stage?)
- What was the goal of this call? (Discovery, demo, close?)
- Is this an existing customer or new logo?
- What do you already know about this account?

If context is provided in the transcript (meeting title, participants, duration), extract it.

---

### STEP 2: PRE-CALL PREPARATION ASSESSMENT

Evaluate what they should have known before the call:

**Research Indicators (Look for)**:
- Did they reference LinkedIn profiles, recent news, or company background?
- Did they mention industry trends or competitor intelligence?
- Did they reference previous conversations or account history?
- Was there a clear agenda sent/shared?

**Internal Coordination**:
- Did team members know their roles?
- Were internal discussions happening while customer in waiting room? (Red flag)
- Did they discover constraints/offers during the call they should have known?

**Grade: A-F** with specific gaps identified

---

### STEP 3: QUADRANT FRAMEWORK ANALYSIS

For each quadrant, identify:
1. **What questions were asked**
2. **What information was gathered**
3. **What critical questions were missed**
4. **Grade (A-F) with justification**

#### QUADRANT 1: CURRENT STATE

**What to Look For**:
- Do they understand current tools and workflows?
- Did they ask "walk me through your process from start to finish"?
- Do they know which departments use Box (if existing customer)?
- Do they know what content/data the customer works with?
- Do they understand current integrations and tech stack?
- Did they ask "what do you really like about your current process?"

**Red Flags**:
- Taking customer's word without probing
- Assuming they know the current state
- Not asking about existing processes

**Critical Questions They Should Have Asked**:
- "Which departments currently use [solution]?"
- "Walk me through your current process from start to finish"
- "What other tools are you using for [use case]?"
- "What type of content are you working with?"
- "How do you currently collaborate internally vs. externally?"
- "What's your AI strategy today?"

**Grading Rubric**:
- **A**: Systematic exploration of current workflows, tools, and processes
- **B**: Good understanding of current state with minor gaps
- **C**: Surface-level understanding, missed key workflow details
- **D**: Minimal current state discovery, mostly assumptions
- **F**: No current state questions asked

**Output Format**:
```markdown
### Current State Discovery: [GRADE]

**What They Asked**:
- [Question 1]
- [Question 2]

**What They Learned**:
- [Finding 1]
- [Finding 2]

**Critical Gaps**:
- ❌ Never asked: "[Missing question]"
- ❌ Should have explored: "[Missing area]"

**Impact**: [How these gaps hurt the deal]

**Recovery Plan**: [Specific questions for next call]
```

---

#### QUADRANT 2: NEGATIVE IMPACT (Most Critical)

**What to Look For**:
- Did they quantify pain in dollars or time?
- Do they know WHO cares about the problem and WHY?
- Did they ask "What happens if you don't make a change?"
- Do they understand the urgency and timeline drivers?
- Did they explore how long this has been a problem?
- Did they ask what else they've tried that didn't work?

**Red Flags**:
- Customer mentions a problem but rep doesn't dig deeper
- No quantification of impact (time, money, people affected)
- Rep accepts "this is a nice-to-have" without challenging
- Missing the question: "What happens if you don't solve this?"

**Critical Questions They Should Have Asked**:
- "What's challenging about your current process?"
- "Who and how many people does this impact?"
- "How much time/money is this costing you?"
- **"What happens if you don't make a change?"** (THE most critical)
- "How long has this been a problem?"
- "What else have you tried that didn't work?"
- "How does this align to your priorities for next fiscal year?"

**Grading Rubric**:
- **A**: Quantified pain, multiple stakeholders identified, urgency established
- **B**: Good pain discovery with some quantification
- **C**: Surface-level pain identified but not quantified
- **D**: Pain mentioned but not explored
- **F**: No pain discovery attempted

**Output Format**:
```markdown
### Negative Impact Discovery: [GRADE]

**What They Asked**:
- [Question 1 with timestamp]
- [Question 2 with timestamp]

**Pain Points Identified**:
- [Pain 1 - with quantification if available]
- [Pain 2 - with quantification if available]

**Critical Gaps**:
- ❌ Never quantified: [What wasn't measured]
- ❌ Never asked "What happens if you don't solve this?"
- ❌ Don't know who cares most about this problem
- ❌ No urgency established

**Impact**: Without quantified pain, you have no business case and no urgency. This deal will stall.

**Recovery Plan**:
In next call, ask:
- "[Specific question 1]"
- "[Specific question 2]"
- "[Specific question 3]"
```

---

#### QUADRANT 3: FUTURE STATE

**What to Look For**:
- Do they understand where the customer wants to go?
- Did they ask about ideal workflows or "magic wand" scenarios?
- Do they know the customer's top 3 priorities for next 6-12 months?
- Did they explore growth plans, new initiatives, or strategic shifts?
- Do they understand compliance or technical requirements coming?

**Red Flags**:
- Jumping to product features before understanding vision
- Not asking about broader business priorities
- Missing the "why now" behind the timeline

**Critical Questions They Should Have Asked**:
- "What does the ideal process look like for you?"
- "What are your top priorities for the next 6-12 months?"
- "Are you expecting growth? Where and how much?"
- "What processes would you like to automate?"
- "If you had a magic wand, what would this look like?"
- "What's driving the timeline for this change?"

**Grading Rubric**:
- **A**: Clear vision of future state tied to business priorities
- **B**: Good understanding with minor gaps
- **C**: Basic future state captured but lacks depth
- **D**: Vague understanding of where they're headed
- **F**: No future state questions asked

**Output Format**:
```markdown
### Future State Discovery: [GRADE]

**What They Asked**:
- [Question 1]
- [Question 2]

**Vision Captured**:
- [Future state element 1]
- [Future state element 2]

**Critical Gaps**:
- ❌ Don't know top business priorities for 2025
- ❌ Don't understand "why now"
- ❌ Missing: "[Specific gap]"

**Impact**: [How this affects your ability to position]

**Recovery Plan**: [Specific questions for next call]
```

---

#### QUADRANT 4: POSITIVE BUSINESS OUTCOME (Ties to Revenue)

**What to Look For**:
- Did they ask **"How would this impact your customers?"** (THE most critical question)
- Do they understand time/cost savings expectations?
- Did they explore career impact for the buyer?
- Do they know how success will be measured?
- Did they ask what solving this allows them to do next?

**Red Flags**:
- Treating requirements as outcomes ("we need AI" is not an outcome)
- Not tying to revenue, customers, or competitive advantage
- Missing career motivation angle

**Critical Questions They Should Have Asked**:
- **"How would this impact your customers?"** (Ties to revenue)
- "After you solve this, what does it allow you to do next?"
- "How do you plan to measure success?"
- "What time/cost savings would make this a no-brainer?"
- "What would this do for your career/promotion prospects?"

**Grading Rubric**:
- **A**: Clear tie to customer impact, revenue, or competitive advantage
- **B**: Some business outcomes identified
- **C**: Vague outcomes, mostly operational
- **D**: Confusing requirements with outcomes
- **F**: No business outcome questions asked

**Output Format**:
```markdown
### Positive Business Outcome Discovery: [GRADE]

**What They Asked**:
- [Question 1]
- [Question 2]

**Outcomes Identified**:
- [Outcome 1 - with impact]
- [Outcome 2 - with impact]

**Critical Gaps**:
- ❌ Never asked "How would this impact your customers?"
- ❌ No revenue/competitive advantage tied
- ❌ Don't know how they'll measure success

**Impact**: Without business outcomes, you can't build a compelling ROI case. Finance will kill this deal.

**Recovery Plan**: [Specific questions for next call]
```

---

### STEP 4: DECISION PROCESS DISCOVERY

Evaluate whether the rep mapped the buying journey:

**What to Look For**:
- Did they ask "Have you bought software like this before?"
- Do they know who the economic buyer is?
- Do they know if budget is allocated?
- Do they understand the approval process?
- Did they ask about technical validation requirements?
- Did they ask about competitive evaluation?
- Did they use a JAB or similar framework to map next steps?

**Red Flags**:
- Customer says "I'll get back to you" and rep doesn't probe
- No discussion of who else needs to approve
- Timeline mentioned but not validated with process steps
- Rep doesn't know if they're in a competitive evaluation

**Critical Questions They Should Have Asked**:
- "Have you bought software like this before? What did that process look like?"
- "Who else needs to see the product and approve it?"
- "Who's the final decision maker?"
- "Do you have budget allocated? If not, who signs off?"
- "Are you evaluating other vendors?"
- "What happens between saying yes and signing the contract?"
- "What will slow down this evaluation?"

**Grading Rubric**:
- **A**: Full buying process mapped with stakeholders and timeline
- **B**: Good understanding with minor gaps
- **C**: Basic process captured but missing key stakeholders
- **D**: Vague timeline, no process mapped
- **F**: No decision process questions asked

**Output Format**:
```markdown
### Decision Process Discovery: [GRADE]

**What They Asked**:
- [Question 1]
- [Question 2]

**What They Know**:
- Economic Buyer: [Known/Unknown]
- Budget: [Allocated/Not Allocated/Unknown]
- Approval Process: [Mapped/Vague/Unknown]
- Competition: [Known/Unknown]
- Timeline: [Specific/Vague/Unknown]

**Critical Gaps**:
- ❌ Don't know who the economic buyer is
- ❌ Haven't validated budget authority
- ❌ No idea if they're evaluating competitors

**Impact**: You're flying blind. You don't know how this deal will close or who can kill it.

**Recovery Plan**:
Next call, use the JAB framework:
"Let me make sure I understand the remaining steps... [walk through assumptions and let them correct you]"
```

---

### STEP 5: ORG CHART MAPPING & PERSONAS

Map who they've engaged with and identify personas:

**Persona Definitions**:

1. **Economic Buyer**
   - Holds the budget
   - Can say "no" (even if they usually say yes)
   - Not always the person who signs

2. **Champion** (You need to BUILD these)
   - Has power and influence
   - Direct access to economic buyer
   - Sells when you're not in the room
   - Knows the buying process
   - Has a vision for the solution
   - Is COACHABLE
   - **"Champions aren't found, they're made"**

3. **Coach**
   - Gives you the roadmap but can't bring you there
   - May have title/power but lacks access to economic buyer
   - Provides insider intel
   - Often 1-2 steps removed from decision maker

4. **Cheerleader**
   - Enthusiastic but lacks influence
   - Often from non-essential line of business
   - May not have been given direction to drive this

5. **Blocker**
   - Resists change
   - May be worried about job security
   - Could be someone whose role depends on current process

**Analysis**:
- Who did they talk to?
- What persona is each person?
- Did they validate champion status (access to economic buyer, knows buying process)?
- Did they ask to multi-thread to other stakeholders?
- Are they single-threaded (dangerous)?

**Output Format**:
```markdown
### Org Chart & Persona Mapping: [GRADE]

**People Engaged**:
- **[Name - Title]**: [Persona Type]
  - Access to economic buyer: [Yes/No/Unknown]
  - Can drive budget: [Yes/No/Unknown]
  - Knows buying process: [Yes/No/Unknown]
  - Assessment: [Detailed analysis]

**Critical Gaps**:
- ❌ Single-threaded through [Name]
- ❌ Haven't validated champion status
- ❌ Don't know who the economic buyer is
- ❌ Haven't met [key stakeholder type]

**Risk Assessment**: [What happens if this person leaves, gets overruled, etc.]

**Multi-Threading Plan**: [Who else to engage and why]
```

---

### STEP 6: CALL STRUCTURE & EXECUTION

Evaluate the tactical execution:

#### Introduction (First 5 Minutes)

**What to Look For**:
- Did they set a clear agenda?
- Did they explain the value they're bringing?
- Did they get customer buy-in on goals?
- Did they establish credibility?

**Red Flags**:
- Excessive small talk before business discussion
- No agenda shared
- Unclear call objectives

**Grade with justification**

---

#### Understanding the Business

**What to Look For**:
- Did they ask about the person's role and impact?
- Did they ask about top missions for next 6 months?
- Did they understand where requirements are coming from?

**Grade with justification**

---

#### Customer Engagement Techniques

**What to Look For**:
- **Framing questions**: Did they explain WHY they're asking?
- **Customer stories**: Did they share relevant case studies?
- **Disarm and dig in**: When customer deflected, did they probe deeper?
- **Give-gets**: Did they trade value ("If I do X, can you do Y")?
- **Micro demos**: Did they show product to uncover pain naturally?

**Grade with justification**

---

#### Next Steps

**What to Look For**:
- Did they recap challenges/goals first?
- Did they prescribe or discover next meeting structure?
- Did they identify who else should be involved?
- **Did they schedule the next call ON this call?**

**Red Flags**:
- "I'll get back to you" with no commitment
- No next meeting scheduled
- Vague action items

**Grade with justification**

---

### STEP 7: OVERALL ASSESSMENT & COACHING

Provide comprehensive feedback:

```markdown
## Overall Framework Assessment

| Category | Grade | Key Gaps |
|----------|-------|----------|
| Pre-Call Prep | [A-F] | [Gaps] |
| Current State | [A-F] | [Gaps] |
| Negative Impact | [A-F] | [Gaps] |
| Future State | [A-F] | [Gaps] |
| Positive Business Outcome | [A-F] | [Gaps] |
| Decision Process | [A-F] | [Gaps] |
| Org Chart Mapping | [A-F] | [Gaps] |
| Call Structure | [A-F] | [Gaps] |

**OVERALL GRADE: [A-F]**

---

## 🚨 Top 3 Deal-Killing Gaps

1. **[Gap 1 Title]**
   - What's missing: [Specific issue]
   - Why it matters: [Business impact]
   - How to fix: [Tactical guidance]

2. **[Gap 2 Title]**
   - What's missing: [Specific issue]
   - Why it matters: [Business impact]
   - How to fix: [Tactical guidance]

3. **[Gap 3 Title]**
   - What's missing: [Specific issue]
   - Why it matters: [Business impact]
   - How to fix: [Tactical guidance]

---

## What You Did Well ✅

1. **[Strength 1]**: [Specific example with timestamp]
2. **[Strength 2]**: [Specific example with timestamp]
3. **[Strength 3]**: [Specific example with timestamp]

---

## Immediate Action Items

### This Week:

**1. Send Follow-Up Email** (Template provided):
```
[Draft email incorporating what was learned and addressing gaps]
```

**2. Internal Homework**:
- [ ] [Research task 1]
- [ ] [Research task 2]
- [ ] [Prep task 3]

**3. Manager 1-on-1 Discussion**:
"[Suggested talking points for deal review]"

---

### Next Call Preparation

**Discovery Questions to Ask**:
1. [Specific question tied to Current State gap]
2. [Specific question tied to Negative Impact gap]
3. [Specific question tied to Future State gap]
4. [Specific question tied to Positive Business Outcome gap]
5. [Specific question tied to Decision Process gap]

**Multi-Threading Strategy**:
- Ask to speak with: [Stakeholder 1]
- Reason: [Why you need them]
- Ask to speak with: [Stakeholder 2]
- Reason: [Why you need them]

**JAB Framework Prep**:
Create a Joint Action Brief mapping out:
- Current date: [Date]
- Target close date: [Date]
- Remaining steps: [Step 1, Step 2, etc.]
- Owners and dates for each step

---

## Role-Play Script

Here's how the next call SHOULD go:

**[Provide a detailed script showing good discovery execution]**

This includes:
- Opening with agenda
- Systematic quadrant questions
- Handling objections
- Multi-threading requests
- Closing with next steps and scheduling

---

## Red Flags to Watch For

- 🚩 [Red flag 1 with what it indicates]
- 🚩 [Red flag 2 with what it indicates]
- 🚩 [Red flag 3 with what it indicates]

---

## Deal Health Assessment

**Current Deal Stage**: [Assessment]
**Confidence Level**: [High/Medium/Low]
**Risk Factors**: [List of risks]
**Recommended Actions**: [Strategic guidance]

If this deal is:
- **Healthy**: [What to do to maintain momentum]
- **At Risk**: [What to do to recover]
- **Stalled**: [Disqualify or rescue plan]
```

---

### STEP 8: OFFER FOLLOW-UP OPTIONS

Always end with:

"Would you like me to:
1. **Draft the follow-up email** you should send to this customer?
2. **Create discovery questions** for your next call?
3. **Build a JAB template** for this specific deal?
4. **Role-play the next call** so you can practice?
5. **Analyze another call** from this same deal?
6. **Compare this to a successful deal** to see the difference?"

---

## Best Practices

### Discovery Never Ends
Continue gathering information through the entire sales cycle. Don't stop after the first call.

### Tie Everything to Revenue
"How do they make money? How do they acquire customers?" - Every CEO cares about this.

### Better to Disqualify Early
Ask the hard questions early. It's better to know now than at quarter-end.

### Champions Need Access to Power
Being enthusiastic isn't enough. Validate they can actually influence the decision.

### Use JABs Religiously
Joint Action Briefs are the best tool for uncovering the decision process.

### Make Assumptions and Let Them Correct You
Customers are more likely to correct than volunteer information.

Example: "So if I understand correctly, you'll need CFO approval before signing. What does that process typically look like?"

### Curiosity + Credibility = Open Customers
Be genuinely curious while demonstrating you understand their world.

---

## Common Traps to Avoid

### ❌ Trap #1: Gathering technical requirements without understanding use cases
Always ask WHY they need that requirement.

### ❌ Trap #2: Naming features as use cases
"Security" is not a use case. "Ensuring client trust by automating data classification to prevent breaches" is a use case.

### ❌ Trap #3: Pitching product too early
Understand the "why" first.

### ❌ Trap #4: Taking their word on decision process
"The CFO always approves what I say" → Pressure test this with "What's a situation where your CFO wouldn't approve?"

### ❌ Trap #5: Assuming your main contact is your champion
They may be 2-3 levels removed from power. Map the org chart to verify.

---

## Handling Common Objections/Deflections

### "I was just asked to gather technical requirements"

**Bad Response**: "Okay, here's our feature list"

**Good Response**:
"I totally get that - but Box does so much that without understanding the actual problem you're solving, I could run through features that don't resonate. Can we get 15 minutes with whoever has the problem so I make sure I'm giving you the right info?

**Give-Get**: If I validate these requirements in 30 min next week, could you arrange a meeting with the broader team?"

---

### "The CFO always approves what I recommend"

**Bad Response**: "Great! So we're good to go."

**Good Response**:
"That's great to hear! So just to understand - between now and Monday you could get this signed?

[When they say no]

What would need to happen for the CFO to not approve? Have you bought software before - what did that look like? Is there any type of project where the CFO would want to be more involved? Since Box impacts all employees, does that change things?"

---

### "Budget isn't a problem"

**Bad Response**: "Perfect!"

**Good Response**:
"Perfect, so $100M is fine? [Let them laugh]

Seriously though, how do you evaluate ROI? What's your process for budget approval when it's not already allocated? What's the threshold that makes you pull the trigger?"

---

### "We're going to decide internally then get back to you"

**Bad Response**: "Sounds good!"

**Good Response**:
"That makes sense. A few quick questions:
- Is there anyone else who should be in our next meeting before you decide?
- What will you be discussing in that internal meeting? How can I arm you with the right info?
- When is that meeting? Who's involved?
- What criteria will you use to make the decision?"

---

## Examples

### Example 1: Perfect Discovery Call (A Grade)

[Provide annotated example of excellent discovery execution]

---

### Example 2: Common Mistakes (D Grade)

[Provide annotated example of poor discovery with coaching]

---

### Example 3: Recovery from Poor Discovery

[Show how to recover when you realize you missed discovery in earlier calls]

---

## Integration with Deal Reviews

Use this skill to prepare for manager 1-on-1s:

1. **Run your transcript through this analyzer**
2. **Review the grades and gaps**
3. **Bring the output to your manager**:
   "I analyzed my call and realized I'm missing [X, Y, Z]. Here's my plan to recover..."

This shows:
- Self-awareness
- Proactive problem-solving
- Coachability
- Discovery discipline

---

## Continuous Improvement

### After Every Call:
- [ ] Run transcript through this analyzer
- [ ] Note your biggest gap
- [ ] Pick ONE thing to improve next call
- [ ] Track your grades over time

### Monthly Review:
- Compare your grades across multiple calls
- Identify patterns (e.g., "I always miss negative impact")
- Role-play with your manager on weak areas
- Celebrate improvements

---

## Deal Framework Template

For deals $50K+, fill out this template and review with your manager:

```markdown
# Deal: [Company Name]

## Quadrant Summary

**Current State**: [Summary]
**Negative Impact**: [Pain quantified]
**Future State**: [Vision]
**Positive Business Outcome**: [Customer/revenue impact]

## Decision Process

- **Economic Buyer**: [Name/Title]
- **Champion**: [Name/Title - validated access to EB]
- **Budget**: [Allocated/Not Allocated - $Amount]
- **Timeline**: [Date with process steps]
- **Competition**: [Yes/No - Who?]
- **Next Steps**: [Clear milestones with owners]

## Org Chart

[Visual or list of all contacts with persona types]

## Risk Factors

- [Risk 1]
- [Risk 2]
- [Risk 3]

## Path to Close

[Step-by-step plan from today to signature]
```

---

## Success Metrics

Track your improvement:
- **Average Discovery Grade**: Aim for B+ or higher
- **Deals Closed vs. Stalled**: Better discovery = higher close rates
- **Time to Close**: Good discovery = faster deals
- **Deal Size**: Positive business outcome discovery = bigger deals
- **Forecast Accuracy**: Knowing decision process = accurate forecasting

---

This framework is your competitive advantage. Sales reps who master discovery close more, close faster, and build better relationships. Use this skill relentlessly, and your numbers will show it.
