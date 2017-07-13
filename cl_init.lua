-- @Project: FiveM Tools
-- @License: GNU General Public License v3.0

AddEventHandler("playerSpawned", function()
  if config.removeWeaponsNotFound then
    removeWeaponsNotFound()
  end
  TriggerServerEvent("ft_weapons:SvloadWeapons")
end)