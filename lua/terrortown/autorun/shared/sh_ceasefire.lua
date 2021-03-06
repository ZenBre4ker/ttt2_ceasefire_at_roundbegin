if SERVER then
	AddCSLuaFile()
end

if file.Exists("terrortown/scripts/sh_ceasefire_cvars.lua", "LUA") then
	include("terrortown/scripts/sh_ceasefire_cvars.lua", "LUA")
end

local ceasefire = GetConVar("ttt_ceasefire")
local ceasefireTime = GetConVar("ttt_ceasefire_duration")

local allowFallDamage = GetConVar("ttt_ceasefire_allowFallDamage")
local allowDrowning = GetConVar("ttt_ceasefire_allowDrowning")
local allowFireDamage = GetConVar("ttt_ceasefire_allowFireDamage")
local allowPropDamage = GetConVar("ttt_ceasefire_allowPropDamage")
local allowExplosionDamage = GetConVar("ttt_ceasefire_allowExplosionDamage")

local ceasefireTimer = 0

hook.Add("TTTBeginRound", "ceasefire_tttbeginround", function()
	if not ceasefire:GetBool() then return end

	ceasefireTimer = CurTime() + ceasefireTime:GetInt()
	EPOP:AddMessage({
				text = "Ceasefire is on for " .. ceasefireTime:GetInt() .. " seconds.",
				color = COLOR_ORANGE
				},
				"You can't damage each other!",
				math.min(5, ceasefireTime:GetInt()),
				nil,
				true
			)
	timer.Create("ceasefire_timer_over", ceasefireTime:GetInt(), 1, function()
		EPOP:AddMessage({
					text = "Ceasefire is now over.",
					color = COLOR_RED
					},
					nil,
					3,
					nil,
					true
				)
	end)
end)

hook.Add("PlayerTakeDamage", "ceasefire_playertakedamage" , function(ply, inflictor, att, dmg, dmginfo)
	if not ceasefire:GetBool() then return end

	if dmg > 0 and CurTime() <= ceasefireTimer
		and not (
			allowFallDamage:GetBool() and dmginfo:IsFallDamage()
			or allowFireDamage:GetBool() and dmginfo:IsDamageType(DMG_BURN)
			or allowDrowning:GetBool() and dmginfo:IsDamageType(DMG_DROWN)
			or allowPropDamage:GetBool() and dmginfo:IsDamageType(DMG_CRUSH)
			or allowExplosionDamage:GetBool() and dmginfo:IsExplosionDamage()
		)
	then
		dmginfo:ScaleDamage(0)
		dmginfo:SetDamage(0)
	end
end)

hook.Add("TTTEndRound", "ceasefire_tttendround", function()
	if not ceasefire:GetBool() then return end

	ceasefireTimer = CurTime() - 0.1

	timer.Remove("ceasefire_timer_over")
end)