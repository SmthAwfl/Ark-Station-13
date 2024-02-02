#define IOTA_DEFAULT_ATMOS "IOTA_ATMOS"
#define IOTA_MAX_TEMPERATURE 330

/turf/closed/mineral/random/labormineral/iota_high_chance
	mineralChance = 15

/datum/map_generator/cave_generator/iota
	weighted_open_turf_types = list(/turf/open/misc/asteroid/airless = 1)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/low_chance = 19, /turf/closed/mineral/random/labormineral/iota_high_chance = 1)
	mob_spawn_chance = 1
	weighted_mob_spawn_list = list(
		/mob/living/basic/mining/basilisk = 1
	)

	weighted_flora_spawn_list = list(
		/obj/structure/flora/rock/pile/style_random = 1,
		/obj/structure/flora/rock/icy/style_random = 2,
		/obj/structure/flora/rock/style_random = 2,
	)

	///Note that this spawn list is also in the icemoon generator
	weighted_feature_spawn_list = list(
		/obj/structure/geyser/hollowwater = 10,
		/obj/structure/geyser/plasma_oxide = 10,
		/obj/structure/geyser/protozine = 10,
		/obj/structure/geyser/random = 2,
		/obj/structure/geyser/wittel = 10,
	)

	initial_closed_chance = 50
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3

/datum/map_generator/cave_generator/iota/ruin_version
	weighted_open_turf_types = list(/turf/open/misc/asteroid/basalt/lava_land_surface/no_ruins = 1)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/volcanic/do_not_chasm = 1)

/datum/map_generator/cave_generator/iota/dangerzone
	initial_closed_chance = 40
	mob_spawn_chance = 8
	weighted_mob_spawn_list = list(
		SPAWN_MEGAFAUNA = 2,
		/obj/effect/spawner/random/lavaland_mob/goliath = 50,
		/obj/effect/spawner/random/lavaland_mob/legion = 30,
		/obj/effect/spawner/random/lavaland_mob/watcher = 40,
		/mob/living/basic/mining/bileworm = 20,
		/mob/living/basic/mining/brimdemon = 20,
		/mob/living/basic/mining/lobstrosity/lava = 20,
		/mob/living/basic/mining/goldgrub = 10,
		/obj/structure/spawner/lavaland = 2,
		/obj/structure/spawner/lavaland/goliath = 3,
		/obj/structure/spawner/lavaland/legion = 3,
		/mob/living/basic/mining/legion/snow = 50,
		/mob/living/basic/mining/lobstrosity = 15,
		/mob/living/basic/mining/wolf = 50,
		/mob/living/simple_animal/hostile/asteroid/polarbear = 30,
		/obj/structure/spawner/ice_moon = 3,
		/obj/structure/spawner/ice_moon/polarbear = 3,
	)


/area/mine/iotaunderground
	name = "Lavaland Underground Jungle"
	map_generator = /datum/map_generator/jungle_generator/iota

/area/mine/iotaunderground/no_gen
	map_generator = null

/area/mine/iotadeepunderground
	name = "Lavaland Underground Bedrock"

/datum/atmosphere/iotastation
	id = IOTA_DEFAULT_ATMOS

	base_gases = list(
		/datum/gas/oxygen=18,
		/datum/gas/nitrogen=88,
	)
	normal_gases = list(
		/datum/gas/oxygen=18,
		/datum/gas/nitrogen=88,
		/datum/gas/carbon_dioxide=10,
	)
	restricted_gases = list(
		/datum/gas/plasma=0.1,
		/datum/gas/bz=1.2,
		/datum/gas/miasma=1.2,
		/datum/gas/water_vapor=0.1,
	)
	restricted_chance = 0	// NOVA EDIT: Disables restricted gases from rolling - Original value (30)

	minimum_pressure = WARNING_LOW_PRESSURE + 15
	maximum_pressure = LAVALAND_EQUIPMENT_EFFECT_PRESSURE - 2

	minimum_temp = BODYTEMP_COLD_DAMAGE_LIMIT + 1
	maximum_temp = IOTA_MAX_TEMPERATURE

/turf/open/lava/smooth/iota_surface
	initial_gas_mix = IOTA_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/lava/smooth/iota_surface

/turf/open/misc/asteroid/basalt/iota_surface
	initial_gas_mix = IOTA_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/lava/smooth/iota_surface

/turf/closed/mineral/random/volcanic/iota
	turf_type = /turf/open/misc/asteroid/basalt/iota_surface
	baseturfs = /turf/open/misc/asteroid/basalt/iota_surface
	initial_gas_mix = IOTA_DEFAULT_ATMOS
	defer_change = TRUE
	mineralChance = 10

/turf/open/misc/asteroid/iota
	planetary_atmos = 1

/turf/closed/mineral/random/iota
	baseturfs = /turf/open/misc/asteroid/iota

/turf/closed/mineral/random/iota/mineral_chances()
	return list(
		/obj/item/stack/ore/bananium = 0.01,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/diamond = 2,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/iron = 10,
		/obj/item/stack/ore/plasma = 10,
		/obj/item/stack/ore/silver = 14,
		/obj/item/stack/ore/titanium = 12,
		/obj/item/stack/ore/uranium = 5,
		/turf/closed/mineral/gibtonite = 0.1,
	)

/datum/map_generator/cave_generator/lavaland/iota
	weighted_open_turf_types = list(/turf/open/misc/asteroid/basalt/iota_surface = 1)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/volcanic/iota = 1)

/area/lavaland/surface/outdoors/unexplored/iota
	map_generator = /datum/map_generator/cave_generator/lavaland/iota

/area/lavaland/surface/outdoors/unexplored/danger/iota
	map_generator = /datum/map_generator/cave_generator/lavaland/iota

/obj/structure/flora/biolumi/flower/iota
	light_power = 1
	light_range = 7

/obj/structure/flora/biolumi/mine/iota
	light_power = 1
	light_range = 7

/obj/structure/flora/biolumi/lamp/iota
	light_power = 1
	light_range = 7

/obj/structure/flora/biolumi/iota
	light_power = 0.5
	light_range = 3

/datum/biome/iota
	var/lightdensity = 0.25
	var/list/biolumi = list(/obj/structure/flora/biolumi/flower, /obj/structure/flora/biolumi/mine/iota, /obj/structure/flora/biolumi/lamp/iota, /obj/structure/flora/biolumi/iota)

/datum/biome/iota/generate_turf(turf/gen_turf)
	gen_turf.ChangeTurf(turf_type, null, CHANGETURF_DEFER_CHANGE)
	if(length(fauna_types) && prob(fauna_density))
		var/mob/fauna = pick(fauna_types)
		new fauna(gen_turf)

	if(length(flora_types) && prob(flora_density))
		var/obj/structure/flora = pick(flora_types)
		new flora(gen_turf)

	if(length(biolumi) && prob(lightdensity))
		var/obj/structure/flora = pick(biolumi)
		new flora(gen_turf)

/datum/biome/iota/jungle
	turf_type = /turf/open/misc/grass/jungle/planet
	flora_density = 40
	flora_types = list(/obj/structure/flora/grass/jungle/a/style_random,/obj/structure/flora/grass/jungle/b/style_random, /obj/structure/flora/tree/jungle/style_random, /obj/structure/flora/rock/pile/jungle/style_random, /obj/structure/flora/bush/jungle/a/style_random, /obj/structure/flora/bush/jungle/b/style_random, /obj/structure/flora/bush/jungle/c/style_random, /obj/structure/flora/bush/large/style_random, /obj/structure/flora/rock/pile/jungle/large/style_random)

/datum/biome/iota/jungle/deep
	lightdensity = 1
	flora_density = 65

/datum/biome/hotspring
	turf_type = /turf/open/water/hot_spring

/datum/biome/iota/plains
	turf_type = /turf/open/misc/grass/jungle/planet
	flora_density = 15
	flora_types = list(/obj/structure/flora/grass/jungle/a/style_random,/obj/structure/flora/grass/jungle/b/style_random, /obj/structure/flora/tree/jungle/style_random, /obj/structure/flora/rock/pile/jungle/style_random, /obj/structure/flora/bush/jungle/a/style_random, /obj/structure/flora/bush/jungle/b/style_random, /obj/structure/flora/bush/jungle/c/style_random, /obj/structure/flora/bush/large/style_random, /obj/structure/flora/rock/pile/jungle/large/style_random)

/datum/map_generator/jungle_generator/iota
	possible_biomes = list(
	BIOME_LOW_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/iota/plains,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/mudlands,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/mudlands,
		BIOME_HIGH_HUMIDITY = /datum/biome/water
		),
	BIOME_LOWMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/iota/plains,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/iota/jungle,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/iota/jungle,
		BIOME_HIGH_HUMIDITY = /datum/biome/mudlands
		),
	BIOME_HIGHMEDIUM_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/iota/plains,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/iota/plains,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/iota/jungle/deep,
		BIOME_HIGH_HUMIDITY = /datum/biome/iota/jungle
		),
	BIOME_HIGH_HEAT = list(
		BIOME_LOW_HUMIDITY = /datum/biome/wasteland,
		BIOME_LOWMEDIUM_HUMIDITY = /datum/biome/iota/plains,
		BIOME_HIGHMEDIUM_HUMIDITY = /datum/biome/iota/jungle,
		BIOME_HIGH_HUMIDITY = /datum/biome/hotspring
		)
	)
/datum/map_generator/jungle_generator/iota/generate_terrain(list/turfs, area/generate_in)
	. = ..()
	var/height_seed = rand(0, 50000)
	var/humidity_seed = rand(0, 50000)
	var/heat_seed = rand(0, 50000)

	for(var/t in turfs)
		var/turf/gen_turf = t
		var/drift_x = (gen_turf.x + rand(-2, 2)) / perlin_zoom
		var/drift_y = (gen_turf.y + rand(-2, 2)) / perlin_zoom

		var/height = text2num(rustg_noise_get_at_coordinates("[height_seed]", "[drift_x]", "[drift_y]"))


		var/datum/biome/selected_biome
		if(height <= 0.98)
			var/humidity = text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]"))
			var/heat = text2num(rustg_noise_get_at_coordinates("[heat_seed]", "[drift_x]", "[drift_y]"))
			var/heat_level
			var/humidity_level

			switch(heat)
				if(0 to 0.25)
					heat_level = BIOME_LOW_HEAT
				if(0.25 to 0.5)
					heat_level = BIOME_LOWMEDIUM_HEAT
				if(0.5 to 0.75)
					heat_level = BIOME_HIGHMEDIUM_HEAT
				if(0.75 to 1)
					heat_level = BIOME_HIGH_HEAT
			switch(humidity)
				if(0 to 0.25)
					humidity_level = BIOME_LOW_HUMIDITY
				if(0.25 to 0.5)
					humidity_level = BIOME_LOWMEDIUM_HUMIDITY
				if(0.5 to 0.75)
					humidity_level = BIOME_HIGHMEDIUM_HUMIDITY
				if(0.75 to 1)
					humidity_level = BIOME_HIGH_HUMIDITY
			selected_biome = possible_biomes[heat_level][humidity_level]
		else
			selected_biome = /datum/biome/mountain
		selected_biome = SSmapping.biomes[selected_biome]
		selected_biome.generate_turf(gen_turf)
		CHECK_TICK
