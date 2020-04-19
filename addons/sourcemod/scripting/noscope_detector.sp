#pragma semicolon 1
#pragma newdecls required

#include <multicolors>

public Plugin myinfo = 
{
	name		= "No-Scope Detector",
	author		= "WhiteCrow from -=XymenGaming=-",
	description	= "Print Message To Chat when someone noscopes",
	version		= "1.0",
	url			= "https://github.com/Ishaan-Kumar/csgo-plugin-noscope-detector"
}


public void OnPluginStart()
{
	if(GetEngineVersion() != Engine_CSGO && GetEngineVersion() != Engine_CSS) SetFailState("Plugin supports CSS and CS:GO only.");
	HookEvent("player_death", OnPlayerDeath);
}

public void OnPlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int attacker = GetClientOfUserId(event.GetInt("attacker"));
	if(!(0 < attacker <= MaxClients && IsClientInGame(attacker))) return;
	char weapon[16];
	event.GetString("weapon", weapon, sizeof(weapon));
	if((StrContains(weapon, "awp") != -1 || StrContains(weapon,"g3sg1") != -1 || StrContains(weapon, "ssg08") != -1 || StrContains(weapon, "scout") != -1) || !(0 < GetEntProp(attacker, Prop_Data, "m_iFOV") < GetEntProp(attacker, Prop_Data, "m_iDefaultFOV")))
	{
		int victim = GetClientOfUserId(GetEventInt(event, "userid"));
		int attacker = GetClientOfUserId(GetEventInt(event, "attacker"));
		
		if (victim == attacker)
			return;
		
		//Return if it is teamkill. It is not a proud moment when you noscope your teammate.
		if(GetClientTeam(victim) == GetClientTeam(attacker))
			return;
	
		if(StrContains(weapon,"awp") != -1 || StrContains(weapon,"g3sg1") != -1 || StrContains(weapon,"ssg08") != -1 || StrContains(weapon,"scar20") != -1){
			if((!GetEntProp(attacker, Prop_Send, "m_bIsScoped")))	
			{
				if(StrContains(weapon, "awp") != -1) 
					weapon = "AWP";
				else if (StrContains(weapon, "ssg08") != -1)
					weapon = "SCOUT";
				else if (StrContains(weapon, "scar20") != -1)
					weapon = "SCAR-20";
				else if (StrContains(weapon, "g3sg1") != -1)
					weapon = "G3SG1";
				char PlayerNameAttacker[MAX_NAME_LENGTH], PlayerNameVictim[MAX_NAME_LENGTH];
				GetClientName(attacker, PlayerNameAttacker, sizeof(PlayerNameAttacker));
				GetClientName(victim, PlayerNameVictim, sizeof(PlayerNameVictim));
				CPrintToChatAll("[\x06%s\x01] \x03%s\x01 noscoped \x03%s\x01 with \x04%s", "-=XymenGaming=-", PlayerNameAttacker, PlayerNameVictim, weapon);
			}
		}
	}
}