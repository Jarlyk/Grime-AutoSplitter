state("GRIME") {}

startup {
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");

	vars.gsfData = new List<dynamic>();
	vars.gsfHasSplit = new HashSet<string>();

	var hasCreated = new HashSet<string>();
	Action<string, bool, string, string, string, int> addGsfSplit = (id, state, label, parent, flagName, flagValue) => {
		// Multiple flags can bind to the same setting (for multi-language support on area triggers)
		// As such, only create the setting itself once
		if (hasCreated.Add(id)) {
			settings.Add(id, state, label, parent);
		}

		vars.gsfData.Add(new {
			SettingName = id,
			FlagName = flagName,
			FlagValue = flagValue
		});
	};

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
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono => {
		Thread.Sleep(3000);

		var mmh = mono["AD_Scripts", "MainMenuHandler"];
		vars.Helper["startingGame"] = mono.Make<bool>(mmh, "instance", "startingGame");

		vars._sh = mono["AD_Scripts", "SyncHandler"];
		vars.mono = mono;

		return true;
	});

	vars.readStrIntDict = (Func<IntPtr, Dictionary<string, int>>)(ptr => {
		var dict = new Dictionary<string, int>();
		if (ptr == IntPtr.Zero)
			return dict;

		var count = vars.Helper.Read<IntPtr>(ptr + 0x40);
		if (count <= 0)
			return dict;

		var entries = vars.Helper.Read<IntPtr>(ptr + 0x18);
		for (int i = 0; i < count; i++) {
			var entry = entries + 0x20 + 0x18 * i;

			var key = vars.Helper.ReadString(entry + 0x8);
			if (string.IsNullOrEmpty(key))
				continue;

			var value = vars.Helper.Read<int>(entry + 0x10);
			dict[key] = value;
		}

		return dict;
	});

	old.startingGame = false;
	vars.foundSh = false;
	vars.globalFlags = null;
}

update {
	if (vars.foundSh) {
		vars.globalFlags = vars.readStrIntDict(current.globalFlagsPtr);
		return;
	}

	if (vars._sh.Static == IntPtr.Zero)
		return;

	vars.Helper["globalFlagsPtr"] = vars.Mono.Make<IntPtr>(vars._sh, "instance", "generalData", "globalFlags");
	vars.foundSh = true;
}

start {
	return !old.startingGame && current.startingGame;
}

split {
	if (vars.globalFlags == null)
		return;

	var n = vars.gsfSettingNames.Count;
	for (int i = 0; i < n; i++) {
		var data = vars.gsfData[i];
		var name = data.SettingName;

		if (!settings[name] || vars.gsfHasSplit.Contains(name))
			continue;

		var flagName = data.FlagName;
		var flagValue = data.FlagValue;

		int value;
		if (vars.globalFlags.TryGetValue(flagName, out value) && value == flagValue) {
			vars.gsfHasSplit.Add(name);
			return true;
		}
	}
}

onReset {
	vars.gsfHasSplit.Clear();
}
