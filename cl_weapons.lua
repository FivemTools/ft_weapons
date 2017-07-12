local clientWeapons = {}

RegisterNetEvent('ft_weapons:ClgiveWeapons')
AddEventHandler('ft_weapons:ClgiveWeapons', function(weapons)
  Citizen.CreateThread(function()
  
    local playerPed = GetPlayerPed(-1)
    for _,weapon in pairs(weapons) do
      local model = GetHashKey(weapon.model)
      table.insert(clientWeapons, {model = weapon.model})
      GiveDelayedWeaponToPed(playerPed, model, tonumber(weapon.ammo), 0, true)
      Citizen.Wait(10)
      SetPedWeaponTintIndex(playerPed, model, tonumber(weapon.tint))
      for i=1,6 do
        local components = weapon["components_"..tostring(i)]
        if components ~= nil then
          GiveWeaponComponentToPed(playerPed, model, GetHashKey(components))
        end
      end
    end
    
  end)
end)

function removeWeaponsNotFound()
  Citizen.CreateThread(function()
  
    while true do
    Citizen.Wait(1000)
      local pedWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
      if clientWeapons ~= nil then
        if pedWeapon ~= -1569615261 then
        
          local weaponFound = false
          
          for k,v in pairs(clientWeapons) do
            if pedWeapon == GetHashKey(v.model) then
              weaponFound = true
              break
            end
          end
          
          if not weaponFound then
            exports.ft_ui:Notification("~h~~b~Suppression de l'armes de PNJ!")
            RemoveWeaponFromPed(GetPlayerPed(-1), pedWeapon)
          end
          
        end
      end
    end
 
  end)
end

RegisterNetEvent('ft_weapons:ClAddWeapons')
AddEventHandler('ft_weapons:ClAddWeapons', function(model, ammo)
  Citizen.CreateThread(function()

    if ammo >= 0 and ammo <= 1000 then
      TriggerServerEvent("ft_weapons:SvAddWeapon", model, ammo)
    else
      print("ft_weapons: Addweapon() ammo error")
    end
  
  end)
end)