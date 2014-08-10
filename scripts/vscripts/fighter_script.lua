function MoveRight(args)
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	if args[0] == "-" then
		if ply.Move == "Right" then
			Stop(args);
		end
		return;
	end
	
	ent:MoveToPosition(Entities:FindByName(nil, "right_edge"):GetOrigin());
	ply.Move = "Right";
end

function MoveLeft(args)
	print(args);
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	
	if args[0] == "-" then
		print("stopping");
		if ply.Move == "Left" then
			Stop(args);
		end
		return;
	end
	print("starting");
	ent:MoveToPosition(Entities:FindByName(nil, "left_edge"):GetOrigin());
	ply.Move = "Left";
end

function Stop(args)	
	local ply = Convars:GetDOTACommandClient();
	local ent = ply:GetAssignedHero();
	ent:MoveToPosition(ent:GetOrigin());
end