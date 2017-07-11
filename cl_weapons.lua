local clientWeapons = {}

RegisterNetEvent('ft_weapons:ClgiveWeapons')
AddEventHandler('ft_weapons:ClgiveWeapons', function(weapons)
  Citizen.CreateThread(function()
  
    local playerPed = GetPlayerPed(-1)
    for k,v in pairs(weapons) do
      local model = GetHashKey(v.model)
      table.insert(clientWeapons, {model = v.model})
      GiveDelayedWeaponToPed(playerPed, model, 0, 0, true)
      Citizen.Wait(10)
      SetPedAmmo(playerPed, model, tonumber(v.ammo))
      Citizen.Wait(10)
      SetPedWeaponTintIndex(playerPed, model, tonumber(v.tint))
      Citizen.Wait(10)
      if v.components_1 ~= nil then
        GiveWeaponComponentToPed(playerPed, model, GetHashKey(v.components_1))
      end
      Citizen.Wait(10)
      if v.components_2 ~= nil then
        GiveWeaponComponentToPed(playerPed, model, GetHashKey(v.components_2))
      end
      Citizen.Wait(10)
      if v.components_3 ~= nil then
        GiveWeaponComponentToPed(playerPed, model, GetHashKey(v.components_3))
      end
      Citizen.Wait(10)
      if v.components_4 ~= nil then
        GiveWeaponComponentToPed(playerPed, model, GetHashKey(v.components_4))
      end
      Citizen.Wait(10)
      if v.components_5 ~= nil then
        GiveWeaponComponentToPed(playerPed, model, GetHashKey(v.components_5))
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


RegisterNetEvent('ft_weapons:ClgiveWeapons')
AddEventHandler('ft_weapons:ClgiveWeapons', function(weapons)



end)


