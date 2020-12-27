-- 自动启动游戏，创建账号，然后启动紫龙脚本，起号
require("common")
Unit.Param.beginAccount = {}

function Unit.State.beginAccount(taskInfo)
    if taskInfo.from == "createRole" then
        return "loginAccount"
    end
    if taskInfo.from == "loginAccount" then
        return "startZL"
    end

    if taskInfo.from == "startZL" then
        if startSS() then
            return "waitZLok"
        end
    end

    return "createRole"
    -- return "loginAccount"
    -- if taskInfo.task=="内置账号" then
    --     -- toast(text,time)
    --     Unit.Param.createRole={
    --         task="beginAccount"
    --     }
    --     return "createRole"
    -- end
end
Unit.Param.waitZLok = {}

function Unit.State.waitZLok(param)
    nLog("等待紫龙脚本退出")
    while appIsRunning("com.aland.hsz") == 1 do
        mSleep(60 * 1000 * 60)
    end
    return "beginAccount"
end

Unit.Param.startZL = {}

function Unit.State.startZL(param)
    init(0)
    os.execute("input keyevent KEYCODE_HOME")

    closeApp("com.aland.hsz")
    mSleep(2000)
    tap(947, 621)
    tap(111, 597)
    mSleep(20000)
    nLog("等待紫龙")
    tap(625, 337)
    mSleep(2000)
    tap(373, 1233)
    mSleep(2000)
    tap(432, 1090)
    mSleep(2000)

    init(1)
    return param.from
    -- Unit.Param.Error.errorType="beginAccount"
    -- Unit.Param.Error.name="beginAccount"
    -- return "Error"
end

Unit.Param.startZL1 = {
    zl_account = "13259490164",
    zl_password = "fanwu123",
    appType = APP_SS
}
-- 等待登录进入游戏
function Unit.State.startZL1(taskInfo)
    os.execute("input keyevent KEYCODE_HOME")
    zl_account = taskInfo.zl_account
    zl_password = taskInfo.zl_password
    init(0)
    nLog("startZL1")
    mSleep(2000)
    -- tap(95,391)
    x, y =
        findMultiColorInRegionFuzzy(
        0xfefefe,
        "0|64|0xfdfefe,67|64|0xfefefe,67|-2|0xfffdfe,32|28|0x000000",
        90,
        20,
        297,
        690,
        771,
        {orient = 2}
    )

    if x ~= -1 then
        showMessage("找到紫龙:" .. (x + 30) .. ":" .. (y + 30))

        tap(x + 30, y + 30)
    else
        showMessage("没找到紫龙")
    end

    while true do
        if multiColor({{201, 71, 0x66330f}, {629, 538, 0xffffff}, {702, 76, 0x666666}}) or
        multiColor({{239, 77, 0x66330f},{639, 72, 0x666666},{617, 516, 0xffffff}})  then
            showMessage("关闭紫龙广告")
            tap(562, 406)
            mSleep(2000)
            break
        end
        mSleep(2000)
    end

    -- 登录
    tap(47, 79)
    mSleep(2000)
    if multiColor({{470, 667, 0xe75e13}, {515, 205, 0xff7f27}, {360, 235, 0xfdfdfd}}) then
    -- 输入账号秘密
    -- zl_account = "13259490164"
    -- zl_password = "fanwu123"
    end

    if multiColor({{349, 125, 0xff7f26}, {336, 175, 0xf6c8a8}, {346, 1215, 0xf6761e}}) then
        tap(247, 179)
        mSleep(1000)
        tap(353, 181)
        mSleep(1000)
    end
    for i = 1, 20 do
        os.execute("input keyevent KEYCODE_FORWARD_DEL")
    end

    inputText(zl_account)

    tap(255, 487)
    inputText(zl_password)
    tap(362, 660)
    mSleep(3000)
    tap(661, 561)

    -- 勾选主线
    mSleep(1000)
    if multiColor({{153, 594, 0xff7f27}}) then
        tap(153, 594)
    end
    --选择上士平台
    mSleep(1000)
    tap(243, 522)
    mSleep(500)
    tap(249, 595)
    mSleep(500)
    tap(342, 1240)

    mSleep(5000)

    if multiColor({{321, 1090, 0x4ba3ff}, {532, 1088, 0x48a2ff}, {400, 243, 0xffffff}}) then
        tap(414, 1095)
    end
    local cnt = 30
    local package = PACKAGES[taskInfo.appType]
    init(1)
    wait_ss(30)
    while cnt > 0 do
        cnt = cnt - 1
        if isFrontApp(package) == 1 then
            nLog("app已经启动")
            lua_exit()
        end
    end
    closeApp(package)
    closeApp("com.aland.hsz")
    writeFileString("/sdcard/touch_status.txt", "reboot lua\n", "a")
    lua_exit()
    -- return "quit"
end
