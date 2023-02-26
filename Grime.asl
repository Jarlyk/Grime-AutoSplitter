state("GRIME") {}

startup {
    dynamic unity = Assembly.Load(File.ReadAllBytes(@"Components\asl-help")).CreateInstance("Unity");
	
	vars.gsfFlagNames = new List<string>();
	vars.gsfFlagValues = new List<int>();
	vars.gsfSettingNames = new List<string>();
	vars.gsfHasSplit = new List<string>();
	vars.started = false;
	vars.readyToSplit = false;
	vars.startTime = DateTime.UtcNow;
	vars._sh = null;
	
	var addGsfSplit = (Action<string, bool, string, string, string, int>)((settingName, defaultValue, caption, category, flagName, flagValue) => {
		//Multiple flags can bind to the same setting (for multi-language support on area triggers)
		//As such, only create the setting itself once
		if (!vars.gsfSettingNames.Contains(settingName)) {		
			settings.Add(settingName, defaultValue, caption, category);
		}
		vars.gsfFlagNames.Add(flagName);
		vars.gsfFlagValues.Add(flagValue);
		vars.gsfSettingNames.Add(settingName);
	});
	
	settings.Add("areas", true, "Area Entry");
	addGsfSplit("area_cavity", false, "Weeping Cavity", "areas", "Displayed Area: Weeping Cavity", 1);
	addGsfSplit("area_cavity", false, "Weeping Cavity", "areas", "Displayed Area: 哭泣腔体", 1);
	addGsfSplit("area_yrden", false, "Yr Den", "areas", "Displayed Area: Yr Den", 1);
	addGsfSplit("area_yrden", false, "Yr Den", "areas", "Displayed Area: 耶尔巢穴", 1);
	addGsfSplit("area_desert", false, "Unformed Desert", "areas", "Displayed Area: Unformed Desert", 1);
	addGsfSplit("area_desert", false, "Unformed Desert", "areas", "Displayed Area: 未成形沙漠", 1);
	addGsfSplit("area_gloomnest", false, "Gloomnest", "areas", "Displayed Area: Gloomnest", 1);
	addGsfSplit("area_gloomnest", false, "Gloomnest", "areas", "Displayed Area: 昏暗窝巢", 1);
	addGsfSplit("area_lithic", true, "Lithic", "areas", "Displayed Area: Lithic", 1);
	addGsfSplit("area_lithic", true, "Lithic", "areas", "Displayed Area: 石灵地", 1);
	addGsfSplit("area_worldpillar", false, "Worldpillar", "areas", "Displayed Area: Worldpillar", 1);
	addGsfSplit("area_worldpillar", false, "Worldpillar", "areas", "Displayed Area: 世界支柱", 1);
	addGsfSplit("area_nerveroot", true, "Nerveroot", "areas", "Displayed Area: Nerveroot", 1);
	addGsfSplit("area_nerveroot", true, "Nerveroot", "areas", "Displayed Area: 神经根", 1);
	addGsfSplit("area_feasters", true, "Feaster's Lair", "areas", "Displayed Area: Feaster's Lair", 1);
	addGsfSplit("area_feasters", true, "Feaster's Lair", "areas", "Displayed Area: 贪食者巢穴", 1);
	addGsfSplit("area_childbed", true, "Childbed", "areas", "Displayed Area: Childbed", 1);
	addGsfSplit("area_childbed", true, "Childbed", "areas", "Displayed Area: 子体温床", 1);
	addGsfSplit("area_servants", true, "Servant's Path", "areas", "Displayed Area: Servant's Path", 1);
	addGsfSplit("area_servants", true, "Servant's Path", "areas", "Displayed Area: 仆从路径", 1);
	addGsfSplit("area_palace", true, "Carven Palace", "areas", "Displayed Area: Carven Palace", 1);
	addGsfSplit("area_palace", true, "Carven Palace", "areas", "Displayed Area: 刻形者宫殿", 1);
	addGsfSplit("area_beyond", true, "Beyond the Barrier", "areas", "Displayed Area: Beyond the Barrier", 1);
	addGsfSplit("area_beyond", true, "Beyond the Barrier", "areas", "Displayed Area: 屏障之外", 1);
	addGsfSplit("area_city", true, "Cenotaph City", "areas", "Displayed Area: Cenotaph City", 1);
	addGsfSplit("area_city", true, "Cenotaph City", "areas", "Displayed Area: 纪念碑城", 1);
	addGsfSplit("area_palesky", true, "Pale Sky", "areas", "Displayed Area: Pale Sky", 1);
	addGsfSplit("area_palesky", true, "Pale Sky", "areas", "Displayed Area: 苍白天空", 1);
	addGsfSplit("area_peakcreation", false, "Peak of Creation", "areas", "Displayed Area: Peak of Creation", 1);
	addGsfSplit("area_peakcreation", false, "Peak of Creation", "areas", "Displayed Area: 创作高峰", 1);
	addGsfSplit("area_garden", false, "Garden", "areas", "Displayed Area: Garden", 1);
	addGsfSplit("area_garden", false, "Garden", "areas", "Displayed Area: 花园", 1);

	settings.Add("bosses", true, "Bosses");
	addGsfSplit("boss_amalgam", true, "Amalgam", "bosses", "GSF Boss Amal", 2);
	addGsfSplit("boss_amalgam", true, "Amalgam", "bosses", "GSF Boss Amal", 3);
	addGsfSplit("boss_mothers", true, "Mothers", "bosses", "GSF Boss Whisper", 3);
	addGsfSplit("boss_vulture", true, "Vulture", "bosses", "GSF_Vulture", 1);
	addGsfSplit("boss_fidus", true, "Fidus", "bosses", "GSF Boss Fidus", 2);
	addGsfSplit("boss_tfp", true, "The Final Performance", "bosses", "GSF Boss Performer", 1);
	addGsfSplit("boss_shidra", true, "Shidra", "bosses", "GSF Shidra Fight", 2);
	addGsfSplit("boss_shidra", true, "Shidra", "bosses", "GSF Shidra Fight", 3);
	addGsfSplit("boss_flowervulture", false, "Surrogate Vulture", "bosses", "GSF Boss Flower Vulture", 1);
	addGsfSplit("boss_flowerheart", false, "Flowerheart", "bosses", "GSF Boss Flowerheart", 1);
	addGsfSplit("boss_flowergiant", false, "Giant of Eyes", "bosses", "GSF Boss Flower Rockgiant", 2);
	addGsfSplit("boss_misbegotten", false, "Misbegotten Amalgam", "bosses", "GSF Boss Amal", 3);
	
	settings.Add("minis", false, "Minibosses");
	//addGsfSplit("boss_goldwarrior", false, "Desert Watcher", "minis", "", 3);
	addGsfSplit("boss_rockgiant", false, "Grieving Rockgiant", "minis", "GSF Stuck Rockgiant Ready", 2);
	addGsfSplit("boss_acolyte", false, "Artisan of Flesh", "minis", "GSF_Palace Acolyte", 1);
	
	settings.Add("events", false, "Events");
	addGsfSplit("event_shidra1", false, "Shidra Intro", "events", "GSF_Collecter_ShidraDiscovered", 1);
	addGsfSplit("event_shidra2", false, "Shidra Yolk", "events", "GSF ShidraHasEgg", 1);
	addGsfSplit("event_shidra3", false, "Strand Pickup", "events", "GSF NGP Collection Status", 2);	
	addGsfSplit("event_shidra4", false, "Shidra Fight Start", "events", "GSF Shidra Fight", 1);
	
	settings.Add("endings", true, "Endings");
	addGsfSplit("ending_kinship", true, "Kinship", "endings", "GSF KinshipEndingActivated", 1);
	//addGsfSplit("ending_weakness", false, "Weakness", "endings", "To Apply Ending Weakness", 1);
}

init {
    vars.Helper.TryLoad = (Func<dynamic, bool>)(helper =>
    {
        vars._mm = helper["AD_Scripts", "MainMenuHandler"];
		vars.Manager = helper;
        return true;
    });
	
	vars.printBytes = (Action<byte[]>)(bytes => {
		var builder = new StringBuilder();
		int k = 0;
		foreach (var b in bytes) {
			builder.Append(b.ToString("X2"));
			k++;
			if ((k & 0x7) == 0)
				builder.Append(' ');
		}
		print(builder.ToString());
	});
	
	vars.readStrIntDict = (Func<IntPtr, Dictionary<string, int>>)(p => {
		var entriesPtr = vars.Helper.Read<IntPtr>(p + 24);
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
	
	vars.hasUpdated = false;
}

update {
	current.startingGame = false;
	current.count_greatPreyConsumed = 0;
	vars.globalFlags = null;
	
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
					var dictPtr = vars.Helper.Read<IntPtr>(gdPtr + gd["globalFlags"]);
					vars.globalFlags = vars.readStrIntDict(dictPtr);
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
	
	if (vars.globalFlags != null) {
		int n = vars.gsfSettingNames.Count;
		for (int i=0; i < n; i++) {
			var name = vars.gsfSettingNames[i];
			if (settings[name] && !vars.gsfHasSplit.Contains(name)) {
				var flagName = vars.gsfFlagNames[i];
				var flagValue = vars.gsfFlagValues[i];
				int value;
				if (vars.globalFlags.TryGetValue(flagName, out value) && value == flagValue) {
					vars.gsfHasSplit.Add(name);
					return true;
				}			
			}
		}
	}
	
    return false;
}

isLoading {
	return false;
}

onReset {
	vars.gsfHasSplit.Clear();
	vars.hasUpdated = false;
	vars.started = false;
	vars.readyToSplit = false;
}