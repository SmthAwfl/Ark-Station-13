#define HACKERMAN_DECK_TEMPERATURE_INCREASE 450

#define HACKING_FORENSICS_SUCCESS_MESSAGE "Damages reported by the internal diagnostics system suggest a digital attack by a wireless hacking implant."

// An implant that injects you with twitch on demand, acting like a bootleg sandevistan

/obj/item/organ/internal/cyberimp/sensory_enhancer
	name = "\improper Qani-Laaca sensory computer"
	desc = "An experimental implant replacing the spine of organics. When activated, it can give a temporary boost to mental processing speed, \
		Which many users percieve as a slowing of time and quickening of their ability to act. Due to its nature, it is incompatible with \
		system that heavily influence the user's nervous system, like the central nervous system rebooter. \
		As a bonus effect, you are immune to the burst of heart damage that comes at the end of twitch usage, as the computer is able to regulate \
		your heart's rhythm back to normal after its use."
	icon = 'modular_nova/modules/implants/icons/implants.dmi'
	icon_state = "sandy"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN
	zone = BODY_ZONE_HEAD
	implant_overlay = null
	implant_color = null
	actions_types = list(/datum/action/cooldown/sensory_enhancer)
	w_class = WEIGHT_CLASS_SMALL
	/// The bodypart overlay datum we should apply to whatever mob we are put into
	var/datum/bodypart_overlay/simple/sensory_enhancer/bodypart_overlay

/obj/item/organ/internal/cyberimp/sensory_enhancer/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	ADD_TRAIT(organ_owner, TRAIT_TWITCH_ADAPTED, TRAIT_NARCOTICS)

/obj/item/organ/internal/cyberimp/sensory_enhancer/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	REMOVE_TRAIT(organ_owner, TRAIT_TWITCH_ADAPTED, TRAIT_NARCOTICS)

/obj/item/organ/internal/cyberimp/sensory_enhancer/on_bodypart_insert(obj/item/bodypart/limb, movement_flags)
	if(isteshari(owner))
		return ..()
	bodypart_overlay = new()
	limb.add_bodypart_overlay(bodypart_overlay)
	owner.update_body_parts()
	return ..()

/obj/item/organ/internal/cyberimp/sensory_enhancer/on_bodypart_remove(obj/item/bodypart/limb, movement_flags)
	if(isteshari(owner))
		return ..()
	limb.remove_bodypart_overlay(bodypart_overlay)
	QDEL_NULL(bodypart_overlay)
	owner.update_body_parts()
	return ..()

/datum/bodypart_overlay/simple/sensory_enhancer
	icon = 'modular_nova/modules/implants/icons/implants_onmob.dmi'
	icon_state = "sandy"
	layers = EXTERNAL_ADJACENT

/datum/action/cooldown/sensory_enhancer
	name = "Activate Qani-Laaca System"
	desc = "Activates your Qani-Laaca computer and grants you its powers. LMB: Short, safer activation. RMB: Longer, more powerful, more dangerous activation."
	button_icon = 'modular_nova/modules/implants/icons/implants.dmi'
	button_icon_state = "sandy"
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = 5 MINUTES
	text_cooldown = TRUE
	/// Keeps track of how much twitch we inject into people on activation
	var/injection_amount = 10

/datum/action/cooldown/sensory_enhancer/Trigger(trigger_flags, atom/target)
	. = ..()

	injection_amount = 10

	var/right_clicked = FALSE

	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		right_clicked = TRUE
		injection_amount = 20

	owner.log_message("clicked their qani-laaca action button with [right_clicked ? "Right" : "Left"]-Click", LOG_ATTACK)

/datum/action/cooldown/sensory_enhancer/Activate(atom/target)
	. = ..()

	var/mob/living/carbon/human/human_owner = owner

	owner.log_message("triggered their qani-laaca implant in [(injection_amount > 10) ? "overdose" : "normal"] mode", LOG_ATTACK)

	human_owner.reagents.add_reagent(/datum/reagent/drug/twitch, injection_amount)

	owner.visible_message(span_danger("[owner.name] jolts suddenly as two small glass vials are fired from ports in the implant on their spine, shattering as they land."), \
			span_userdanger("You jolt suddenly as your Qani-Laaca system ejects two empty glass vials rearward, shattering as they land."))
	playsound(human_owner, 'sound/items/hypospray.ogg', 50, TRUE)

	var/obj/item/telegraph_vial = new /obj/item/qani_laaca_telegraph(get_turf(owner))
	var/turf/turf_we_throw_at = get_step(owner, REVERSE_DIR(owner.dir))
	telegraph_vial.throw_at(turf_we_throw_at, 1, 3, gentle = FALSE, quickstart = TRUE)

	// Safety net in case the injection amount doesn't get reset. Apparently it happened to someone in a round.
	injection_amount = initial(injection_amount)

/obj/item/qani_laaca_telegraph
	name = "spent Qani-Laaca cartridge"
	desc = "A small glass vial, usually kept in a large stack inside a Qani-Laaca implant, that is broken open and ejected \
		each time the implant is used. If you're looking at one long enough to think about it this long, you either have fast eyes \
		or were lucky enough to catch one before it broke."
	icon = 'icons/obj/medical/drugs.dmi'
	icon_state = "blastoff_ampoule_empty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/qani_laaca_telegraph/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/shatters_when_thrown, /obj/effect/decal/cleanable/glass, 1, SFX_SHATTER)
	transform = transform.Scale(0.75, 0.75)

// Hackerman deck, lets you emag or doorjack things (NO CYBORGS) within a short range of yourself

/obj/item/organ/internal/cyberimp/hackerman_deck
	name = "\improper Binyat wireless hacking system"
	desc = "A rare-to-find neural chip that allows its user to interface with nearby machinery \
		and effect it in (usually) beneficial ways. Due to the rudimentary connection, fine manipulation \
		isn't possible, however the deck will drop a payload into the target's systems that will attempt \
		hacking for you. Due to their complexity, the system does not appear to work on cyborgs."
	icon = 'modular_nova/modules/implants/icons/implants.dmi'
	icon_state = "hackerman"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN
	zone = BODY_ZONE_HEAD
	implant_overlay = null
	implant_color = null
	actions_types = list(/datum/action/cooldown/spell/pointed/hackerman_deck)
	w_class = WEIGHT_CLASS_SMALL
	/// The bodypart overlay datum we should apply to whatever mob we are put into
	var/datum/bodypart_overlay/simple/hackerman/bodypart_overlay

/obj/item/organ/internal/cyberimp/hackerman_deck/on_bodypart_insert(obj/item/bodypart/limb, movement_flags)
	if(isteshari(owner))
		return ..()
	bodypart_overlay = new()
	limb.add_bodypart_overlay(bodypart_overlay)
	owner.update_body_parts()
	return ..()

/obj/item/organ/internal/cyberimp/hackerman_deck/on_bodypart_remove(obj/item/bodypart/limb, movement_flags)
	if(isteshari(owner))
		return ..()
	limb.remove_bodypart_overlay(bodypart_overlay)
	QDEL_NULL(bodypart_overlay)
	owner.update_body_parts()
	return ..()

/datum/bodypart_overlay/simple/hackerman
	icon = 'modular_nova/modules/implants/icons/implants_onmob.dmi'
	icon_state = "hackerman"
	layers = EXTERNAL_ADJACENT

/datum/action/cooldown/spell/pointed/hackerman_deck
	name = "Activate Ranged Hacking"
	desc = "Click on any machine, excepting cyborgs, to hack them. Has a short range, only two tiles."
	active_msg = "You warm up your Binyat deck, there's an idle buzzing at the back of your mind as it awaits a target."
	deactive_msg = "Your hacking deck makes an almost disappointed sounding buzz at the back of your mind as it powers down."
	button_icon = 'modular_nova/modules/implants/icons/implants.dmi'
	button_icon_state = "hackerman"
	spell_requirements = SPELL_REQUIRES_MIND
	cast_range = INFINITY // The range code doesn't work here, so we use our own, don't worry about it
	aim_assist = FALSE
	spell_max_level = 1 // God I hate actions
	cooldown_time = 5 MINUTES
	sparks_amt = 2
	ranged_mousepointer = 'icons/effects/mouse_pointers/override_machine_target.dmi'
	/// What we don't work on, will always not work on mobs because I know what you are
	var/static/list/emag_blacklist = list(
		/obj/machinery/shieldgen,
		/obj/machinery/computer/communications,
		/obj/machinery/computer/arcade,
		/obj/machinery/computer/holodeck,
		/obj/machinery/computer/emergency_shuttle,
		/obj/machinery/recycler,
	)
	/// How far away we can hack things
	var/hack_range = 2

/datum/action/cooldown/spell/pointed/hackerman_deck/is_valid_target(atom/cast_on)
	. = ..()

	if(ismob(cast_on) || is_type_in_list(cast_on, emag_blacklist))
		owner.balloon_alert(owner, "security too strong")
		return FALSE

	if(get_dist(owner, cast_on) > hack_range)
		owner.balloon_alert(owner, "too far away")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/hackerman_deck/cast(atom/cast_on)
	. = ..()

	unset_click_ability(owner)

	playsound(owner, 'sound/effects/light_flicker.ogg', 50, TRUE)
	var/beam = owner.Beam(cast_on, icon_state = "light_beam", time = 5 SECONDS)

	owner.visible_message(span_bolddanger("[owner.name] makes an unusual buzzing sound as the air between [owner.p_them()] and [cast_on] crackles."), \
			span_bolddanger("The air between you and [cast_on] begins to crackle audibly as the Binyat gets to work."))

	if(!do_after(owner, 5 SECONDS, cast_on, IGNORE_SLOWDOWNS))
		qdel(beam)
		StartCooldown(1 SECONDS) // Resets the spell to working after a second, just so its not spammed
		return

	if(!cast_on.emag_act(owner))
		owner.balloon_alert(owner, "can't hack this!")
		StartCooldown(1 SECONDS) // Resets the spell to working after a second, just so its not spammed
		return

	owner.log_message("hacked [key_name(cast_on)] from [get_dist(owner, cast_on)] tiles away using a wireless hacking implant", LOG_ATTACK)
	cast_on.forensics?.add_hacking_implant_trace()
	cast_on.add_hiddenprint(owner)

	playsound(cast_on, 'sound/machines/terminal_processing.ogg', 15, TRUE)

	var/mob/living/carbon/human/human_owner = owner

	human_owner.adjust_bodytemperature(HACKERMAN_DECK_TEMPERATURE_INCREASE)

/// Adds an item to the list of fibers for this forensics datum that tells on the fact someone used a hacking implant here
/datum/forensics/proc/add_hacking_implant_trace()
	LAZYSET(fibers, HACKING_FORENSICS_SUCCESS_MESSAGE, HACKING_FORENSICS_SUCCESS_MESSAGE)

#undef HACKERMAN_DECK_TEMPERATURE_INCREASE
