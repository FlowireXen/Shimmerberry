- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> Each Release:
- Update: README.md, Version Number ("Year"."Month"."Day""Minor"), Create *Latest GitHub Release*
- External:
- - Discord-Thread
- - Wiki: https://balatromods.miraheze.org/wiki/Shimmerberry
- - Mod Index: https://github.com/skyline69/balatro-mod-index

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> UPCOMING:
- Upload to: https://thunderstore.io/c/balatro
- - Also add Link to README.md

> Next TODO's:
- Shimmerberry "Challenger Arrival"/"The Circus"
- [SEMBL] Shimmerberry Lite :: Only the Challenges (and needed Patches)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> Future WiPs:
- [++ ]: Update to new SMODS; Blind Mod, Chance Mod, etc.
- [+  ]: "##FIXME##"/"FIXME"
- [  -]: Add Unlock requirements to some Jokers

> Known Bugs:
- [MAJOR][Won't Fix]: "Talisman" crashes the Game -> Use "Amulet" instead.
- [MINOR][Can't Fix]: "Afterimage" doesn't apply "context.modify_ante" correctly.
- [MINOR][Can't Fix]: "Parking Disc: 3" doesn't apply "context.modify_ante" correctly.

> Current WiPs:
- None!

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> "Challenger Arrival"/"The Circus" [SPOILERS]
- If you're looking here to gain an Edge over your competitors, you're sadly not gonna find anything interesting ;)

> New SMODS needed:
- Use the SMODS "Blind Size" changing code/logic
- Add "can_sell(self, card, context)" to "Anchor"-Joker and disable selling when unselectable

> Features [Ideas/Notes]:
- Sticker, "Temporary Copy": "Doesn't take up Space, Destroyed at the End of Shop", set one to "-1" and the other to "0" (so negative doesn't apply)
- Sticker, "Fleeting": Self destructs when Boss Blind is defeated
- Joker, "Scale": X2 Mult when having the same amount of Jokers on both sides
- Joker, "Chloroform": Next 2 Shop Jokers are free and Sleepy (Phanta Compat.)
- Voucher, "Doomed", "Doomed 2": First Level just adds Doom, Second Level gives +1 Hand Size for every 50% Doom
- Skip Tag, "Discovery": Generates [Random Planet Card] at the start of the Blind (3 uses)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> Add "Circus" Mode:
- Rogue-Like where you select Challenge-Rules and Modifiers
- Each Run Rewards Points, these can be used to unlock Shimmerberry
- Winning Ante 12, can be increased for greater Rewards
- Different Rules and Modifiers give more points or multipliers
- When you select a Rule, choose between 2 versions (Easy Option gives Score, Harder Option gives Multiplier, BOTH show how they affect score)

> "Circus" Starts:
- "Shadow Crystal": 2 Hands, 2 Hand Size, 2 Discards, Diamond Suit is (always) Negative
- "Digital Roses": Bans Pluto & Jupiter, All Non-Face Cards are "Memory Cards"
- "Scalper": +2 Hand Size, Starting Deck is "Degrading"
- "Desperate": +2 Hands, Hands only earn 0.5 Coins
- "Doomsday": Deck is Linked to a "Degrading" "Black Hole"

> Challenge Ideas [Notes/Rules/Modifiers]:
- Consider "Bound" for some challenges
- Replace Money with Time; $1 => 10 seconds, Shows a Timer in the Money-Slot, Internally just subtract $0.1 every second
- "No Shops"
- After beating a Boss Blind, permanently Disable all owned Jokers

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> Challenges [Final]:

# "Pizzo Trial":
-- Don't Regain Hands & Discards, Start with "5 Hands" and "5 Discards"
-- Each Shop Generates a "+1 Hand" and "+1 Discard" Voucher for $5
-- > [Secretly Ban these Vouchers at start of Run]
-- Hands and Discards give Money [Green Deck]

# "Cascade"/"Escalation Protocol":
-- First Blind starts at 100
-- Beat Double the last round score every Blind
-- Skipping Actively just Doubles/Triples Score immidiatly
-- "G.GAME.SEMBY_last_score = get_blind_amount(G.GAME.round_resets.ante)*G.GAME.starting_params.ante_scaling"

# "Gungame":
-- Start with 4 Kings [1 of each suit]
-- Played Cards split in half (rounded up); 1x"King" -> 2x"Seven" -> 4x"Four" -> 8x"Two"
-- Played 2's get destroyed, Rankless cards always get destroyed
-- Newly added cards always turn into Stone

# "Simon Says":
-- Selects a random Poker Hand, changes when the Poker-Hand is played
-- Playing any Hand that isn't Simon's Hand is invalid

# "0 to 100":
-- Super Buff Shop, Both Reroll Vouchers
-- Go from Ante 1 to Ante 8 instantly

# "Frozen Hell":
-- Starting Deck is Debuffed
-- All but 1 Mult are added to Chips
