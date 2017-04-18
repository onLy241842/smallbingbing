function yuanzheng_main()
	local mainx1, mainy1, mainx2, mainy2
	local yuanzhengflag1 = false
	local yuanzhengflag2 = false
	
	--检查卷轴左边的菱形
	mainx1, mainy1 = findMultiColorInRegionFuzzy(0xc26d1b,"1|1|0xb96513", 95, 360,125, 365, 335)
	if mainx1 > -1 then
			yuanzhengflag1 = true
	end
	
	
	mainx2, mainy2 = findMultiColorInRegionFuzzy(0xbb6916,"1|1|0xbc6c19", 95, 920, 125, 930, 135)
	if mainx2 > -1 then
			yuanzhengflag2 = true
	end
	
	if yuanzhengflag1 and yuanzhengflag2 then
			return true
	else
			return false
	end
	
end


function yuanzheng_win()
		local yzwinx1, yzwiny1
		
	while true do
		yzwinx1, yzwiny1 = findMultiColorInRegionFuzzy(0xf6d062,"12|0|0xf5cd57,2|9|0xefb823,12|11|0xf1c13a", 95,1067, 520, 1090, 542)
		if yzwinx1 > -1 then
			yz_index = yz_index + 1
			if yz_index == 15 then
					yz_index = 1
			end
						
			tap(979, 179, "yz_win_ui")
			mSleep(200);
			tap(979, 179, "yz_win_ui")
			mSleep(200);
    
			--中间连点三次处理某些提示类信息
			tap(590, 385,"yz_win_ui 1")
			mSleep(1000);
			tap(590, 385, "yz_win_ui 2")
			mSleep(1000);
			tap(590, 385,"yz_win_ui 3")
			mSleep(1000);
			tap(590, 385,"yz_win_ui 4")
			mSleep(1000);
    
    --点击向右箭头
    tap(1084, 534, "yz_win_ui 5")
		break
		end
	end
end

function auto_fight()
			local autox1, autox2
			autox1, autox2 = findMultiColorInRegionFuzzy(0x211a15,"-1|9|0x261c17", 95, 1145, 575, 1150, 588)
			if autox1 > -1 then
				tap(1184, 597, "auto_fight")
			else
				return
			end
end

yz_pox = { 
						{x = 527, y = 312, mode = "gk"},
						{x = 468, y = 468, mode = "bx"},
						{x = 650, y = 523, mode = "gk"}, 
						{x = 868, y = 545, mode = "bx"},
						{x = 905, y = 402, mode = "gk"}, }
yz_index = 1;

function yuanzheng_map_click()
	
		--点击关卡或者宝箱
		--处理关卡,直接点击
		if yz_pox[yz_index].mode == "gk" then
			 --tap(yz_pox[yz_index].x, yz_pox[yz_index].y, "远征关卡")
			 tap(596, 528, " 测试点击")
			 mSleep(1000)
			 tap(947, 414, "确认敌方信息")
			 select_hero()
			 auto_fight()
			 yuanzheng_win()
		else
			 tap(yz_pox[yz_index].x, yz_pox[yz_index].y, "到达宝箱")
			 tap(638,516,"领取宝箱")
		end 
			 

end 


function yuanzheng()
		local main_ui
		
		main_ui = yuanzheng_main()
		if main_ui then
			 yuanzheng_map_click()
		end
end
		
		