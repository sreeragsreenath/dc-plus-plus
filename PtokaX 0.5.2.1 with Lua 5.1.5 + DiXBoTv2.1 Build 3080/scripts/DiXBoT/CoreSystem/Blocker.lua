Blocker = {

	MyINFOArrival = {
		BlockerPublicHubs = function(user,data)
			if tBlocker.BlockPubHub[user.iProfile] then
				if Core.GetUserValue(user,18) and Core.GetUserValue(user,18) > 0 then
					Blocker.Func.doBlockerPubHubAction(user,tBlocker.PubHubAct,Core.GetUserValue(user,18))
					table.insert(tCoroutine, coroutine.create(function()
						Blocker.Func.doBlockerStats("PubHub")
					end))
				end
			end		
		end,
		
		doClientCheck = function(user,data)
			if tBlocker.bClientCheck then
				local sClient
				local sVersion
				if Core.GetUserValue(user,6) then sClient = string.gsub(Core.GetUserValue(user,6),  " ", "") end
				if Core.GetUserValue(user,7) then sVersion = string.gsub(Core.GetUserValue(user,7),  " ", "") end
				if sClient and sVersion then
					local n = 1
					if tBlocker.bAllowUnknown == 0 then n = 0 end
					if not tClients[sClient] then
						tClients[sClient] = {}
						tClients[sClient]["bAllow"] = n
						tClients[sClient][sVersion] = n
						SaveToFile("DiXBoT/Global/tClients.dll", tClients,"tClients")
					elseif not tClients[sClient][sVersion] then
						tClients[sClient][sVersion] = n
						SaveToFile("DiXBoT/Global/tClients.dll", tClients,"tClients")
					end
				end
				if tBlocker.bClientCheckProf[user.iProfile] then
					Blocker.Func.doClientCheck(user,sClient,sVersion)
				end
			end
		end,
		
		doCountryCheck = function(user)
			if tBlocker.bCountryCheck then
				local sCountry = IP2Country.GetCountryCode(user.sIP)
				if sCountry ~= "??" then
					if tCountry[sCountry] == nil then
						if tBlocker.bAllowNewCountry then
							tCountry[sCountry] = 1 else	tCountry[sCountry] = 0 
						end
						SaveToFile("DiXBoT/Global/tCountry.dll", tCountry, "tCountry")
					end
				end
				if tBlocker.bCountryCheckProf[user.iProfile] then
					Blocker.Func.doCountryCheck(user, sCountry)
				end
			end
		end,
	},

	UserConnected = {
		BlockNickCheck = function(user,data)
			for i = 1, #tBlockerNick do
				if user.sNick:lower():find(tBlockerNick[i][1]) then
					--doBlockNickAction(user, tBlockerNick[i][1], tBlockerNick[i][2], tBlockerNick[i][1])
					Blocker.Func.doBlockerUserNoti(user,ParseReturn({Blocker.Lang["blocker23"][2], (Blocker.Lang2["blocker23"] or Blocker.Lang["blocker23"][1]),string.gsub(tBlockerNick[i][1],"%%","")}))
					--Core.SendToUser(user, "*** "..ParseReturn({Blocker.Lang["blocker23"][2], (Blocker.Lang2["blocker23"] or Blocker.Lang["blocker23"][1]),string.gsub(tBlockerNick[i][1],"%%","")}))
					Blocker.Func.doBlockNickAction(user,string.gsub(tBlockerNick[i][1],"%%",""),(tBlockerNick[i][3] or ""),i)
					table.insert(tCoroutine, coroutine.create(function()
						Blocker.Func.doBlockerStats("Nick")
					end))
					return true
				end
			end
		end,
	},
	
	ChatArrival = {
		BlockerBlockChat = function(user,data)
			if tBlocker.BlockChat.MC[user.iProfile] then
				Blocker.Func.doBlockerUserNoti(user,ParseReturn({Blocker.Lang["blocker4"][2], (Blocker.Lang2["blocker4"] or Blocker.Lang["blocker4"][1])}))
				Blocker.Func.doBlockerNoti(user,"chatmc","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from chatting in Mainchat!")
				tChat[user.sNick] = true
				table.insert(tCoroutine, coroutine.create(function()
					Blocker.Func.doBlockerStats("Chat")
				end))
			end
		end,
	},
	
	ToArrival = {
		BlockerBlockChat = function(user,data)
			if tBlocker.BlockChat.PM[user.iProfile] then
				Blocker.Func.doBlockerUserNoti(user,ParseReturn({Blocker.Lang["blocker5"][2], (Blocker.Lang2["blocker5"] or Blocker.Lang["blocker5"][1])}))
				Blocker.Func.doBlockerNoti(user,"chatpm","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from chatting in PM!")
				tChat[user.sNick] = true
				table.insert(tCoroutine, coroutine.create(function()
					Blocker.Func.doBlockerStats("PM")
				end))
			end
		end,
	},
	
	SearchArrival = {
		BlockerBlockSearch = function(user,data)
			if tBlocker.BlockSearch[user.iProfile] then
				Blocker.Func.doBlockerUserNoti(user,ParseReturn({Blocker.Lang["blocker8"][2], (Blocker.Lang2["blocker8"] or Blocker.Lang["blocker8"][1])}))
				Blocker.Func.doBlockerNoti(user,"search","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from Searching!")
				tStopFunc.SearchArrival[user.sNick] = true
				table.insert(tCoroutine, coroutine.create(function()
					Blocker.Func.doBlockerStats("Search")
				end))
			elseif not Core.GetUserValue(user, 10) and tBlocker.BlockPsvSearch[user.iProfile] then
				Blocker.Func.doBlockerUserNoti(user,ParseReturn({Blocker.Lang["blocker14"][2], (Blocker.Lang2["blocker14"] or Blocker.Lang["blocker14"][1])}))
				Blocker.Func.doBlockerNoti(user,"search", "*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from Passive Searching!")
				tStopFunc.SearchArrival[user.sNick] = true
				table.insert(tCoroutine, coroutine.create(function()
					Blocker.Func.doBlockerStats("Search")
				end))
			end
		end,	
	},
	
	MultiSearchArrival = {
		BlockerBlockSearch = function(user,data)
			if tBlocker.BlockSearch[user.iProfile] then
				Blocker.Func.doBlockerUserNoti(user,ParseReturn({Blocker.Lang["blocker8"][2], (Blocker.Lang2["blocker8"] or Blocker.Lang["blocker8"][1])}))
				Blocker.Func.doBlockerNoti(user,"search","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from Searching!")
				tStopFunc.MultiSearchArrival[user.sNick] = true
				table.insert(tCoroutine, coroutine.create(function()
					Blocker.Func.doBlockerStats("Search")
				end))
			end
		end,
	},
	
	ConnectToMeArrival = {
		BlockerBlockDownload = function(user,data)
			if tBlocker.BlockDownload[user.iProfile] then
				local s,e,_,sRev = data:find("^(%S+)%s+(%S+)")
				if not sRev then
					Blocker.Func.doBlockerUserNoti(user,ParseReturn({Blocker.Lang["blocker11"][2], (Blocker.Lang2["blocker11"] or Blocker.Lang["blocker11"][1])}))
					Blocker.Func.doBlockerNoti(user,"download","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from Downloading!")
					table.insert(tCoroutine, coroutine.create(function()
						Blocker.Func.doBlockerStats("Download")
					end))
					tStopFunc.ConnectToMeArrival[user.sNick] = true
				elseif sRev and not (tBlockerTmp[sRev] and tBlockerTmp[sRev][user.sNick]) then
					Blocker.Func.doBlockerUserNoti(user,ParseReturn({Blocker.Lang["blocker11"][2], (Blocker.Lang2["blocker11"] or Blocker.Lang["blocker11"][1])}))
					Blocker.Func.doBlockerNoti(user,"download","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from Downloading!")
					table.insert(tCoroutine, coroutine.create(function()
						Blocker.Func.doBlockerStats("Download")
					end))
					tStopFunc.ConnectToMeArrival[user.sNick] = true	
				end
			end
			if tBlockerTmp[sRev] then
				tBlockerTmp[sRev] = nil
			end
			
--			local s,e,_,sRev = data:find("^(%S+)%s+(%S+)")
--			if sRev and tBlockerTmp[sRev] and tBlockerTmp[sRev][user.sNick] then
--				tBlockerTmp[sRev][user.sNick] = nil
--				tStopFunc.ConnectToMeArrival[user.sNick] = true
--			end
		end,
	},
	
	RevConnectToMeArrival = {
		BlockerBlockDownload = function(user,data)
			if tBlocker.BlockDownload[user.iProfile] then
				Blocker.Func.doBlockerUserNoti(user,"("..(GetProfileName(user.iProfile) or "Unreg")..")  "..ParseReturn({Blocker.Lang["blocker11"][2], (Blocker.Lang2["blocker11"] or Blocker.Lang["blocker11"][1])}))
				Blocker.Func.doBlockerNoti(user,"download","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from Passive Downloading!")
				table.insert(tCoroutine, coroutine.create(function()
					Blocker.Func.doBlockerStats("Download")
				end))
				tStopFunc.RevConnectToMeArrival[user.sNick] = true
			else
				local s,e,sRev = data:find("%s+(%S+)|$")
				if sRev then
					--tStopFunc.ConnectToMeArrival[sRev] = 1
					if tBlockerTmp[user.sNick] then
						tBlockerTmp[user.sNick][sRev] = true
					else
						tBlockerTmp[user.sNick] = {[sRev] = true}
					end
				end				
			end
		end,
	},
	
	MultiConnectToMeArrival = {
		BlockerBlockDownload = function(user,data)
			if tBlocker.BlockDownload[user.iProfile] then
				Blocker.Func.doBlockerUserNoti(user,"("..(GetProfileName(user.iProfile) or "Unreg")..")  "..ParseReturn({Blocker.Lang["blocker11"][2], (Blocker.Lang2["blocker11"] or Blocker.Lang["blocker11"][1])}))
				Blocker.Func.doBlockerNoti(user,"download","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been Blocked from Downloading!")
				table.insert(tCoroutine, coroutine.create(function()
					Blocker.Func.doBlockerStats("Download")
				end))
				tStopFunc.MultiConnectToMeArrival[user.sNick] = true
			end
		end,
		
	},
	
	Func = {
		-----------------BlockerStats Func-----------------------------------------	
		doBlockerStats = function(sMode)
			if tBlockerStats[sMode] then
				tBlockerStats[sMode] = tBlockerStats[sMode] + 1
			else
				tBlockerStats[sMode] = 1
			end
		end,
		
		doBlockerStatsSave = function()
			SaveToFile("DiXBoT/CoreSystem/Blocker/tBlockerStats.lua", tBlockerStats,"tBlockerStats")
		end,
	
		-----------------CountryCheck Func-----------------------------------------	
		doCountryCheck = function(user, sCountry)
			if sCountry ~= "??" then
				if tBlocker.bCountryCheckProf[user.iProfile] and tCountry[sCountry] == 0 then --and tCountry[IP2Country.GetCountryName(user)] == 0 then
					table.insert(tCoroutine, coroutine.create(function()
						Blocker.Func.doBlockerStats("Country")
					end))
					Blocker.Func.doBlockerAction(user,(tBlocker.BlockCountryAct or "redir"),"countrycheck","Country [ "..(sCountry or "Unknown").." ] is not allowed in this hub!")
				end
			else
				if tBlocker.bCountryCheckProf[user.iProfile] and not tBlocker.bAllowUnknownCountry then --and tCountry[IP2Country.GetCountryName(user)] == 0 then
					table.insert(tCoroutine, coroutine.create(function()
						Blocker.Func.doBlockerStats("Country")
					end))
					Blocker.Func.doBlockerAction(user,(tBlocker.BlockCountryAct or "redir"),"countrycheck","Country [ Unknown ] is not allowed in this hub!")
				end
			end
		end,

		-----------------CountryCheck Func-----------------------------------------
		-----------------ClientCheck Func-----------------------------------------
		doClientCheck = function(user,sClient,sVersion)
			if sClient and sVersion then
				if tClients[sClient].bAllow == 0 or tClients[sClient][sVersion] == 0 then
					table.insert(tCoroutine, coroutine.create(function()
						Blocker.Func.doBlockerStats("Client")
					end))
					Blocker.Func.doBlockerAction(user,(tBlocker.BlockClientAct or "redir"),"clientcheck","Client [ "..sClient.." V:"..sVersion.." ] is not allowed in this hub!")
				end
			else
				table.insert(tCoroutine, coroutine.create(function()
					Blocker.Func.doBlockerStats("Client")
				end))
				Blocker.Func.doBlockerAction(user,(tBlocker.BlockClientAct or "redir"),"clientcheck","Client [ "..(sClient or "N/A").." V:"..(sVersion or "N/A").." ] is not allowed in this hub!")
			end
		end,
		
		doBlockerAction = function(user,act,check,reason)
			local t = {["warn"] = "Warned", ["disc"] = "Disconnected", ["redir"] = "Redirected", ["kick"] = "Kicked", ["ban"] = "Banned", }
			Core.SendToUser(user,"*** You have been "..t[(act or "redir")].." because: "..(reason or "We don't like you!"))
			Blocker.Func.doBlockerNoti(user, check, "*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been "..t[(act or "redir")].." because: "..(reason or "We don't like you!"))
			if user and act then
				if act == "disc" then
					Core.Disconnect(user)
				elseif act == "warn" then
					Core.Disconnect(user)
				elseif act == "redir" then
					doGlobalRedir(user)
				elseif act == "kick" then
					BanMan.TempBan(user, 0, "Client not allowed", (SetMan.GetString(21) or "DiXBoT"), true)
				elseif act == "ban" then
					BanMan.Ban(user, "Client Not allowed.", (SetMan.GetString(21) or "DiXBoT"), true)	
				else
					doGlobalRedir(user)
				end
			else
				doGlobalRedir(user)
			end
		end,
		
		SetCountryCheckAction = function(user,data)
			local act = {["disc"]=true,["warn"]=true,["redir"]=true,["kick"]=true,["ban"]=true,}
			doArg1(data)
			if arg == nil then
				doReturn = "Error! - Type !countryaction [ Disk/Warn/Redir/Kick/Ban ] to change this setting."
			elseif act[arg:lower()] == nil then
				doReturn = "Error! - [ "..arg.." ] is not a valid choice. Type !bcact [ Disk/Warn/Redir/Kick/Ban ] to change this setting."
			else
				tBlocker.BlockCountryAct = arg:lower()
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "CountryCheck Action have been set to [ "..arg:upper().." ]."
			end
		end,
		
		
		SetCountryCheck = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! Type !countrycheck [ True/False ] to change this setting."
			elseif arg:lower() == "true" then
				tBlocker.bCountryCheck = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "CountryCheck has been set to [ "..arg:upper().." ]."
			elseif arg:lower() == "false" then
				tBlocker.bCountryCheck = false
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "CountryCheck has been set to [ "..arg:upper().." ]."
			else
				doReturn = "Error! Type !countrycheck [ True/False ] to change this setting."
			end
			doDxbAction(user,"$CLIENTCHECK§COUNTRYCHECK")
		end,
		
		SetBlockerCountryAllowNew = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! Type !countryallownew [ True/False ] to change this setting."
			elseif arg:lower() == "true" then
				tBlocker.bAllowNewCountry = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Allow New Countries has been set to [ "..arg:upper().." ]."
			elseif arg:lower() == "false" then
				tBlocker.bAllowNewCountry = false
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Allow New Countries has been set to [ "..arg:upper().." ]."
			else
				doReturn = "Error! Type !countryallownew [ True/False ] to change this setting."
			end
			doDxbAction(user,"$CLIENTCHECK§CLIENTCHECK")
		end,
		
		SetBlockerCountryAllowUnknown = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! Type !countryallowunknown [ True/False ] to change this setting."
			elseif arg:lower() == "true" then
				tBlocker.bAllowUnknownCountry = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Allow Unknown Countries has been set to [ "..arg:upper().." ]."
			elseif arg:lower() == "false" then
				tBlocker.bAllowUnknownCountry = false
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Allow Unknown Countries has been set to [ "..arg:upper().." ]."
			else
				doReturn = "Error! Type !countryallowunknown [ True/False ] to change this setting."
			end
			doDxbAction(user,"$CLIENTCHECK§CLIENTCHECK")
		end,
		
		SetCountryCheckProf = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !countrycheckprof [ Profile ] [ True/False ] to change this setting."
			elseif not uLevel[arg:lower()] then
				doReturn = "Error! - [ "..arg.." ] is not a valide Profile. Use [ "..sLevel.." ]."
			elseif arg2:lower() == "true" then
				tBlocker.bCountryCheckProf[uLevel[arg:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "CountryCheck for Profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ] has been set to "..arg2:upper().." ]."
			elseif arg2:lower() == "false" then
				if tBlocker.bCountryCheckProf[uLevel[arg:lower()]] then
					tBlocker.bCountryCheckProf[uLevel[arg:lower()]] = nil
				end
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "CountryCheck for Profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ] has been set to "..arg2:upper().." ]."
			else
				doReturn = "Error! - Type !countrycheckprof [ Profile ] [ True/False ] to change this setting."
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetCountryAllow = function(user,data)
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !countryallow [ CountryCode ] [ True/False ] to change this setting!."
			elseif arg2:lower() == "true" then
				if tCountry[arg:upper()] then
					tCountry[arg:upper()] = 1
					SaveToFile("DiXBoT/Global/tCountry.dll", tCountry, "tCountry")
					doReturn = "Country [ "..arg:upper().." ] has been set to [ "..arg2:upper().." ]."
				else
					tCountry[arg:upper()] = 1
					SaveToFile("DiXBoT/Global/tCountry.dll", tCountry, "tCountry")
					doReturn = "Country [ "..arg:upper().." ] has been add to DB and set to [ "..arg2:upper().." ]."
				end
			elseif arg2:lower() == "false" then
				if tCountry[arg:upper()] then
					tCountry[arg:upper()] = 0
					SaveToFile("DiXBoT/Global/tCountry.dll", tCountry, "tCountry")
					doReturn = "Country [ "..arg:upper().." ] has been set to [ "..arg2:upper().." ]."
				else
					tCountry[arg:upper()] = 0
					SaveToFile("DiXBoT/Global/tCountry.dll", tCountry, "tCountry")
					doReturn = "Country [ "..arg:upper().." ] has been add to DB and set to [ "..arg2:upper().." ]."
				end
			else
				doReturn = "Error! - Type !countryallow [ CountryCode ] [ True/False ] to change this setting."
			end
		end,

		-----------------Global Blocker Action Func-----------------------------------------
		doBlockerAction = function(user,act,check,reason)
			local t = {["warn"] = "Warned", ["disc"] = "Disconnected", ["redir"] = "Redirected", ["kick"] = "Kicked", ["ban"] = "Banned", }
			Core.SendToUser(user,"*** You have been "..t[(act or "redir")].." because: "..(reason or "We don't like you!"))
			Blocker.Func.doBlockerNoti(user, check, "*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been "..t[(act or "redir")].." because: "..(reason or "We don't like you!"))
			if user and act then
				if act == "disc" then
					Core.Disconnect(user)
				elseif act == "warn" then
					Core.Disconnect(user)
				elseif act == "redir" then
					doGlobalRedir(user)
				elseif act == "kick" then
					BanMan.TempBan(user, 0, "Client not allowed", (SetMan.GetString(21) or "DiXBoT"), true)
				elseif act == "ban" then
					BanMan.Ban(user, "Client Not allowed.", (SetMan.GetString(21) or "DiXBoT"), true)	
				else
					doGlobalRedir(user)
				end
			else
				doGlobalRedir(user)
			end
		end,
		
		SetClientCheckAction = function(user,data)
			local act = {["disc"]=true,["warn"]=true,["redir"]=true,["kick"]=true,["ban"]=true,}
			doArg1(data)
			if arg == nil then
				doReturn = "Error! - Type !bcact [ Disk/Warn/Redir/Kick/Ban ] to change this setting."
			elseif act[arg:lower()] == nil then
				doReturn = "Error! - [ "..arg.." ] is not a valid choice. Type !bcact [ Disk/Warn/Redir/Kick/Ban ] to change this setting."
			else
				tBlocker.BlockClientAct = arg:lower()
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "ClientCheck Action have been set to [ "..arg:upper().." ]."
			end
		end,
		
		SetClientCheck = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! Type !clientcheck [ True/False ] to change this setting."
			elseif arg:lower() == "true" then
				tBlocker.bClientCheck = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "ClientCheck has been set to [ "..arg:upper().." ]."
			elseif arg:lower() == "false" then
				tBlocker.bClientCheck = false
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "ClientCheck has been set to [ "..arg:upper().." ]."
			else
				doReturn = "Error! Type !clientcheck [ True/False ] to change this setting."
			end
			doDxbAction(user,"$CLIENTCHECK§CLIENTCHECK")
		end,
		
		SetBlockerClientAllowUnknown = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! Type !bcallowunknown [ True/False ] to change this setting."
			elseif arg:lower() == "true" then
				tBlocker.bAllowUnknown = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Allow Unknown Clients has been set to [ "..arg:upper().." ]."
			elseif arg:lower() == "false" then
				tBlocker.bAllowUnknown = false
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Allow Unknown Clients has been set to [ "..arg:upper().." ]."
			else
				doReturn = "Error! Type !bcallowunknown [ True/False ] to change this setting."
			end
			doDxbAction(user,"$CLIENTCHECK§CLIENTCHECK")
		end,
		
		SetClientCheckProf = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !clientcheckprof [ Profile ] [ True/False ] to change this setting."
			elseif not uLevel[arg:lower()] then
				doReturn = "Error! - [ "..arg.." ] is not a valide Profile. Use [ "..sLevel.." ]."
			elseif arg2:lower() == "true" then
				tBlocker.bClientCheckProf[uLevel[arg:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "ClientCheck for Profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ] has been set to "..arg2:upper().." ]."
			elseif arg2:lower() == "false" then
				if tBlocker.bClientCheckProf[uLevel[arg:lower()]] then
					tBlocker.bClientCheckProf[uLevel[arg:lower()]] = nil
				end
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "ClientCheck for Profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ] has been set to "..arg2:upper().." ]."
			else
				doReturn = "Error! - Type !clientcheckprof [ Profile ] [ True/False ] to change this setting."
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetClientCheckActionProf = function(user,data)
			local act = {["warn"]=true,["disc"]=true,["redir"]=true,["kick"]=true,["ban"]=true,}
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !clientactionprof [ Profile ] [ Warn/Disc/Redir/Kick/Ban/False ] to change this setting."
			elseif not uLevel[arg:lower()] then
				doReturn = "Error! - [ "..arg.." ] is not a valide Profile. Use [ "..sLevel.." ]."
			elseif not act[arg2:lower()] then
				doReturn = "Error! - [ "..arg.." ] is not a valide Action. Use [ Warn/Disc/Redir/Kick/Ban ]."
			elseif act[arg2:lower()] then
				tBlocker.bAction[uLevel[arg:lower()]] = arg2:lower()
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "ClientCheck Action for Profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ] has been set to [ "..arg2:upper().." ]."
			elseif arg2:lower() == "false" then
				if tBlocker.bAction[uLevel[arg:lower()]] then
					tBlocker.bAction[uLevel[arg:lower()]] = nil
				end
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "ClientCheck Action for Profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ] has been set to [ "..arg2:upper().." ]."
			else
				doReturn = "Error! - Type !clientactionprof [ Profile ] [ True/False ] to change this setting."
			end
			doDxbAction(user,"$CLIENTCHECK§CLIENTCHECK")
		end,
		
		doBlockerDelClient = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! - Type !CCclientdel [ ClientName ] to use this feature."
			elseif tClients[arg] == nil then
				doReturn = "Error! - No Client in DB named [ "..arg.." ]."
			else
				tClients[arg] = nil
				SaveToFile("DiXBoT/Global/tClients.dll", tClients,"tClients")
				doReturn = "Client [ "..arg.." ] has been Deleted from DB."
			end
		end,
		
		doBlockerAddClient = function(user,data)
			doArg2(data)
			if arg == nil or arg2 == nil then
				doReturn = "Error! - Type !CCclientadd [ ClientName(Ex DC++) ] [ ClientVersion(Ex: 0.770 - no spaces allowed) ] to use this feature."
			else
				if not tClients[arg] then
					tClients[arg] = {}
					tClients[arg]["bAllow"] = 1
				end
				if tClients[arg][arg2] == nil then
					tClients[arg][arg2] = 1
				end
				SaveToFile("DiXBoT/Global/tClients.dll", tClients,"tClients")
				doReturn = "Client [ "..arg.." V:"..arg2.." ] has been Added to DB."
			end
		end,
		
		doBlockerListClient = function(user,data)
			doReturn = "*** List the damn clients :D"
		end,
		
		SetBlockerClientAllow = function(user,data)
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !bcallow [ Client ] [ True/False ] to change this setting."
			elseif tClients[arg] == nil then
				doReturn = "Error! - Client  [ "..arg.." ] could not be found in DB."
			else
				if arg2:lower() == "true" then
					tClients[arg].bAllow = 1
					SaveToFile("DiXBoT/Global/tClients.dll", tClients,"tClients")
					doReturn = "Access for Client [ "..arg.." ] has been set to [ "..arg2:upper().. " ]."
				elseif arg2:lower() == "false" then
					tClients[arg].bAllow = 0
					SaveToFile("DiXBoT/Global/tClients.dll", tClients,"tClients")
					doReturn = "Access for Client [ "..arg.." ] has been set to [ "..arg2:upper().. " ]."
				else
					doReturn = "Error! - Type !bcallow [ Client ] [ True/False ] to change this setting."
				end
			end
		end,
		
		SetBlockerClientVersionAllow = function(user,data)
			doArg3(data)
			if (arg or arg2 or Arg3) == nil then
				doReturn = "Error! - Type !bcallow [ Client ] [ True/False ] [ Client Version] to change this setting."
			elseif tClients[arg] == nil then
				doReturn = "Error! - Client  [ "..arg.." ] could not be found in DB."
			elseif tClients[arg][arg2] == nil then
				doReturn = "Error! - Client  [ "..arg.." ] version [ "..arg2.." ] could not be found in DB."
			else
				if arg3:lower() == "true" then
					tClients[arg][arg2] = 1
					SaveToFile("DiXBoT/Global/tClients.dll", tClients,"tClients")
					doReturn = "Access for Client [ "..arg.." ] version [ "..arg2.." ] has been set to [ "..arg3:upper().. " ]."
				elseif arg3:lower() == "false" then
					tClients[arg][arg2] = 0
					SaveToFile("DiXBoT/Global/tClients.dll", tClients,"tClients")
					doReturn = "Access for Client [ "..arg.." ] version [ "..arg2.." ] has been set to [ "..arg3:upper().. " ]."
				else
					doReturn = "Error! - Type !bcallow [ Client ] [ True/False ] [ Client Version] to change this setting."
				end
			end		
		end,		
		-----------------ClientCheck Func-----------------------------------------
		SetBlockChat = function(user,data)
			local t = {["main"] = "MC",["pm"] = "PM",}
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg3(data)
			if (arg or arg2 or arg3) == nil then
				doReturn = {Blocker.Lang["blocker1"][2], (Blocker.Lang2["blocker1"] or Blocker.Lang["blocker1"][1])}
			elseif not t[arg:lower()] then
				doReturn = {Blocker.Lang["blocker1"][2], (Blocker.Lang2["blocker1"] or Blocker.Lang["blocker1"][1])}
			elseif not uLevel[arg2:lower()] then
				doReturn = {Blocker.Lang["blocker2"][2], (Blocker.Lang2["blocker2"] or Blocker.Lang["blocker2"][1]),arg2,sLevel}
			elseif arg3:lower() == "true" then
				tBlocker.BlockChat[t[arg:lower()]][uLevel[arg2:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker3"][2], (Blocker.Lang2["blocker3"] or Blocker.Lang["blocker3"][1]),arg:upper(),(GetProfileName(uLevel[arg2:lower()]) or "Unreg"),arg3:upper()}
			elseif arg3:lower() == "false" then
				if tBlocker.BlockChat[t[arg:lower()]][uLevel[arg2:lower()]] then
					tBlocker.BlockChat[t[arg:lower()]][uLevel[arg2:lower()]] = nil
				end
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker3"][2], (Blocker.Lang2["blocker3"] or Blocker.Lang["blocker3"][1]),arg:upper(),(GetProfileName(uLevel[arg2:lower()]) or "Unreg"),arg3:upper()}	
			else
				doReturn = {Blocker.Lang["blocker1"][2], (Blocker.Lang2["blocker1"] or Blocker.Lang["blocker1"][1])}
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetBlockSearch = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = {Blocker.Lang["blocker6"][2], (Blocker.Lang2["blocker6"] or Blocker.Lang["blocker6"][1])}
			elseif not uLevel[arg:lower()] then
				doReturn = {Blocker.Lang["blocker2"][2], (Blocker.Lang2["blocker2"] or Blocker.Lang["blocker2"][1]),arg,sLevel}
			elseif arg2:lower() == "true" then
				tBlocker.BlockSearch[uLevel[arg:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker7"][2], (Blocker.Lang2["blocker7"] or Blocker.Lang["blocker7"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			elseif arg2:lower() == "false" then
				if tBlocker.BlockSearch[uLevel[arg:lower()]] then
					tBlocker.BlockSearch[uLevel[arg:lower()]] = nil
				end
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker7"][2], (Blocker.Lang2["blocker7"] or Blocker.Lang["blocker7"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			else
				doReturn = {Blocker.Lang["blocker6"][2], (Blocker.Lang2["blocker6"] or Blocker.Lang["blocker6"][1])}
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetBlockDownload = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = {Blocker.Lang["blocker9"][2], (Blocker.Lang2["blocker9"] or Blocker.Lang["blocker9"][1])}
			elseif not uLevel[arg:lower()] then
				doReturn = {Blocker.Lang["blocker2"][2], (Blocker.Lang2["blocker2"] or Blocker.Lang["blocker2"][1]),arg,sLevel}
			elseif arg2:lower() == "true" then
				tBlocker.BlockDownload[uLevel[arg:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker10"][2], (Blocker.Lang2["blocker10"] or Blocker.Lang["blocker10"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			elseif arg2:lower() == "false" then
				if tBlocker.BlockDownload[uLevel[arg:lower()]] then
					tBlocker.BlockDownload[uLevel[arg:lower()]] = nil
				end
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker10"][2], (Blocker.Lang2["blocker10"] or Blocker.Lang["blocker10"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			else
				doReturn = {Blocker.Lang["blocker9"][2], (Blocker.Lang2["blocker9"] or Blocker.Lang["blocker9"][1])}
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetBlockPassiveSearch = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = {Blocker.Lang["blocker12"][2], (Blocker.Lang2["blocker12"] or Blocker.Lang["blocker12"][1])}
			elseif not uLevel[arg:lower()] then
				doReturn = {Blocker.Lang["blocker2"][2], (Blocker.Lang2["blocker2"] or Blocker.Lang["blocker2"][1]),arg,sLevel}
			elseif arg2:lower() == "true" then
				tBlocker.BlockPsvSearch[uLevel[arg:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker13"][2], (Blocker.Lang2["blocker13"] or Blocker.Lang["blocker13"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
				elseif arg2:lower() == "false" then
				if tBlocker.BlockPsvSearch[uLevel[arg:lower()]] then
					tBlocker.BlockPsvSearch[uLevel[arg:lower()]] = nil
					SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				end
				doReturn = {Blocker.Lang["blocker13"][2], (Blocker.Lang2["blocker13"] or Blocker.Lang["blocker13"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			else
				doReturn = {Blocker.Lang["blocker12"][2], (Blocker.Lang2["blocker12"] or Blocker.Lang["blocker12"][1])}
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetBlockNickCheck = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = {Blocker.Lang["blocker15"][2], (Blocker.Lang2["blocker15"] or Blocker.Lang["blocker15"][1])}
			elseif not uLevel[arg:lower()] then
				doReturn = {Blocker.Lang["blocker2"][2], (Blocker.Lang2["blocker2"] or Blocker.Lang["blocker2"][1]),arg,sLevel}
			elseif arg2:lower() == "true" then
				tBlocker.BlockNick[uLevel[arg:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker16"][2], (Blocker.Lang2["blocker16"] or Blocker.Lang["blocker16"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			elseif arg2:lower() == "false" then
				if tBlocker.BlockNick[uLevel[arg:lower()]] then
					tBlocker.BlockNick[uLevel[arg:lower()]] = nil
					SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				end
				doReturn = {Blocker.Lang["blocker16"][2], (Blocker.Lang2["blocker16"] or Blocker.Lang["blocker16"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			else
				doReturn = {Blocker.Lang["blocker15"][2], (Blocker.Lang2["blocker15"] or Blocker.Lang["blocker15"][1])}
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		doBlockNickAdd = function(user,data)
			local act = {["disc"] = true,["redir"] = true, ["kick"] = true,["ban"] = true,}
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = {Blocker.Lang["blocker17"][2], (Blocker.Lang2["blocker17"] or Blocker.Lang["blocker17"][1])}
			elseif not act[arg2:lower()] then
				doReturn = {Blocker.Lang["blocker17"][2], (Blocker.Lang2["blocker17"] or Blocker.Lang["blocker17"][1])}
			else
				local str = Blocker.Func.doBlockerMagic(arg):lower()
				for i = 1, #tBlockerNick do
					if str:find(tBlockerNick[i][1]) then
						doReturn = {Blocker.Lang["blocker18"][2], (Blocker.Lang2["blocker18"] or Blocker.Lang["blocker18"][1]),arg,string.gsub(tBlockerNick[i][1],"%%","")}
						return true
					end
				end
				table.insert(tBlockerNick, {str,0,arg2:lower()})
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlockerNick.lua", tBlockerNick,"tBlockerNick")
				doReturn = {Blocker.Lang["blocker19"][2], (Blocker.Lang2["blocker19"] or Blocker.Lang["blocker19"][1]),arg}
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		doBlockNickDel = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = {Blocker.Lang["blocker20"][2], (Blocker.Lang2["blocker20"] or Blocker.Lang["blocker20"][1])}
			else
				if type(tonumber(arg)) == "number" then
					if tBlockerNick[tonumber(arg)] then
						table.remove(tBlockerNick,tonumber(arg))
						SaveToFile("DiXBoT/CoreSystem/Blocker/tBlockerNick.lua", tBlockerNick,"tBlockerNick")
						doReturn = {Blocker.Lang["blocker21"][2], (Blocker.Lang2["blocker21"] or Blocker.Lang["blocker21"][1]),arg}
					else
						doReturn = {Blocker.Lang["blocker22"][2], (Blocker.Lang2["blocker22"] or Blocker.Lang["blocker22"][1]),arg}
					end
				else
					local str = Blocker.Func.doBlockerMagic(arg):lower()
					for i = 1, #tBlockerNick do
						if str == string.gsub(tBlockerNick[i][1],"%%","") then
							table.remove(tBlockerNick,i)
							SaveToFile("DiXBoT/CoreSystem/Blocker/tBlockerNick.lua", tBlockerNick,"tBlockerNick")
							doReturn = {Blocker.Lang["blocker21"][2], (Blocker.Lang2["blocker21"] or Blocker.Lang["blocker21"][1]),arg}
							return true
						end
					end
					doReturn = {Blocker.Lang["blocker22"][2], (Blocker.Lang2["blocker22"] or Blocker.Lang["blocker22"][1]),arg}
				end
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		doBlockNickAction = function (user, str, act, nNr)
			local t = {["disc"] = "Disconnected",["redir"] = "Redirected",["kick"] = "Kicked",["ban"] = "Banned",}
			if user and str and act then
				local tUser = user
				if act:lower() == "disc" then
					Core.Disconnect(user)
				elseif act:lower() == "kick" then
					BanMan.TempBan(user, 0, "Unwanted string [ "..(str or "Unknown").." ] in Nick.", "DiXBoT", true)
				elseif act:lower() == "ban" then
					BanMan.Ban(user, "Unwanted string [ "..(str or "Unknown").." ] in Nick.", "DiXBoT", true)
				else
					doGlobalRedir(user)
				end
				tBlockerNick[nNr][2] = tBlockerNick[nNr][2] + 1
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlockerNick.lua", tBlockerNick,"tBlockerNick")
				Blocker.Func.doBlockerNoti(tUser,"nick","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been "..(t[act] or "Removed").." because: Nick had string [ "..str.." ] in it.")
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetBlockPubHubCheck = function(user,data)
			local uLevel, sLevel = doProfiles()
			uLevel["unreg"] = -1 sLevel = sLevel.."/Unreg"
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = {Blocker.Lang["blocker24"][2], (Blocker.Lang2["blocker24"] or Blocker.Lang["blocker24"][1])}
			elseif not uLevel[arg:lower()] then
				doReturn = {Blocker.Lang["blocker2"][2], (Blocker.Lang2["blocker2"] or Blocker.Lang["blocker2"][1]),arg,sLevel}
			elseif arg2:lower() == "true" then
				tBlocker.BlockPubHub[uLevel[arg:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker25"][2], (Blocker.Lang2["blocker25"] or Blocker.Lang["blocker25"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			elseif arg2:lower() == "false" then
				if tBlocker.BlockPubHub[uLevel[arg:lower()]] then
					tBlocker.BlockPubHub[uLevel[arg:lower()]] = nil
				end
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = {Blocker.Lang["blocker25"][2], (Blocker.Lang2["blocker25"] or Blocker.Lang["blocker25"][1]),(GetProfileName(uLevel[arg:lower()]) or "Unreg"),arg2:upper()}
			else
				doReturn = {Blocker.Lang["blocker24"][2], (Blocker.Lang2["blocker24"] or Blocker.Lang["blocker24"][1])}
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetBlockPubHubAction = function(user,data)
			local t = {["warn"] = 0, ["disc"] = 1, ["redir"] = 2, ["kick"] = 3, ["ban"] = 4, }
			doArg1(data)
			if arg == nil then
				doReturn = "Error! - Type !blockpubhubact [ Warn/Disc/Redir/Kick/Ban ] to change this setting."
			elseif t[arg:lower()] == nil then
				doReturn = "Error! - Type !blockpubhubact [ Warn/Disc/Redir/Kick/Ban ] to change this setting."
			else
				tBlocker.PubHubAct = t[arg:lower()]
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Block Publick Hub Action has been set to [ "..arg:upper().." ]."
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		doBlockerPubHubAction = function(user,nNr,nPub)
			if user and nNr then
				local t = {[0] = "Warned", [1] = "Disconnected", [2] = "Redirected", [3] = "Kicked", [4] = "Banned", }
				Core.SendToUser(user,"*** You have been "..t[nNr].." because: You're connected to [ "..nPub.." ] Public hub(s)!")
				Blocker.Func.doBlockerNoti(user,"pubhub","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been "..t[nNr].." for being connected to [ "..nPub.." ] Public hub(s)!")
				if nNr == 0 then
					--
				elseif nNr == 1 then
					Core.Disconnect(user)
				elseif nNr == 2 then
					doGlobalRedir(user)
				elseif nNr == 3 then
					BanMan.TempBan(user, 0, "Unauthorised advertising.", (SetMan.GetString(21) or "DiXBoT"), true)
				else
					BanMan.Ban(user, "Unauthorised advertising.", (SetMan.GetString(21) or "DiXBoT"), true)
				end
			end
		end,
		
		SetBlockerNotiProf = function(user,data)
			local uLevel, sLevel = doOpProfiles()
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !blocknotiprof [ OpProfile ] [ True/False ] to change this setting."
			elseif uLevel[arg:lower()] == nil then
				doReturn = "[ "..arg.." ] is not a valide Operator Profile. Please use [ "..sLevel.." ]."
			elseif arg2:lower() == "true" then
				tBlocker.bNotiProf[uLevel[arg:lower()]] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker Notification for profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ] has been set to [ "..arg2:upper().." ]."
			elseif arg2:lower() == "false" then
				tBlocker.bNotiProf[uLevel[arg:lower()]] = nil
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker Notification for profile [ "..(GetProfileName(uLevel[arg:lower()]) or "Unreg").." ] has been set to [ "..arg2:upper().." ]."
			else
				doReturn = "Error! - Type !blocknotiprof [ OpProfile ] [ True/False ] to change this setting."
			end
		end,
		
		SetBlockerNotiMode = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Error! - Type !blocknotimode [ Main/PM/False ] to change this setting."
			elseif arg:lower() == "main" then
				tBlocker.nNotiMode = 0
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker Notification Mode has been set to [ "..arg:upper().." ]."
			elseif arg:lower() == "pm" then
				tBlocker.nNotiMode = 1
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker Notification Mode has been set to [ "..arg:upper().." ]."
			elseif arg:lower() == "false" then
				tBlocker.nNotiMode = false
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker Notification Mode has been set to [ "..arg:upper().." ]."
			else
				doReturn = "Error! - Type !blocknotimode [ Main/PM/False ] to change this setting."
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetBlockerNotiOnAct = function(user,data)
			local t = {["nick"] = true,["chatmc"] = true,["chatpm"] = true,["search"] = true,["download"] = true,["pubhub"] = true,["clientcheck"] = true,["countrycheck"] = true,}
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = "Error! - Type !blocknotiact [ Nick/Chatmc/Chatpm/Search/Download/PubHub ] [ True/False ] to change this setting."
			elseif t[arg:lower()] == nil then
				doReturn = "Error! - Type !blocknotiact [ Nick/Chatmc/Chatpm/Search/Download/PubHub ] [ True/False ] to change this setting."
			elseif arg2:lower() == "true" then
				tBlocker.NotiAct[arg:lower()] = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker Notification on action [ "..arg:upper().." ] has been set to [ "..arg2:upper().." ]."
			elseif arg2:lower() == "false" then
				tBlocker.NotiAct[arg:lower()] = nil
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker Notification on action [ "..arg:upper().." ] has been set to [ "..arg2:upper().." ]."
			else
				doReturn = "Error! - Type !blocknotiact [ Nick/Chatmc/Chatpm/Search/Download/PubHub ] [ True/False ] to change this setting."
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		SetBlockerUserNoti = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = "Blocker User Notification is currently set to [ "..tostring(tBlocker.bUserNoti):upper().." ]. Type !blockusernoti [ True/False ] to change this setting."
			elseif arg:lower() == "true" then
				tBlocker.bUserNoti = true
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker User Notification has been set to [ "..arg:upper().." ]."
			elseif arg:lower() == "false" then
				tBlocker.bUserNoti = false
				SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
				doReturn = "Blocker User Notification has been set to [ "..arg:upper().." ]."
			else
				doReturn = "Blocker User Notification is currently set to [ "..tostring(tBlocker.bUserNoti):upper().." ]. Type !blockusernoti [ True/False ] to change this setting."
			end
			doDxbAction(user,"$BLOCKER§BLOCKER")
		end,
		
		doBlockerConfig = function(user,data)
			local header = "\n\n\t"..string.rep(":", 100).."\n\t"..SetMan.GetString(0).." Blocker Config:\n\t"..string.rep(":", 100).."\n"
			local footer = "\t"..string.rep(":", 100).."\n\tType !help to view your commands.\n\t"..string.rep(":", 100)..""
			local body = ""
			local nr = 1
			local tDisc = {[0] = "Disconnect",[1] = "Kick",[2] = "Redirect",}
			local NotiMode = ""
			if tBlocker.nNotiMode == 0 then NotiMode = "Mainchat" elseif tBlocker.nNotiMode == 1 then NotiMode = "PM" else NotiMode = "FALSE" end
			local sNickProf = "\n\t\t\t"
			local sChatProf = "\n\t\t\t"
			local sSearchProf = "\n\t\t\t"
			local sDlProf = "\n\t\t\t"
			local sPubHubProf = "\n\t\t\t"
			local sNickString = "\n\t\t\t"
			local sNotiProf = "\n\t\t\t"
				local t = ProfMan.GetProfiles()
				for i=1, (#t+1) do
					if t[i] then
						if t[i].tProfilePermissions.bIsOP then
							sNickProf = sNickProf..(GetProfileName(i-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockNick[i-1] or "false"):upper().."\n\t\t\t"
							sChatProf = sChatProf..(GetProfileName(i-1) or "Unreg").."\t\t: MC "..tostring(tBlocker.BlockChat.MC[i-1] or "false"):upper().."\tPM "..tostring(tBlocker.BlockChat.PM[i-1] or "false"):upper().."\n\t\t\t"
							sSearchProf = sSearchProf..(GetProfileName(i-1) or "Unreg").."\t\t: ALL "..tostring(tBlocker.BlockSearch[i-1] or "false"):upper().."\tPSV "..tostring(tBlocker.BlockPsvSearch[i-1] or "false"):upper().."\n\t\t\t"
							sDlProf = sDlProf..(GetProfileName(i-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockDownload[i-1] or "false"):upper().."\n\t\t\t"
							sPubHubProf = sPubHubProf..(GetProfileName(i-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockPubHub[i-1] or "false"):upper().."\n\t\t\t"
							sNotiProf = sNotiProf..(GetProfileName(i-1) or "Unreg").."\t\t: "..tostring(tBlocker.bNotiProf[i-1] or "false"):upper().."\n\t\t\t"
						else
							sNickProf = sNickProf..(GetProfileName(i-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockNick[i-1] or "false"):upper().."\n\t\t\t"
							sChatProf = sChatProf..(GetProfileName(i-1) or "Unreg").."\t\t: MC "..tostring(tBlocker.BlockChat.MC[i-1] or "false"):upper().."\tPM "..tostring(tBlocker.BlockChat.PM[i-1] or "false"):upper().."\n\t\t\t"
							sSearchProf = sSearchProf..(GetProfileName(i-1) or "Unreg").."\t\t: ALL "..tostring(tBlocker.BlockSearch[i-1] or "false"):upper().."\tPSV "..tostring(tBlocker.BlockPsvSearch[i-1] or "false"):upper().."\n\t\t\t"
							sDlProf = sDlProf..(GetProfileName(i-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockDownload[i-1] or "false"):upper().."\n\t\t\t"
							sPubHubProf = sPubHubProf..(GetProfileName(i-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockPubHub[i-1] or "false"):upper().."\n\t\t\t"
						end
					else
						sNickProf = sNickProf..(GetProfileName(-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockNick[-1] or "false"):upper()
						sChatProf = sChatProf..(GetProfileName(i-1) or "Unreg").."\t\t: MC "..tostring(tBlocker.BlockChat.MC[-1] or "false"):upper().."\tPM "..tostring(tBlocker.BlockChat.PM[-1] or "false"):upper()
						sSearchProf = sSearchProf..(GetProfileName(i-1) or "Unreg").."\t\t: ALL "..tostring(tBlocker.BlockSearch[-1] or "false"):upper().."\tPSV "..tostring(tBlocker.BlockPsvSearch[-1] or "false"):upper()
						sDlProf = sDlProf..(GetProfileName(-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockDownload[-1] or "false"):upper()
						sPubHubProf = sPubHubProf..(GetProfileName(-1) or "Unreg").."\t\t: "..tostring(tBlocker.BlockPubHub[-1] or "false"):upper()
					end
				end
			local tConfig = {
				[1] = {
					{"Notification Mode", NotiMode},
					{"Notify on Blocked Nick", tostring(tBlocker.NotiAct.nick):upper()},
					{"Notify on Blocked Mainchat", tostring(tBlocker.NotiAct.chatmc):upper()},
					{"Notify on Blocked PM", tostring(tBlocker.NotiAct.chatpm):upper()},
					{"Notify on Blocked Search", tostring(tBlocker.NotiAct.search):upper()},
					{"Notify on Blocked Download", tostring(tBlocker.NotiAct.download):upper()},
					{"Notify on Blocked Publick Hub", tostring(tBlocker.NotiAct.pubhub):upper()},
				},
				[2] = {
					{"Notify Profiles", sNotiProf},
				},
				[3] = {
					{"Bad Nick Profiles Checked", sNickProf},
				},
				[4] = {
					{"Chat Profiles Checked", sChatProf},
				},
				[5] = {
					{"Search Profiles Checked", sSearchProf},
				},
				[6] = {
					{"Download Profiles Checked", sDlProf},
				},
				[7] = {
					{"Publick Hub Profiles Checked", sPubHubProf},
				},
			}
			for i=1, #tConfig do
				if i ~= nr then
					body = body.."\t"..string.rep("-",100).."\n"
					nr = i
				end
				for l=1, #tConfig[i] do
					if tConfig[i][l][2] ~= nil then
						local line = "\t"..string.format("%-40.55s",tConfig[i][l][1])
						local line2 = tConfig[i][l][2]
						body = body.." "..line.."\t: "..line2.."\n"
   	 				end
				end
				doMemClear()
				doReturn = "\n"..header..body..footer.."\n"
			end
		end,
		--Blocker.Func.doBlockerNoti(user,"clientcheck","*** "..(GetProfileName(user.iProfile) or "Unreg").." "..user.sNick.." with IP "..user.sIP.." ("..IP2Country.GetCountryName(user)..") has been "..t[nNr].." because: Unwanted client "..sClient.." v: "..sVersion)
		doBlockerNoti = function(user,mode,str)
			if tBlocker.nNotiMode then
				if user and str and tBlocker.NotiAct[mode] then
					if tBlocker.nNotiMode == 0 then
						for i in pairs(tBlocker.bNotiProf) do
							Core.SendToProfile(i, "<"..SetMan.GetString(21).."> "..str)
						end
					else
						for i in pairs(tBlocker.bNotiProf) do
							Core.SendPmToProfile(i, SetMan.GetString(21), str)
						end
					end
				end
			end
		end,
		
		doBlockerUserNoti = function(user, str)
			local sMsg = ""
			if tBlocker.bUserNoti then
				if user and str then
					Core.SendToUser(user, "*** "..str)
				end
			end
		end,
		
		doBlockerMagic = function(sStr)
			if sStr then
				local t = {["."] = true,["/"] = true,["%"] = true,}
				local t2 = {["%["] = "%%[",["%("] = "%%(",["%)"] = "%%)",["%."] = "%%.",["%+"] = "%%+",	["%-"] = "%%-",	["%*"] = "%%*",	["%?"] = "%%?",	["%["] = "%%[",	["%^"] = "%%^",	["%$"] = "%%$",	}
				local str = sStr
				str = str:gsub("%.","%%%.")
				for s in pairs(t2) do
					if not t[s] then 
						str = str:gsub(s, t2[s]) 
					end
				end
				return str
			end
		end,
		
		BlockerSort = function()
			table.sort(tBlockerNick, function(i, v) return (i[2] > v[2]) end)
			SaveToFile("DiXBoT/CoreSystem/Blocker/tBlockerNick.lua", tBlockerNick,"tBlockerNick")
		end,
		
		------------------------------------------------ Rightclicks ------------------------------------------------
		doBlockerChatRC = function(user,data)
			local t = ProfMan.GetProfiles()
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Chat Block\\"..t[i].sProfileName.."\\PM True$<%[mynick]> !blockchat pm "..t[i].sProfileName.." true&#124;")
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Chat Block\\"..t[i].sProfileName.."\\PM False$<%[mynick]> !blockchat pm "..t[i].sProfileName.." false&#124;")
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Chat Block\\"..t[i].sProfileName.."\\MAIN True$<%[mynick]> !blockchat main "..t[i].sProfileName.." true&#124;")
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Chat Block\\"..t[i].sProfileName.."\\MAIN False$<%[mynick]> !blockchat main "..t[i].sProfileName.." false&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Chat Block\\Unreg\\PM True$<%[mynick]> !blockchat pm Unreg true&#124;")
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Chat Block\\Unreg\\PM False$<%[mynick]> !blockchat pm Unreg false&#124;")
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Chat Block\\Unreg\\MAIN True$<%[mynick]> !blockchat main Unreg true&#124;")
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Chat Block\\Unreg\\MAIN False$<%[mynick]> !blockchat main Unreg false&#124;")
		end,
		doBlockerSearchRC = function(user,data)
			local t = ProfMan.GetProfiles()
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Search Block\\"..t[i].sProfileName.."\\True$<%[mynick]> !blockSearch "..t[i].sProfileName.." true&#124;")
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Search Block\\"..t[i].sProfileName.."\\False$<%[mynick]> !blockSearch "..t[i].sProfileName.." false&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Search Block\\Unreg\\True$<%[mynick]> !blockSearch Unreg true&#124;")
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Search Block\\Unreg\\False$<%[mynick]> !blockSearch Unreg false&#124;")
		end,
		doBlockerPsvSearchRC = function(user,data)
			local t = ProfMan.GetProfiles()
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Passive Search Block\\"..t[i].sProfileName.."\\True$<%[mynick]> !blockpsvSearch "..t[i].sProfileName.." true&#124;")
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Passive Search Block\\"..t[i].sProfileName.."\\False$<%[mynick]> !blockpsvSearch "..t[i].sProfileName.." false&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Passive Search Block\\Unreg\\True$<%[mynick]> !blockpsvSearch Unreg true&#124;")
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Passive Search Block\\Unreg\\False$<%[mynick]> !blockpsvSearch Unreg false&#124;")
		end,
		doBlockerDLRC = function(user,data)
			local t = ProfMan.GetProfiles()
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Download Block\\"..t[i].sProfileName.."\\True$<%[mynick]> !blockdl "..t[i].sProfileName.." true&#124;")
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Download Block\\"..t[i].sProfileName.."\\False$<%[mynick]> !blockdl "..t[i].sProfileName.." false&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Download Block\\Unreg\\True$<%[mynick]> !blockdl Unreg true&#124;")
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Download Block\\Unreg\\False$<%[mynick]> !blockdl Unreg false&#124;")
		end,
		doBlockerNickRC = function(user,data)
			local t = ProfMan.GetProfiles()
			for i=1, #t do
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Bad Nick Block\\"..t[i].sProfileName.."\\True$<%[mynick]> !blocknick "..t[i].sProfileName.." true&#124;")
				Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Bad Nick Block\\"..t[i].sProfileName.."\\False$<%[mynick]> !blocknick "..t[i].sProfileName.." false&#124;")
			end
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Bad Nick Block\\Unreg\\True$<%[mynick]> !blocknick Unreg true&#124;")
			Core.SendToUser(user,"$UserCommand 1 15  • Security\\Blocker\\Bad Nick Block\\Unreg\\False$<%[mynick]> !blocknick Unreg false&#124;")
		end,
		------------------------------------------------ Rightclicks ------------------------------------------------
	
	},
	
	Timers = {
		["BlockerSort"] = {3600,0,"Blocker Perf. Optimizer",},
		["doBlockerStatsSave"] = {600,0,"Blocker Stats. Save.",},
	},
	
	Asserts = {
		[1] = "DiXBoT/CoreSystem/Blocker/tBlocker.lua",
		[2] = "DiXBoT/CoreSystem/Blocker/tBlockerNick.lua",
		[3] = "DiXBoT/CoreSystem/Blocker/tBlockerTmp.lua",
		[4] = "DiXBoT/CoreSystem/Blocker/tBlockerStats.lua",
	},
		
	DxbMgrArrival = {
		doBlocker = {"blocker",function(user)
			table.insert(tCoroutine, coroutine.create(function()
				local tAct = {["disc"] = "Disconnect",["redir"] = "Redirect", ["kick"] = "Kick",["ban"] = "Ban",}
				local tNotiAct = {["nick"] = true,["chatmc"] = true,["chatpm"] = true,["search"] = true,["download"] = true,["pubhub"] = true,["clientcheck"] = true,["countrycheck"] = true,}
				local sConf = "$BLOCKER"
				local sNickProf = "$BLOCKER§NICKPROF "
				local sChatProf = "$BLOCKER§CHATPROF "
				local sSearchProf = "$BLOCKER§SEARCHPROF "
				local sDlProf = "$BLOCKER§DLPROF "
				local sPubHubProf = "$BLOCKER§PUBHUBPROF "
				local sNickString = "$BLOCKER§NICKSTRING "
				local sNotiProf = "$BLOCKER§NOTIPROF "
				local sClientProf = "$BLOCKER§CLIENTPROF "
				local sCountryProf = "$BLOCKER§COUNTRYPROF "
				local sNotiAct = ""


				local tPubHubAct = {[0] = "Warn", [1] = "Disc", [2] = "Redir", [3] = "Kick", [4] = "Ban", }
				
				for act in pairs(tNotiAct) do
					sNotiAct = sNotiAct..act.."\\"..tostring(tBlocker.NotiAct[act]or "false")..","
				end
				t1 = {
					["notimode"] = tostring(tBlocker.nNotiMode or "false"),
					["notiact"] = sNotiAct,
					["pubhubact"] = tPubHubAct[tBlocker.PubHubAct],
					["usernoti"] = tostring(tBlocker.bUserNoti or "false"),
					["cbact"] = (tBlocker.BlockClientAct or "disc"),
					["cbstatus"] = tostring(tBlocker.bClientCheck or "false"),
					["cbunknown"] = tostring(tBlocker.bAllowUnknown or "false"),
					["countrycheck"] = tostring(tBlocker.bCountryCheck or "false"),
					["countrynew"] = tostring(tBlocker.bAllowNewCountry or "false"),
					["countryunknown"] = tostring(tBlocker.bAllowUnknownCountry or "false"),
					["countryact"] = tBlocker.BlockCountryAct or "disc",
				}
				for a,b in pairs(t1) do
					sConf = sConf.."§"..a.." "..b
				end
				Core.SendToUser(user,"$DXB "..sConf)
				
				local t = ProfMan.GetProfiles()
				for i=1, (#t+1) do
					if t[i] then
						if t[i].tProfilePermissions.bIsOP then
							sNickProf = sNickProf..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tBlocker.BlockNick[i-1]).."\\,"
							sChatProf = sChatProf..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tBlocker.BlockChat.MC[i-1]).."\\"..tostring(tBlocker.BlockChat.PM[i-1])..","
							sSearchProf = sSearchProf..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tBlocker.BlockSearch[i-1]).."\\"..tostring(tBlocker.BlockPsvSearch[i-1])..","
							sDlProf = sDlProf..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tBlocker.BlockDownload[i-1]).."\\,"
							sPubHubProf = sPubHubProf..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tBlocker.BlockPubHub[i-1]).."\\,"
							sClientProf = sClientProf..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tBlocker.bClientCheckProf[i-1])..","
							sCountryProf = sCountryProf..(GetProfileName(i-1) or "Unreg").."\\0\\"..tostring(tBlocker.bCountryCheckProf[i-1])..","
							
							sNotiProf = sNotiProf..(GetProfileName(i-1) or "Unreg").."/"..tostring(tBlocker.bNotiProf[i-1])..","
						else
							sNickProf = sNickProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockNick[i-1])..","
							sChatProf = sChatProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockChat.MC[i-1]).."\\"..tostring(tBlocker.BlockChat.PM[i-1])..","
							sSearchProf = sSearchProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockSearch[i-1]).."\\"..tostring(tBlocker.BlockPsvSearch[i-1])..","
							sDlProf = sDlProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockDownload[i-1])..","
							sPubHubProf = sPubHubProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockPubHub[i-1])..","
							sClientProf = sClientProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.bClientCheckProf[i-1])..","
							sCountryProf = sCountryProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.bCountryCheckProf[i-1])..","
						end
					else
						sNickProf = sNickProf..(GetProfileName(-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockNick[-1])..","
						sChatProf = sChatProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockChat.MC[-1]).."\\"..tostring(tBlocker.BlockChat.PM[-1])..","
						sSearchProf = sSearchProf..(GetProfileName(i-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockSearch[-1]).."\\"..tostring(tBlocker.BlockPsvSearch[-1])..","
						sDlProf = sDlProf..(GetProfileName(-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockDownload[-1])..","
						sPubHubProf = sPubHubProf..(GetProfileName(-1) or "Unreg").."\\1\\"..tostring(tBlocker.BlockPubHub[-1])..","
						sClientProf = sClientProf..(GetProfileName(-1) or "Unreg").."\\1\\"..tostring(tBlocker.bClientCheckProf[-1])..","
						sCountryProf = sCountryProf..(GetProfileName(-1) or "Unreg").."\\1\\"..tostring(tBlocker.bCountryCheckProf[-1])..","
					end
				end

				Core.SendToUser(user,"$DXB "..sNickProf)
				Core.SendToUser(user,"$DXB "..sChatProf)
				Core.SendToUser(user,"$DXB "..sSearchProf)
				Core.SendToUser(user,"$DXB "..sDlProf)
				Core.SendToUser(user,"$DXB "..sPubHubProf)
				Core.SendToUser(user,"$DXB "..sNotiProf)
				Core.SendToUser(user,"$DXB "..sClientProf)
				Core.SendToUser(user,"$DXB "..sCountryProf)
				
				for i = 1, #tBlockerNick do
					sNickString = sNickString..tBlockerNick[i][1].."\\"..tAct[tBlockerNick[i][3]].."\\"..string.gsub(tBlockerNick[i][2],"%%","")..","
				end
				Core.SendToUser(user,"$DXB "..sNickString)
			end))
		end,},
		
		doBlockerNickStr = {"blocknickstr",function(user)
			table.insert(tCoroutine, coroutine.create(function()
				local tAct = {["disc"] = "Disconnect",["redir"] = "Redirect", ["kick"] = "Kick",["ban"] = "Ban",}
				local sNickString = "$BLOCKER§NICKSTRING "
				for i = 1, #tBlockerNick do
					sNickString = sNickString..tBlockerNick[i][1].."\\"..tAct[tBlockerNick[i][3]].."\\"..tBlockerNick[i][2]..","
				end
				Core.SendToUser(user,"$DXB "..sNickString)			
			end))
		end,},
		
		doBlockerClientList = {"blockclientlist",function(user)
			for sClient in pairs(tClients) do
				local s = ""
				s = sClient.."\\"..tClients[sClient].bAllow..";"
				for sV in pairs(tClients[sClient]) do
					if sV ~= "bAllow" then
						s = s..sV.."\\"..tClients[sClient][sV]..","
					end
				end
				Core.SendToUser(user, "$DXB $BLOCKER§CLIENTLIST "..s)	
			end
		end,},
		
		doBlockerCountryList = {"blockcountrylist",function(user)
			for sCountry in pairs(tCountry) do
				local s = ""
				s = s..sCountry..","..tCountry[sCountry].."\\"
				Core.SendToUser(user, "$DXB $BLOCKER§COUNTRYLIST "..s)
			end
		end,},
	},
	
	OnStartup = {
		doCheckTable = function()
			if tBlocker["BlockClientAct"] == nil then tBlocker["BlockClientAct"] = "disc" end
			if tostring(tBlocker["bClientCheck"]) == nil then tBlocker["bClientCheck"] = false end
			if tostring(tBlocker["bAllowUnknown"]) == nil then tBlocker["bAllowUnknown"] = true end
			if type(tBlocker["bClientCheckProf"]) ~= "table" then tBlocker["bClientCheckProf"] = {} end
			if tostring(tBlocker["bCountryCheck"]) == nil then tBlocker["bCountryCheck"] = false end
			if tostring(tBlocker["BlockCountryAct"]) == nil then tBlocker["BlockCountryAct"] = "redir" end
			if type(tBlocker["bCountryCheckProf"]) ~= "table" then tBlocker["bCountryCheckProf"] = {} end
			if tostring(tBlocker["bAllowNewCountry"]) == nil then tBlocker["bAllowNewCountry"] = true end
			if tostring(tBlocker["bAllowUnknownCountry"]) == nil then tBlocker["bAllowUnknownCountry"] = true end
			SaveToFile("DiXBoT/CoreSystem/Blocker/tBlocker.lua", tBlocker,"tBlocker")
			if type(tBlockerStats) ~= "table" then tBlockerStats = {} end
			SaveToFile("DiXBoT/CoreSystem/Blocker/tBlockerStats.lua", tBlockerStats,"tBlockerStats")
		end,
	},
		
	DxbLoad = {
		doLoadDxbBlockerCmd = function()
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Blocker/ini/CMD.ini")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Blocker/ini/LANG.ini")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Blocker/ini/CONF.ini")
			if Blocker.Conf.Lang then
				local f = io.open(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Blocker/lang/"..Blocker.Conf.Lang..".lang", "r")
				if f then
					dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Blocker/lang/"..Blocker.Conf.Lang..".lang")
				else
					Blocker.Conf.Lang = false
					Blocker.Lang2 = {}
					SaveToFile("DiXBoT/CoreSystem/Blocker/ini/CONF.ini", Blocker.Conf,"Blocker.Conf")
				end
			else
				Blocker.Lang2 = {}
			end
		end,
	},
	Lang2 = {},
}
DxbModule = {Blocker,Blocker.Lang2}