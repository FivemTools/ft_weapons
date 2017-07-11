AddEventHandler("playerSpawned", function()
  if config.removeWeaponsNotFound then
    removeWeaponsNotFound()
  end
  TriggerServerEvent("ft_weapons:SvloadWeapons")
end)