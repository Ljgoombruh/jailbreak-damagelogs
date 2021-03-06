-- edit the privileges on config/config.lua

local function checkSettings(self, value)
	if value == 1 or value == 2 then
		return not ( JB.State == STATE_SETUP or JB.State == STATE_PLAYING or JB.State == STATE_LASTREQUEST )
	elseif value == 3 then
		return not ( JB.State == STATE_SETUP or JB.State == STATE_PLAYING or JB.State == STATE_LASTREQUEST ) or self:Team() == TEAM_SPECTATOR
	elseif value == 4 then
		return true
	end
	return false
end


local meta = FindMetaTable("Player")

function meta:CanUseDamagelog()
	for k,v in pairs(Damagelog.User_rights) do
		if self:IsUserGroup(k) then
			return checkSettings(self, v)
		end
	end
	return checkSettings(self, 2)
end

function meta:CanUseRDMManager()
	for k,v in pairs(Damagelog.RDM_Manager_Rights) do
		if self:IsUserGroup(k) then
			return v
		end
	end
	return false
end
