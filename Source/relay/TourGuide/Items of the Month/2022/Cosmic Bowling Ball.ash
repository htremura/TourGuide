//Cosmic Bowling Ball
RegisterTaskGenerationFunction("IOTMCosmicBowlingBallGenerateTasks");
void IOTMCosmicBowlingBallGenerateTasks(ChecklistEntry [int] task_entries, ChecklistEntry [int] optional_task_entries, ChecklistEntry [int] future_task_entries)
{
	if (!__iotms_usable[lookupItem("cosmic bowling ball")])
		return;
	int bowlingUses = get_property_int("_cosmicBowlingSkillsUsed");
	int bowlingCooldown2 = bowlingUses * 2 + 6;
	int bowlingCooldown = get_property_int("cosmicBowlingBallReturnCombats");
	boolean bowlingSupernag = get_property_boolean("tourGuideBowlingBallSupernag");

	string url;
	if (bowlingCooldown == 0)
	{
		string [int] description;
		string main_title = "Cosmic bowling ball usable";
		description.listAppend(HTMLGenerateSpanFont("You can bowl again next turn!", "blue"));
		description.listAppend("Next use has " + HTMLGenerateSpanOfClass(bowlingCooldown2, "r_bold") + " duration.");
		optional_task_entries.listAppend(ChecklistEntryMake("__item cosmic bowling ball", url, ChecklistSubentryMake("Cosmic bowling ball returns next combat", "", description), -11));
	}

	if (bowlingCooldown < 0 && bowlingSupernag)
	{
		string [int] description;
		string main_title = "Cosmic bowling ball usable";
		description.listAppend(HTMLGenerateSpanFont("You can bowl again -- right now!", "blue"));
		description.listAppend("Next use has " + HTMLGenerateSpanOfClass(bowlingCooldown2, "r_bold") + " duration.");
		optional_task_entries.listAppend(ChecklistEntryMake("__item cosmic bowling ball", url, ChecklistSubentryMake("Cosmic bowling ball is in your inventory!", "", description), -11));
	}
}


RegisterResourceGenerationFunction("IOTMCosmicBowlingBallGenerateResource");
void IOTMCosmicBowlingBallGenerateResource(ChecklistEntry [int] resource_entries)
{
	if (!__iotms_usable[lookupItem("cosmic bowling ball")])
		return;

	// Entries
	int bowlingUses = get_property_int("_cosmicBowlingSkillsUsed");
	int bowlingCooldown2 = bowlingUses * 2 + 6;
	int bowlingCooldown = get_property_int("cosmicBowlingBallReturnCombats");
	string url;
	if (bowlingCooldown == -1)
	{
		string main_title = "Cosmic bowling ball usable";
		string [int] description;
		description.listAppend("Hit a strike! Knock the competition down a pin with your hole-y ball.");
		description.listAppend("Give yourself an item/meat buff, gain stats in a zone, or banish for the next " + HTMLGenerateSpanOfClass(bowlingCooldown2, "r_bold") + " combats.");
		
		resource_entries.listAppend(ChecklistEntryMake("__item cosmic bowling ball", "", ChecklistSubentryMake("Cosmic bowling ball banish", "", "Has " + HTMLGenerateSpanOfClass(bowlingCooldown2, "r_bold") + " duration and cooldown.")).ChecklistEntrySetCombinationTag("banish").ChecklistEntrySetIDTag("Cosmic bowling ball banish"));
		resource_entries.listAppend(ChecklistEntryMake("__item cosmic bowling ball", url, ChecklistSubentryMake("Cosmic bowling ball use available", "", description)).ChecklistEntrySetCombinationTag("special").ChecklistEntrySetIDTag("Cosmic bowling ball skills"));
	}
	if (bowlingCooldown > -1)
	{
		string main_title = HTMLGenerateSpanFont("" + bowlingCooldown, "red") + " combats until cosmic bowling ball returns";
		string [int] description;
		Banish banish_entry = BanishByName("Bowl a Curveball");
		int turns_left_of_banish = banish_entry.BanishTurnsLeft();
		if (turns_left_of_banish > 0)
		{
			description.listAppend("Currently used on " + banish_entry.banished_monster + " for " + pluralise(turns_left_of_banish, "more turn", "more turns") + ".");
		}
		if (bowlingCooldown == 0)
		{
			description.listAppend(HTMLGenerateSpanFont("You can bowl again next turn!", "blue"));
			description.listAppend("Next use has " + HTMLGenerateSpanOfClass(bowlingCooldown2, "r_bold") + " duration.");
			resource_entries.listAppend(ChecklistEntryMake("__item cosmic bowling ball", url, ChecklistSubentryMake("Cosmic bowling ball returns next combat", "", description), -11).ChecklistEntrySetCombinationTag("banish").ChecklistEntrySetIDTag("Cosmic bowling ball skills"));
			resource_entries.listAppend(ChecklistEntryMake("__item cosmic bowling ball", url, ChecklistSubentryMake(main_title, "", description)).ChecklistEntrySetCombinationTag("special").ChecklistEntrySetIDTag("Cosmic bowling ball skills"));
		}
		else
		{	
			description.listAppend("Bowling ball in the sky with your diamonds.");
			resource_entries.listAppend(ChecklistEntryMake("__item cosmic bowling ball", url, ChecklistSubentryMake(main_title, "", description)).ChecklistEntrySetCombinationTag("banish").ChecklistEntrySetIDTag("Cosmic bowling ball skills"));
			resource_entries.listAppend(ChecklistEntryMake("__effect trash-wrapped", url, ChecklistSubentryMake(main_title, "", description)).ChecklistEntrySetCombinationTag("special").ChecklistEntrySetIDTag("Cosmic bowling ball skills"));
		}
	}
}