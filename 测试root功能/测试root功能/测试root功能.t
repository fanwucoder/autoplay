﻿Unit={
State={},
Param={}
}
H={}
function processState(stateTable,stateName,stateParam)
    if stateTable[stateName]~=nil then
        return stateTable[stateName](stateParam)
    end
    return "Error"
end
H["登录界面"]={
{"登录按钮",0.8,725,645,775,698,"101A28-111111","7|7|101A28-111111,6|19|101A28-111111"},
}
function floatwinrun()
    -- 浮动窗口运行按钮执行的事件,如果不需要可去掉
    require("XM")
    XM.AddTable(H)
    setrotatescreen(0)
    

 
    local ret = screencap(0,0,500,500,"/sdcard/t.bmp")
if ret == true then
lineprint("截图成功")
else
lineprint("截图失败")
end

   local ret= cmdnew("su root screencap -p /sdcard/aa.png")
   lineprint(ret)
    --    while true do    
    --        
    --        
    --        x,y,ret=findmulticolor(180,555,264,634,"009688-111111","0|0|009688-111111,-1|19|009688-111111",0.9,0)
    --        
    --        
    --        if x~=-1 then
    --            lineprint("找到颜色")
    --            lineprint(tostring(x))
    --            lineprint(tostring(y))
    --        else
    --            lineprint("什么鬼a")    
    --        end
    --        --releasecapture()
    --        
    --    end
    --    
    --    XM.SetTableID("登录界面")
    --    
    --    while true do
    --        XM.KeepScreen()
    --        if XM.Find(5,"登录按钮",true) then
    --            lineprint("找到登录了")   
    --        else
    --            lineprint("什么鬼，找不到!")
    --        end
    --    end
    
end
function main()
    
    Unit.State.Name="init"
    while true do
        Unit.State.Name=processState(Unit.State,Unit.State.Name,Unit.Param[Unit.State.Name])
        XM.Print("当前状态:"..Unit.State.Name)
        sleep(200)
    end
    
end
PACKAGES={"com.hegu.dnl.mi","com.hegu.dnl.sn79"}
-- appType类型
APP_XM=1 -- 小米
APP_SS=2 -- 上士
function startApp(appType)
    if appType==APP_XM then
        messagebox("启动小米版")
        local ret = cmd("su root am start -n com.hegu.dnl.mi/com.hegu.dnl.MainActivity") 
        return ret~=nil
    else
        local package=PACKAGES[appType]
        local ret=sysstartapp(package)
        return ret==1
    end
    
    
    return ret==1
    
end
function isRuning(appType)
    local ret=sysisrunning(PACKAGES[appType])
    return ret==1
end 
Unit.Param.init={

}


function Unit.State.init(initParam)
    initParam.appType=APP_XM 
    Unit.Param.login.appType=APP_XM
    return "login"
end
Unit.Param.login={
}
function Unit.State.login(userInfo)
    if startApp(userInfo.appType)   then
        return "choseUser"
    end
    
    return "Error"
    
    
end
Unit.Param.choseUser={}
function Unit.State.choseUser(choseUser)
    return "choseUser"
end