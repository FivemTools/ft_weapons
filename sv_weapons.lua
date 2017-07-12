-- Load lib MySQL --
require "resources/mysql-async/lib/MySQL"

---------------------TEST----------------------

TriggerEvent("ft_gamemode:SvAddSimpleCommand", "givegun", 2, function (source, args)

  TriggerClientEvent('ft_weapons:ClAddWeapons', source, args[1], tonumber(args[2]))
  
end)

TriggerEvent("ft_gamemode:SvAddSimpleCommand", "addcomponent", 2, function (source, args)

  TriggerClientEvent('ft_weapons:SvAddComponent', source, args[1], args[2])
  
end)

---------------------TEST----------------------

RegisterServerEvent("ft_weapons:SvloadWeapons")
AddEventHandler("ft_weapons:SvloadWeapons", function()
  TriggerEvent("ft_gamemode:SvGetPlayerData", source, "steamId", function (steamId)
  
    MySQL.Async.fetchAll("SELECT * FROM weapons WHERE steamId = @name", {['@name'] = steamId}, function(weapons)
      TriggerClientEvent('ft_weapons:ClgiveWeapons', source, weapons)
    end)
    
  end)
end)

RegisterServerEvent("ft_weapons:SvAddWeapon")
AddEventHandler("ft_weapons:SvAddWeapon", function(model, ammo)
 TriggerEvent("ft_gamemode:SvGetPlayerData", source, "steamId", function (steamId)
 
    local model = string.upper(model)
    if string.match(model, "WEAPON_") then
      if ammo >= 0 and ammo <= 1000 then
        MySQL.Sync.execute("INSERT INTO weapons (`steamId`, `model`, `ammo`) VALUES (@steamid, @model, @ammo)", {['@steamid'] = steamId, ['@model'] = model, ['@ammo'] = ammo})
      else
        print("ft_weapons: Ammo amount error")
      end
    else
      print("ft_weapons: Invalid model")
    end
    
  end)
end)

RegisterServerEvent("ft_weapons:SvAddComponent")
AddEventHandler("ft_weapons:SvAddComponent", function(model, component)
  TriggerEvent("ft_gamemode:SvGetPlayerData", source, "steamId", function (steamId)
  
    local model = string.upper(model)
    local component = string.upper(component)
    
    if string.match(model, "WEAPON_") then
      if string.match(component, "CLIP") or string.match(component, "KNUCKLE") or string.match(component, "SWITCHBLADE") then
        MySQL.Sync.execute("UPDATE weapons SET `component_1`=@component WHERE `model`=@model AND `steamId`=@steamId", {['@steamid'] = steamId, ['@model'] = model, ['@component'] = component})
      elseif string.match(component, "SUPP") then
        MySQL.Sync.execute("UPDATE weapons SET `component_2`=@component WHERE `model`=@model AND `steamId`=@steamId", {['@steamid'] = steamId, ['@model'] = model, ['@component'] = component})
      elseif string.match(component, "FLSH") then
        MySQL.Sync.execute("UPDATE weapons SET `component_3`=@component WHERE `model`=@model AND `steamId`=@steamId", {['@steamid'] = steamId, ['@model'] = model, ['@component'] = component})
      elseif string.match(component, "AFGRIP") then
        MySQL.Sync.execute("UPDATE weapons SET `component_4`=@component WHERE `model`=@model AND `steamId`=@steamId", {['@steamid'] = steamId, ['@model'] = model, ['@component'] = component})
      elseif string.match(component, "SCOPE") then
        MySQL.Sync.execute("UPDATE weapons SET `component_5`=@component WHERE `model`=@model AND `steamId`=@steamId", {['@steamid'] = steamId, ['@model'] = model, ['@component'] = component})
      elseif string.match(component, "VARMOD") then
        MySQL.Sync.execute("UPDATE weapons SET `component_6`=@component WHERE `model`=@model AND `steamId`=@steamId", {['@steamid'] = steamId, ['@model'] = model, ['@component'] = component})
      else        
        print('ft_weapons: Invalid component')
      end
    else
       print("ft_weapons: Invalid model")
    end
    
  end)
end)