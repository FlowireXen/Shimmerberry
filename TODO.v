# TODO's:

> List of Known Bugs:
- [MAJOR][Won't Fix]: "Talisman" crashes the Game -> Use "Amulet" instead.
- [MINOR][Can't Fix]: "Afterimage" doesn't apply "context.modify_ante" correctly.
- [MINOR][Can't Fix]: "Parking Disc: 3" doesn't apply "context.modify_ante" correctly.

> Future WiPs:
- [++ ]: "Winning Ante: 99" should be "Winning Ante: None/-" (Requires patching UI)
- [  -]: Add Unlock requirements to some Jokers

> Each Release:
- Update: README.md, Version Number ("Year"."Month"."Day""Minor"), Create *Latest GitHub Release*
- External:
- - Wiki: https://balatromods.miraheze.org/wiki/Shimmerberry
- - Mod Index: https://github.com/FlowireXen/balatro-mod-index - meta.json, readme.md

> Next TODO's:
- Upload to: https://thunderstore.io/c/balatro
- Shimmerberry Lite :: Only the Challenges (and needed Patches), Any Jokers will be reproduced in the Challenge Code - If the Challenge is interesting, Shimmerberry Lite -> SEMBL

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Patch Notes:
Updated Art-Credits system, now always shows the Art-Credits, much like the PotatoPatchUtils
Internal Update: Removed unnecessary "name" property from all Onbjects
"Shiny" edition now shows both states in collection
"Degrading" works in Collection View again
"Degrading" now works with Playing cards -> "Destroyed if this card is held in hand at end of round"
Updated Translation File: Removed Duplicate Entries
Updated Challenge "Shiny Hunt": Now grants a flat $3 bonus to all starting eggs
Reworked "Improv Show": Now Converts leftover hands into bonus hands for future scoring
"Cockroach" now relies on the SMODS fallback when skipping the Winning Ante -> Added some fitting ingame info!
"TMTRAINER" is no longer Blueprint Compatible, but doesn't break as often anymore.
Technical: All Destruction Effects happen quicker now
"Bound Joker" has more visual feedback
"Melon" and "Plastic Key" wait for the Win-Screen before getting destroyed in more/better circumstances
Obscure Ritual has been Buffed (50% -> 66.6%)
Eternal Jokers given by Challenges are Immune to "Emergency Button", "Copy Printer" and "Order (Spectral)"
"Echoing Joker" reduced cost by $2 + Description Updated
"Shooting Star" Description Updated
All Jokers with a Changing Texture are now less prone to breaking/crashing when changing the internal Values
"Revives" now always shuffle into the Deck
Updated "Chrono Break" Revive Mechanic, "Chrono Break" now Shatters all scoring cards instead of 1 random
Updated "Tempered Glass" Revive Mechanic
Enjoy Art from GhostSalt, lanedarushpy, ... :3
Some Challenges now have Custom Death Reasons!
Intimidating: Now only shows up Ante 2 and up
Nerfed: Stocked Shelves (Destroyed after buying 5 cards)
Buffed: Watching Forest -> Now always sorts once, direction changes every 3 hands
Nerfed: Bound Joker -> Gives 3 slots instead of 4

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Check for ##TODO##'s

????CAN I PAY SOMEONE TO DO THE WIKI????
--> https://balatromods.miraheze.org/wiki/Modded_Balatro_Wiki:Balatro_localization_transcriber
Wiki Inspo: https://balatromods.miraheze.org/wiki/Phanta


!! Bug Report: Shader Issue !! -> Fixed: Shoutout to "thewhiteoctavia"

Currently: Give all Jokers (& others) Pronouns

Artists: Add "Guest Links" section
-> Add "guest_link" code!

For the other Artist:
"Memory Tarot"/IBM/Floppy Disc -> Floppy Disc (by IBM(™-Logo here))
Daybreak -> Chapter 5 Sunset
Annoying Dog -> Is a Toby Fox reference, but instead of his usual Pixel Dog, do something more smooth -> 4 Different Textures needed here
Also Give: Lost Constellation

.md file
-> Collection View -> Replace Some Jokers with new Stuff (there's PINK Placeholders)
---> Switch Scartere and Memory on the Preview

Add sound sources to origin
Add Texture files to origin
( Generally Update Origin )

Rework Countdown Challenge again?; Patch the thing that Resets hands and discards... Easy :>
Otherwise; Make sure Burglar works ;3 

Add Delayed Gratification to the Banned Jokers for Countdown

Black hole.. Remove the Sticker on destroy

Add "Eden"-Sticker, reduces money of Item to 0

Butterfly; Inverse Logic (Gain is slow, loss is fast)



> Next Update [Sketch]:

[IDEA] Deck:
- Replaces Money with Time
- - $1 => 10 seconds
- - Literally just show a time in the Money-Slot
- - "Set Cost" can just be hooked etc.

Sticker: "Temporary Copy"
Effect:  "Doesn't take up Space, Destroyed at the End of Shop"
--> set one to "-1" and the other to "0" (so negative doesn't apply either)

> Challenger Approaching [SPOILER][Sketch]:

"Nonrefundable Trial": 10 Hand Size, 10 Cards, playing cards are all Degrading
"Explosive Trial": Buff Shop, Go from Ante 1 to Ante 8 instantly
"Deckless Trial": All playing cards are debuffed
"Desperate Trial": Starting Stats -1, Hands only earn $0.5, Only one Card each Shop (No Vouchers or boosters), No reward money
"Doomsday Trial": Start with "[Degrading] Black Hole", Deck is Linked to Black Hole, Winning Ante 6, Ban Revive Jokers, (Empty Shops?)
"??": After beating a Boss Blind, permanently Disable all owned Jokers

"Pizzo Trial": Don't Regain Hands & Discards, You're able to buy Hands and Discards in Shop (Vouchers, Ban Upgrades), Start with 5 of each
- Instead of Vouchers; Add two Custom Buttons above the Deck -> $4 per Discard, $8 per Hand
- Hands (and Discards) DO still give money

"Gungame Trial":
- Entire Deck start as 2's
- Played Cards up their rank by 3
- Played Face Cards get destroyed
- (Ace) -> 2 -> 5 -> 8 -> Jack -> Ace -> Gone
- Played "Stone Cards" / "Cards with no ranks" get Destroyed (Message from Deck; "INVALID")
- Ban Normal Card Packs

[FINAL] "Digital Roses" (Challenge):
- Start with "Flower Pot" and "Potted Flower" [2x Eternal]
- All Face Cards are "Memory Cards" / Entire Deck is "Memory Cards" (+ Ban Pluto)

[FINAL] "Cascade"/"Escalation Protocol" (Challenge):
- First Blind starts at 100
- Beat Double the last round score every Blind
- Skipping Actively just Doubles all Score immidiatly

--G.GAME.SEMBY_last_score = get_blind_amount(G.GAME.round_resets.ante)*G.GAME.starting_params.ante_scaling

"Simon Says" -> Selects (4) Cards in a Order,
You have to repeat showed order
Speeds up, also requests unselecting in a different order, increases cards selected & de-selected, mixes operations etc.

Challenge: "Binary Soul"
Selling Joker to the Left; Invert All Bits
Selling Joker to Right: Shift all bits to the Left, Overflow gets destroyed, Push 0 into queue
Win by fulfilling a random Sequence 0000 0000
Instead; Show a Number and a Target Number (0-255)
Also has a random starting number
Math to make sure the numbers are apart and not easy to get

Doomed Voucher; First Level just adds Doom, second Level gives +1 Hand Size for every 50% Doom

Every Consumable can be flipped once, revealing a random planet card

Skip Tag: "New Discovery"
Generates a random Planet Card at the start of the Blind (3 rounds left)
(Secret extension; Last turn always pulls a modded planet?)

Idea, Joker: Scale - "X2 Mult" when having the same amount of Jokers on both sides

Phanta Compat.: Chloroform; Next 2 Shop Jokers are free and Sleepy
