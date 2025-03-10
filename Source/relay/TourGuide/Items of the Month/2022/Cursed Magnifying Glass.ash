//2022: cursed magnifying glass
RegisterTaskGenerationFunction("IOTYCursedMagnifyingGlassGenerateTasks");
void IOTYCursedMagnifyingGlassGenerateTasks(ChecklistEntry [int] task_entries, ChecklistEntry [int] optional_task_entries, ChecklistEntry [int] future_task_entries)
{
	if (lookupItem("cursed magnifying glass").available_amount() == 0) return;
	
	int free_void_fights_left = clampi(5 - get_property_int("_voidFreeFights"), 0, 5);
	int cursedGlassCounter = get_property_int("cursedMagnifyingGlassCount");
	string url;
	string [int] description;
	{
		if (cursedGlassCounter < 12)
		{
            url = invSearch("cursed magnifying glass");
			description.listAppend((13 - cursedGlassCounter).pluralise("combat", "combats") + " until next void fight.");
			optional_task_entries.listAppend(ChecklistEntryMake("__item cursed magnifying glass", url, ChecklistSubentryMake("Cursed magnifying glass combat", "", description), 8));
        }	
		
		if (cursedGlassCounter == 12)
		{
            if (lookupItem("cursed magnifying glass").equipped_amount() == 0) {
            description.listAppend(HTMLGenerateSpanFont("Equip the cursed magnifying glass", "red"));
            url = invSearch("cursed magnifying glass");
			} 
			description.listAppend(HTMLGenerateSpanFont("One more fight until you encounter a void.", "blue"));
			task_entries.listAppend(ChecklistEntryMake("__item void stone", url, ChecklistSubentryMake("Cursed magnifying glass combat", "", description), -11));
        }	
	
		if (cursedGlassCounter == 13)
        {
            if (lookupItem("cursed magnifying glass").equipped_amount() == 0) {
            description.listAppend(HTMLGenerateSpanFont("Equip the cursed magnifying glass", "red"));
            url = invSearch("cursed magnifying glass");
			}  
			description.listAppend(HTMLGenerateSpanFont("Void combat next adventure", "red"));
			task_entries.listAppend(ChecklistEntryMake("__item void stone", url, ChecklistSubentryMake("Cursed magnifying glass combat", "", description), -11));
        }
		if (free_void_fights_left > 0)
		{
            description.listAppend("" + free_void_fights_left + " free void fights remaining.");
        }	
		else
		{
		    description.listAppend("No free void fights remaining, but you can replace them with lobsterfrogmen or something.");
		}
	}	
}