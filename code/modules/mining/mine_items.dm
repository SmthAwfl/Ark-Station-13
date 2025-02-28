/**********************Light************************/

//this item is intended to give the effect of entering the mine, so that light gradually fades. we also use the base effect for certain lighting effects while mapping.
/obj/effect/light_emitter
	name = "light emitter"
	icon_state = "lighting_marker"
	anchored = TRUE
	invisibility = INVISIBILITY_ABSTRACT
	var/set_luminosity = 8
	var/set_cap = 0

/obj/effect/light_emitter/Initialize(mapload)
	. = ..()
	set_light(set_luminosity, set_cap)

/obj/effect/light_emitter/singularity_pull()
	return

/obj/effect/light_emitter/singularity_act()
	return

/obj/effect/light_emitter/podbay
	set_cap = 1

/obj/effect/light_emitter/thunderdome
	set_cap = 1
	set_luminosity = 1.6

/**********************Miner Lockers**************************/

/obj/structure/closet/wardrobe/miner
	name = "mining wardrobe"
	icon_door = "mining_wardrobe"

/obj/structure/closet/wardrobe/miner/PopulateContents()
	new /obj/item/storage/backpack/duffelbag/explorer(src)
	new /obj/item/storage/backpack/explorer(src)
	new /obj/item/storage/backpack/satchel/explorer(src)
	new /obj/item/storage/backpack/messenger/explorer(src)
	new /obj/item/clothing/under/rank/cargo/miner/lavaland(src)
	new /obj/item/clothing/under/rank/cargo/miner/lavaland(src)
	new /obj/item/clothing/under/rank/cargo/miner/lavaland(src)
	new /obj/item/clothing/shoes/workboots/mining(src)
	new /obj/item/clothing/shoes/workboots/mining(src)
	new /obj/item/clothing/shoes/workboots/mining(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/suit/hooded/wintercoat/miner(src)
	new /obj/item/clothing/suit/hooded/wintercoat/miner(src)
	new /obj/item/clothing/suit/hooded/wintercoat/miner(src)

/obj/structure/closet/secure_closet/miner
	name = "miner's equipment locker"
	icon_state = "mining"
	req_access = list(ACCESS_MINING)

/obj/structure/closet/secure_closet/miner/unlocked
	locked = FALSE

/obj/structure/closet/secure_closet/miner/PopulateContents()
	..()
	new /obj/item/stack/sheet/mineral/sandbags(src, 5)
	new /obj/item/storage/box/emptysandbags(src)
	new /obj/item/card/mining_point_card(src)
	new /obj/item/shovel(src)
	new /obj/item/pickaxe/mini(src)
	new /obj/item/radio/headset/headset_cargo/mining(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/storage/bag/plants(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/mining_scanner(src)
	new /obj/item/clothing/glasses/meson(src)
	if (HAS_TRAIT(SSstation, STATION_TRAIT_SMALLER_PODS))
		new /obj/item/survivalcapsule/bathroom(src)
	else
		new /obj/item/survivalcapsule(src)
	new /obj/item/assault_pod/mining(src)


/obj/structure/closet/secure_closet/miner/populate_contents_immediate()
	. = ..()

	new /obj/item/gun/energy/recharge/kinetic_accelerator(src)

/**********************Shuttle Computer**************************/

/obj/machinery/computer/shuttle/mining
	name = "mining shuttle console"
	desc = "Used to call and send the mining shuttle."
	circuit = /obj/item/circuitboard/computer/mining_shuttle
	shuttleId = "mining"
	possible_destinations = "mining_home;mining_away;landing_zone_dock"
	no_destination_swap = TRUE

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/machinery/computer/shuttle/mining/attack_hand(mob/user, list/modifiers)
	if(is_station_level(user.z) && user.mind && IS_HEAD_REVOLUTIONARY(user) && !(user.mind in dumb_rev_heads))
		to_chat(user, span_warning("You get a feeling that leaving the station might be a REALLY dumb idea..."))
		dumb_rev_heads += user.mind
		return

	if (HAS_TRAIT(user, TRAIT_FORBID_MINING_SHUTTLE_CONSOLE_OUTSIDE_STATION) && !is_station_level(user.z))
		to_chat(user, span_warning("You get the feeling you shouldn't mess with this."))
		return

	if(isliving(user))
		var/mob/living/living_user = user
		for(var/obj/item/implant/exile/exile_implant in living_user.implants)
			to_chat(living_user, span_warning("A warning flashes across the screen, and the shuttle controls lock in response to your exile implant."))
			return

	return ..()

/obj/machinery/computer/shuttle/mining/common
	name = "lavaland shuttle console"
	desc = "Used to call and send the lavaland shuttle."
	circuit = /obj/item/circuitboard/computer/mining_shuttle/common
	shuttleId = "mining_common"
	possible_destinations = "commonmining_home;lavaland_common_away;landing_zone_dock;mining_public"

/obj/docking_port/stationary/mining_home
	name = "SS13: Mining Dock"
	shuttle_id = "mining_home"
	roundstart_template = /datum/map_template/shuttle/mining/delta
	width = 7
	dwidth = 3
	height = 5

/obj/docking_port/stationary/mining_home/kilo
	roundstart_template = /datum/map_template/shuttle/mining/kilo
	height = 10

/obj/docking_port/stationary/mining_home/northstar
	roundstart_template = /datum/map_template/shuttle/mining/northstar
	height = 6

/obj/docking_port/stationary/mining_home/common
	name = "SS13: Common Mining Dock"
	shuttle_id = "commonmining_home"
	roundstart_template = /datum/map_template/shuttle/mining_common/meta

/obj/docking_port/stationary/mining_home/common/kilo
	roundstart_template = /datum/map_template/shuttle/mining_common/kilo

/obj/docking_port/stationary/mining_home/common/northstar
	roundstart_template = /datum/map_template/shuttle/mining_common/northstar

/**********************Mining car (Crate like thing, not the rail car)**************************/

/obj/structure/closet/crate/miningcar
	desc = "A mining car. This one doesn't work on rails, but has to be dragged."
	name = "Mining car (not for rails)"
	icon_state = "miningcar"
	base_icon_state = "miningcar"
