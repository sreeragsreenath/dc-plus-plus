Rules = {
	MyINFOArrival = {

		doRulesCheck = function(user,data)
			if tRules[user.iProfile] then
				if tRules[user.iProfile].iMinshare then
					if not Core.GetUserValue(user,16) then Core.SendToUser(user, "*** Invalid client tag") Core.Disconnect(user) return true end
					if tRules[user.iProfile].iMinshare > (Core.GetUserValue(user,16) or 0) then
						Core.SendToUser(user,"*** "..ParseReturn({Rules.Lang["rule1"][2], (Rules.Lang2["rule1"] or Rules.Lang["rule1"][1]), (doShareCal(tRules[user.iProfile].iMinshare) or "0 b")}))
						Rules.Func.doRulesAction(user, 7, 12)
					end
				end
				if tRules[user.iProfile].iMaxshare then
					if not Core.GetUserValue(user,16) then Core.SendToUser(user, "*** Invalid client tag") Core.Disconnect(user) return true end
					if tRules[user.iProfile].iMaxshare < Core.GetUserValue(user,16) then
						Core.SendToUser(user,"*** "..ParseReturn({Rules.Lang["rule2"][2], (Rules.Lang2["rule2"] or Rules.Lang["rule2"][1]), (doShareCal(tRules[user.iProfile].iMaxshare) or "0 b")}))
						Rules.Func.doRulesAction(user, 7, 12)
					end
				end
				if tRules[user.iProfile].iMinslots then
					if not Core.GetUserValue(user,21) then Core.SendToUser(user, "*** Invalid client tag") Core.Disconnect(user) return true end
					if tRules[user.iProfile].iMinslots > Core.GetUserValue(user,21) then
						Core.SendToUser(user,"*** "..ParseReturn({Rules.Lang["rule3"][2], (Rules.Lang2["rule3"] or Rules.Lang["rule3"][1]), tostring(tRules[user.iProfile].iMinslots or "0")}))
						Rules.Func.doRulesAction(user, 8, 14)
					end
				end
				if tRules[user.iProfile].iMaxslots then
					if not Core.GetUserValue(user,21) then Core.SendToUser(user, "*** Invalid client tag") Core.Disconnect(user) return true end
					if tRules[user.iProfile].iMaxslots < Core.GetUserValue(user,21) then
						Core.SendToUser(user,"*** "..ParseReturn({Rules.Lang["rule4"][2], (Rules.Lang2["rule4"] or Rules.Lang["rule4"][1]), tostring(tRules[user.iProfile].iMaxslots or "0")}))
						Rules.Func.doRulesAction(user, 8, 14)
					end
				end
				if tRules[user.iProfile].iRatio then
					if not (Core.GetUserValue(user,17) and Core.GetUserValue(user,21)) then Core.SendToUser(user, "*** Invalid client tag") Core.Disconnect(user) return true end
					if (tRules[user.iProfile].iRatio[1]/tRules[user.iProfile].iRatio[2]) < (Core.GetUserValue(user,17)/Core.GetUserValue(user,21)) then
						Core.SendToUser(user,"*** "..ParseReturn({Rules.Lang["rule5"][2], (Rules.Lang2["rule5"] or Rules.Lang["rule5"][1]), tRules[user.iProfile].iRatio[1],tRules[user.iProfile].iRatio[2]}))
						Rules.Func.doRulesAction(user, 9, 16)
					end
				end
				if tRules[user.iProfile].iMaxhubs then
					if not Core.GetUserValue(user,17) then Core.SendToUser(user, "*** Invalid client tag") Core.Disconnect(user) return true end
					if tRules[user.iProfile].iMaxhubs < Core.GetUserValue(user,17) then
						Core.SendToUser(user,"*** "..ParseReturn({Rules.Lang["rule6"][2], (Rules.Lang2["rule6"] or Rules.Lang["rule6"][1]), tostring(tRules[user.iProfile].iMaxhubs or "0")}))
						Rules.Func.doRulesAction(user, 10, 18)
					end
				end
				if tRules[user.iProfile].iNick then
					if ((tRules[user.iProfile].iNick[1] > string.len(user.sNick)) or (tRules[user.iProfile].iNick[2] < string.len(user.sNick))) then
						Core.SendToUser(user,"*** "..ParseReturn({Rules.Lang["rule7"][2], (Rules.Lang2["rule7"] or Rules.Lang["rule7"][1]), tRules[user.iProfile].iNick[1],tRules[user.iProfile].iNick[2]}))
						Rules.Func.doRulesAction(user, 9, 16)
					end
				end
			end
		end,
	},
	
	Func = {
		SetMinShare = function(user,data)
			local tCal = {["b"] = 1,["kb"] = 1024, ["mb"] = 1024*1024, ["gb"] = 1024*1024*1024, ["tb"] = 1024*1024*1024*1024,["pb"] = 1024*1024*1024*1024*1024,["eb"] = 1024*1024*1024*1024*1024*1024,}
			local tLevel = {["b"] = 0,["kb"] = 1,["mb"] = 2, ["gb"] = 3, ["tb"] = 4,["pb"] = 5,["eb"] = 6, }
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg3(data)
			if (arg or arg2 or arg3) == nil then
				doArg2(data)
				if arg == nil then
					doReturn = {Rules.Lang["rule8"][2], (Rules.Lang2["rule8"] or Rules.Lang["rule8"][1])}
				elseif type(tonumber(arg)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg}
				elseif not tCal[arg2:lower()] then
					doReturn = {Rules.Lang["rule10"][2], (Rules.Lang2["rule10"] or Rules.Lang["rule10"][1]), arg2}
				else
					SetMan.SetNumber(1,tonumber(arg))
					SetMan.SetNumber(2,tLevel[arg2:lower()])
					SetMan.Save()
					doReturn = {Rules.Lang["rule11"][2], (Rules.Lang2["rule11"] or Rules.Lang["rule11"][1]), (doShareCal(tonumber(arg) * tCal[arg2:lower()]) or "Disabled")}
				end
			else
				if not uLevel[arg:lower()] then
					doReturn = {Rules.Lang["rule12"][2], (Rules.Lang2["rule12"] or Rules.Lang["rule12"][1]), arg, sLevel}
				elseif type(tonumber(arg2)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg2}
				elseif not tCal[arg3:lower()] then
					doReturn = {Rules.Lang["rule10"][2], (Rules.Lang2["rule10"] or Rules.Lang["rule10"][1]), arg3}
				elseif arg2 == "0" then
					if tRules[uLevel[arg:lower()]] and tRules[uLevel[arg:lower()]].iMinshare then
						tRules[uLevel[arg:lower()]].iMinshare = nil
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule13"][2], (Rules.Lang2["rule13"] or Rules.Lang["rule13"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg")}
				else
					if tRules[uLevel[arg:lower()]] then
						tRules[uLevel[arg:lower()]].iMinshare = (tonumber(arg2) * tCal[arg3:lower()]) or 0
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					else
						tRules[uLevel[arg:lower()]] = {}
						tRules[uLevel[arg:lower()]].iMinshare = (tonumber(arg2) * tCal[arg3:lower()]) or 0
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule14"][2], (Rules.Lang2["rule14"] or Rules.Lang["rule14"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg"),(doShareCal(tonumber(arg2) * tCal[arg3:lower()]) or "Disabled")}
				end
			end
		end,
	
		SetMaxShare = function(user,data)
			local tCal = {["b"] = 1,["kb"] = 1024, ["mb"] = 1024*1024, ["gb"] = 1024*1024*1024, ["tb"] = 1024*1024*1024*1024,["pb"] = 1024*1024*1024*1024*1024,["eb"] = 1024*1024*1024*1024*1024*1024,}
			local tLevel = {["b"] = 0,["kb"] = 1,["mb"] = 2, ["gb"] = 3, ["tb"] = 4,["pb"] = 5,["eb"] = 6, }
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg3(data)
			if (arg or arg2 or arg3) == nil then
				doArg2(data)
				if arg == nil then
					doReturn = {Rules.Lang["rule15"][2], (Rules.Lang2["rule15"] or Rules.Lang["rule15"][1])}
				elseif type(tonumber(arg)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg}
				elseif not tCal[arg2:lower()] then
					doReturn = {Rules.Lang["rule10"][2], (Rules.Lang2["rule10"] or Rules.Lang["rule10"][1]), arg3}
				else
					SetMan.SetNumber(3,tonumber(arg))
					SetMan.SetNumber(4,tLevel[arg2:lower()])
					SetMan.Save()
					doReturn = {Rules.Lang["rule16"][2], (Rules.Lang2["rule16"] or Rules.Lang["rule16"][1]),(doShareCal(tonumber(arg) * tCal[arg2:lower()]) or "Disabled")}
				end
			else
				if not uLevel[arg:lower()] then
					doReturn = {Rules.Lang["rule12"][2], (Rules.Lang2["rule12"] or Rules.Lang["rule12"][1]), arg, sLevel}
				elseif type(tonumber(arg2)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg2}
				elseif not tCal[arg3:lower()] then
					doReturn = {Rules.Lang["rule10"][2], (Rules.Lang2["rule10"] or Rules.Lang["rule10"][1]), arg3}
				elseif arg2 == "0" then
					if tRules[uLevel[arg:lower()]] and tRules[uLevel[arg:lower()]].iMaxshare then
						tRules[uLevel[arg:lower()]].iMaxshare = nil
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule17"][2], (Rules.Lang2["rule17"] or Rules.Lang["rule17"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg")}
				else
					if tRules[uLevel[arg:lower()]] then
						tRules[uLevel[arg:lower()]].iMaxshare = (tonumber(arg2) * tCal[arg3:lower()]) or 0
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					else
						tRules[uLevel[arg:lower()]] = {}
						tRules[uLevel[arg:lower()]].iMaxshare = (tonumber(arg2) * tCal[arg3:lower()]) or 0
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule18"][2], (Rules.Lang2["rule18"] or Rules.Lang["rule18"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg"),(doShareCal(tonumber(arg2) * tCal[arg3:lower()]) or "Disabled")}
				end
			end
		end,
		
		SetMinSlots = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doArg1(data)
				if arg == nil then
					doReturn = {Rules.Lang["rule19"][2], (Rules.Lang2["rule19"] or Rules.Lang["rule19"][1])}
				elseif type(tonumber(arg)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg}
				else
					SetMan.SetNumber(5,tonumber(arg))
					SetMan.Save()
					doReturn = {Rules.Lang["rule20"][2], (Rules.Lang2["rule20"] or Rules.Lang["rule20"][1]), arg}
				end
			else
				if not uLevel[arg:lower()] then
					doReturn = {Rules.Lang["rule12"][2], (Rules.Lang2["rule12"] or Rules.Lang["rule12"][1]), arg, sLevel}
				elseif type(tonumber(arg2)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg2}
				elseif arg2 == "0" then
					if tRules[uLevel[arg:lower()]] and tRules[uLevel[arg:lower()]].iMinslots then
						tRules[uLevel[arg:lower()]].iMinslots = nil
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end					
					doReturn = {Rules.Lang["rule21"][2], (Rules.Lang2["rule21"] or Rules.Lang["rule21"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg")}
				else
					if tRules[uLevel[arg:lower()]] then
						tRules[uLevel[arg:lower()]].iMinslots = tonumber(arg2)
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					else
						tRules[uLevel[arg:lower()]] = {}
						tRules[uLevel[arg:lower()]].iMinslots = tonumber(arg2)
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule22"][2], (Rules.Lang2["rule22"] or Rules.Lang["rule22"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg"), arg2}
				end
			end
		end,
		
		SetMaxSlots = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doArg1(data)
				if arg == nil then
					doReturn = {Rules.Lang["rule23"][2], (Rules.Lang2["rule23"] or Rules.Lang["rule23"][1])}
				elseif type(tonumber(arg)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg}
				else
					SetMan.SetNumber(6,tonumber(arg))
					SetMan.Save()
					doReturn = {Rules.Lang["rule24"][2], (Rules.Lang2["rule24"] or Rules.Lang["rule24"][1]), arg}
				end
			else
				if not uLevel[arg:lower()] then
					doReturn = {Rules.Lang["rule12"][2], (Rules.Lang2["rule12"] or Rules.Lang["rule12"][1]), arg, sLevel}
				elseif type(tonumber(arg2)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg2}
				elseif arg2 == "0" then
					if tRules[uLevel[arg:lower()]] and tRules[uLevel[arg:lower()]].iMaxslots then
						tRules[uLevel[arg:lower()]].iMaxslots = nil
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end					
					doReturn = {Rules.Lang["rule25"][2], (Rules.Lang2["rule25"] or Rules.Lang["rule25"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg")}
				else
					if tRules[uLevel[arg:lower()]] then
						tRules[uLevel[arg:lower()]].iMaxslots = tonumber(arg2)
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					else
						tRules[uLevel[arg:lower()]] = {}
						tRules[uLevel[arg:lower()]].iMaxslots = tonumber(arg2)
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule26"][2], (Rules.Lang2["rule26"] or Rules.Lang["rule26"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg"), arg2}
				end
			end
		end,
		
		SetMaxHubs = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doArg1(data)
				if arg == nil then
					doReturn = {Rules.Lang["rule27"][2], (Rules.Lang2["rule27"] or Rules.Lang["rule27"][1])}
				elseif type(tonumber(arg)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg}
				else
					SetMan.SetNumber(9,tonumber(arg))
					SetMan.Save()
					doReturn = {Rules.Lang["rule28"][2], (Rules.Lang2["rule28"] or Rules.Lang["rule28"][1]),arg}
				end
			else
				if not uLevel[arg:lower()] then
					doReturn = {Rules.Lang["rule12"][2], (Rules.Lang2["rule12"] or Rules.Lang["rule12"][1]), arg, sLevel}
				elseif type(tonumber(arg2)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg2}
				elseif arg2 == "0" then
					if tRules[uLevel[arg:lower()]] and tRules[uLevel[arg:lower()]].iMaxhubs then
						tRules[uLevel[arg:lower()]].iMaxhubs = nil
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end	
					doReturn = {Rules.Lang["rule29"][2], (Rules.Lang2["rule29"] or Rules.Lang["rule29"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg")}
				else
					if tRules[uLevel[arg:lower()]] then
						tRules[uLevel[arg:lower()]].iMaxhubs = tonumber(arg2)
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					else
						tRules[uLevel[arg:lower()]] = {}
						tRules[uLevel[arg:lower()]].iMaxhubs = tonumber(arg2)
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule30"][2], (Rules.Lang2["rule30"] or Rules.Lang["rule30"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg"), arg2}
				end
			end
		end,
		
		SetRatio = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg3(data)
			if (arg or arg2 or arg3) == nil then
				doArg2(data)
				if (arg or arg2) == nil then
					doReturn = {Rules.Lang["rule31"][2], (Rules.Lang2["rule31"] or Rules.Lang["rule31"][1])}
				elseif type(tonumber(arg)) ~= "number" or type(tonumber(arg2)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg.."/"..arg2}
				else
					SetMan.SetNumber(8, tonumber(arg))
					SetMan.SetNumber(7, tonumber(arg2))
					SetMan.Save()
					doReturn = {Rules.Lang["rule32"][2], (Rules.Lang2["rule32"] or Rules.Lang["rule32"][1]), arg,arg2}
				end
			else
				if not uLevel[arg:lower()] then
					doReturn = {Rules.Lang["rule12"][2], (Rules.Lang2["rule12"] or Rules.Lang["rule12"][1]), arg, sLevel}
				elseif type(tonumber(arg2)) ~= "number" or type(tonumber(arg3)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg2.."/"..arg3}
				elseif arg2 == "0" or arg3 == "0" then
					if tRules[uLevel[arg:lower()]] and tRules[uLevel[arg:lower()]].iRatio then
						tRules[uLevel[arg:lower()]].iRatio = nil
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end	
					doReturn = {Rules.Lang["rule33"][2], (Rules.Lang2["rule33"] or Rules.Lang["rule33"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg")}
				else
					if tRules[uLevel[arg:lower()]] then
						tRules[uLevel[arg:lower()]].iRatio = {tonumber(arg2),tonumber(arg3)}
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					else
						tRules[uLevel[arg:lower()]] = {}
						tRules[uLevel[arg:lower()]].iRatio = {tonumber(arg2),tonumber(arg3)}
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule34"][2], (Rules.Lang2["rule34"] or Rules.Lang["rule34"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2.."/"..arg3}
				end
			end
		end,
		
		SetRulesNick = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg3(data)
			if (arg or arg2 or arg3) == nil then
				doArg2(data)
				if (arg or arg2) == nil then
					doReturn = {Rules.Lang["rule35"][2], (Rules.Lang2["rule35"] or Rules.Lang["rule35"][1])}
				elseif type(tonumber(arg)) ~= "number" or type(tonumber(arg2)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg.." "..arg2}
				else
					SetMan.SetNumber(60, tonumber(arg))
					SetMan.SetNumber(61, tonumber(arg2))
					SetMan.Save()
					doReturn = {Rules.Lang["rule36"][2], (Rules.Lang2["rule36"] or Rules.Lang["rule36"][1]), arg, arg2}
				end
			else
				if not uLevel[arg:lower()] then
					doReturn = {Rules.Lang["rule12"][2], (Rules.Lang2["rule12"] or Rules.Lang["rule12"][1]), arg, sLevel}
				elseif type(tonumber(arg2)) ~= "number" or type(tonumber(arg3)) ~= "number" then
					doReturn = {Rules.Lang["rule9"][2], (Rules.Lang2["rule9"] or Rules.Lang["rule9"][1]), arg2.."/"..arg3}
				elseif arg2 == "0" or arg3 == "0" then
					if tRules[uLevel[arg:lower()]] and tRules[uLevel[arg:lower()]].iNick then
						tRules[uLevel[arg:lower()]].iNick = nil
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end	
					doReturn = {Rules.Lang["rule38"][2], (Rules.Lang2["rule38"] or Rules.Lang["rule38"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg")}
				else
					if tRules[uLevel[arg:lower()]] then
						tRules[uLevel[arg:lower()]].iNick = {tonumber(arg2),tonumber(arg3)}
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					else
						tRules[uLevel[arg:lower()]] = {}
						tRules[uLevel[arg:lower()]].iNick = {tonumber(arg2),tonumber(arg3)}
						SaveToFile("DiXBoT/CoreSystem/Rules/tRules.lua", tRules,"tRules")
					end
					doReturn = {Rules.Lang["rule37"][2], (Rules.Lang2["rule37"] or Rules.Lang["rule37"][1]), (GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2,arg3}
				end
			end
		end,
		
		doRulesShow = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg1(data)
			local header = "\n\n\t"..string.rep(":", 80).."\n\t"..(SetMan.GetString(0) or "No HubName Entered").." "..(arg or ""):upper().." Rules\n\t"..string.rep(":", 80).."\n"
			local footer = "\n\t"..string.rep(":", 80).."\n\tType !rulesconfig [ Profile/PtokaX ] to view a specific set of rules\n\t"..string.rep(":", 80)
			local names = ""

			if arg == nil then
				doReturn = "Error! - Type !rulesconfig [ PtokaX/"..sLevel.." ] to view the configured Rules."
			elseif uLevel[arg:lower()] then
				if tRules[uLevel[arg:lower()]] then
					line = "Min Share:\t "..(doShareCal(tRules[uLevel[arg:lower()]].iMinshare) or "-")
					line2 = " Max Share:\t "..(doShareCal(tRules[uLevel[arg:lower()]].iMaxshare) or "-")
					line3 = " Min Slots:\t "..(tRules[uLevel[arg:lower()]].iMinslots or "-")
					line4 = " Max Slots:\t "..(tRules[uLevel[arg:lower()]].iMaxslots or "-")
					if tRules[uLevel[arg:lower()]].iRatio then
						line5 = " Hub/Slot Ratio:\t "..(tRules[uLevel[arg:lower()]].iRatio[1] or "-").."/"..(tRules[uLevel[arg:lower()]].iRatio[2] or "-")
					else
						line5 = " Hub/Slot Ratio:\t -/-"
					end
					line6 = " Max Hubs:\t "..(tRules[uLevel[arg:lower()]].iMaxhubs or "-")
					if tRules[uLevel[arg:lower()]].iNick then
						line5 = " Nick Min/Max::\t "..(tRules[uLevel[arg:lower()]].iNick[1] or "-").."/"..(tRules[uLevel[arg:lower()]].iNick[2] or "-")
					else
						line5 = " Nick Min/Max::\t -/-"
					end
					names = names.."\t "..line.."\n\t"..line2.."\n\t"..line3.."\n\t"..line4.."\n\t"..line5.."\n\t"..line6
					doReturn = "\n"..header..names..footer.."\n"
				else
					doReturn = "Error! - No rules have been defined for Profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ]."
				end
			elseif arg:lower() == "ptokax" then
				local tVal = {[0] = "b",[1] = "Kb",[2] = "Mb",[3] = "Gb",[4] = "Tb",   }
				line = "Min Share:\t "..(SetMan.GetNumber(1) or "-").." "..tVal[SetMan.GetNumber(2)]
				line2 = " Max Share:\t "..(SetMan.GetNumber(3) or "-").." "..tVal[SetMan.GetNumber(4)]
				line3 = " Min Slots:\t "..SetMan.GetNumber(5)
				line4 = " Max Slots:\t "..SetMan.GetNumber(6)
				line5 = " Hub/Slot Ratio:\t "..SetMan.GetNumber(7).."/"..SetMan.GetNumber(8)
				line6 = " Max Hubs:\t "..SetMan.GetNumber(9)
				line7 = " Nick Min/Max:\t "..SetMan.GetNumber(60).."/"..SetMan.GetNumber(61)
				names = names.."\t "..line.."\n\t"..line2.."\n\t"..line3.."\n\t"..line4.."\n\t"..line5.."\n\t"..line6.."\n\t"..line7
				doReturn = "\n"..header..names..footer.."\n"
			else
				doReturn = "Error! - Type !rulesconfig [ PtokaX/"..sLevel.." ] to view the configured Rules."
			end
		end,
		
		doMyRules = function(user,data)
			local header = "\n\n\t"..string.rep(":", 80).."\n\t"..(SetMan.GetString(0) or "No HubName Entered").." Rules\n\t"..string.rep(":", 80).."\n"
			local footer = "\n\t"..string.rep(":", 80).."\n\tType !help to view your commands.\n\t"..string.rep(":", 80)
			local names = ""
			if tRules[user.iProfile] then
				if tRules[user.iProfile].iMinshare then 
					names = names.."\t Min Share:\t\t\t "..doShareCal(tRules[user.iProfile].iMinshare).."\n"
				else 
					names = names.."\t Min Share:\t\t\t -\n"
				end
				if tRules[user.iProfile].iMaxshare then 
					names = names.."\t Max Share:\t\t\t "..doShareCal(tRules[user.iProfile].iMaxshare or "0").."\n"
				else 
					names = names.."\t Max Share:\t\t\t -\n"
				end
				if tRules[user.iProfile].iMinslots then 
					names = names.."\t Min Slots:\t\t\t "..(tRules[user.iProfile].iMinslots or "-").." Slots\n"
				else 
					names = names.."\t Min Slots:\t\t\t -\n"
				end
				if tRules[user.iProfile].iMaxslots then 
					names = names.."\t Max Slots:\t\t\t "..(tRules[user.iProfile].iMaxslots or "-").." Slots\n"
				else 
					names = names.."\t Max Slots:\t\t\t -\n"
				end
				if tRules[user.iProfile].iMaxhubs then 
					names = names.."\t Max Hubs:\t\t\t "..(tRules[user.iProfile].iMaxhubs or "-").." Hubs\n"
				else 
					names = names.."\t Max Hubs:\t\t\t -\n"
				end
				if tRules[user.iProfile].iRatio then
					names = names.."\t Hub/Slot Ratio:\t\t\t "..(tRules[user.iProfile].iRatio[1] or "-").."/"..(tRules[user.iProfile].iRatio[2] or "-").." Ratio\n"
				else
					names = names.."\t Hub/Slot Ratio:\t\t\t -/- Ratio\n"
				end

				if tRules[user.iProfile].iNick then
					names = names.."\t Nick Min/Max Char(s):\t\t "..(tRules[user.iProfile].iNick[1] or "-").."/"..(tRules[user.iProfile].iNick[2] or "-").." Chars"
				else
					names = names.."\t Nick Min/Max Char(s):\t\t -/- Chars"
				end
				doReturn = "\n"..header..names..footer.."\n"
			else
				names = names.."\t Min Share:\t\t -\n"
				names = names.."\t Max Share:\t\t -\n"
				names = names.."\t Min Slots:\t\t -\n"
				names = names.."\t Max Slots:\t\t -\n"
				names = names.."\t Max Hubs: \t\t -\n"
				names = names.."\t Hub/Slot Ratio:\t\t -/-"
				doReturn = "\n"..header..names..footer.."\n"
			end
		end,
		
		doRulesAction = function(user,iBool, iRedir)
			if SetMan.GetBool(iBool) and SetMan.GetString(iRedir) then
				Core.Redirect(user, SetMan.GetString(iRedir), "")
				Core.SendToUser(user,"$ForceMove "..SetMan.GetString(iRedir).."|")
				Core.Disconnect(user)
			else
				Core.Disconnect(user)
			end
		end,
		
		---------------------------------RightClicks---------------------------------
		doRulesMinshareRC = function(user,data)
			local t = ProfMan.GetProfiles()
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Min Share\\PtokaX$<%[mynick]> !minshare %[line: Enter Min Share. Ex 1 GB]&#124;")
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Min Share\\"..t[i].sProfileName.."$<%[mynick]> !minshare "..t[i].sProfileName.." %[line: Enter Min Share. Ex 1 GB]&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Min Share\\Unreg$<%[mynick]> !minshare unreg %[line: Enter Min Share. Ex 1 GB]&#124;")
		end,
		doRulesMaxshareRC = function(user,data)
			local t = ProfMan.GetProfiles()
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Share\\PtokaX$<%[mynick]> !maxshare %[line: Enter Max Share. Ex 1 GB]&#124;")
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Share\\"..t[i].sProfileName.."$<%[mynick]> !maxshare "..t[i].sProfileName.." %[line: Enter Max Share. Ex 1 GB]&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Share\\Unreg$<%[mynick]> !maxshare unreg %[line: Enter Max Share. Ex 1 GB]&#124;")
		end,
		doRulesMinslotsRC = function(user,data)
			local t = ProfMan.GetProfiles()
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Min Slots\\PtokaX$<%[mynick]> !minslots %[line: Enter Min Slots. Ex 3]&#124;")
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Min Slots\\"..t[i].sProfileName.."$<%[mynick]> !minslots "..t[i].sProfileName.." %[line: Enter Min Slots. Ex 3]&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Min Slots\\Unreg$<%[mynick]> !minslots unreg %[line: Enter Min Slots. Ex 3]&#124;")
		end,
		doRulesMaxslotsRC = function(user,data)
			local t = ProfMan.GetProfiles()
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Slots\\PtokaX$<%[mynick]> !maxslots %[line: Enter Max Slots. Ex 20]&#124;")
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Slots\\"..t[i].sProfileName.."$<%[mynick]> !maxslots "..t[i].sProfileName.." %[line: Enter Max Slots. Ex 20]&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Slots\\Unreg$<%[mynick]> !maxslots unreg %[line: Enter Max Slots. Ex 20]&#124;")
		end,
		doRulesMaxhubsRC = function(user,data)
			local t = ProfMan.GetProfiles()
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Hubs\\PtokaX$<%[mynick]> !maxhubs %[line: Enter Max Hubs. Ex 20]&#124;")
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Hubs\\"..t[i].sProfileName.."$<%[mynick]> !maxhubs "..t[i].sProfileName.." %[line: Enter Max Hubs. Ex 20]&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Max Hubs\\Unreg$<%[mynick]> !maxhubs unreg %[line: Enter Max Hubs. Ex 20]&#124;")
		end,
		doRulesRatioRC = function(user,data)
			local t = ProfMan.GetProfiles()
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Hub/Slot Ratio\\PtokaX$<%[mynick]> !ratio %[line: Enter Ratio Hubs.] %[line: Enter Ratio Slots]&#124;")
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Hub/Slot Ratio\\"..t[i].sProfileName.."$<%[mynick]> !ratio "..t[i].sProfileName.." %[line: Enter Ratio Hubs.] %[line: Enter Ratio Slots]&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Hub/Slot Ratio\\Unreg$<%[mynick]> !ratio unreg %[line: Enter Ratio Hubs.] %[line: Enter Ratio Slots]&#124;")
		end,
		doRulesNickRC = function(user,data)
			local t = ProfMan.GetProfiles()
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Nick Length\\PtokaX$<%[mynick]> !nickLength %[line: Enter Min. Nick Length] %[line: Enter Max. Nick Length]&#124;")
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Nick Length\\"..t[i].sProfileName.."$<%[mynick]> !nickLength "..t[i].sProfileName.." %[line: Enter Min. Nick Length] %[line: Enter Max. Nick Length]&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Nick Length\\Unreg$<%[mynick]> !nickLength unreg %[line: Enter Min. Nick Length] %[line: Enter Max. Nick Length]&#124;")
		end,
		doRulesConfig = function(user,data)
			local t = ProfMan.GetProfiles()
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Current Config\\PtokaX$<%[mynick]> !rulesconfig ptokax&#124;")
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Current Config\\"..t[i].sProfileName.."$<%[mynick]> !rulesconfig "..t[i].sProfileName.."&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Hub Config\\Hub Rules\\Current Config\\Unreg$<%[mynick]> !rulesconfig unreg&#124;")
		end,
		---------------------------------RightClicks---------------------------------
		
	},

	Asserts = {
		[1] = "DiXBoT/CoreSystem/Rules/tRules.lua",
	},

	DxbMgrArrival = {
		doDxbRules = {"dxbrules",function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			Core.SendToUser(user,"$DXB $DXBRULES§RULESPROF "..sLevel)
		end,},
		
		doDxbRulesSet = {"dxbrulesset",function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			local sConf = ""
			dxbArg1(data)
			if arg and uLevel[arg:lower()] then
				if tRules[uLevel[arg:lower()]] then
					sConf = sConf.."§MINSHARE "..(doShareCal(tRules[uLevel[arg:lower()]].iMinshare,0) or "0 B")
					sConf = sConf.."§MAXSHARE "..(doShareCal(tRules[uLevel[arg:lower()]].iMaxshare,0) or "0 B")
					sConf = sConf.."§MINSLOTS "..(tRules[uLevel[arg:lower()]].iMinslots or "0")
					sConf = sConf.."§MAXSLOTS "..(tRules[uLevel[arg:lower()]].iMaxslots or "0")
					sConf = sConf.."§MAXHUBS "..(tRules[uLevel[arg:lower()]].iMaxhubs or "0")
					if tRules[uLevel[arg:lower()]].iRatio then
						sConf = sConf.."§RATIOHUBS "..(tRules[uLevel[arg:lower()]].iRatio[1] or "0")
						sConf = sConf.."§RATIOSLOTS "..(tRules[uLevel[arg:lower()]].iRatio[2] or "0")
					else
						sConf = sConf.."§RATIOHUBS 0"
						sConf = sConf.."§RATIOSLOTS 0"
					end
					if tRules[uLevel[arg:lower()]].iNick then
						sConf = sConf.."§NICKMIN "..(tRules[uLevel[arg:lower()]].iNick[1] or "0")
						sConf = sConf.."§NICKMAX "..(tRules[uLevel[arg:lower()]].iNick[2] or "0")
					else
						sConf = sConf.."§NICKMIN 0"
						sConf = sConf.."§NICKMAX 0"
					end
				else
					sConf = sConf.."§MINSHARE 0 B"
					sConf = sConf.."§MAXSHARE 0 B"
					sConf = sConf.."§MAXHUBS 0"
					sConf = sConf.."§MINSLOTS 0"
					sConf = sConf.."§MAXSLOTS 0"
					sConf = sConf.."§RATIOHUBS 0"
					sConf = sConf.."§RATIOSLOTS 0"
					sConf = sConf.."§NICKMIN 0"
					sConf = sConf.."§NICKMAX 0"
				end
				Core.SendToUser(user,"$DXB $DXBRULES"..sConf)
				--Core.SendToAll("Test: $DXB $DXBRULES"..sConf)
			end
		end,},
		
		doPxRules = {"pxrules",function(user,data)
			local tVal = {[0] = "B",[1] = "KB",[2] = "MB",[3] = "GB",[4] = "TB",   }
			local sConf = ""
			sConf = sConf.."§MINSHARE "..SetMan.GetNumber(1).." "..tVal[SetMan.GetNumber(2)]
			sConf = sConf.."§MAXSHARE "..SetMan.GetNumber(3).." "..tVal[SetMan.GetNumber(4)]
			sConf = sConf.."§MAXHUBS "..SetMan.GetNumber(9)
			sConf = sConf.."§MINSLOTS "..SetMan.GetNumber(5)
			sConf = sConf.."§MAXSLOTS "..SetMan.GetNumber(6)
			sConf = sConf.."§RATIOHUBS "..SetMan.GetNumber(7)
			sConf = sConf.."§RATIOSLOTS "..SetMan.GetNumber(8)
			sConf = sConf.."§NICKMIN "..SetMan.GetNumber(60)
			sConf = sConf.."§NICKMAX "..SetMan.GetNumber(61)
				Core.SendToUser(user,"$DXB $PXRULES"..sConf)
				--Core.SendToAll("Test: $DXB $DXBRULES"..sConf)
		end,},
	},
	
	
	DxbLoad = {
		doLoadDRules = function()
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Rules/ini/CMD.ini")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Rules/ini/LANG.ini")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Rules/ini/CONF.ini")
			if Rules.Conf.Lang then
				local f = io.open(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Rules/lang/"..Rules.Conf.Lang..".lang", "r")
				if f then
					dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Rules/lang/"..Rules.Conf.Lang..".lang")
				else
					Rules.Conf.Lang = false
					SaveToFile("DiXBoT/CoreSystem/Rules/ini/CONF.ini", Rules.Conf,"Rules.Conf")
					Rules.Lang2 = {}
				end
			else
				Rules.Lang2 = {}
			end
		end,
	},
	Lang2 = {},
}
DxbModule = {Rules,Rules.Lang2}