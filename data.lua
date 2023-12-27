local _letters = { "", "", "", "e", "f", "g", "h", "i", "j", "k" }
for i = 4, 10 do
	local name = "5d-linked-belt-"..(i < 10 and "0" or "")..i

	local ingredient = "5d-underground-belt-"..(i < 10 and "0" or "")..i

	local subgroup = "belt" -- only belt

	local belt = "5d-transport-belt-"..(i < 10 and "0" or "")..i
	local ubelt = "5d-underground-belt"..(i < 10 and "0" or "")..i
    local base_ubelt = "express-underground-belt"

	local icon = "__5dim_transport__/graphics/icon/underground-belt/underground-belt-icon-" .. (i < 10 and "0" or "")  .. i .. ".png"

	local filename = "__5dim_transport__/graphics/entities/underground-belt/underground-belt-" .. (i < 10 and "0" or "") .. i .. ".png"

    local letters = {}
	local technologies = {}
	local speeds = {}

    letters[name] = _letters[i]
	technologies[name] = "logistics-"..i
	speeds[name] = i * 0.03125

	local technology = technologies[name]
	local speed = speeds[name]
	local letter = letters[name]
	local order = "e[linked-belt]-" .. letter .. "[" .. name .. "]"

	local item = {
		type = "item",
		name = name,
		icon = icon,
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = subgroup,
		order = order,
		place_result = name,
		stack_size = 10,
	}

	local recipe = {
		type = "recipe",
		name = name,
		enabled = false,
		ingredients = {
			{ ingredient, 2 },
		},
		result = name,
		result_count = 2,
	}

	table.insert(data.raw.technology[technology].effects, { type = "unlock-recipe", recipe = name })

	local entity = {
		type = "linked-belt",
		name = name,
		icon = icon,
		icon_size = 64,
		icon_mipmaps = 4,
		flags = {
			"placeable-neutral",
			"player-creation",
		},
		minable = {
			mining_time = 0.1,
			result = name,
		},
		max_health = 160,
		corpse = "underground-belt-remnants",
		dying_explosion = "underground-belt-explosion",
		open_sound = {
			{
				filename = "__base__/sound/machine-open.ogg",
				volume = 0.5,
			},
		},
		close_sound = {
			{
				filename = "__base__/sound/machine-close.ogg",
				volume = 0.5,
			},
		},
		working_sound = {
			sound = {
				filename = "__base__/sound/underground-belt.ogg",
				volume = 0.2,
			},
			max_sounds_per_type = 2,
			audible_distance_modifier = 0.5,
			persistent = true,
			use_doppler_shift = false,
		},
		resistances = {
			{
				type = "fire",
				percent = 60,
			},
			{
				type = "impact",
				percent = 30,
			},
		},
		collision_box = {
			{
				-0.4,
				-0.4,
			},
			{
				0.4,
				0.4,
			},
		},
		selection_box = {
			{
				-0.5,
				-0.5,
			},
			{
				0.5,
				0.5,
			},
		},
		damaged_trigger_effect = {
			type = "create-entity",
			entity_name = "spark-explosion",
			offset_deviation = {
				{
					-0.5,
					-0.5,
				},
				{
					0.5,
					0.5,
				},
			},
			offsets = {
				{
					0,
					1,
				},
			},
			damage_type_filters = "fire",
		},
		animation_speed_coefficient = 32,
		belt_animation_set = {
			animation_set = {
				filename = "__5dim_transport__/graphics/entities/transport-belt/"
					.. "transport-belt-" .. (i < 10 and "0" or "") .. i
					.. ".png",
				priority = "extra-high",
				width = 64,
				height = 64,
				frame_count = 16,
				direction_count = 20,
			},
		},
		fast_replaceable_group = "linked-belts",
		speed = speed,
		structure_render_layer = "object",
		structure = {
			direction_in = {
				sheet = {
					filename = filename,
					priority = "extra-high",
					width = 96,
					height = 96,
					y = 96,
				},
			},
			direction_out = {
				sheet = {
					filename = filename,
					priority = "extra-high",
					width = 96,
					height = 96,
				},
			},
			direction_in_side_loading = {
				sheet = {
					filename = filename,
					priority = "extra-high",
					width = 96,
					height = 96,
					y = 288,
				},
			},
			direction_out_side_loading = {
				sheet = {
					filename = filename,
					priority = "extra-high",
					width = 96,
					height = 96,
					y = 192,
				},
			},
			back_patch = {
				sheet = {
					filename = "__base__/graphics/entity/"
						.. base_ubelt
						.. "/"
						.. base_ubelt
						.. "-structure-back-patch.png",
					priority = "extra-high",
					width = 96,
					height = 96,
					hr_version = {
						filename = "__base__/graphics/entity/"
							.. base_ubelt
							.. "/hr-"
							.. base_ubelt
							.. "-structure-back-patch.png",
						priority = "extra-high",
						width = 192,
						height = 192,
						scale = 0.5,
					},
				},
			},
			front_patch = {
				sheet = {
					filename = "__base__/graphics/entity/"
						.. base_ubelt
						.. "/"
						.. base_ubelt
						.. "-structure-front-patch.png",
					priority = "extra-high",
					width = 96,
					height = 96,
					hr_version = {
						filename = "__base__/graphics/entity/"
							.. base_ubelt
							.. "/hr-"
							.. base_ubelt
							.. "-structure-front-patch.png",
						priority = "extra-high",
						width = 192,
						height = 192,
						scale = 0.5,
					},
				},
			},
		},
		allow_clone_connection = true,
		allow_blueprint_connection = true,
		allow_side_loading = false,
	}

	data:extend({ item, recipe, entity })
end
