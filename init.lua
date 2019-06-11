--Freedom from Android users

minetest.register_on_joinplayer(function(player)
	
	if minetest.check_player_privs(player:get_player_name(), {ban=true})==false then
	
		local name = player:get_player_name()
		local privs = minetest.get_player_privs(name)
		privs.interact = nil
		privs.shout = nil
		minetest.set_player_privs(name, privs)
	
		local num = math.random(1000,9999)
		player:set_attribute("ffa", num)
		local num2 = player:get_attribute("ffa")
		
		minetest.show_formspec(player:get_player_name(), "ffa_form", "size[6.5,5] background[1,1;1,1;gui_formbg.png;true] bgcolor[#111111aa; true] image_button[0.7,1.3;2,2;key_logo.png;OK2;] pwdfield[0.7,4.35;5.8,1;pass;;#cccccc] tooltip[OK2;Your password: "..num2..";#A500A5;white] label[3,1.9;Hover key\nto reveal password] box[0,0;6.35,0.7;#111111] label[0.3,0.15;"..minetest.colorize("#777777","Server is available for PC users only").."] field_close_on_enter[pass;true]")
		

		
	end
	
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "ffa_form" then

		if fields.pass then
			
			local number = player:get_attribute("ffa")	
			if fields.pass == number then
	
				local name = player:get_player_name()
				local privs = minetest.get_player_privs(name)
				privs.interact = true
				privs.shout = true
				minetest.set_player_privs(name, privs)

				minetest.chat_send_player(name, (minetest.colorize("#61FF00","Congrats, now you can play, "..name.."!")))
				
			elseif fields.pass == "" then
				minetest.kick_player(name, "You did'nt enter the password, try to join again!")
			elseif fields.pass ~= number then
				minetest.kick_player(name, "Your password is wrong, try to join again!")
				
			end	

		elseif fields.quit == "true" then
				minetest.kick_player(name, "You did'nt enter the password, try to join again!")	
		end
		
	end
end)
