require "TSLib"
require("common")
require("register")
require("createRole")
function main()
    init(1)
    Unit.State.Name="init"
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
        mSleep(5000)
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
    -- if waitPic1(770,586,841,626,"ss_yinlogin.png")==true then
    --     randomTap(804,610)
    --     rndSleep(1000,2000)
    -- end
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
    
    if  waitPic1(951,71,987,92,"ss_role_create.png") then
        nLog("角色创建页面")
    end
    
    if accountInfo.from~=nil then
        Unit.Param[accountInfo.from].from="login"
        return accountInfo.from
    end
end
function main_test()
    init(1)
    local account="zhuandaqian3233"
   
   
    

    -- Unit.State.loginAccount(Unit.Param.loginAccount)
    --   local account="zhuandaqian4466"
    --   writeFileString("/sdcard/password.txt",""..account.."="..account,"a",1)
    
    -- mSleep(3000)
  
    -- snapshot("ss_role_create_ok.png",1071,618,1088,643)
    -- mSleep(100)
    -- waitPic1(1071,618,1088,643,"ss_role_create_ok.png")

  
    -- ./adb    pull /sdcard/TouchSprite/res/ss_role_create_ok.png res
    -- copy res/ss_role_create_ok.png C:\Users\fan\Documents\TSStudio\Projects\autoplay\
end
--   nLog("???")
-- main_test()
main()


-- main()