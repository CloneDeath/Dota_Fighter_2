function Fighter_MoveRight(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	ent:MoveToPosition(Entities:FindByName(nil, "right_edge"):GetOrigin());
	ent.Move = "Right";
end

function Fighter_StopRight(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	if ent.Move == "Right" then
		Stop(args);
	end
end

function Fighter_MoveLeft(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	ent:MoveToPosition(Entities:FindByName(nil, "left_edge"):GetOrigin());
	ent.Move = "Left";
end

function Fighter_StopLeft(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	if ent.Move == "Left" then
		Stop(args);
	end
end

function Stop(args)	
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	ent:MoveToPosition(ent:GetOrigin());
end

function Fighter_Attack(args)
	local ent = args.unit;
	local offset = 0;
	
	if ent.Move == "Right" then
		offset = 100;
	else -- move left
		offset = -100;
	end
	
	for _, found_ent in pairs(Entities:FindAllInSphere(ent:GetOrigin() + Vector(offset, 0, 0), 100)) do
		if found_ent ~= ent and found_ent:IsAlive() and found_ent:GetTeam() ~= ent:GetTeam() then
		--if (found_ent ~= ent) and (found_ent:GetTeam() == DOTA_TEAM_BADGUYS or found_ent:GetTeam() == DOTA_TEAM_GOODGUYS) and found_ent:GetTeam() ~= ent:GetTeam() then
			print("Found target", found_ent);
			local damageTable = {
				victim = found_ent,
				attacker = ent,
				damage = 50,
				damage_type = DAMAGE_TYPE_PURE,
			}
			
			ent:PerformAttack(found, true, true, false, true);
			--ApplyDamage(damageTable);
		end
	end
end
