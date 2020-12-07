-- 一些通用函数和代码
require "TSLib"--使用本函数库必须在脚本开头引用并将文件放到设备 lua 目录下
 
Unit={
    State={},
    Param={}
}
H={}
function waitFound(to,step,func)
    local cnt=0
    while cnt<to do
        if func() then
            nLog("找到图色")
            return true   
        end  
        mSleep(step*1000)
        cnt=cnt+step
 
    end
    return false
end
function processState(stateTable,stateName,stateParam)
    if stateTable[stateName]~=nil then
        return stateTable[stateName](stateParam)
    end
    return "Error"
end

function waitPic1(x1,y1,x2,y2,picpath,to,step)
    to=to or 120
    step=step or 5
    nLog("找图"..picpath)
    return waitFound(to,step,(function ()
      
        local x,y=findImage(picpath,x1,y1,x2,y2)
        return x~=-1 and y~=-1
    end
    )    )
end

function rndSleep(a,b)
    math.randomseed(getRndNum()) -- 随机种子初始化真随机数
    num = math.random(a, b) -- 随机获取一个 1 - 100 之间的数字
    mSleep(num)
end
function wrapNextState(param,state)
    Unit.Param[param.next]=param.nextParam
    return param.next
end



