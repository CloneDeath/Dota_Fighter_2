require("fighter_script");

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function CAddonTemplateGameMode:InitGameMode()
	-- Set up events
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 1 );
	--ListenToGameEvent("player_spawn", Dynamic_Wrap(CAddonTemplateGameMode, 'OnPlayerSpawn'), self);
	Convars:RegisterCommand("-moveleft", MoveLeft, "moves hero left", 0);
	
	Convars:RegisterCommand("-moveright", MoveRight, "moves hero right", 0);
	
	-- Set up game	
	GameRules:GetGameModeEntity():SetFogOfWarDisabled(true);
	GameRules:GetGameModeEntity():SetCameraDistanceOverride(500);
end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		GameLogic();
	elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
		GameLogic();
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1;
end

local Toggle = 0;
function GameLogic()
	for i = 0, 1 do
		local ply = PlayerResource:GetPlayer(i);
		if ply ~= nil then
			-- Camera
			PlayerResource:SetCameraTarget(i, ply:GetAssignedHero());
			
			Toggle = Toggle + 1;
			if Toggle >= 3 then
				local temp = Entities:CreateByClassname("info_target");
				temp:SetOrigin(ply:GetAssignedHero():GetOrigin());
				PlayerResource:SetCameraTarget(i, temp);
				Toggle = 0;
			end
			
			SendToConsole("dota_camera_pitch_max 10");
			SendToConsole("r_farz 6000");
			
			-- Abilities
			local ability;
				
			ability = ply:GetAssignedHero():FindAbilityByName("fighter_jump");
			if (ability ~= nil) then ability:SetLevel(1); end
			
			-- Stop movement
			SendToConsole("bind leftarrow +moveleft");
			SendToConsole("bind rightarrow +moveright");
		end
	end
end

-- Set up player spawn
--[[function CAddonTemplateGameMode:OnPlayerSpawn(ev)
	print("player " .. ev.userid .. " spawned");
	
	local ply = PlayerResource:GetPlayer(ev.userid);
	SetCameraTarget(ev.userid, ply:GetAssignedHero());
end]]
