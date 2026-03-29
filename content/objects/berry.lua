-- Berry pool
SMODS.ObjectType({
	key = "Berry",
	--default = "j_SEMBY_berry_shimmer",
	default = "j_SEMBY_berry_straw", -- Ironic...
	cards = {
		--["j_gros_michel"] = true,
		--["j_cavendish"] = true,
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end
})
