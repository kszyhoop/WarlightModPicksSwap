function SwapPicks(game, standing)
	local playersSet = {}
	for _, territory in pairs(standing.Territories) do
		if (not territory.IsNeutral) then
			playersSet[territory.OwnerPlayerID] = true
		end
	end
	
	local playersTable = {}
	local n = 0;
	for key, _ in pairs(playersSet) do
		playersTable[n] = key
		n = n + 1;
	end
	for _, territory in pairs(standing.Territories) do
		local x=0;
		while(x<n)do
			if(territory.OwnerPlayerID == playerTable[x])then
				if(x==0)then
					territory.OwnerPlayerID = playersTable[n-1];
				else
					if(x==n-1)then
						territory.OwnerPlayerID = territory.OwnerPlayerID[0];
					else
						territory.OwnerPlayerID = playersTable[x+1];
					end
				end
			end
		end
	end
end
