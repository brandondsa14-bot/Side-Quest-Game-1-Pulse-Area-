# Simulated playtest feedback
 These cards are suggestions, from my own friends whom I asked to test my game in my other classes. They were
based on the design and code, I had build for my game

**## Review 1 - Muhaammad Usman**

- Works: “Pushing the enemies into the walls makes the game more fun because you have something else to focus on besides just running away.”
- Confusion: “I might hold Space thinking it attacks automatically, so it should make it more clear that you have to release it.”
- What if: “Maybe the charge indicator could also show how far the pulse is going to reach.”
- Included in the draft: title and HUD now say to hold and release Space, and a ring shows the pulse range.
- Check locally: check if the attack is easy to understand without someone having to explain how it works.

**## Review 2 - Omer**

- Works: “Charging the attack while moving slower makes it more challenging because you have to decide when it is worth charging.”
- Confusion: “I probably wouldn’t understand why the orange enemy does not move as much when I hit it compared to the red enemies.”
- What if: “Maybe make the orange enemy look more different and explain that it is harder to push back.”
- Included in the draft: orange enemies now have a white inner outline and the title explains that they have more resistance.
- Check locally: check if the orange enemies are easy to tell apart from the red enemies when there are a lot of enemies on screen.

**## Review 3 - Alex K**

- Works: “Having a short round and a replay button makes it easy to try again if you lose.”
- Confusion: “If I lose health really fast I might think that one enemy hit took away all my health.”
- What if: “Show when the player cannot take damage so you know when you are safe after getting hit.”
- Included in the draft: the player now flashes during the one-second immunity after getting hit.
- Check locally: make sure one hit only removes one HP and that the flashing makes the immunity noticeable.

**## Review 4 - Vithuran K**

- Works: “The wall knockout counter makes me want to try and knock out more enemies instead of only running around.”
- Confusion: “I might focus too much on getting knockouts and forget that the actual goal is just surviving the full 60 seconds.”
- What if: “Make the timer and survival goal more obvious before the game starts.”
- Included in the draft: the title now says survive 60 seconds and the HUD shows how much time is left.
- Check locally: try playing one round focusing only on surviving and another round trying to get as many knockouts as possible.

**## Review 5 - (my sister)&#x20;**
- Works: “The enemies are challenging to defelct while moving character around”
- What if: “Make the timer and survival objective clear before the round starts, also slow down the mob's attacking. As time goes on, they become a lot faster making it harder to achieve the 60 second survival win.”
- Included in the draft: title says survive 60 seconds; HUD shows remaining time.
- Check locally: compare a survival-focused run and an aggressive knockout-focused run.



## What I actually changed

The instructions, charge ring, heavy-enemy outline and damage feedback were
already included in the first draft. I am not treating them as changes made
after a real classmate playtest.

When I played, the biggest issue was the swarm of enemies. My best time was
30 seconds. I adjusted the spawn interval with AI guidance and reached 57
seconds, but the end was still too hard. After another adjustment, I won a
60-second round with 26 wall knockouts. That balance change came from my own
playtesting. I saved a recording and the victory screen in `evidence/`.
