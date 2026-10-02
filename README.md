# Pulse Arena

ARENA, but there are no bullets: charge a radial pulse and push enemies into
the walls. Charging halves your movement speed, so timing and positioning matter.

Solo project for CSCI 4160U Side Quest 1. Draft prepared with AI assistance;
local build and playtest verification are still required.

## Build and run

Prerequisites: Odin on PATH, its complete base/core/vendor directories, and
the platform compiler/linker prerequisites described in the official install
guide: https://odin-lang.org/docs/install/

From this folder (the one containing main.odin), run this single command:

```sh
odin run . -out:pulse-arena
```

Raylib is imported as `vendor:raylib`. Use the complete official Odin distribution.
The game has no external asset files or additional package dependencies.
API reference: https://pkg.odin-lang.org/vendor/raylib/

## Controls and objective

| Input | Action |
|---|---|
| Enter | Start / replay |
| R | Replay from an end screen |
| WASD or arrows | Move |
| Hold Space | Charge a pulse; movement becomes slower |
| Release Space | Push nearby enemies away |
| P | Pause / resume |
| Esc | Quit |

Survive 60 seconds with 3 HP. Red enemies chase you. Orange heavy enemies
appear after 15 seconds; they are slower but resist knockback. Push an enemy
into a wall to earn a knockout. Contact costs 1 HP, followed by 1 second of
damage immunity. A pulse needs 0.85 seconds to recharge; a full charge takes
1.2 seconds. A quick pulse makes space, while a charged pulse reaches farther.

## Intended depth

- Decision: flee, use a quick pulse, or commit to a charged pulse.
- Trade-off: a longer charge gives range and force but reduces escape speed.
- Mastery: line up wall impacts and group enemies without trapping yourself.

## Scope and cut line

| Priority | Feature | Status |
|---|---|---|
| 1 | Title, play, win/lose, replay | Implemented; local verification pending |
| 2 | Movement, chasing enemies, health | Implemented; local verification pending |
| 3 | Charged pulse and wall knockouts | Implemented; local verification pending |
| 4 | Heavy enemy, cooldown and charge HUD | Implemented; local verification pending |
| CUT | Bosses, upgrades, multiple arenas | Excluded |
| CUT | Sprites, music, online scores | Excluded |

## Files

- `main.odin`: entire game, with short comments.
- `ATTRIBUTION.md`: code, dependency and asset credits.
- `jam-log.csv`: original column schema; fill one real row per sitting.
- `POSTMORTEM.md`: draft; replace TODOs with your experience and evidence.
- `FEEDBACK.md`: explicitly simulated feedback with friend names.
- `WALKTHROUGH.md`: Mac setup, code explanation and submission steps.
- `TESTING.md`: manual checks and space to record actual results.
- `docs/COURSE-RUBRIC.md`: unchanged course rubric.
- `docs/POSTMORTEM-TEMPLATE.md`: unchanged original reflection template.

The intended final submission is the finished repository tagged `jam-final`,
with the log and postmortem committed before creating the tag. This draft has
not been pushed, tagged, or verified from a clean clone.
