clicknext = 1


function tap(inx, iny, callmsg) 
  touchDown(0, inx, iny)
  mSleep(50)
  touchUp(0, inx,iny)
  sysLog(callmsg.." tap "..tostring(inx).." "..tostring(iny))
end



function start_zhanyi()
  local zhanyix1, zhanyiy1, zhanyix2, zhanyiy2
  local zhanyiflag1, zhanyiflag2
  
  zhanyix1, zhanyiy1 = findMultiColorInRegionFuzzy(0xa0e318,"0|1|0x9fe217", 95, 288, 36, 293, 38)
  if zhanyix1 > -1 then
    zhanyiflag1 = true
  end
  
  zhanyix2, zhanyiy2 = findMultiColorInRegionFuzzy(0xf8d879,"12|-1|0xf7d776", 95, 1100, 600, 1125, 614)
  if zhanyix2 > -1 then
    zhanyiflag2 = true
  end
  
  if zhanyiflag1 and zhanyiflag2 then
    tap(1115, 610, "start_zhanyi")
    mSleep(1000)
    
    --尝试20次
    for i = 1, 20 do
      zhanyix1, zhanyiy1 = findMultiColorInRegionFuzzy(0xa0e318,"0|1|0x9fe217", 95, 288, 36, 293, 38)
      if zhanyix1 > -1 then
        tap(1115, 610, "start_zhanyi")
        mSleep(2000)
      else
        sysLog("break for in start zhanyi")
        break
      end
    end
  end
end

function select_hero()

  local heroid = createHUD()     --创建一个HUD
	showHUD(heroid,"选择英雄",12,"0xffff0000","0xffffffff",0,530,700,128,22)      --显示HUD内容
	mSleep(1000)
	hideHUD(heroid)
  tap(1150, 636, "select_hero")
  mSleep(2000)

  --尝试20次
  for k = 1, 20 do
    local x1, y1
    x1, y1 = findMultiColorInRegionFuzzy(0xffe363,"-4|2|0x231a20,3|2|0x281f1f,0|8|0x2e231f", 95, 108,134, 122, 149)
    if x1 > -1 then
      tap(1150, 636, "select_hero")
      mSleep(3000)
    else
       sysLog("break select_hero")
       break
    end
    
    
  end
  
  --自动战斗
	tap(1150, 636, "自动战斗")
  --sysLog("select_hero")
end

function left_dialog( )
  local x, y
  keepScreen(true)
  x, y = findMultiColorInRegionFuzzy(0x7f6f63,"1|1|0x857568,264|0|0x958676,264|1|0x806e64", 95, 114, 550, 433, 575)
  if x > -1 then
    tap(670, 685, "left_dialog")
    --sysLog("letf dialog")
    mSleep(200)
  end
  keepScreen(false)
  
end


function right_dialog( )
  local x, y
  keepScreen(true)
  x, y = findMultiColorInRegionFuzzy(0x827166,"-1|-1|0x7e6d62,263|1|0x88776a,262|-1|0x77675a", 95, 854, 554, 1133, 569)
  if x > -1 then
    tap(670, 685, "right_dialog")
    --sysLog("right dialog");
    mSleep(200)
  end
  keepScreen(false)
end


function update_ui()
  local x1, y1
  local x2, y2
  local cl
  --	laststate, nowstate;
  --	infight, inWin = 1 , 2
  
  --	sysLog("in update ui")
  --	keepScreen(true)
  --	取战队升级4个蓝字，8个点
  --	x1, y1 = findMultiColorInRegionFuzzy(0x71e7fa,"36|-1|0x40e8f1,77|6|0x4ee7ff,118|7|0x3ae3ff,173|5|0x45def8,204|4|0x28e2ff,250|9|0x39daf7,290|5|0x2dd9fd", 90,478, 102, 804, 179)
  --	cl =  getColor(978, 180)
  --	sysLog(tostring(c1))
  --	判断绿色的最上面小箭头
  --	x2, y2 = findMultiColorInRegionFuzzy(0xb8f764,"1|4|0xacf354,-12|3|0x93eb31", 80, 644, 250, 674, 260)
  --	sysLog("update ui x2")
  --	sysLog(tostring(x2))
  --	if x1 > -1 and x2 > -1 then
  --x1, y1 = findMultiColorInRegionFuzzy(0xf7d673,"3|8|0xf1c034,24|4|0xf6d164,24|13|0xf2c237", 95, 47, 23, 80,61)
  --if x1 > -1 then
  --	nowstate = infight
  --else
  --	nowstate = inWin
  --end
  
  ----上次查询是战斗，本次不在战斗认为进入了胜利界面
  --if laststate == infight and nowstate = inWin then
  --		tap(977, 180)
  --		sysLog("tap update")
  --		mSleep(2000)
  --end 
  --laststate = nowstate
  
  
  --	if x2 > -1 then
  --		tap(977, 180)
  --		sysLog("tap update")
  --		mSleep(2000)
  --	end
  
  --	keepScreen(false)
end

function win_ui()
  local x, y
  local x1 , y1 
  local x2 , y2 
  local notmain = false
  sysLog("in win ui")
 
  keepScreen(true)
  x, y = findMultiColorInRegionFuzzy(0xf7d673,"-1|12|0xf0bc2b,23|-1|0xf8dc7f,25|13|0xf5d061", 95, 43, 20, 83, 68)
  if x > -1 then
    nowstep = "fight"
  else
    nowstep = "win"
  end
  keepScreen(false)
  
  keepScreen(true)
  --判断左边绿色的加号+
  x1, y1 = findMultiColorInRegionFuzzy(0xa0e318,"1|1|0xa0e318", 95, 288,35, 292,37)
  if x1 > -1 then
    notmain = false
  else
    notmain = true
  end
  keepScreen(false)
  
  --上一个周期为fight，本周期为win, 同时不在战役主界面和英雄选择界面，则认为进入了胜利界面
  if nowstep == "win" and laststep == "fight" and notmain then
    --sysLog("in win ui")
    --处理一下战队升级
		
    tap(979, 179, "win_ui")
    mSleep(200);
    tap(979, 179, "win_ui")
    mSleep(200);
    
    --中间连点三次处理某些提示类信息
    tap(590, 385,"win_ui 1")
    mSleep(1000);
    tap(590, 385, "win_ui 2")
    mSleep(1000);
    tap(590, 385,"win_ui 3")
    mSleep(1000);
    tap(590, 385,"win_ui 4")
    mSleep(1000);
    
    --点击向右箭头
    tap(1084, 534, "win_ui 5")
    
    return true
  end
  laststep = nowstep
  
  return false
end 


function hero_big_magic_3( )
  local bigmagic = {0, 0, 0, 0, 0}
  
  local x1,y1, x2, y2, x3, y3, x4, y4, x5, y5
  
  --检测2号英雄
  keepScreen(true)
  --检测2号英雄下面的橙色条
  x2, y2 = findMultiColorInRegionFuzzy(0xfd601b,"0|4|0xff3908", 90, 486 ,691, 500, 705)
  if x2 > -1 then
    bigmagic[2] = 1
    tap(438, 574)
    sysLog("hero 2 big")
    mSleep(2000)
  end
  keepScreen(false)
  
  --检测3号英雄 使用方框右上角 取两个黄色的点
  keepScreen(true)
  x3, y3 = findMultiColorInRegionFuzzy(0xf5d93c,"0|-3|0xecea41", 90, 558, 508, 568, 516)
  if x3 > -1 then
    bigmagic[3] = 1
    tap(634, 589)
    sysLog("hero 3 big")
    mSleep(2000)
  end
  keepScreen(false)
  
  --检测4号英雄 使用方框右上角 取两个黄色的点
  keepScreen(true) 
  x4, y4 = findMultiColorInRegionFuzzy(0xe8e03b,"1|1|0xeeed40", 90, 752, 510, 759, 516)
  if x4 > -1 then
    bigmagic[4] = 1
    tap(825, 578)
    sysLog("hero 4 big")
    mSleep(2000)
  end
  keepScreen(false)
  --检测5号英雄
  
end			

function hero_big_magic_4( )
  local x1,y1, x2, y2, x3, y3, x4, y4
  
  keepScreen(true)
  --检测1号英雄 使用方框右上角 取两个黄色的点
  x1, y1 = findMultiColorInRegionFuzzy(0xeeee36,"1|0|0xeeee3c", 95, 270, 511, 278, 571)
  if x1 > -1 then
    tap(346, 578, "hero_big_1")
    mSleep(2000)
  end
  keepScreen(false)
  
  --检测2号英雄 使用方框右上角 取两个黄色的点
  keepScreen(true)
  x2, y2 = findMultiColorInRegionFuzzy(0xedeb3e,"2|-1|0xf0e842", 95, 463, 507, 469, 515)
  if x2 > -1 then
    tap(539, 519,"hero_big_2")
    mSleep(2000)
  end
  keepScreen(false)
  
  --检测3号英雄 使用方框右上角 取两个黄色的点
  keepScreen(true)
  x3, y3 = findMultiColorInRegionFuzzy(0xece741,"2|-1|0xefeb43", 95, 569, 509, 662,515)
  if x3 > -1 then
    tap(724, 584, "hero_big_3")
    mSleep(2000)
  end
  keepScreen(false)
  
  keepScreen(true)
  x4, y4 = findMultiColorInRegionFuzzy(0xeeea3d,"2|0|0xf0e842", 95, 849, 511, 856,517)
  if x4 > -1 then
    tap(929, 574, "hero_big_4")
    mSleep(2000)
  end
  keepScreen(false)
  
end


function hero_big_magic_5( )
  local x1,y1, x2, y2, x3, y3, x4, y4, x5, y5
  
  keepScreen(true)
  --检测1号英雄 头像下面的红色条
  x1, y1 = findMultiColorInRegionFuzzy(0xf76119,"-1|-1|0xf86412", 95, 298, 695, 304, 699)
  if x1 > -1 then
    tap(248, 579, "hero_big_1")
    mSleep(2000)
  end
  keepScreen(false)
  
  --检测2号英雄 头像下面的红色条
  keepScreen(true)
  x2, y2 = findMultiColorInRegionFuzzy(0xef661d,"-1|-1|0xfe5e1a", 95,490, 696, 493, 699)
  if x2 > -1 then
    tap(440, 582,"hero_big_2")
    mSleep(2000)
  end
  keepScreen(false)
  
  --检测3号英雄 头像下面的红色条
  keepScreen(true)
  x3, y3 = findMultiColorInRegionFuzzy(0xf66613,"0|3|0xff4511", 95,685, 695, 689, 702)
  if x3 > -1 then
    tap(628, 590, "hero_big_3")
    mSleep(2000)
  end
  keepScreen(false)
  
	--检测4号英雄 头像下面的红色条
  keepScreen(true)
  x4, y4 = findMultiColorInRegionFuzzy(0xf76512,"0|2|0xff5411", 95, 876, 695, 891, 700)
  if x4 > -1 then
    tap(811, 587, "hero_big_4")
    mSleep(2000)
  end
  keepScreen(false)
  
	
	--检测5号英雄 头像下面的红色条
  keepScreen(true)
  x5, y5 = findMultiColorInRegionFuzzy(0xfd601b,"2|1|0xfa6116", 95, 1068,695, 1074, 700)
  if x5 > -1 then
    tap(1004, 591, "hero_big_5")
    mSleep(2000)
  end
  keepScreen(false)
  
end


function choose_mode( )
		--选择模式
		sysLog("choose_mode")
	if gamemode == 1 then
			--点击两次
			tap(797, 128, "gamemode 1")
			--tap(797, 128, "gamemode 1")
			mSleep(3000)
	elseif gamemode == 2 then
			tap(878, 123, "gamemode 2")
			--tap(878, 123, "gamemode 2")
			mSleep(3000)
	end 
end

clicknextX, clicknexty = 1100, 316
function action_clicknext( ) 

  local x, y
  keepScreen(true)
  --检测大的箭头块
  x, y = findMultiColorInRegionFuzzy(0xf4c94c,"-2|-26|0xf1c23b,50|-16|0xf9dc81,56|4|0xf3c84b", 90, 1036, 276, 1141, 359)
  if x > -1 then
    tap(clicknextX, clicknexty, "action_clicknext")
    --sysLog("click next")
  end
  keepScreen(false)
end

function choose_guanka()

	local zhanyimainid = createHUD()     --创建一个HUD
	showHUD(zhanyimainid,"查找关卡"..index,12,"0xffff0000","0xffffffff",0,530,700,128,22)      --显示HUD内容
	mSleep(1000)
	hideHUD(zhanyimainid)
	local guanka_flag = false
	keepScreen(true)
	--检查卷轴界面左边的小菱形
  mainx1, mainy1 			= findMultiColorInRegionFuzzy(0xbd6511,"1|1|0xb5600b", 95, 179, 134, 183, 137)
	--检查左边的小旗
	mainx11, mainyy1	  = findMultiColorInRegionFuzzy(0xf3c84c,"5|0|0xf4cb54", 95, 185, 123, 198, 127)
	
  if mainx1 > -1 or mainx11 > -1 then
    leftflag = true
  end
  
	
	
		--循环回第一关
	if index > guanka_mod[chapter_num] then
			index = 1
	end
  
	sysLog("index"..tostring(index))
  --检查卷轴界面右边的小菱形
  mainx2, mainy2 = findMultiColorInRegionFuzzy(0xc06711,"1|1|0xbd600f", 95, 711,133, 176,138)
  if mainx2 > -1 then
    rightflag = true
  end
	keepScreen(false)
	 
	 
  sysLog("in main"..tostring(leftflag).." "..tostring(rightflag))
  if leftflag and rightflag then
		if gamemode == 1 then
			tap(chapterx[chapter_num][index], chaptery[chapter_num][index], "zhanyi_main")
			mSleep(4000)
    elseif gamemode == 2 then
			tap(hardmodex[chapter_num][index], hardmodey[chapter_num][index], "zhanyi_main")
			mSleep(4000)
		end
    

    --连续判断10次
    for k = 1, 10 do
      mainx1 , mainy1 = findMultiColorInRegionFuzzy(0xbd6511,"1|1|0xb5600b", 95, 179, 134, 183, 137)
      if mainx1 > -1 then
        --仍然在战役主界面上则点击
				if gamemode == 1 then
					tap(chapterx[chapter_num][index], chaptery[chapter_num][index], "action_clicknext")
					mSleep(2000)
				elseif gamemode  == 2 then
					tap(hardmodex[chapter_num][index], hardmodey[chapter_num][index], "action_clicknext")
					mSleep(2000)
				end
      else
        sysLog("break zhanyi for loop")
        break
      end
      
    end
    --关卡数目加1
    index = index + 1
		guanka_flag = true
	end
		return guanka_flag
    --sysLog("click zhanyi main".. tostring(chapter2x[index])..tostring(chapter2y[index]))
end
  

guanka_mod = { 6, 7, 6, 7}
function zhanyi_main( )
  local mainx1, mainy1, mainx2, mainy2, mainx11, mainyy1
  local leftflag, rightflag
	
	sysLog("zhanyi main")
	choose_mode()
  nowstep = "main"
  
	
  if choose_guanka() then
	
		start_zhanyi()
    mSleep(4000)
    select_hero()
		
		--战斗
		zidongzhandou = createHUD()
		showHUD(zidongzhandou,"开始战斗",12,"0xffff0000","0xffffffff",0,5,659,128,20)      --显示HUD内容
		hideHUD(zidongzhandou)
		
		while true do
		 sysLog("fighting"..index)
		 win_flag = win_ui()
			if win_flag then
				sysLog("break win flag"..tostring(win_flag))
				break
			end
		
			left_dialog( )
			right_dialog( )
			action_clicknext()
	
			if hero_num == 5 then
				hero_big_magic_5()
			elseif hero_num == 4 then
				hero_big_magic_4()
			elseif hero_num == 3 then
				hero_big_magic_3()
			end
			
		end
	end
	
end



-------------------------------------------------
chapterx = {
								{305,303,507,914,1019,727},					--第1章普通模式x坐标
								{295,219,566, 594, 843, 1052, 865}, --第2章普通模式x坐标
								{344,347,622,857,1043,823} ,   			--第3章普通模式x坐标
								{272,515,334,658,779,973,1042}
								}
  chaptery = {
								{573,342,458,604,381,354},					--第1章普通模式y坐标
								{577,356,275, 546, 286, 358, 566},
								{340,618,433,307,489,604},
								{511,597,298,271,462,595,305}
								
							}
	
	hardmodex = { 
								{305,303,507,914,1019,727}, 
								{297,221,568,597,853,1069,856}
								}
								
	hardmodey = { 
								{573,342,458,604,381,354},
								{578,343,281,594,297,385,562}
								}
  
  index = 1
-------------------------------------------------

function main( ) 
  local rtn
  
  init("0", 1)--初始化触摸操控脚本
	setScreenScale(720,1280,0) --设置坐标
  start,setting = showUI("ui.json")--显示UI并获取设置
  
	if start == 0  then
      print("取消执行")
      lua_exit()--取消则退出
  end

	require "yuanzheng"

	--选择英雄个数
	if setting["heronum"] == "0" then
		hero_num = 3
		herostr = "3个英雄出战"
	elseif setting["heronum"] == "1" then
		hero_num = 4
		herostr = "4个英雄出战"
	elseif setting["heronum"] == "2" then
		hero_num = 5
		herostr = "5个英雄出战"
	end
	sysLog("hero_num"..tostring(hero_num))

	--选择关卡号
	if setting["chapter"] == "0" then
		chapter_num = 2
	elseif setting["chapter"] == "1" then
		chapter_num = 3
	elseif setting["chapter"] == "2" then
		chapter_num = 4
	elseif setting["chapter"] == "3" then
		chapter_num = 5
	elseif setting["chapter"] == "4" then
		chapter_num = 6
	elseif setting["chapter"] == "5" then
		chapter_num = 7
	elseif setting["chapter"] == "6" then
		chapter_num = 8
	elseif setting["chapter"] == "7" then
		chapter_num = 9
	end
	
	sysLog("chapter_num"..tostring(chapter_num))
	--sysLog("zidongzhanyi "..setting["zidongzhanyi"])
	
	if setting["mode"] == "0" then
		gamemode = 1 --普通模式
		modestr  = "普通模式"
	else
		gamemode = 2 --精英模式
		modestr  = "精英模式"
	end
	sysLog("gamemode"..tostring(gamemode))
	
	
	
	
	infor = "刷第"..tostring(chapter_num).."章".."\n"..modestr..herostr
	
	dialog(infor, 0)
	 
  
  while true do
    
    sysLog("start")
		--选中自动战役才执行
		--if setting["zidongzhanyi"] == "0" then
			zhanyi_main(index) 
		--end
		
		--yuanzheng()
	end
--dialog("finish", 2)
end

-- lua异常捕捉
function error(msg)
  local errorMsg = "[Lua error]"..msg
  print(errorMsg)    
end

xpcall(main, error)
--main()


