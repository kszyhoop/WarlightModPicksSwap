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
	
	-- only with 2 players
	if (n ~= 2) then 
		return 
	end
	
	for _, territory in pairs(standing.Territories) do
		if (territory.OwnerPlayerID == playersTable[0]) then 
			territory.OwnerPlayerID = playersTable[1]
			if #territory.NumArmies.SpecialUnits >= 0 then
				swapSpecialUnits(territory, playersTable[1])
			end
		elseif (territory.OwnerPlayerID == playersTable[1]) then
			territory.OwnerPlayerID = playersTable[0]
			if #territory.NumArmies.SpecialUnits >= 0 then
				swapSpecialUnits(territory, playersTable[0])
			end
		end
	end
end

function swapSpecialUnits(territory, newPlayer)
	local array = {};
	for _, unit in pairs(territory.NumArmies.SpecialUnits) do
		table.insert(array, getNewUnit(unit, newPlayer))
	end
	territory.NumArmies = territory.NumArmies.Subtract(WL.Armies.Create(0, territory.NumArmies.SpecialUnits)).Add(WL.Armies.Create(0, array))
end

function getNewUnit(unit, player)
	if unit.proxyType == "Commander" then
		return WL.Commander.Create(player)
	elseif unit.proxyType == "CustomSpecialUnit" then
		local newUnit = WL.CustomSpecialUnitBuilder.CreateCopy(unit)
		newUnit.OwnerID = player
		return newUnit.Build()
	elseif unit.proxyType == "Boss1" then
		return WL.Boss1.Create(player)
	elseif unit.proxyType == "Boss2" then
		return WL.Boss2.Create(player)
	elseif unit.proxyType == "Boss3" then
		return WL.Boss3.Create(player, unit.Stage)
	elseif unit.proxyType == "Boss4" then
		return WL.Boss4.Create(player)
	end
end
