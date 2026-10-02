---
game_title: "Pulse Arena"
twist_one_liner: "ARENA, but charged pulses replace bullets and wall impacts eliminate enemies."
twist_category: "rule-bender"
twist_from_ideas_list: "adapted"
how_far_from_arena: "substantial"
tools: ["ChatGPT / Codex"]
models: ["TODO: exact model label from interface"]
primary_model: "TODO: exact model label"
plan: "TODO: free/student/paid-personal/api"
agent_instructions_file: no
sessions: 0
total_minutes: 0
total_prompts: 0
total_tokens_in: unavailable
total_tokens_out: unavailable
tokens_source: "unavailable: no user-visible session token totals provided in this conversation"
code_share_llm_pct: "TODO: estimate after edits"
code_share_mixed_pct: "TODO: estimate after edits"
code_share_hand_pct: "TODO: estimate after edits"
odin_experience_before: "none"
llm_coding_before: "TODO: never/occasional/weekly/daily"
gamedev_experience_before: "TODO: choose based on your actual experience"
transcripts_shared: no
---

# Postmortem - Pulse Arena

> Working draft: I still need to fill in the session totals, model details and
> my feature estimates. The gameplay results below are from my own tests.

## 1. The game

Pulse Arena is a small survival game where I have to last 60 seconds while
enemies chase me. Instead of shooting, I hold Space to charge a pulse and
release it to push enemies away. If I push them into a wall, I get a knockout.
I start with three health points, and charging slows me down.

I kept the single arena, top-down movement and enemies coming in from the
edges. I removed the bullets and changed the attack into a pulse. I also added
wall knockouts, a charge meter, a cooldown, heavy enemies and a 60-second win
condition.

The main choice is whether to release a quick pulse to make some space or
hold it longer for a stronger push. Holding it longer sounds better, but it
also makes me slower while enemies are still coming towards me. The idea is
to get better at timing the pulse and lining enemies up with the walls.
In my winning round, I survived 60 seconds and got 26 wall knockouts.

## 2. My setup

I had never used Odin and Raylib before, so I asked ChatGPT / Codex to help me
make a small game and walk me through it. I ran it on my Mac with Odin
`dev-2026-09-nightly:a2fb372`. Xcode command-line tools were already installed,
so I did not need to install them again. There was no AGENTS.md or other
project instruction file.

At first, I ran `odin check .` from my home folder and got an error saying
there were no Odin files there. Once I used `cd` to enter the actual
`pulse-arena` folder, the check passed. I then used
`odin run . -out:pulse-arena` to launch the game.

The assistant helped with the code and explanations, but I ran the game and
tested it myself. It could not play the game in its own workspace.

## 3. Feature by feature

I still need to add my actual prompt counts, time estimates and helpfulness
ratings. Several features came from the same prompt, so those counts should
not be added together as if they were separate prompts.

| Feature | Who | Prompts | First try? | Minutes | Help 1-5 | What happened |
|---|---|---|---|---|---|---|
| Window, title and game loop | llm | TODO | Yes, after entering the right folder | TODO | TODO | The game opened successfully |
| Movement | llm | TODO | Worked in my playtest | TODO | TODO | I could move around the arena |
| Enemy spawning and difficulty | mixed | TODO | Ran, but needed balancing | TODO | TODO | I changed the spawn interval twice with AI guidance |
| Health and losing | llm | TODO | Worked in my playtest | TODO | TODO | I could lose and reach the end screen |
| Charged pulse and wall knockouts | llm | TODO | Worked in my playtest | TODO | TODO | My winning round had 26 knockouts |
| Win condition | llm | TODO | Verified after balance changes | TODO | TODO | The victory screen showed 60 seconds |
| Replay and pause | llm | TODO | Reported working in my initial checks | TODO | TODO | I tested losing/replay and pausing |
| Heavy enemy | llm | TODO | Not separately documented | TODO | TODO | Orange enemies have reduced knockback |
| HUD and charge indicator | llm | TODO | Visible in the running game | TODO | TODO | Shows health, score, time and charge |

## 4. Where AI helped

AI helped me get started with a language I had not used before. It gave me
the initial game code and broke the setup into small steps, so I could check
Odin first, open the right folder and then run the game. Having those steps
made it easier to follow what I was doing.

It also helped me find the spawning line when I said the game was too hard.
I did not have to search through the whole file to guess which value to
change. I could change that one line, run it again and compare the result.

TODO: Link this to the completed session log and add my own estimate of time
saved, if I can reasonably estimate it.

## 5. Where AI did not help enough

The first version ran, but winning was really hard. There were so many
enemies that my best time was about 30 seconds. AI had written working code,
but that did not mean the difficulty felt right when I played it.

After the first spawn adjustment, I reached 57 seconds. That was much better,
but the enemies still piled up near the end. I explained that and changed the
spawn interval again. After that, I reached 60 seconds with 26 wall knockouts.
This was the part where actually playing mattered more than just checking
whether the code compiled.

## 6. The issue I found, changed and checked

The main issue I found was the enemy spawning balance. It was a problem in
the AI-generated design values, rather than a crash or a confirmed runtime
bug. I have not found a separate runtime bug, so I am not going to claim I did.

The original spawning line was:

```odin
g.spawn_timer = max(f32(0.32), f32(0.95)-g.elapsed*0.009)
```

The first adjustment was:

```odin
g.spawn_timer = max(f32(0.65), f32(1.20)-g.elapsed*0.007)
```

The final version is:

```odin
g.spawn_timer = max(f32(1.0), f32(1.5)-g.elapsed*0.005)
```

I checked the change by playing again after each adjustment. My best reported
times went from 30 seconds to 57 seconds, then to a completed 60-second round.
The victory screenshot shows 26 wall knockouts. I saved that screenshot and a
gameplay recording in `evidence/`.

This shows that the ending is reachable after the changes. It does not prove
the game is balanced for everyone. The rubric asks for an AI-introduced bug,
so I still need to check whether this balance issue meets that requirement
or document an actual logic bug if one comes up.

## 7. The idea compared with the final game

Since I joined the lab late, this was a late-start idea rather than a pitch
I presented on the original Wednesday. The idea was to keep the arena but
replace shooting with charged pulses and wall knockouts. That is still the
main mechanic in the final game.

I kept the scope small. There are no bosses, upgrades, extra levels, music or
custom sprites. I focused on making the game run, fixing the difficulty and
getting through a complete round.

The cards suggested clearer hold/release instructions, a charge indicator and
making the heavy enemies easy to tell apart. Those were included in the initial
draft. The changes I made after actually playing were the two spawn adjustments.
I also saved a gameplay recording and victory screenshot in the evidence folder.

## 8. What I would do differently next time

Next time, I would test the difficulty earlier instead of waiting until all
the features were in place. I would start with movement and one enemy, add the
pulse, and check how that feels before increasing the enemy count.

I would still use AI for explanations and finding the part of the code I need
to change, but I would give it specific feedback from each test. Saying that
my best time was 30 seconds gave us something more useful to work with than
just saying the game was hard. I would also write down my session details as
I work and commit each playable version.

What I would want from the tools is a better way to check gameplay behavior.
In this session, the assistant could inspect code, but I still had to test
whether the game was actually manageable.

## 9. What I learned

The biggest thing I learned was that a game can work and still be too hard.
At first I was happy just to get Odin and Raylib running, but the repeated
playtests were what helped improve it. Changing one spawn formula made a
noticeable difference without needing to add more features.