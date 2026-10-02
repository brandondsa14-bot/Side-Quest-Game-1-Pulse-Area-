# Attribution

## Game code and assistance

- `main.odin` and documentation drafts were generated with ChatGPT / Codex
  in this conversation on September 27th, 2026. The student must review, understand,
  test, and revise them before submission.
- Prompt: “can you assistance me with the creation of my explode mini game. Essentialy you use WASD to move around 'red seeker's'. You have a charge up that creates a bubble around you and destroy's any seeker's in that area, but has a cool down rate of 5 seconds. I need help in creating all the necessary asset's in accordance with the guidlines attached per the lecture slide. Assist me with how to implement features so it's a cool mini game that student's can play with maximum play time of around 1-2 minutes. If you have any ideas of how to improve the game based on my 1st iteration please let me know. 

- AI assistance: game concept, implementation, documentation and simulated feedback.
  Exact model label should be recorded from the student's interface in the log.

## Dependencies

- Odin: https://odin-lang.org/ (compiler and standard/vendor libraries).
- Raylib: https://www.raylib.com/ (graphics, keyboard input, window and timing).
  The game uses Odin's `vendor:raylib` bindings. Raylib is licensed under zlib/libpng.
  Its library-provided default font is used for all text.

## Assets and course materials

- No external sprites, music, sound effects, downloaded fonts or AI-generated
  images are used. Visuals are runtime-drawn Raylib shapes.
- Original jam CSV header, postmortem template and rubric: course mini-jam
  handout supplied for CSCI 4160U at Ontario Tech University, Cristiano Politowski.
  Unmodified rubric and reflection template are retained under `docs/`.
- Simulated feedback is credited and labeled in `FEEDBACK.md`.
