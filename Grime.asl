state("GRIME") {}

startup {
    
    refreshRate = 15;

    vars.debugPrint = false;

    dynamic unity = Assembly.Load(File.ReadAllBytes(@"Components\asl-help")).CreateInstance("Unity");
    
	vars.started = false;
	vars.readyToSplit = false;
	vars.startTime = DateTime.UtcNow;
	vars._sh = null;
    vars.debugPrinted = !vars.debugPrint;

    vars.indexOfName = 0;
    vars.indexOfDefaultOn = 1;
    vars.indexOfCaption = 2;
    vars.indexOfFlagName = 3;
    vars.indexOfFlagValue = 4;
    vars.indexOfIsSplit = 5;
    
    var addSplits = (Action<object[,], string>)((splits, category) => {
        int nrOfSplitsAdded = 0;
		for (int i = 0; i <= splits.GetUpperBound(0); i++) {
			settings.Add((string)splits[i, vars.indexOfName], (bool)splits[i, vars.indexOfDefaultOn], (string)splits[i, vars.indexOfCaption], category);
            nrOfSplitsAdded++;
		}
        if (vars.debugPrint) print("+++++ " + nrOfSplitsAdded + " splits added to category '" + category + "'"); 
	});
    
    //Areas
    vars.categoryArea = "areas";
	settings.Add(vars.categoryArea, true, "Area");
	settings.SetToolTip(vars.categoryArea, "splits when the area is entered for the first time");
    vars.areas = new object[,] {
        {"area_cavity", false, "Weeping Cavity", "AreaTitle/Weeping Cavity", 0, false},
        {"area_yrden", false, "Yr Den", "AreaTitle/Warrior Den", 0, false},
        {"area_desert", false, "Unformed Desert", "AreaTitle/Unformed Desert", 0, false},
        {"area_gloomnest", false, "Gloomnest", "AreaTitle/Nest", 0, false},
        {"area_lithic", true, "Lithic", "AreaTitle/Lithic", 0, false},
        {"area_worldpillar", false, "Worldpillar", "AreaTitle/Worldpillar", 0, false},
        {"area_nerveroot", true, "Nerveroot", "AreaTitle/Nerveroot", 0, false},
        {"area_feasters", true, "Feaster's Lair", "AreaTitle/Lair", 0, false},
        {"area_childbed", true, "Childbed", "AreaTitle/Childbed", 0, false},
        {"area_servants", true, "Servant's Path", "AreaTitle/Servant's Path", 0, false},
        {"area_palace", true, "Carven Palace", "AreaTitle/Carven Palace", 0, false},
        {"area_beyond", true, "Beyond the Barrier", "AreaTitle/Beyond the Barrier", 0, false},
        {"area_city", true, "Cenotaph City", "AreaTitle/Cenotaph City", 0, false},
        {"area_palesky", true, "Pale Sky", "AreaTitle/Pale Sky", 0, false},
        {"area_peakcreation", false, "Peak of Creation", "AreaTitle/Peak Of Creation", 0, false},
        {"area_garden", false, "Garden", "AreaTitle/Garden", 0, false}
    };
    addSplits(vars.areas, vars.categoryArea);
	
    //Surrogates
    vars.categorySurrogate = "surrogates";
	settings.Add(vars.categorySurrogate, false, "Surrogate");
	settings.SetToolTip(vars.categorySurrogate, "splits when the surrogate is activated");
    vars.surrogates = new object[,] {
        {"surrogate_cavity_depths", false, "Weeping Cavity - Depths", "AreaTitle/Checkpoint/Weeping Cavity - Depths", 0, false},
        {"surrogate_cavity_tearfalls", false, "Weeping Cavity - Tearfalls", "AreaTitle/Checkpoint/Weeping Cavity - Tearfalls", 0, false},
        {"surrogate_desert_mountain", false, "Unformed Desert - Mountainside", "AreaTitle/Checkpoint/Unformed Desert - Mountainside", 0, false},
        {"surrogate_desert_shell", false, "Unformed Desert - Head Shell", "AreaTitle/Checkpoint/Unformed Desert - Head Shell", 0, false},
        {"surrogate_gloomnest", false, "Gloomnest", "AreaTitle/Checkpoint/Nest", 0, false},
        {"surrogate_lithic_upper", false, "Lithic - Upper", "AreaTitle/Checkpoint/Lithic - Upper", 0, false},
        {"surrogate_lithic_lower", false, "Lithic - Lower", "AreaTitle/Checkpoint/Lithic - Lower", 0, false},
        {"surrogate_lithic_lift", false, "Lithic - Carven Lift", "AreaTitle/Checkpoint/Lithic - Carven Lift", 0, false},
        {"surrogate_worldpillar", false, "Worldpillar - Shidra", "AreaTitle/Checkpoint/Worldpillar - Shidra", 0, false},
        {"surrogate_nerveroot", false, "Nerveroot", "AreaTitle/Checkpoint/Nerveroot", 0, false},
        {"surrogate_feasters_bones", false, "Feaster's Lair - Sunken Bones", "AreaTitle/Checkpoint/Feaster's Lair - Sunken Bones", 0, false},
        {"surrogate_feasters_maulers", false, "Feaster's Lair - Maulers", "AreaTitle/Checkpoint/Feaster's Lair - Maulers", 0, false},
        {"surrogate_feasters_acid", false, "Feaster's Lair - Acid Weeper", "AreaTitle/Checkpoint/Feaster's Lair - Acid Weeper", 0, false},
        {"surrogate_servants_path", false, "Servant's Path", "AreaTitle/Checkpoint/Servant's Path", 0, false},
        {"surrogate_palace_entrance", false, "Carven Palace - Entrance", "AreaTitle/Checkpoint/Carven Palace - Entrance", 0, false},
        {"surrogate_palace_shapely", false, "Carven Palace - The Shapely", "AreaTitle/Checkpoint/Carven Palace - The Shapely", 0, false},
        {"surrogate_garden_strands", false, "Garden - Hair Strands", "AreaTitle/Checkpoint/Lonolad Garden - Hair Strands", 0, false},
        {"surrogate_garden_trees", false, "Garden - Thirsting Trees", "AreaTitle/Checkpoint/Lonolad Garden - Thirsting Trees", 0, false},
        {"surrogate_childbed_giant", false, "Childbed - Enveloping Petals", "AreaTitle/Checkpoint/Childbed - Giant", 0, false},
        {"surrogate_childbed_vulture", false, "Childbed - The Dream Fog", "AreaTitle/Checkpoint/Childbed - Vulture", 0, false},
        {"surrogate_barrier", false, "Beyond The Barrier", "AreaTitle/Checkpoint/Beyond The Barrier", 0, false},
        {"surrogate_city", false, "Cenotaph City", "AreaTitle/Checkpoint/Cenotaph City", 0, false},
        {"surrogate_sky_entrance", false, "Pale Sky - Ingress", "AreaTitle/Checkpoint/Pale Sky - Entrance", 0, false},
        {"surrogate_sky_exit", false, "Pale Sky - Egress", "AreaTitle/Checkpoint/Pale Sky - Exit", 0, false},
        {"surrogate_between_skies", false, "Worldpillar - Between Two Skies", "AreaTitle/Checkpoint/Worldpillar - Between two skies", 0, false},
        {"surrogate_peak", false, "Peak Of Creation", "AreaTitle/Checkpoint/Peak Of Creation", 0, false}
    };
    addSplits(vars.surrogates, vars.categorySurrogate);

    //Nervepasses
    vars.categoryNervepass = "nervepasses";
	settings.Add(vars.categoryNervepass, false, "Nervepass");
	settings.SetToolTip(vars.categoryNervepass, "splits when the nervepass is opened");
    vars.nervepasses = new object[,] {
        {"nervepass_desert", false, "Unformed Desert", "GSF_Nervepass_Desert", 1, false},
        {"nervepass_lithic", false, "Lithic", "GSF_Nervepass_Lithic", 1, false},
        {"nervepass_worldpillar", false, "Worldpillar", "GSF_Nervepass_Hub", 1, false},
        {"nervepass_feasters", false, "Feaster's Lair", "GSF_Nervepass_Lair", 1, false},
        {"nervepass_gloomnest", false, "Gloomnest", "GSF_Nervepass_Nest", 1, false},
        {"nervepass_palace", false, "Carven Palace", "GSF_Nervepass_Palace", 1, false},
        {"nervepass_garden", false, "Garden", "GSF_Nervepass_Garden", 1, false},
        {"nervepass_city", false, "Cenotaph City", "GSF_Nervepass_City", 1, false}
    };
    addSplits(vars.nervepasses, vars.categoryNervepass);

    //Bosses
    vars.categoryBoss = "bosses";
	settings.Add(vars.categoryBoss, true, "Boss");
	settings.SetToolTip(vars.categoryBoss, "splits when the boss is defeated");
    vars.bosses = new object[,] {
        {"boss_amalgam", true, "Amalgam", "GSF Boss Amal", 2, false},
        {"boss_mothers", true, "Mothers", "GSF Boss Whisper", 3, false},
        {"boss_vulture", true, "Vulture", "GSF_Vulture", 1, false},
        {"boss_fidus", true, "Fidus", "GSF Boss Fidus", 2, false},
        {"boss_tfp", true, "The Final Performance", "GSF Boss Performer", 1, false},
        {"boss_shidra", true, "Shidra", "GSF Shidra Fight", 2, false},
        {"boss_flowervulture", false, "Surrogate Vulture", "GSF Boss Flower Vulture", 1, false},
        {"boss_flowerheart", false, "Flowerheart", "GSF Boss Flowerheart", 1, false},
        {"boss_flowergiant", false, "Giant of Eyes", "GSF Boss Flower Rockgiant", 2, false},
        {"boss_misbegotten", false, "Misbegotten Amalgam", "GSF Boss Amal", 3, false}
    };
    addSplits(vars.bosses, vars.categoryBoss);

    //Minibosses
    vars.categoryMiniboss = "mini_bosses";
	settings.Add(vars.categoryMiniboss, false, "Miniboss");
	settings.SetToolTip(vars.categoryMiniboss, "splits when the miniboss is defeated");
    vars.minibosses = new object[,] {
        {"mini_boss_rockgiant", false, "Rockgiant", "Miniboss Dead: Rockgiant", 0, false},
        {"mini_boss_desert_watcher", false, "Desert Watcher", "Miniboss Dead: Desert Watcher", 0, false},
        {"mini_boss_jawstag", false, "Jawstag", "Miniboss Dead: Jawstag", 0, false},
        {"mini_boss_grieving_rockgiant", false, "Grieving Rockgiant", "Miniboss Dead: Grieving Rockgiant", 0, false},
        {"mini_boss_jawcrab", false, "Jawcrab", "Miniboss Dead: Jawcrab", 0, false},
        {"mini_boss_artisan", false, "Artisan of Flesh", "Miniboss Dead: Artisan of Flesh", 0, false}
    };
    addSplits(vars.minibosses, vars.categoryMiniboss);

    //Objectives
    vars.categoryObjective = "events";
	settings.Add(vars.categoryObjective, false, "Objective");
	settings.SetToolTip(vars.categoryObjective, "splits when the objective is reached");
    vars.objectives = new object[,] {
        {"event_shidra1", false, "talk to Shidra", "GSF_Collecter_ShidraDiscovered", 1, false},
        {"event_shidra2", false, "give Kilyahstone to Shidra", "GSF ShidraHasEgg", 1, false},
        {"event_shidra3", false, "pick up Strand of Child", "GSF NGP Collection Status", 2, false},
        {"event_unsealer", false, "get Unsealer from Shidra", "GSF_City Barrier", 1, false},
        {"event_shidra4", false, "fight Shidra", "GSF Shidra Fight", 1, false}
    };
    addSplits(vars.objectives, vars.categoryObjective);

    //Endings
    vars.categoryEnding = "endings";
	settings.Add(vars.categoryEnding, true, "Ending");
	settings.SetToolTip(vars.categoryEnding, "splits when the ending is reached");
    vars.endings = new object[,] {
        {"ending_kinship", false, "Kinship", "GSF KinshipEndingActivated", 1, false}
    };
    addSplits(vars.endings, vars.categoryEnding);
    
}

init {
    vars.Helper.TryLoad = (Func<dynamic, bool>)(helper =>
    {
        vars._mm = helper["AD_Scripts", "MainMenuHandler"];
		vars.Manager = helper;
        return true;
    });

	vars.readStrIntDict = (Func<IntPtr, Dictionary<string, int>>)(p => {
        var basePtr = vars.Helper.Read<IntPtr>(p);
		var entriesPtr = vars.Helper.Read<IntPtr>(basePtr + 24);
		var count = vars.Helper.Read<int>(entriesPtr + 24);
		if (count <= 0) return null;

		var result = new Dictionary<string, int>(count);
		for (int i=0; i < count; i++) {
			var keyPtr = entriesPtr + 32 + i*24 + 8;
			if (keyPtr != IntPtr.Zero) {
				var valPtr = entriesPtr + 32 + i*24 + 16;
				var key = vars.Helper.ReadString(keyPtr);
				var value = vars.Helper.Read<int>(valPtr);
				if (key != null) {
					result.Add(key, value);
				}
			}
		}
		return result;
	});
    
	vars.readStrList = (Func<IntPtr, List<string>>)(p => {
        var derefPtr = vars.Helper.Read<IntPtr>(p);
		var count = vars.Helper.Read<int>(derefPtr + 24);
		if (count <= 0) return null;
		var itemsPtr = vars.Helper.Read<IntPtr>(derefPtr + 16);
		var result = new List<string>(count);
		for (int i = 0; i < count; i++) {
			var itemPtr = itemsPtr + 32 + (i * 8);
			if (itemPtr != IntPtr.Zero) {
				var itemValue = vars.Helper.ReadString(itemPtr);
				if (itemValue != null) {
					result.Add(itemValue);
				}
			}
		}
		return result;
	});

	vars.hasUpdated = false;
}

update {
	current.startingGame = false;
	current.count_greatPreyConsumed = 0;
	vars.globalFlags = null;
    vars.mapMarkers = null;
    vars.visitedAreas = null;
    vars.unlockedCheckpoints = null;
	
	var mm = vars._mm;
	if (mm.Static != IntPtr.Zero) {
		var mmPtr = mm.Static + mm["instance"];
		if (mmPtr != IntPtr.Zero) {
			current.startingGame = vars.Helper.Read<bool>(mmPtr, mm["startingGame"]);
		}
	}
	
	if (vars.readyToSplit) {
		var sh = vars._sh;
		var gd = vars._gd;
		if (sh.Static != IntPtr.Zero && gd.Static != IntPtr.Zero)	{
			var shPtr = vars.Helper.Read<IntPtr>(sh.Static + sh["instance"]);
			if (shPtr != IntPtr.Zero) {
				var gdPtr = vars.Helper.Read<IntPtr>(shPtr + sh["generalData"]);
				if (gdPtr != IntPtr.Zero) {
					vars.globalFlags = vars.readStrIntDict(gdPtr + gd["globalFlags"]);
					vars.mapMarkers = vars.readStrIntDict(gdPtr + gd["mapData_markers"]);
                    vars.visitedAreas = vars.readStrList(gdPtr + gd["visitedAreaNameTerms"]);
                    vars.unlockedCheckpoints = vars.readStrList(gdPtr + gd["unlockedCheckpoints"]);
                    if (!vars.debugPrinted) {
                        if (vars.globalFlags != null) {
                            foreach (string globalFlag in vars.globalFlags.Keys) {
                                print("+++++ globalFlag '" + globalFlag + "' = " + vars.globalFlags[globalFlag]);
                            }
                        }
                        if (vars.mapMarkers != null) {
                            foreach (string mapMarker in vars.mapMarkers.Keys) {
                                print("+++++ mapMarker '" + mapMarker + "'");
                            }
                        }
                        if (vars.visitedAreas != null) {
                            foreach (string visitedArea in vars.visitedAreas) {
                                print("+++++ visitedArea '" + visitedArea + "'");
                            }
                        }
                        if (vars.unlockedCheckpoints != null) {
                            foreach (string unlockedCheckpoint in vars.unlockedCheckpoints) {
                                print("+++++ unlockedCheckpoint '" + unlockedCheckpoint + "'");
                            }
                        }
                        vars.debugPrinted = true;
                    }
 				}
			}
		}
	}
	
	//Delay connecting to gameplay scene data until the game has fully loaded
	//Currently we use a timer for this purpose, but there might be a better way
	if (!vars.readyToSplit && vars.started && (DateTime.UtcNow - vars.startTime).TotalSeconds >= 10) {
		if (vars._sh == null) {
			vars._sh = vars.Manager["AD_Scripts", "SyncHandler"];
			vars._gd = vars.Manager["AD_Scripts", "GeneralData"];
		}
	
		vars.readyToSplit = true;
	}
	
	vars.hasUpdated = true;
}

start {
	if (!vars.hasUpdated) return false;
	return current.startingGame && !old.startingGame;
}

onStart {
	vars.started = true;
	vars.startTime = DateTime.UtcNow;
}

split {
	if (!vars.hasUpdated) return false;
	if (!vars.started) return false;
	
	//Delay splitting until game has fully loaded
	if (!vars.readyToSplit) return false;

    var checkSplits = (Func<string, object[,], List<string>, bool>) ((category, splits, flags) => {
        if (flags != null && settings[category]) {
            for (int i = 0; i <= splits.GetUpperBound(0); i++) {
                if (!settings[(string)splits[i, vars.indexOfName]] || (bool)splits[i, vars.indexOfIsSplit]) {
                    continue;
                }
                string flagName = (string)splits[i, vars.indexOfFlagName];
                if (flags.Contains(flagName)) {
                    if (vars.debugPrint) print("+++++ splitting for '" + flagName + "'");
                    splits[i, vars.indexOfIsSplit] = true;
                    return true;
                }
            }
        }
        return false;
    });

    var checkSplitsWithValues = (Func<string, object[,], Dictionary<string, int>, bool, bool>) ((category, splits, flags, ignoreValues) => {
        if (flags != null && settings[category]) {
            for (int i = 0; i <= splits.GetUpperBound(0); i++) {
                if (!settings[(string)splits[i, vars.indexOfName]] || (bool)splits[i, vars.indexOfIsSplit]) {
                    continue;
                }
                string flagName = (string)splits[i, vars.indexOfFlagName];
                int flagValue = (int)splits[i, vars.indexOfFlagValue];
                if (flags.ContainsKey(flagName) && (ignoreValues || (flags[flagName] == flagValue))) {
                    if (vars.debugPrint) print("+++++ splitting for '" + flagName + "'" + (ignoreValues ? "" : " = " + flagValue));
                    splits[i, vars.indexOfIsSplit] = true;
                    return true;
                }
            }
        }
        return false;
    });
    
    if (checkSplits(vars.categoryArea, vars.areas, vars.visitedAreas)) return true;
    if (checkSplits(vars.categorySurrogate, vars.surrogates, vars.unlockedCheckpoints)) return true;
    if (checkSplitsWithValues(vars.categoryNervepass, vars.nervepasses, vars.globalFlags, false)) return true;
    if (checkSplitsWithValues(vars.categoryBoss, vars.bosses, vars.globalFlags, false)) return true;
    if (checkSplitsWithValues(vars.categoryMiniboss, vars.minibosses, vars.mapMarkers, true)) return true;
    if (checkSplitsWithValues(vars.categoryObjective, vars.objectives, vars.globalFlags, false)) return true;
    if (checkSplitsWithValues(vars.categoryEnding, vars.endings, vars.globalFlags, false)) return true;

    return false;
}

isLoading {
	return false;
}

onReset {
    var resetSplits = (Action<object[,], string>)((splits, category) => {
        int nrOfSplitsReset = 0;
		for (int i = 0; i <= splits.GetUpperBound(0); i++) {
            if ((bool)splits[i, vars.indexOfIsSplit]) nrOfSplitsReset++;
			splits[i, vars.indexOfIsSplit] = false;
		}
        if (vars.debugPrint) print("+++++ reset " + nrOfSplitsReset + " splits in category '" + category + "'"); 
	});

    resetSplits(vars.areas, vars.categoryArea);
    resetSplits(vars.surrogates, vars.categorySurrogate);
    resetSplits(vars.nervepasses, vars.categoryNervepass);
    resetSplits(vars.bosses, vars.categoryBoss);
    resetSplits(vars.minibosses, vars.categoryMiniboss);
    resetSplits(vars.objectives, vars.categoryObjective);
    resetSplits(vars.endings, vars.categoryEnding);
    
	vars.hasUpdated = false;
	vars.started = false;
	vars.readyToSplit = false;
    vars.debugPrinted = !vars.debugPrint;
}
