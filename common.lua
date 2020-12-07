-- 项目公用函数
require("TSLib")
require("tools")
PACKAGES={"com.hegu.dnl.mi","com.hegu.dnl.sn79"}
-- appType类型
APP_XM=1 -- 小米
APP_SS=2 -- 上士
function startApp(appType)
    local package=PACKAGES[appType]
    local ret=runApp(package,true)
    nLog("启动应用:"..APP_XM.."启动结果："..ret)
    
    
    return ret==0
    
end

function startSS()
    local ret= runApp(PACKAGES[APP_SS])
    mSleep(2000)
    if ret==0 then
        if waitPic1(598,146,680,197,"start_ok.png")~=true then
            nLog("账号首次登录启动app成功")
            return false
        end
        if waitPic1(391,331,520,382,"ss_fisrt_login.png",5,1) then
            nLog("账号首次登录启动app成功")
            return true
        end
        
        if waitPic1(602,399,672,435,"ss_login.png",5,1) then
            nLog("启动app成功")
            return true
        end
        
    end
    return true
end
function startToAccount() 
    if startSS() ~=true then
        return false
    end
    
    if waitPic1(391,331,520,382,"ss_fisrt_login.png",3,1) then
        nLog("账号首次登录启动app成功")
        randomTap(815,408)
    else
        randomTap(788,502)      
    end
    rndSleep(300,600)
    randomTap(817,421)
    rndSleep(300,600)
    return true
    
end

function stopSSApp()
    closeApp(PACKAGES[APP_SS])
    rndSleep(3000,5000)
end

