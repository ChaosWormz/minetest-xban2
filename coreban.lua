local owner = minetest.setting_get("name") or "Admin"

minetest.register_chatcommand("ban", {
	params = "<name>",
	description = "Ban IP of player",
	privs = {ban=true},
	func = function(name, param)
		if param == owner then
			return false, "You may not ban that player!"
		end
		if param == "" then
			return true, "Ban list: " .. minetest.get_ban_list()
		end
		if not minetest.get_player_by_name(param) then
			return false, "No such player."
		end
		if not minetest.ban_player(param) then
			return false, "Failed to ban player."
		end	
		
		local desc = minetest.get_ban_description(param)
		minetest.log("action", name .. " bans " .. desc .. ".")
		return true, "Banned " .. desc .. "."
	end,
})
