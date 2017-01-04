Stats = {

	UserConnected = {
		doStatsUser = function(user,data)
			Stats.Func.doHubStatCal(1)
		end,
	},

	RegConnected = {
		doStatsUser = function(user,data)
			Stats.Func.doHubStatCal(1)
		end,
	},

	OpConnected = {
		doStatsOp = function(user,data)
			Stats.Func.doHubStatCal(1)
		end,
	},

	ChatArrival = {
		doStatChat = function(user,data)
			local s,e,p,sChat = string.find(data,"%b<>%s+(%S)(.*)|")
			if not tCoreConfig.System.Prefix[p] then
				Stats.Func.doHubStatsChatCal(1)
			end
		end,
	},

	Func = {

		SetHubStartDate = function(user,data)
			doArg3(data)
			if (arg or arg2 or arg3) == nil then
				doReturn = {Stats.Lang[1][2], (Stats.Lang2[1] or Stats.Lang[1][1])}
			elseif string.find(arg, "%a") or string.find(arg2, "%a") or string.find(arg3, "%a") then
				doReturn = {Stats.Lang[2][2], (Stats.Lang2[2] or Stats.Lang[2][1])}
			elseif tonumber(arg) < 1970 then
				doReturn = {Stats.Lang[3][2], (Stats.Lang2[3] or Stats.Lang[3][1])}
			elseif tonumber(arg2) > 12 then
				doReturn = {Stats.Lang[4][2], (Stats.Lang2[4] or Stats.Lang[4][1]), "12"}
			elseif tonumber(arg3) > 31 then
				doReturn = {Stats.Lang[4][2], (Stats.Lang2[4] or Stats.Lang[4][1]), "12"}
			else
				local table = {["year"] = tonumber(arg),["month"] = tonumber(arg2),["day"] = tonumber(arg3),["hour"] = 12,["min"] = 0,["sec"] = 0, ["isdst"] = 1}
				tDxbStats.FirstRun.Date = arg2.."/"..arg3.."/"..arg.." 12:00:00"
				tDxbStats.FirstRun.Time = os.time(table)
				SaveToFile("DiXBoT/CoreSystem/Stats/tDxbStats.lua", tDxbStats,"tDxbStats")
				doReturn = {Stats.Lang[5][2], (Stats.Lang2[5] or Stats.Lang[5][1])}
			end
		end,

		doResetStats = function(user,data)
			doArg1(data)
			if arg == nil then
				doReturn = {Stats.Lang[6][2], (Stats.Lang2[6] or Stats.Lang[6][1])}
			elseif arg:lower() == "hours" then
				tHubStats.Hours = {}
				SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
				doReturn = {Stats.Lang[7][2], (Stats.Lang2[7] or Stats.Lang[7][1]), arg:upper()}
			elseif arg:lower() == "days" then
				tHubStats.Days = {}
				SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
				doReturn = {Stats.Lang[7][2], (Stats.Lang2[7] or Stats.Lang[7][1]), arg:upper()}
			elseif arg:lower() == "months" then
				tHubStats.Months = {}
				SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
				doReturn = {Stats.Lang[7][2], (Stats.Lang2[7] or Stats.Lang[7][1]), arg:upper()}
			elseif arg:lower() == "stability" then
				tDxbStats.Restart.Count = 0
				tDxbStats.Reboot.Count = 0
				tDxbStats.Down = 0
				SaveToFile("DiXBoT/CoreSystem/Stats/tDxbStats.lua", tDxbStats,"tDxbStats")
				doReturn = {Stats.Lang[7][2], (Stats.Lang2[7] or Stats.Lang[7][1]), arg:upper()}
			elseif arg:lower() == "all" then
				tDxbStats.Restart.Count = 0
				tDxbStats.Reboot.Count = 0
				tDxbStats.Down = 0
				SaveToFile("DiXBoT/CoreSystem/Stats/tDxbStats.lua", tDxbStats,"tDxbStats")
				tHubStats.Hours = {}
				tHubStats.Days = {}
				tHubStats.Months = {}
				SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
				doReturn = {Stats.Lang[7][2], (Stats.Lang2[7] or Stats.Lang[7][1]), arg:upper()}
			else
				doReturn = {Stats.Lang[6][2], (Stats.Lang2[6] or Stats.Lang[6][1])}
			end
		end,

		doHubStatCal = function(i)
			local tModes = {[1] = "Hours", [2] = "Days", [3] = "Months",}
			local tday = {["0"] = "Sunday",["1"] = "Monday",["2"] = "Tuesday",["3"] = "Wednesday",["4"] = "Thursday",["5"] = "Friday",["6"] = "Saturday",}
			local tmonth = { ["01"] = "January", ["02"] = "February", ["03"] = "March", ["04"] = "April", ["05"] = "May", ["06"] = "June", ["07"] = "July", ["08"] = "August", ["09"] = "September", ["10"] = "October", ["11"] = "November", ["12"] = "December", }
			local tNow = {["Hours"] = os.date("%H"), ["Days"] = tday[os.date("%w")], ["Months"] = tmonth[os.date("%m")],}
			local tCal = {["Share"] = Core.GetCurrentSharedSize(), ["Users"] = Core.GetUsersCount(),}

			if tHubStats.Record == nil then tHubStats.Record = {["nMaxUsers"]=Core.GetMaxUsersPeak(),["nMaxShare"]=0,["nMaxAvgShare"]=0,} end
			if Core.GetUsersCount() > tHubStats.Record.nMaxUsers then tHubStats.Record.nMaxUsers = Core.GetUsersCount() end
			if Core.GetCurrentSharedSize() > tHubStats.Record.nMaxShare then tHubStats.Record.nMaxShare = Core.GetCurrentSharedSize() end
			if (Core.GetCurrentSharedSize() > 0 and Core.GetUsersCount() > 0) and (Core.GetCurrentSharedSize()/Core.GetUsersCount()) > tHubStats.Record.nMaxAvgShare then tHubStats.Record.nMaxAvgShare = (Core.GetCurrentSharedSize()/Core.GetUsersCount()) end
			SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
			for i,v in ipairs(tModes) do
				if tHubStats[v].Now then
					if tHubStats[v].Now ~= tNow[v] then
						tHubStats[v].Now = tNow[v]
						tHubStats[v][tNow[v]] = {}
					end
				else
					tHubStats[v].Now = tNow[v]
				end
				for sCal in pairs(tCal) do
					if tHubStats[v][tNow[v]] then
						if tHubStats[v][tNow[v]][sCal] then
							if tHubStats[v][tNow[v]][sCal] < tCal[sCal] + 1 then
								tHubStats[v][tNow[v]][sCal] = tCal[sCal]+(i or 0)
								SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")	
							end
						else
							tHubStats[v][tNow[v]][sCal] = tCal[sCal]+(i or 0)
							SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")	
						end
					else
						tHubStats[v][tNow[v]] = {[sCal] = tCal[sCal]+(i or 0)}
						SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")	
					end
				end
			end
		end,

		doHubStatsChatCal = function(sChars)
			local tModes = {[1] = "Hours", [2] = "Days", [3] = "Months",}
			local tday = {["0"] = "Sunday",["1"] = "Monday",["2"] = "Tuesday",["3"] = "Wednesday",["4"] = "Thursday",["5"] = "Friday",["6"] = "Saturday",}
			local tmonth = { ["01"] = "January", ["02"] = "February", ["03"] = "March", ["04"] = "April", ["05"] = "May", ["06"] = "June", ["07"] = "July", ["08"] = "August", ["09"] = "September", ["10"] = "October", ["11"] = "November", ["12"] = "December", }
			local tNow = {["Hours"] = os.date("%H"), ["Days"] = tday[os.date("%w")], ["Months"] = tmonth[os.date("%m")],}
			for i,v in ipairs(tModes) do
				if tHubStats[v].Now then
					if tHubStats[v].Now ~= tNow[v] then
						tHubStats[v].Now = tNow[v]
						tHubStats[v][tNow[v]] = {}
						SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
					end
				else
					tHubStats[v].Now = tNow[v]
					SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
				end
				if tHubStats[v][tNow[v]] then
					if tHubStats[v][tNow[v]]["Chat"] then
						if not tHubStats[v][tNow[v]]["Chat"] == (tHubStats[v][tNow[v]]["Chat"] + sChars) then
							tHubStats[v][tNow[v]]["Chat"] = tHubStats[v][tNow[v]]["Chat"] + sChars
							SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
						end
					else
						tHubStats[v][tNow[v]]["Chat"] = sChars
						SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
					end
				else
					tHubStats[v][tNow[v]] = {["Chat"] = sChars}
					SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", tHubStats,"tHubStats")
				end
			end
		end,

		doShowHubstats = function(user,data)
			local sMode = {["hours"] = "Hours", ["days"] = "Days", ["months"] = "Months",}
			local sStat = {["share"] = "Share", ["users"] = "Users", ["chat"] = "Chat",}
			doArg2(data)
			if (arg or arg2) == nil then
				doReturn = {Stats.Lang[9][2], (Stats.Lang2[9] or Stats.Lang[9][1])}
			elseif sMode[string.lower(arg)] == nil then
				doReturn = {Stats.Lang[9][2], (Stats.Lang2[9] or Stats.Lang[9][1])}
			elseif sStat[string.lower(arg2)] == nil then
				doReturn = {Stats.Lang[9][2], (Stats.Lang2[9] or Stats.Lang[9][1])}
			else
				Stats.Func.doHubStatCal()
				doReturn = Stats.Func.doBuildHubStats(sMode[string.lower(arg)], sStat[string.lower(arg2)], 50)
			end
		end,

		doBuildHubStats = function(sMode,sStat, sMax)
			local tDivs = {
				["Share"] = 1024*1024,
				["Users"] = 1,
				["Chat"] = 10,
				}
			local tHH = {
				["Hours"] = {[1] = "00",[2] = "01",[3] = "02",[4] = "03",[5] = "04",[6] = "05",[7] = "06",[8] = "07",[9] = "08",[10] = "09",[11] = "10",[12] = "11",[13] = "12",[14] = "13",[15] = "14",[16] = "15",[17] = "16",[18] = "17",[19] = "18",[20] = "19",[21] = "20",[22] = "21",[23] = "22",[24] = "23",["n"] = 24,},
				["Days"] = {[1] = "Monday",[2] = "Tuesday",[3] = "Wednesday",[4] = "Thursday",[5] = "Friday",[6] = "Saturday",[7] = "Sunday",},
				["Months"] = { [01] = "January", [02] = "February", [03] = "March", [04] = "April", [05] = "May", [06] = "June", [07] = "July", [08] = "August", [09] = "September", [10] = "October", [11] = "November", [12] = "December",}
				}
			local header = ("\r\n\r\n\t"..string.rep(":", 100).."\r\n\t"..(SetMan.GetString(0) or "No HubName Entered").." Statistics: [ "..sStat.." / "..sMode.." ]\r\n\t"..string.rep(":", 100).."\r\n" or "Error")
			local footer = "\t"..string.rep(":", 100).."\r\n\t Type !help [ stats ] to get help.\r\n\t"..string.rep(":", 100)..""
			local names = ""
			local sDiv = 1
			local sPr = 0
			for i,v in ipairs(tHH[sMode]) do
				if tHubStats[sMode][v] and tHubStats[sMode][v][sStat] then
					if tHubStats[sMode][v][sStat] > sMax then
						while tHubStats[sMode][v][sStat]/(sDiv*tDivs[sStat]) > sMax do
							if sStat == "Share" then
								if sDiv > 15 then
									tDivs[sStat] = tDivs[sStat]*1024
									sDiv = 1
								else
									sDiv = sDiv + 1
								end
							else
								sDiv = sDiv + 1
							end
						end
					end
					if sStat == "Chat" then
						sPr = sPr + (tHubStats[sMode][v][sStat] or 0)
					end
				end
			end
			collectgarbage("collect")
			if sStat == "Chat" and sPr == 0  and sMode == "Hours" then
				doReturn = {Stats.Lang[8][2], (Stats.Lang2[8] or Stats.Lang[8][1])}
			end

			for i,v in ipairs(tHH[sMode]) do
				local sVal = ""
				local sID = ""
				if tHubStats[sMode][v] and tHubStats[sMode][v][sStat] then
					sVal = tHubStats[sMode][v][sStat]
				else
					sVal = 0
				end

				if sMode == "Hours" then
					sID = "\t"..v..":00 - "..v..":59"
				else
					sID = "\t"..v
				end

				if string.len(sID) < 15 then
					while string.len(sID) < 15 do
						sID = sID.." "
					end
				end 
				local a,b = "",""
				if sStat == "Share" then
					a,b = doShareCal(sVal),""
					sVal = sVal/(sDiv*tDivs[sStat])
				elseif sStat == "Users" then
					a,b = sVal,"User(s)"
					sVal = sVal/(sDiv*tDivs[sStat])
				elseif sStat == "Chat" then
					if sPr == 0 then
						a,b = "0", "%"
					else
						a,b = string.format("%.2f",(sVal/sPr)*100), "%"
					end
					if sVal == 0 then sVal = 1 end
					if sPr == 0 then sPr = 1 end
					sVal = string.format("%.0f",(sVal/sPr)*100/2)
				end
				local line = sID
				--local line2 = "["..string.rep("•", sVal/(sDiv*tDivs[sStat])).."] "..a.." "..b
				local line2 = "["..string.rep("•", sVal).."] "..a.." "..b
				names = names.." "..line.."\t: "..line2.."\r\n"
			end
			collectgarbage("collect")
			return "\r\n"..header..names..footer.."\r\n"

		end,

		doDxbNfo = function(user,data)
			local header = "\r\n\r\n\t"..string.rep(":", 100).."\r\n\t"..(SetMan.GetString(0) or "No HubName Entered").." DiXBoT Info:\r\n\t"..string.rep(":", 100).."\r\n"
			local footer = "\t"..string.rep(":", 100).."\r\n\t"..(SetMan.GetString(0) or "No HubName Entered").." WebSite: "..(tCoreConfig.System.WebSite or "No Website").."\r\n\t"..string.rep(":", 100)..""
			local names = ""
			local nr = 1
			local t = Core.GetUser(user.sNick, true)
			local tDxbNfo = {
				[1] = {
					{"DiXBoT Vers.", tDixbot.Name.." "..tDixbot.CodeName.." Build "..tDixbot.Build},
					{"Build Date", tDixbot.Date},
					{"Author      ", "Snooze"},
					{"Website", "www.dixbot.com"},
				},
				[2] = {
					{"PtokaX Vers.", "PtokaX "..Core.Version},
					{"Author      ", "PPK"},
					{"Website", "www.ptokax.org"},
				},
				[3] = {
					{"Hub Name", (SetMan.GetString(0) or "N/A")},
					{"Hub Desc.", (SetMan.GetString(5) or "N/A")},
					{"Hub Addy", SetMan.GetString(2)..":"..SetMan.GetString(3)},
					{"Hub WebSite", (tCoreConfig.System.WebSite or "N/A")},
					{"Hub Mail", (tCoreConfig.System.Mail or "N/A")},
				},
				[4] = {
					{"Hub Uptime", doTimeCal(Core.GetUpTime(), "long")},
				--	{"Server Uptime", doTimeCal(PXU.MsToHHmmssms(PXU.GetTickCount()*60*60))},
					{"UserPeak/UserMax", Core.GetActualUsersPeak().." User(s) / "..Core.GetMaxUsersPeak().." User(s)"},
					{"Current Users", Core.GetUsersCount().." User(s)"},
					{"Current Share", doShareCal(Core.GetCurrentSharedSize(),2)},
					{"Regged User(s)", table.maxn(RegMan.GetRegs()).." User(s)"},
					{"Regged User(s) Online", table.maxn(Core.GetOnlineRegs()).." User(s)"},
					{"NonRegged User(s) Online", Core.GetUsersCount()-table.maxn(Core.GetOnlineRegs()).." User(s)"},
				},
				[5] = {
					{"Your Nick", user.sNick},
					{"Your IP", user.sIP},
					{"Your Desc.", (t.sDescription or "N/A")},
					{"Your Client", (t.sClient or "N/A").." V:"..(t.sClientVersion or "N/A")},
					{"Hubs/Slots", (t.iHubs or "N/A").." Hub(s) / "..(t.iSlots or "N/A").." Slot(s).."},
					{"Your Connection", (t.sConnection or "N/A")},
					{"Your Mail", (t.sEmail or "N/A")},
					{"Your Profile", (GetProfileName(t.iProfile) or "Unregged")},
					{"Your Share", doShareCal(t.iShareSize,2)},
					{"Online Time", doTimeDif(t.iLoginTime)},
				},
			}
			for i=1, table.getn(tDxbNfo) do
				if i ~= nr then
					names = names.."\t"..string.rep("-",75).."\r\n"
					nr = i
				end
				for l=1, table.getn(tDxbNfo[i]) do
					if tDxbNfo[i][l][2] ~= nil then
						word = tDxbNfo[i][l][1]
						if string.len(word) < 35 then
							while string.len(word) < 35 do
								word = word.." "
							end
						end
						local line = "\t"..word
						local line2 = tDxbNfo[i][l][2]
						names = names.." "..line.."\t: "..line2.."\r\n"
   	 				end
				end
				collectgarbage("collect")
				doReturn = "\r\n"..header..names..footer.."\r\n"
			end					
		end,

		doShowDxbStats = function(user,data)
			local tStat = {
					[1] = {
						{"Hub Started", tDxbStats.FirstRun.Date},
						{"Hub Lifetime", doTimeCal(os.difftime(os.time(),tDxbStats.FirstRun.Time))},
						{"Hub Downtime", doTimeCal(tDxbStats.Down)},
						{"Hub Stability", 100-tonumber(string.format("%.8f",(tDxbStats.Down/os.difftime(os.time(),tDxbStats.FirstRun.Time))*100)).." %"},
					},
					[2] = {
						{"Hub Restarts", tDxbStats.Restart.Count.." Restart(s)"},
					--	{"Server Reboots", tDxbStats.Reboot.Count.." Reboot(s)"},
					},
					[3] = {
						{"Hub Uptime", doTimeCal(Core.GetUpTime())},
					--	{"Server Uptime", doTimeCal(PXU.MsToHHmmssms(PXU.GetTickCount()*60*60))},
					},
				}
			local header = "\r\n\r\n\t"..string.rep(":", 100).."\r\n\t"..SetMan.GetString(0).." DiXBoT Stability Stats:\r\n\t"..string.rep(":", 100).."\r\n"
			local footer = "\t"..string.rep(":", 100).."\r\n\tType !help to view available commands.\r\n\t"..string.rep(":", 100)..""
			local names = ""
			local nr = 1
			for i=1, table.getn(tStat) do
				if i ~= nr then
					names = names.."\t"..string.rep("-",75).."\r\n"
					nr = i
				end
				for l=1, table.getn(tStat[i]) do
					if tStat[i][l][2] ~= nil then
						word = tStat[i][l][1]
						if string.len(word) < 20 then
							while string.len(word) < 20 do
								word = word.." "
							end
						end
						local line = "\t"..word
						local line2 = tStat[i][l][2]
						names = names.." "..line.."\t: "..line2.."\r\n"
   	 				end
				end
				collectgarbage("collect")
				doReturn = "\r\n"..header..names..footer.."\r\n"
			end	
		end,

		doStatUptimeTmr = function()
			if tDxbStats.Last == "" then
				tDxbStats.Last = os.time()
			else
				if (os.time() - tonumber(tDxbStats.Last)) > 240 then
					tDxbStats.Reboot.Count = tDxbStats.Reboot.Count + 1
				end
				if (os.time() - tonumber(tDxbStats.Last)) > 120 then
					tDxbStats.Down = tDxbStats.Down + (os.time() - (tonumber(tDxbStats.Last)+120))
				end
				tDxbStats.Last = os.time()
			end
			--tDxbStats.Reboot.Tick = PXU.GetTickCount()
			tDxbStats.Restart.Tick = Core.GetUpTime()
			SaveToFile("DiXBoT/CoreSystem/Stats/tDxbStats.lua", tDxbStats,"tDxbStats")
		end,
	},

	Timers = {
		["doHubStatCal"] = {300,0,"HubStats updater",},
		["doStatUptimeTmr"] = {60,0,"Stability Stats",},
	},

	OnStartup = {
		doDxbStatsFirstrun = function()
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/tDxbStats.lua")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/tHubStats.lua")
			if type(tDxbStats) ~= "table" then
				local t = {["Restart"] = {["Count"] = 0,["Tick"] = 0,},
				["Reboot"] = {["Count"] = 0,["Tick"] = 0,},["Reboots"] = 0,
				["Down"] = 0,["FirstRun"] = {["Date"] = "",["Time"] = 0,},["Last"] = 0,}
				SaveToFile("DiXBoT/CoreSystem/Stats/tDxbStats.lua", t,"tDxbStats")
				dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/tDxbStats.lua")
			end
		
			if type(tHubStats) ~= "table" then
				local t2 = {["Hours"] = {["Now"] = "",},
						["Days"] = {["Now"] = "",},
						["Months"] = {["Now"] = "",},
						}
				SaveToFile("DiXBoT/CoreSystem/Stats/tHubStats.lua", t2,"tHubStats")
				dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/tHubStats.lua")
				Core.SendToAll("*** tHubStats.lua table fixed.")
			end

			if tDxbStats.FirstRun.Date == "" then
				tDxbStats.FirstRun.Date = os.date()
				tDxbStats.FirstRun.Time = os.time()
				SaveToFile("DiXBoT/CoreSystem/Stats/tDxbStats.lua", tDxbStats,"tDxbStats")
			end
		--	if tDxbStats.Reboot.Tick == "" then
		--		tDxbStats.Reboot.Tick = PXU.GetTickCount()
		--	elseif tDxbStats.Reboot.Tick > PXU.GetTickCount() then
		--		tDxbStats.Reboot.Count = tDxbStats.Reboot.Count + 1
		--		SaveToFile("DiXBoT/CoreSystem/Stats/tDxbStats.lua", tDxbStats,"tDxbStats")
		--	end
			if tDxbStats.Restart.Tick == "" then
				tDxbStats.Restart.Tick = core.GetUpTime()
			elseif tDxbStats.Restart.Tick > Core.GetUpTime() then
				tDxbStats.Restart.Count = tDxbStats.Restart.Count + 1
				SaveToFile("DiXBoT/CoreSystem/Stats/tDxbStats.lua", tDxbStats,"tDxbStats")
			end
		end,
	},
	
	DxbMgrArrival = {
		doStatsHours = {"statshours",function(user)
			local t = {[1] = "00",[2] = "01",[3] = "02",[4] = "03",[5] = "04",[6] = "05",[7] = "06",[8] = "07",[9] = "08",[10] = "09",[11] = "10",[12] = "11",[13] = "12",[14] = "13",[15] = "14",[16] = "15",[17] = "16",[18] = "17",[19] = "18",[20] = "19",[21] = "20",[22] = "21",[23] = "22",[24] = "23",}
			local sStats = "$HUBSTATS§STATHOUR "
			for i,v in ipairs(t) do
				--Core.SendToAll(v)
				if tHubStats.Hours[v] then
					sStats = sStats..tHubStats.Hours[v]["Users"]..";"
				else
					sStats = sStats.."0;"
				end
			end	
			Core.SendToUser(user,"$DXB "..sStats)
		end,},
	},

	DxbLoad = {
		doLoadStats = function()
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/ini/CMD.ini")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/ini/LANG.ini")
			dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/ini/CONF.ini")

			if Stats.Conf.Lang then
				local f = io.open(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/lang/"..Stats.Conf.Lang..".lang", "r")
				if f then
					dofile(tCoreConfig.System.wPath.."DiXBoT/CoreSystem/Stats/lang/"..Stats.Conf.Lang..".lang")
				else
					Stats.Conf.Lang = false
				Stats.Lang2 = {}
					SaveToFile("DiXBoT/CoreSystem/Stats/ini/CONF.ini", Stats.Conf,"Stats.Conf")
				end
			else
				Stats.Lang2 = {}
			end
		end,
	},
	Lang2 = {},
}
DxbModule = {Stats,Stats.Lang2}