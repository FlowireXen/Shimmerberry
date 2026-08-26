-- Durability pool
SMODS.ObjectType({
	key = "Durability",
	default = "j_SEMBY_toolkit",
	cards = {
		["j_selzer"] = true,
		["j_popcorn"] = true,
		["j_ice_cream"] = true,
		--["j_turtle_bean"] = true,
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end
})
