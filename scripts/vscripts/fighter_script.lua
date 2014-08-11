function Fighter_MoveRight(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	ent:MoveToPosition(Entities:FindByName(nil, "right_edge"):GetOrigin());
	ply.Move = "Right";
end

function Fighter_StopRight(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	if ply.Move == "Right" then
		Stop(args);
	end
end

function Fighter_MoveLeft(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	ent:MoveToPosition(Entities:FindByName(nil, "left_edge"):GetOrigin());
	ply.Move = "Left";
end

function Fighter_StopLeft(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	if ply.Move == "Left" then
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
	
end
