
--Freedom from Android users

minetest.register_on_joinplayer(function(player)
	
	
	if minetest.check_player_privs(player:get_player_name(), {ban=true})==false then
	
	
		local name = player:get_player_name()
		local privs = minetest.get_player_privs(name)
		privs.interact = nil
		minetest.set_player_privs(name, privs)
	
		local num = math.random(1000,9999)
		player:set_attribute("ffa", num)
		local num2 = player:get_attribute("ffa")
		
		minetest.show_formspec(player:get_player_name(), "ffa_form", "size[8,7] bgcolor[#333444cc; false] image[2.9,1;3.5,3.5;login_icon.png] button_exit[2.9,5.4;3,0.5;OK1;JOIN] pwdfield[3.2,4.55;3,1;pass;;#cccccc] tooltip[OK1;Your password: "..num2..";#A500A5;white] vertlabel[0.2,0.5;CHECK BUTTON TOOLTIP] box[-0.3,-0.3;1.1,7.7;#111111]")
		
		
	
	end
	
end)

minetest.register_chatcommand("join", {
  param = "<test>",
  description = "Password for interact",
  privs = {shout=true},
  func = function(name, param)

	if param ~= "" then
	return
	end

	local player = minetest.get_player_by_name(name)

	if minetest.check_player_privs(player:get_player_name(), {interact=true})==false then

		local num2 = player:get_attribute("ffa")
		
		minetest.show_formspec(player:get_player_name(), "ffa_form", "size[8,7] bgcolor[#333444cc; false] image[2.9,1;3.5,3.5;login_icon.png] button_exit[2.9,5.4;3,0.5;OK1;JOIN] pwdfield[3.2,4.55;3,1;pass;;#cccccc] tooltip[OK1;Your password: "..num2..";#A500A5;white] vertlabel[0.2,0.5;CHECK BUTTON TOOLTIP] box[-0.3,-0.3;1.1,7.7;#111111]")

	else
	
	minetest.chat_send_player(name, (minetest.colorize("#61FF00","You have interact, "..name.."!")))
	
	
	end



  end,
})



minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "ffa_form" then -- Replace this with your form name
		--fields.name = num
		if fields.OK1 then
			local number = player:get_attribute("ffa")
			if fields.pass == number then
				
				local name = player:get_player_name()
				local privs = minetest.get_player_privs(name)
				privs.interact = true
				minetest.set_player_privs(name, privs)



				minetest.chat_send_player(name, (minetest.colorize("#61FF00","Congrats, now you can play, "..name.."!")))
				
				
			else
				--minetest.kick_player(name, "Your password is wrong, try to join again!")
				minetest.chat_send_player(name, (minetest.colorize("red","Your password is wrong, try again with command /join, "..name.."!")))
			end
		end
		
	end
end)

