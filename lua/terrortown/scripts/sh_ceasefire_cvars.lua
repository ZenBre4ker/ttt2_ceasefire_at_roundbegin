--make sure that the convarutil.lua exists that adds all convars
if SERVER then
	AddCSLuaFile()
	if file.Exists("terrortown/scripts/sh_convarutil_local.lua", "LUA") then
		AddCSLuaFile("terrortown/scripts/sh_convarutil_local.lua")
	end
end

if file.Exists("terrortown/scripts/sh_convarutil_local.lua", "LUA") then
	include("terrortown/scripts/sh_convarutil_local.lua")
-- Must run before hook.Add
	local shortNameOfAddon = "Ceasefire"
	local longNameOfAddon = "Ceasefire at Roundbegin"

	local cg = ConvarGroup(shortNameOfAddon, longNameOfAddon)

	--Convar(ConvarGroup cg , Bool TTT2-Only, String ttt_Addon_Modifier, Bool/Int/Float DefaultValue, Table{} FCVAR_Flags, String Modifier Description, String Datatype ("bool","int","float"), Bool/Int/Float MinValue, Bool/Int/Float MaxValue, Int Decimalpoints)
	--Example:
	--Convar(cg, false, "ttt_asm_shift_speed_modifier", 2, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Movement speed multiplier during the aiming sequence", "float", 0.01, 8, 2)

	Convar(cg, false, "ttt_ceasefire", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Should there be a Ceasefire at Roundbegin?", "bool", 0, 1, 0)
	Convar(cg, false, "ttt_ceasefire_duration", 30, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "How long the duration of the Ceasefire at Roundbegin should be?", "int", 3, 60, 0)
	Convar(cg, false, "ttt_ceasefire_allowFallDamage", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Should Fall Damage be allowed during Ceasefire?", "bool", 0, 1, 0)
	Convar(cg, false, "ttt_ceasefire_allowDrowning", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Should Drowning be allowed during Ceasefire?", "bool", 0, 1, 0)
	Convar(cg, false, "ttt_ceasefire_allowFireDamage", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Should Fire Damage be allowed during Ceasefire?", "bool", 0, 1, 0)
	Convar(cg, false, "ttt_ceasefire_allowPropDamage", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Should Prop Damage be allowed during Ceasefire?", "bool", 0, 1, 0)
	Convar(cg, false, "ttt_ceasefire_allowExplosionDamage", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Should Explosion Damage be allowed during Ceasefire?", "bool", 0, 1, 0)
--

print(shortNameOfAddon .. " Convars are created.")

end
