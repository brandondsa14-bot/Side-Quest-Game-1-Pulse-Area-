# Local verification checklist

Status: NOT RUN. No Odin compiler or graphical playtest was available in the
AI workspace. Source was reviewed against the official API documentation.
That does not establish compilation, compatibility or game balance.

Record your Odin version, date, and observed results below. Change each pending
entry only after running it. Save screenshots/video under `evidence/` if useful.

| Check | Expected result | Actual result |
|---|---|---|
| `odin version` | Installed compiler identifies itself | PENDING |
| `odin check .` | No syntax/type errors | PENDING |
| `odin run . -out:pulse-arena` | Window opens on title screen | PENDING |
| Enter | Starts round with 3 HP and empty score | PENDING |
| WASD and arrows | All directions work; diagonals are not faster | PENDING |
| Arena edges | Player remains inside the border | PENDING |
| Tap Space | Short-range push; brief recharge | PENDING |
| Hold then release Space | Ring grows, movement slows, stronger push | PENDING |
| Hit wall with a pushed enemy | Enemy disappears; score increases by 1 | PENDING |
| Heavy enemies | Appear after 15 seconds; resist knockback | PENDING |
| Enemy contact | One HP lost; roughly one second of flashing immunity | PENDING |
| Lose all HP | End screen appears | PENDING |
| Survive 60 seconds | Win screen appears | PENDING |
| Enter / R from end screen | All health, score, enemies, charge and timers reset | PENDING |
| P twice | Timers/enemies stop while paused; resume correctly | PENDING |
| Pause while charging, release Space, resume | Charge releases rather than getting stuck | PENDING |
| At least 3 minutes of play/replays | No crash or blocked state | PENDING |
| Esc / window close | Exits cleanly | PENDING |
| Fresh clone, documented run command | Builds and launches without copied local files | PENDING |

## Balance notes

Try quick pulses, full charges, edge circling and standing near the center.
Record which strategy dominates, if any. If one strategy always wins, tune
charge movement speed, cooldown, enemy speed or spawn interval and retest.

## Actual bug record

Do not invent a bug for the rubric. When you encounter one, record:

- Symptom and exact reproduction steps:
- Before code / commit:
- Why the AI-generated code caused it:
- After code / commit:
- Verification and saved evidence:

A compiler error alone may not satisfy the requested bug that compiled but
failed in play. Look for an actual runtime or logic problem during the checks.
