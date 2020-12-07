require "TSLib"
require("common")
require("register")
require("createRole")
function main()
    init(1)
    Unit.State.Name="init"
    -- Unit.State.Name="CcreateRole1"
    
    -- Unit.Param.CcreateRole1={
    --     account="dalaoban21",
    --     roleCount=1,
    --     totalCount=4,
    --     from="loginAccount"
    -- }
    nLog("开始运行")
    while true do
        Unit.State.Name=processState(Unit.State,Unit.State.Name,Unit.Param[Unit.State.Name])
        nLog("当前状态:"..tostring(Unit.State.Name))
        mSleep(100)
    end
    
end
Unit.Param.Error={
    errorType="空",
    state="空"
}


function Unit.State.Error(errorInfo)
    if errorInfo.errorType=="create_error" then
        while true do
            nLog("不能注册账号了")
            toast("不能注册账号了",1)
            mSleep(5000)
        end
    end
    
    while true    do 
       
        nLog("未处理的错误"..errorInfo.errorType)  
        stopSSApp()
        mSleep(5000)
        return "init"
    end
    
end

Unit.Param.init={
    task="register", --createRole 创建角色，register --注册账号 -- regAndcreate注册并创建
    appType=APP_SS 
}


function Unit.State.init(initParam)
    
    -- local task="register"
    -- local appType=APP_SS
    -- Unit.Param.beginTask.task="register"
    -- Unit.Param.beginTask.appType=APP_SS
    
    local task="createRole"
    local appType=APP_SS
    Unit.Param.beginTask.task="createRole"
    Unit.Param.beginTask.appType=APP_SS
    
    return "beginTask"
end
Unit.Param.beginTask={
    appType=2,
    task="choseUser"
}

SERVER_ADDR="http://192.168.0.103:5000"

-- function afterLogin()
--     XM.Print("等待账号")
--     XM.SetTableID("登录界面")
--     if Unit.Param.login.appType==APP_XM then
       
--         XM.Print("等待公告")
        
--         waitPic(602,74,677,118,"1")
--         XM.RndTap(644,607)
--         sleep(2000)
--         XM.RndTap(624,523)
--         sleep(5000)
--     else
--         XM.Print("等待上士登录页面")
--         if waitPic(600,396,678,439,5)==true then
--             XM.Print("找到上士登录按钮")
--         end
        
--     end
  
-- end

function Unit.State.beginTask(taskInfo)
    if taskInfo.task=="register" then
        return taskInfo.task
    end
    if taskInfo.task=="createRole" then
        return taskInfo.task
    end
    -- return taskInfo.task
    return "Error"
    
end
Unit.Param.loginAccount={
    account="zhuandaqian3233",
    next="Error",
    from="createRole",
    qu=109,
}


function Unit.State.loginAccount(accountInfo)
    if startToAccount()~=true then
        Unit.Param.Error.errorType="startError"
        Unit.Param.Error.name="loginAccount"
        return "Error"
    end
    local account=accountInfo.account
    randomTap(638,281)
    for i=0,#account,1 do
        inputText(string.sub(account,i,i))
        rndSleep(300,600)
    end
    touchDown(583,583)
  
    rndSleep(500,1000)
    touchUp(583, 583)
    randomTap(583,387)
    rndSleep(1000,2000)
    randomTap(800,377)
    rndSleep(1000,2000)
    
    for i=0,#account,1 do
        inputText(string.sub(account,i,i))
        rndSleep(300,600)
    end
    randomTap(612,486)
    if waitPic1(755,405,806,437,"ss_register_ok1.png",5,1)==true    then 
       
        randomTap( 836,163)
        randomTap(869,161)
        rndSleep(3000,4000)
    end
    if waitPic1(516,81,582,119,"ss_register_ok.png",5,1)==true then
        randomTap(804,610)
        rndSleep(1000,2000)
    
    end
    if waitPic1(770,586,841,626,"ss_yinlogin.png",10,1)==true then
        randomTap(804,610)
        rndSleep(1000,2000)
    end
    if waitPic1(770,586,841,626,"ss_yinlogin.png",10,1)==true then
        randomTap(804,610)
        rndSleep(1000,2000)
    end
    if waitPic1(614,77,635,94,"ss_gonggao.png",10,1) ==true then
        randomTap(631,595)
        rndSleep(1000,2000)
    end
    if waitPic1(614,77,635,94,"ss_gonggao.png",10,1) ==true then
        randomTap(643,606)
        rndSleep(1000,2000)
    end
    -- 选区逻辑
    randomTap(617,403)
    rndSleep(2000,3000)
    for i=1,5,1 do 
        moveTo( 656,506,657,483)
        moveTo( 657,483,656,423)
        moveTo( 656,423,657,326)
        moveTo( 657,506,662,268)
    end
    -- 
    rndSleep(2000,3000)
    touchDown(530,609)
    rndSleep(2000,3000)
    touchUp(530,609)
    rndSleep(2000,3000)
    randomTap(661,515)
    local success=false
    -- 排队
    -- if  waitPic1(1071,618,1088,643,"ss_loginpd_ok.png",10,1) then
    --     local cnt=0
    --     while waitPic1(1071,618,1088,643,"ss_loginpd_ok.png",10,1)==true do
    --         mSleep(10000)
    --         nLog("排队等待"..(cnt*20).."s")
    --         if cnt>3600/20 then
    --             nLog("排队超时,重新登录")
    --             stopSSApp()
    --             return "loginAccount"
    --         end
    --         if  waitPic1(551,4,639,52,"chose_user.png",2,1) then 
    --             success=true
    --             nLog("角色选择页")
    --             break
    --         end
    --         if  success==false and waitPic1(951,71,987,92,"ss_role_create.png",2,1)  then
    --             success=true
    --             nLog("角色创建页面")
    --             break
    --         end
            
    --     end
        
    -- end
    mSleep(5000)
    local cnt=0
    while cnt<3600/5 do
        if  waitPic1(551,4,639,52,"chose_user.png",2,1) then 
            success=true
            nLog("角色选择页")
            break
        end
        if  success==false and  waitPic1(146,12,229,55,"ss_role_create.png",2,1)  then
            success=true
            nLog("角色创建页面")
            break
        end
        -- 崩溃重启试试
        if  appIsRunning(PACKAGES[APP_SS])==0 then
            return "loginAccount"
            
        end
        
        cnt=cnt+1
        mSleep(5000)
    end
    
    if accountInfo.from~=nil and  success then
        Unit.Param[accountInfo.from].from="loginAccount"
        return accountInfo.from
    end
    Unit.Param.Error.errorType="loginAccountError"
    Unit.Param.Error.name="loginAccount"
    return "Error"
end
function main_test()
    init(1)
    local account="zhuandaqian3233"
   
  
    -- nLog("跳出循环")
    --  waitPic1(551,4,639,52,"chose_user.png",2,1) 
    --   waitPic1(951,71,987,92,"ss_role_create.png",2,1) 
    -- Unit.State.loginAccount(Unit.Param.loginAccount)
    --   local account="zhuandaqian4466"
    --   writeFileString("/sdcard/password.txt",""..account.."="..account,"a",1)
    
    -- mSleep(3000)
    -- if waitPic1(755,405,806,437,"ss_register_ok1.png",5,1)==true    then 
    --     randomTap(836,163)
    --     randomTap(869,161)
    --     rndSleep(3000,4000)
    -- end
    
    -- snapshot("ss_role_create.png",146,12,229,55)
    mSleep(100)
    -- waitPic1(146,12,229,55,"ss_role_create.png")

  
    -- ./adb    pull /sdcard/TouchSprite/res/ss_role_create.png res
    -- copy res/ss_role_create.png C:\Users\fan\Documents\TSStudio\Projects\autoplay
    --  copy res/ss_role_create.png C:\Users\fan\Documents\TSStudio\Projects\autoplay
end
--   nLog("???")
-- main_test()
main()


-- main()