-- Load lib MySQL --
require "resources/mysql-async/lib/MySQL"


RegisterServerEvent("ft_weapons:SvloadWeapons")
AddEventHandler("ft_weapons:SvloadWeapons", function()
  TriggerEvent("ft_gamemode:SvGetPlayerData", source, "steamId", function (steamId)
  
    MySQL.Async.fetchAll("SELECT * FROM weapons WHERE steamId = @name", {['@name'] = steamId}, function(weapons)
      TriggerEvent("ft_debugBase:SvDebug", { data = weapons })
      TriggerClientEvent('ft_weapons:ClgiveWeapons', source, weapons)
    end)
    
  end)
end)