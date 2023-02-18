require('SwapPicks')

function Server_StartGame(game, standing)
        print("Mod: Swap Picks")
	-- only with manual picking
	if (not game.Settings.AutomaticTerritoryDistribution) then
		SwapPicks(game, standing);
	end


end

