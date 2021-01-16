require("common")
-- 卡分解页面
MAP = {["格鲁"] = {321, 164}}
SUB_MAP = {
    -- ["诺曼达"] = {762, 167},
    ["悬空"] = {963, 292},
    ["暮光"] = {308, 610}
}
SUB_MAP1 = {
    ["悬空"] = {
        ["矿脉"] = {243, 610},
        ["失落"] = {766, 607},
        ["龙族"] = {296, 486},
        ["幽暗"] = {710, 492},
        ["罪恶"] = {333, 366},
        ["天空"] = {689, 367},
        ["宫殿"] = {707, 253},
        ["冰火"] = {280, 244}
    },
    ["暮光"] = {["灼热"] = {1104, 411}, ["幽寒"] = {535, 374}, ["黄昏"] = {775, 566}, ["恶毒"] = {491, 168}},
    ["诺曼达"] = {["瘟疫"] = {499, 199}}
}
Unit.Param.playGamer = {}

function Unit.State.playGamer(taskInfo)
    showMessage("初始化刷副本的信息！")

    if taskInfo.from == "playGamerOne" then
        showMessage("执行完毕，退出脚本")
        return "playFinish"
    end
    if runAppWithoutLogin(taskInfo.appType) ~= true then
        showMessage("启动游戏出错！")
        return "Error"
    end

    snapshot("/sdcard/start_login_ok.png", 0, 0, 1270, 700)
    mSleep(2000)
    -- bid, _ = frontAppBid()

    -- if bid ~= PACKAGES[APP_SS] then
    --     if runAppWithoutLogin(APP_SS) ~= true then
    --         showMessage("启动游戏出错！")
    --         return "Error"
    --     end
    -- else
    --     showMessage("app is running")
    -- end
    -- showMessage(taskInfo.taskRole)
    if wait_bak(3) then
        showMessage("在主城中")
        goChoseGamer()
        SetTableID("上士登录页")
        if waitColor("角色选择", false, 30 * 60, 10) then
            showMessage("等待角色选择")
        end
    end
    showMessage("xxx")
    Unit.Param.playGamerOne = {
        taskRole = taskInfo.taskRole,
        cur = 1
    }
    return "playGamerOne"
    --   ret=get_num(544,280,584,307,"90ABB4-242926")
end
Unit.Param.waitForLogin = {
    taskRole = {},
    cur = 1
}
-- 等待登录进入游戏
function Unit.State.waitForLogin(taskInfo)
    if runAppWithoutLogin(APP_SS, true) ~= true then
        showMessage("启动游戏出错！")
        return "Error"
    end
    return "playFinish"
end

Unit.Param.playFinish = {}
-- 等待登录进入游戏
function Unit.State.playFinish(taskInfo)
    -- 挂机完毕
    write_status("finish\n")
    return "quit"
end

Unit.Param.playGamerOne = {
    taskRole = {},
    cur = 1
}
function Unit.State.playGamerOne(taskInfo)
    showMessage("开始清日常")
    if taskInfo.cur > 1 then
        return "playGamer"
    end
    -- for key, value in pairs(taskInfo) do
    --     showMessage("key:" .. key)
    -- end
    mSleep(5000)
    role_info = taskInfo.taskRole[taskInfo.cur]
    -- showMessage(taskInfo.taskRole)
    local role_idx = role_info.role
    showMessage("role_idx" .. role_idx)
    local fb = role_info["副本"]
    local fj = role_info["分解装备"]
    local cs = role_info["出售装备"]
    -- nLogtab
    -- nLogTab(fj)
    --  nLogTab(cs)
    choseGamer(role_idx)
    randomTap(637, 666)
    mSleep(1000)
    closeGG()

    snapshot("/sdcard/start_game_" .. taskInfo.cur .. ".png", 0, 0, 1270, 700)
    mSleep(2000)
    if taskInfo.cur == 1 then
        set_base_picture()
        mSleep(2000)
    end
    learn_skills()
    -- check_auto_play()

    if role_info["副本方式"] == "自动" then
        fb = rand_map(role_info["区域"], false)
    end
    if fb[6] then
        doPalyOne(fb[1], fb[2], fb[3], fb[4], fb[5])
    end
    wait_bak()
    mSleep(1000)
    clear_package(fj, cs)
    qhzb()
    loin_sign()
    get_online(false)
    get_online(true)
    clear_xhp()
    do_dn()
    do_dn()
    do_gbl()
    do_buygh(2)

    get_rc()
    lqcj()
    lqgkjl()

    snapshot("/sdcard/finish_game_" .. taskInfo.cur .. ".png", 0, 0, 1270, 700)
    mSleep(1000)

    mSleep(2000)
    goChoseGamer()
    SetTableID("上士登录页")
    if waitColor("角色选择", false, 30 * 60, 10) then
        showMessage("等待角色选择")
    end
    mSleep(1000)
    showMessage("cur role:" .. taskInfo.cur)
    taskInfo.cur = taskInfo.cur + 1
    return "playGamerOne"
end

function choseGamer(idx)
    showMessage("选角色")
    idx = idx - 1
    for i = 0, 5, 1 do
        randomTap(100, 346)
        mSleep(1000)
    end
    local page, other = math.modf(idx / 8)
    for i = 0, page - 1, 1 do
        randomTap(1184, 355)
        mSleep(1000)
    end
    idx = idx % 8
    local row, other1 = math.modf(idx / 4)
    local col = idx % 4
    local x = 276 + 225 * col
    local y = 292 + 219 * row
    showMessage("tap x:" .. x .. "y:" .. y)
    randomTap(x, y)
    mSleep(1000)
end
-- init(1)
-- choseGamer(8)

function goChoseGamer()
    showMessage("通过回城页面到选择色页面")
    -- 通过回城页面到选择色页面
    randomTap(32, 54)
    rndSleep(1000)
    randomTap(863, 604)
    rndSleep(1000)
    -- 等待页面稳定
end

function goMap(area, subarea, name, level)
    showMessage("走大地图")
    -- area 地图
    -- name 图名
    -- level 等级

    randomTap(1190, 100)
    for i = 0, 2, 1 do
        moveTo(734, 210, 711, 673)
        -- showMessage("滑动地图")
        rndSleep(100)
    end
    -- 其他地图
    SetTableID("进副本")
    local xy = SUB_MAP[subarea]
    mSleep(1000)
    for i = 1, 3 do
        -- showMessage("x:" .. xy[1] .. ",y:" .. xy[2])
        randomTap(xy[1], xy[2])
    end

    if waitColor("副本返回", false, 120, 3) ~= true then
        return false
    end
    xy = SUB_MAP1[subarea][name]
    -- showMessage(xy[1])
    -- showMessage(xy[2])
    randomTap(xy[1], xy[2])
    if waitColor("开始挑战", false, 15, 3) ~= true then
        return false
    end

    if level == "普通" then
        randomTap(673, 166)
    elseif level == "冒险" then
        randomTap(853, 156)
    elseif level == "勇士" then
        randomTap(985, 164)
    elseif level == "王者" then
        randomTap(1143, 162)
    end
    return true
end
function beginPlayOne(area, subarea, name, level)
    showMessage("进图")
    if goMap(area, subarea, name, level) ~= true then
        return false
    end
    mSleep(5000)
    local num = get_num(1142, 12, 1206, 54, "DBDEE0-111111|BFC5CB-111111")
    if num == nil or num <= 0 then
        showMessage("没精力了")
        randomTap(60, 25)
        mSleep(3000)
        randomTap(60, 25)
        mSleep(3000)
        randomTap(1232, 48)
        mSleep(5000)
        return false
    end
    randomTap(1095, 632)
    showMessage("开始挑战")
    return true
end

function doPalyOne(area, subarea, name, level, times)
    -- 点击再来一次
    times = tonumber(times)
    showMessage("开始单刷:" .. times .. "次")
    if beginPlayOne(area, subarea, name, level) ~= true then
        return false
    end
    cnt = 0
    local time_cost = 0
    local begin_time = os.time()
    has_check = false
    while true do
        if has_check == false and waitPlayBegin() then
            showMessage("副本开始了")
        end
        if has_check == false then
            if checkautoplay() == false then
                --完善一场状态
            else
                has_check = true
                showMessage("已经开始自动挂机")
            end
        end
        time_cost = os.time() - begin_time

        local is_end = false
        if waitPlayEnd() then
            showMessage("副本已经结束")
            is_end = true
        end

        if is_end then
            doOpenCard(true, true)
            cnt = cnt + 1
            showMessage("已经刷了" .. cnt .. "次")
            if cnt > times then
                showMessage("副本刷完了")
                doRePalyOne(false)
                wait_bak()
                break
            else
                doRePalyOne(true)
                showMessage("继续副本")
            end
        end
        -- 月卡
        if multiColor({{918, 177, 0xddbb88}, {926, 187, 0xb79663}, {913, 195, 0xb18a54}, {932, 178, 0xc9aa7b}}) then
            randomsTap(918, 177)
        end
        if find(5, {"上士登录页", "拜师"}, true) then
            showMessage("关闭拜师")
        end
        if find(5, "拜师", true) then
            showMessage("关闭拜师")
        end

        if find("变强卡屏", 5, true) then
            showMessage("变强卡屏")
            return false
        end
        -- 商人页面，没有检测到翻牌
        if closeSR(1) then
            doRePalyOne(false)
        end

        if find(5, {"登录广告", "精力"}, false) then
            showMessage("已经超时回城了")
            if beginPlayOne(area, subarea, name, level) ~= true then
                return false
            end
        end
        showMessage("刷副本" .. cnt)
        write_status("刷副本" .. cnt .. "\n")
        mSleep(200)
    end
end
function wait_bak(max_cnt)
    if max_cnt == nil then
        max_cnt = 20
    end

    -- 等待回城
    local cnt = 0
    while cnt < max_cnt do
        if find(5, {"登录广告", "精力"}, false) then
            return true
        end
        if find(5, {"登录广告", "精力xy"}, false) then
            return true
        end
        if find(5, {"登录广告", "宠物广告"}, true) then
            showMessage("关闭宠物广告")
        end

        cnt = cnt + 1
        mSleep(1000)
    end
    return false
end

function checkautoplay()
    showMessage("检查自动挂机")
    SetTableID("进副本")
    cnt = 0
    while cnt < 100 do
        -- if find("自动副本", 5, false) then
        --     showMessage("已经自动挂机了")
        --     return true
        -- end
        for i = 1, 20 do
            if
                multiColor(
                    {{34, 268, 0xffd278}, {48, 268, 0xffffbb}, {40, 286, 0xffff67}, {27, 277, 0xffbb2a}},
                    90,
                    false
                )
             then
                showMessage("已经自动挂机了")
                return true
            end
        end

        randomTap(42, 273)
        -- showMessage("检查次数" .. cnt)
        cnt = cnt + 1
        mSleep(200)
    end

    return false
end
function waitPlayBegin()
    showMessage("等待副本开始")
    SetTableID("进副本")
    cnt = 0
    while cnt < 30 do
        if find("副本血条", false) then
            showMessage("副本开始了")
            return true
        end
        cnt = cnt + 1
        mSleep(1000)
    end
    return false
end
function waitPlayEnd()
    showMessage("等待副本结束")
    SetTableID("进副本")

    if find("选择卡牌", false, 5) == true then
        showMessage("副本结束")
        return true
    end

    -- if multiColor({{529, 43, 0x101334}, {87, 37, 0x301630}, {1227, 84, 0xefde99}, {1188, 91, 0x3e3c30}}) then
    --     nLog("副本已经开始")
    --     return true
    -- end
    mSleep(2000)
    return false
end
function doOpenCard(card1, card2)
    showMessage("翻牌")
    local x, y = 226, 171
    local ret = getRnd(0, 3)
    x = x + 280 * ret
    if card1 then
        randomTap(x, y)
    end
    ret = getRnd(0, 3)

    x, y = 216, 568
    x = x + 280 * ret
    if card2 then
        randomTap(x, y)
    end
    randomTap(1208, 88)
    showMessage("翻牌完毕")
end
function closeSR(wait)
    if wait == nil then
        wait = 1000
    end

    local has_sr = false
    showMessage("关闭神秘商人")
    keepScreen(false)
    keepScreen(true)
    local x, y =
        findMultiColorInRegionFuzzy(0xb59c73, "-4|26|0x685526,-4|17|0x08101f", 80, 1096, 636, 1096, 636, {orient = 2})
    if x ~= -1 then
        has_sr = true
        randomsTap(x, y)
    else
        showMessage("没有商人1")
    end
    keepScreen(false)
    mSleep(1000)
    keepScreen(true)
    if multiColor({{1113, 112, 0xe7cd90}, {1128, 125, 0xb4935f}, {1114, 130, 0xba9560}, {1128, 116, 0xc9ae84}}) then
        showMessage("点击商人2")
        has_sr = true
        randomsTap(1127, 126)
    else
        showMessage("没有商人2")
    end
    keepScreen(false)
    mSleep(1000)
    keepScreen(true)
    if
        (isColor(888, 75, 0xe9cd98, 85) and isColor(899, 86, 0xc6a677, 85) and isColor(912, 100, 0x9a703b, 85) and
            isColor(907, 80, 0xcbac7e, 85) and
            isColor(891, 97, 0xb48b57, 85))
     then
        has_sr = true
        showMessage("点击商人3")
        randomsTap(898, 85)
    else
        showMessage("没有商人3")
    end
    keepScreen(false)
    mSleep(wait)
    return has_sr
end

function doRePalyOne(bool)
    showMessage("点击再来一次")
    local cnt = 0
    SetTableID("进副本")
    -- randomTap( 577,58)
    mSleep(2000)
    while true do
        closeSR()
        -- if multiColor({{1119, 37, 0xffffff}, {1126, 43, 0x89898c}, {1126, 46, 0x0b1030}, {1113, 45, 0x05081a}}) then
        -- end
        if find("商人没精力", 5, true) then
            showMessage("卡商人没精力了，回城")
            return true
        end

        if find("副本结束", 5, false) then
            if bool then
                showMessage("点继续")
                randomTap(1105, 147)
            else
                showMessage("点回城")
                randomTap(1100, 55)
            end
            return true
        end

        if find("图刷完了", 5, true) then
            showMessage("图刷完了，没疲劳了")
            return false
        end

        mSleep(200)
        cnt = cnt + 1
        if cnt >= 5 then
            showMessage("等待超时")
            return false
        end
    end
    showMessage("没有找到再次挑战！")
    return false
end
function wait_xm()
end
function wait_ss(xm, timeout)
    -- 等待上士登录账号
    showMessage("等待上士登录")
    SetTableID("上士登录页")
    cnt = 0
    while true do
        -- 登录页

        -- wait_ss(false)
        if find("登录按钮", true, 5) then
            mSleep(1000)
        end
        if findg("绑定手机g", true, 5) then
            mSleep(1000)
        end

        if find("公告", true, 5) then
            mSleep(1000)
        end
        -- lua_exit()
        if find("排队", false) then
            showMessage("排队中...")
            mSleep(1000)
        -- break
        end
        if find("排队xy", false) then
            showMessage("排队中...")
            mSleep(1000)
        -- break
        end

        if find("登录人满", true) then
            -- nLog("人满了")
            mSleep(1000)
        -- break
        end

        if xm then
            if find("游戏登录按钮", false, 5) then
                mSleep(1000)
                dialogRet("手动选区", "选区", "", "", 0)
                xm = false
            end
        else
            -- 点击登录
            -- break
            if find("游戏登录按钮", true, 5) then
                mSleep(1000)
            end
        end
        if waitColor("角色选择", false, 10, 5) then
            showMessage("进入游戏成功")
            return true
        end
        mSleep(1000)
        cnt = cnt + 1
        if timeout ~= nil and cnt > timeout then
            return false
        end
        showMessage("登录排队中" .. cnt)
        write_status("登录排队中" .. cnt .. "\n")
        -- nLog("??")
    end
    -- mSleep(5000)
    -- if find("排队", false) then
    --     nLog("排队")
    -- end

    showMessage("进入游戏超时")
    return false
end

function runAppWithoutLogin(appType, xm)
    if xm == nil then
        xm = false
    end

    showMessage("直接登录，不输入账号")
    if find(5, {"登录广告", "精力"}, false) then
        showMessage("已经登录")
        return true
    else
        stopSSApp()
    end
    package = PACKAGES[appType]
    showMessage("启动包名:" .. package)
    local ret = runApp(package, true)
    if ret == 0 then
        return wait_ss(xm)
    end
    return false
end

function closeGG()
    showMessage("关闭广告页")
    SetTableID("上士登录页")
    while true do
        if find("广告1", true) then
            showMessage("GG")
            mSleep(1000)
        end
        if find("广告2", true) then
            showMessage("GG")
            mSleep(1000)
        end
        if find("登录完成", true) then
            showMessage("GG")
            mSleep(1000)
            break
        end
        if find("决斗段位", true) then
            showMessage("GG")
            mSleep(1000)
            break
        end
        if find("工会地下城", true) then
            showMessage("工会地下城")
            mSleep(1000)
            break
        end

        mSleep(1000)
    end
    showMessage("登录完成")
end
-- closeGG()
function get_email()
    showMessage("清邮件")
    write_status("清邮件\n")
    SetTableID("上士登录页")
    has_email = false
    for i = 1, 100 do
        x, y =
            findMultiColorInRegionFuzzy(
            0x2f73ac,
            "-3|16|0xd90100,-3|31|0x0c2745,7|9|0xf2e3c9",
            90,
            412,
            350,
            499,
            625,
            {orient = 2}
        )

        if x ~= -1 then
            tap(x, y)
            has_email = true
            mSleep(1000)
            break
        else
            showMessage("kkkk")
        end
    end
    if has_email == false then
        return has_email
    end

    randomTap(95, 211)
    showMessage("邮箱不为空")

    randomTap(1026, 668)
    mSleep(500)

    randomTap(107, 121)
    mSleep(500)
    randomsTap(1033, 554)
    mSleep(500)
    randomTap(1130, 556)
    mSleep(500)

    randomTap(106, 300)
    mSleep(500)
    randomsTap(1033, 554)
    mSleep(500)
    randomTap(1130, 556)
    mSleep(500)

    randomTap(73, 22)
    mSleep(500)
    return has_email
end
function fenjiezb(type, a, b, c)
    showMessage("分解装备")
    write_status("分解装备\n")
    if a == nil then
        a = true
    end
    if b == nil then
        b = true
    end
    if c == nil then
        c = false
    end
    SetTableID("分解装备")
    -- 分解装备
    -- 背包
    randomTap(1222, 672)
    mSleep(2000)
    if type == 1 then
        showMessage("分解")
        randomTap(861, 675)
        mSleep(1000)
    else
        showMessage("出售")
        randomTap(1041, 679)
        mSleep(1000)
    end
    x, y = findMultiColorInRegionFuzzy(0x6ed532, "", 80, 423, 399, 474, 440, {orient = 2})
    if (x == -1 and a) or (x ~= -1 and not a) then
        randomTap(449, 424)
        mSleep(1000)
    end
    x, y = findMultiColorInRegionFuzzy(0x6ed532, "", 80, 553, 399, 602, 442, {orient = 2})
    if (x == -1 and b) or (x ~= -1 and not b) then
        randomTap(573, 427)
        mSleep(1000)
    end
    x, y = findMultiColorInRegionFuzzy(0x6ed532, "", 80, 677, 396, 732, 439, {orient = 2})
    if (x == -1 and c) or (x ~= -1 and not c) then
        randomTap(700, 426)
        mSleep(1000)
    end
    randomTap(654, 519)
    mSleep(1000)
    if find("分解确认", 5, true) then
        showMessage("分解装备")
    end
    mSleep(1000)
    local finish = false
    if (isColor(640, 408, 0x104eb6, 80)) then
        showMessage("没有装备了")
        randomTap(640, 423)
        mSleep(1000)
        randomTap(453, 511)
        mSleep(1000)
        finish = true
    else
        mSleep(10000)
        randomTap(893, 154)
    end
    randomTap(57, 24)
    mSleep(5000)
    return finish
    -- if get_email() ~= true then
    --     break
    -- end
end
function clear_package(fj, cs)
    -- 清理邮件和分解装备
    showMessage("清背包")
    write_status("清背包\n")
    for i = 1, 10 do
        if fj[1] ~= true and cs[1] ~= true then
            break
        end

        use_zb_all()
        if fj[1] then
            showMessage("分解装备")
            if fenjiezb(1, fj[2], fj[3], fj[4]) == true then
                showMessage("没装备了")
            end
        end
        if cs[1] then
            showMessage("出售装备")
            if fenjiezb(2, cs[2], cs[3], cs[4]) == true then
                showMessage("没装备了")
            end
        end

        if get_email() ~= true then
            showMessage("没邮件了")
            break
        end
    end
end
function set_base_picture()
    randomsTap(46, 62)
    mSleep(1000)
    randomTap(241, 257)
    mSleep(2000)
    moveTo(628, 171, 628, 140)
    -- 画质调到最低，反正后台跑，节约性能
    tap(920, 403)
    -- tap(653, 395)
    mSleep(500)
    tap(541, 535)
    mSleep(500)
    randomsTap(1116, 133)
    mSleep(1000)
end
function learn_skills()
    local today = tonumber(os.date("%d", os.time()))
    if today % 2 ~= 0 then
        return
    end
    showMessage("清技能点")
    write_status("清技能点\n")
    mSleep(1000)
    -- writeFileString(file,str,mode,wrap)

    if (isColor(1185, 648, 0xff0000, 90)) ~= true then
        return
    end

    posistion = {{1162, 668}, {1161, 673}, {948, 674}, {752, 462}, {54, 34}}
    for i = 1, #posistion do
        xy = posistion[i]
        randomTap(xy[1], xy[2])
        mSleep(1500)
    end
    -- 直接弹出学习技能页面卡住了
    if multiColor({{638, 247, 0x101a28}, {598, 458, 0x124599}, {818, 468, 0x163e85}}) then
        tapArray({{756, 462, 0x144391}})
    end
    back_city()
end
function get_zb_type(x, y)
    x = x + 5
    y = y + 5
    if (isColor(x, y, 0x4d3428, 90)) then
        return "ss"
    end

    if (isColor(x, y, 0x612d44, 90)) then
        return "fz"
    end
    if (isColor(x, y, 0x412c43, 90)) then
        return "zh"
    end
    if (isColor(x, y, 0x1c3a4c, 90)) then
        return "lz"
    end
    if (isColor(x, y, 0x4a525e, 90)) then
        return "bz"
    end
    return ""
end
function is_sugg(x, y)
    x = x + 69
    y = y + 66
    return isColor(x, y, 0x6ac100)
end
function use_zb(x, y)
    x = x + 50
    y = y + 50
    randomTap(x, y)
    rndSleep(1000)
    showMessage("点击了" .. x .. ":" .. y)
    if multiColor({{475, 375, 0x161b2c}, {580, 76, 0x154393}}) then
        randomTap(572, 71)
        rndSleep(1000)
    end

    if multiColor({{957, 376, 0x161b2c}, {1082, 71, 0x13479e}}) then
        randomTap(1113, 77)
        rndSleep(1000)
    end

    if multiColor({{748, 462, 0x163c7d}, {743, 385, 0x101a28}}) then
        randomTap(751, 452)
        rndSleep(1000)
    end
    rndSleep(10000)
end

function use_zb_all(not_open)
    mSleep(5000)
    showMessage("穿推荐的装备")
    write_status("穿推荐的装备\n")
    if not_open ~= true then
        randomTap(1222, 672)
        mSleep(2000)
    end
    xstep = 95
    ystep = 96
    startx, starty = 797, 135
    nLog(1057 - 988)
    nLog(392 - 326)
    mSleep(200)
    for i = 0, 24 do
        local row, other = math.modf(i / 5)
        local col = i % 5
        local x = startx + col * xstep
        local y = starty + row * ystep
        local zb_lx = get_zb_type(x, y)
        -- nLog("x="..(x+5).."y="..(y+5))
        local sugg = is_sugg(x, y)
        if sugg and (zb_lx == "lz" or zb_lx == "zh" or zb_lx == "bz" or zb_lx == "ss") then
            showMessage("穿戴装备r:" .. row .. ",c:" .. col .. ",type:" .. zb_lx)
            use_zb(x, y)
            use_zb_all(true)
            return
        end
        mSleep(200)
    end
    randomTap(57, 24)
    mSleep(5000)
end
function check_play(i)
    step = 164 * i
    x, y = findMultiColorInRegionFuzzy(0xffdd77, "", 90, 602 + step, 134, 658 + step, 153, {orient = 2})
    if x ~= -1 then
        return true
    end
    return false
end
function back_city()
    SetTableID("进副本")
    cnt = 0
    while cnt < 10 do
        if waitColor("副本返回", true, 3, 1) ~= true then
            showMessage("退出")
            mSleep(1000)
        end
        if waitColor("副本返回", true, 3, 1) ~= true then
            showMessage("退出")
            mSleep(1000)
        end

        if waitColor("关闭设置", true, 3, 1) == true then
            showMessage("点到了头像，退出")
            mSleep(1000)
        end
        if multiColor({{1221, 35, 0xe9cc9b}, {1233, 49, 0xbc9865}, {1244, 37, 0xc9ac7d}, {1222, 58, 0xaf8852}}) then
            randomTap(1234, 46)
            mSleep(1000)
        end
        if wait_bak(3) == true then
            break
        end
    end
end

function check_auto_play()
    local today = tonumber(os.date("%d", os.time()))
    if not (has_config("暮光" .. AREA_MG_CONFIG) == false or today % 5 == 0) then
        return
    end
    for name, p in pairs(SUB_MAP) do
        -- nLog(""..name)
        for name1, p1 in pairs(SUB_MAP1[name]) do
            if goMap("赫顿城", name, name1, "普通") then
                write_config(name .. AREA_MG_CONFIG, true)
                write_config(name .. name1 .. AREA_MG_CONFIG, true)

                local level = {[0] = "普通", [1] = "冒险", [2] = "勇士", [3] = "王者"}
                for idx, name2 in pairs(level) do
                    if check_play(idx) then
                        write_config(name .. name1 .. name2 .. AREA_MG_CONFIG, true)
                        showMessage(name .. name1 .. name2 .. "开通")
                    end
                end
            else
                write_config(name .. name1 .. AREA_MG_CONFIG, false)
            end
            showMessage(name .. name1 .. "开通情况")
            write_status(name .. name1 .. "开通情况\n")
            back_city()
        end
    end
end
function has_open(area, subarea, name, level)
    if subarea == "暮光" and level == "普通" and (name == "灼热" or name == "幽寒" or name == "黄昏" or name == "恶毒") then
        return true
    end
    return read_bool(subarea .. name .. level .. AREA_MG_CONFIG, false)
end
function rand_map(all, max)
    if has_open("赫顿城", "悬空", "失落", "普通") then
        local i = 1
        while i < #all do
            local start, _ = string.find(all[i], "暮光")
            if start ~= nil then
                nLog("移除" .. all[i])
                table.remove(all,i)
            else
                i = i + 1
            end
        end
    end

    while true do
        local x = getRnd(1, #all)
        s = all[x]
        local x1 = strSplit(s, ",")

        if max == true or x1[1] == "暮光" then
            local level = {[0] = "普通", [1] = "冒险", [2] = "勇士", [3] = "王者"}
            for i = 3, 0, -1 do
                if has_open(x1[1], x1[2], x1[3], level[i]) then
                    x1[4] = level[i]
                    return x1
                end
            end
        else
            if has_open(x1[1], x1[2], x1[3], x1[4]) then
                return x1
            end
        end

        table.remove(all, x)
    end
end
function tapxy(x, y)
    randomTap(x, y)
    mSleep(2000)
end
function loin_sign()
    -- 领每日签到,随机决定是否签到
    if getRnd(1, 30) < 5 then
        return
    end
    local today = tonumber(os.date("%d", os.time()))
    -- local today=22
    randomTap(1025, 32)
    mSleep(2000)
    x1 = 412
    y1 = 271
    xstep = 109
    ystep = 109

    if today > 21 then
        x1 = 417
        y1 = 299
        today = today - 21
        nLog("滑动")
        mSleep(1000)
        moveTo(746, 513, 757, 306, 10, 800)
        mSleep(1000)
    end
    local row, _ = math.modf((today - 1) / 7)
    local col = (today - 1) % 7
    x1 = x1 + xstep * col
    y1 = y1 + ystep * row
    tapxy(x1, y1)
    tapxy(1224, 96)
    lj = {{837, 605, 0xf6f09f}, {923, 605, 0xa7b9a9}, {1000, 604, 0x3a5cbe}, {1084, 608, 0xfea65c}}
    for i = 1, 4 do
        local xy = lj[i]
        tapxy(xy[1], xy[2])
        tapxy(1224, 96)
    end
    tapxy(1118, 132)
    rndSleep(2000)
end
function get_online(level)
    -- 领在线和等级礼包
    randomTap(1025, 32)
    mSleep(2000)
    local cntout = 20
    if level == true then
        moveTo(233, 615, 243, 403, 10, getRnd(800, 1000))
        mSleep(2000)
        randomTap(239, 617)
    else
        randomTap(238, 601)
    end

    mSleep(2000)
    while cntout > 0 do
        if (isColor(987, 199, 0xe09c1e, 90)) then
            randomTap(987, 199)
            mSleep(1000)
        end
        cntout = cntout - 1
    end
    tapxy(1118, 132)
    rndSleep(2000)
end

-- clear_xhp(7)
function clear_xhp()
    -- 清理等级奖励的消耗品
    tapxy(1222, 672)
    tapxy(1190, 98)
    xstep = 95
    ystep = 95
    startx, starty = 797, 135
    mSleep(2000)
    just_use = {"xhp_翅膀.png", "xhp_套装.png", "xhp_衣服.png", "xhp_鞋子.png"}
    local cnt = 0
    keepScreen(true)
    while cnt <= 24 do
        local row, other = math.modf(cnt / 5)
        local col = cnt % 5
        local x = startx + col * xstep
        local y = starty + row * ystep
        nLog("找第" .. cnt .. "个")
        nLogArr({cnt, x, y, x + 50, y + 50, 10000})
        -- mSleep(50)
        for i = 1, #just_use do
            local x1, y1 = findImageInRegionFuzzy(just_use[i], 90, x - 5, y - 5, x + 55, y + 55, 0, 2)
            -- local x1, y1 = findImage(just_use[i], x-5, y-5, x + 55, y + 55, 20000)
            if x1 ~= -1 then
                showMessage("找到" .. just_use[i])
                tapxy(x1 + 50, y1 + 50)
                tapxy(615, 75)
                tapxy(1109, 84)
                tapxy(298, 98)
                cnt = cnt - 1
                keepScreen(false)
                mSleep(1000)
                keepScreen(true)
                break
            end
        end

        cnt = cnt + 1
    end
    keepScreen(false)
    nLog("why")

    tapxy(57, 24)

    rndSleep(2000)
end
-- clear_xhp()
function do_dn()
    -- 刷斗牛
    tap_range = {{1228, 422, 0xb37240}, {109, 210, 0x2c7cca}, {619, 273, 0x205fae}, {969, 609, 0xf7cd35}}
    for i = 1, #tap_range do
        xy = tap_range[i]
        if i == 3 then
            if isColor(xy[1], xy[2], xy[3]) then
                tapxy(xy[1], xy[2])
            else
                back_city()
                return
            end
        else
            tapxy(xy[1], xy[2])
        end
    end
    mSleep(10000)
    if checkautoplay() ~= true then
        nLog("没有自动开图")
        tapxy(1066, 28)
        tapxy(458, 581)

        if (isColor(792, 455, 0x13418d, 90)) then
            tapxy(792, 455)
        end
        back_city()
        return
    end
    cntout = 300
    while cntout > 0 do
        if multiColor({{578, 126, 0xfbfbfc}, {618, 136, 0xffffff}, {670, 146, 0xffffff}, {483, 466, 0x607175}}) then
            tapxy(578, 126)
            break
        end
        cntout = cntout - 1
        mSleep(1000)
    end
    if cntout <= 0 then
        tapxy(578, 126)
    end

    back_city()
end
function do_gbl()
    -- 刷哥布林
    local tap_range = {{1229, 424, 0x995e3c}, {114, 210, 0x424547}, {655, 508, 0x2b78c4}}
    for i = 1, #tap_range do
        xy = tap_range[i]
        if i == 3 then
            if isColor(xy[1], xy[2], xy[3]) then
                tapxy(xy[1], xy[2])
            else
                back_city()
                return
            end
        else
            tapxy(xy[1], xy[2])
        end
    end
    local tap_range = {{252, 428, 0x20293c}, {247, 335, 0x20293c}, {253, 243, 0x20293c}, {256, 145, 0x20293c}}
    for i = 1, #tap_range do
        xy = tap_range[i]
        tapxy(xy[1], xy[2])

        if (isColor(1069, 605, 0xe0ab28, 90)) then
            tapxy(1069, 605)
            break
        end
    end
    if checkautoplay() ~= true then
        nLog("没有自动开图")
        tapxy(1066, 28)
        tapxy(458, 581)

        if (isColor(792, 455, 0x13418d, 90)) then
            tapxy(792, 455)
        end
        back_city()
        return
    end
    cntout = 300
    while cntout > 0 do
        if multiColor({{578, 126, 0xfbfbfc}, {618, 136, 0xffffff}, {670, 146, 0xffffff}, {483, 466, 0x607175}}) then
            tapxy(578, 126)
            break
        end
        cntout = cntout - 1
        mSleep(1000)
    end
    if cntout <= 0 then
        tapxy(578, 126)
    end
    back_city()
end
H["工会购买"] = {
    {"没有工会", {{1016, 416, 0x114eb4}, {1018, 640, 0x104eb5}}, {1016, 426}},
    {"公会主页", {{1200, 681, 0xce8213}, {158, 128, 0x216abc}, {1132, 542, 0x0b1625}}, {0, 0}}
}
function do_buygh(sp)
    SetTableID("工会购买")
    tapxy(1023, 669)
    mSleep(1000)
    if waitColor("公会主页", false) == false then
        if waitColor("没有工会", true) then
        end
        back_city()
        return
    end
    if sp == nil then
        sp = 0
    end
    tapArray({{109, 307, 0x256aac}, {768, 375, 0x154393}})
    dx = 353
    dy = 215
    x, y = 497, 330
    x, y = get_table_pos(sp, 3, 497, 330, 353, 215)
    tapArray({{x, y, 0xbc7a1a}})
    local weekday = tonumber(os.date("%w", os.time()))
    -- nLog("星期"..weekday)
    if weekday == 0 then
        tapArray({{863, 545, 0x154190}})
    end
    tapArray({{649, 652, 0x393d43}, {618, 30, 0x23314e}})

    back_city()
end
function get_table_pos(i, w, startx, starty, dx, dy)
    -- 从0开始的排列的表格坐标
    local row, _ = math.modf(i / w)
    local col = i % w
    local x = startx + col * dx
    local y = starty + row * dy
    return x, y
end

function tapArray(arr)
    for i = 1, #arr do
        xy = arr[i]
        tapxy(xy[1], xy[2])
    end
end
function qhzb()
    -- 强化装备
    tapArray({{1234, 547, 0xa88252}, {1064, 583, 0x5d3b1e}})
    moveTo(1082, 583, 1084, 205, 30, 1000)
    mSleep(1000)
    for i = 1, 3 do
        moveTo(1082, 683, 1084, 30, 30)
    end
    mSleep(2000)
    tapArray({{1068, 660, 0x030405}, {780, 648, 0x02060c}})
    mSleep(5000)
    tapArray({{149, 577, 0x020305}})
    back_city()
end

--
function get_rc()
    -- 日常活跃
    tapArray({{1227, 431, 0xbfc2c2}, {112, 132, 0x1c5083}})
    for i = 1, 15 do
        if (isColor(1198, 376, 0xd78e16, 90)) then
            tapArray({{1157, 376, 0xe7af26}, {468, 161, 0x112033}})
        end
    end
    tapArray(
        {
            {607, 166, 0x48371c},
            {641, 483, 0xeab22b},
            {468, 161, 0x112033},
            {754, 165, 0x221509},
            {641, 484, 0xe7af26},
            {468, 161, 0x112033},
            {898, 162, 0x332413},
            {650, 483, 0xa89c80},
            {468, 161, 0x112033},
            {1046, 172, 0x564a22},
            {640, 485, 0xe6ad25},
            {468, 161, 0x112033},
            {1193, 168, 0x1f090d},
            {637, 483, 0xeab22b},
            {468, 161, 0x112033}
        }
    )
    back_city()
end
function lqcj()
    -- 领取成就
    local today = tonumber(os.date("%d", os.time()))
    if today % 10 ~= 0 then
        return
    end

    tapArray({{1229, 541, 0x8c6441}, {1134, 516, 0x69427b}})
    for i = 1, 20 do
        if (isColor(1191, 387, 0xde971b, 90)) then
            tapArray({{1152, 388, 0xdaa525}})
        end
        if (isColor(1185, 278, 0xdf9d1d, 90)) then
            tapArray({{1150, 282, 0x564931}, {468, 161, 0x112033}})
        end
    end

    back_city()
end
function lqgkjl()
    -- 领取管卡奖励
    local today = tonumber(os.date("%d", os.time()))
    if today % 10 ~= 0 then
        return
    end
    -- goMap("赫顿城", "暮光", "恶毒", "普通")
    -- tapArray({{53, 132, 0xba864b}})
    zj_arr = {
        {268, 178, 0x727c59},
        {264, 292, 0x4d2515},
        {272, 389, 0x548b7b},
        {273, 385, 0x3c4846},
        {274, 487, 0x2293cf},
        {267, 589, 0x727494},
        {272, 617, 0x684a40},
        {268, 519, 0x4a5152},
        {271, 410, 0x181418},
        {261, 297, 0xaa6a57}
    }

    subarray = {
        {{1124, 173, 0xe11e17}, {550, 16, 0x0c111b}},
        {
            {691, 170, 0xf8c69a},
            {550, 16, 0x0c111b},
            {906, 173, 0xa6afb6},
            {550, 16, 0x0c111b},
            {1121, 176, 0x442c2e},
            {550, 16, 0x0c111b}
        },
        {
            {688, 171, 0xefb890},
            {550, 16, 0x0c111b},
            {905, 176, 0x6199e8},
            {550, 16, 0x0c111b},
            {1124, 175, 0xffca09},
            {550, 16, 0x0c111b}
        }
    }
    for i = 1, 3 do
        moveTo(278, 311, 261, 612, 30, 60)
    end
    mSleep(1000)
    for i = 1, 10 do
        pos = zj_arr[i]
        tapArray({pos})

        -- nLog("what")
        for j = 1, 20 do
            -- nLog(j)
            if (isColor(1088, 367, 0xe7a520, 90)) then
                tapArray({{1058, 370, 0xeec14e}})
            end
        end
        local p2 = subarray[i]
        if p2 ~= nil then
            tapArray(p2)
        end
        if i == 5 then
            for k = 1, 3 do
                -- nLog(k)
                moveTo(261, 612, 278, 311, 30, 60)
            end
        end
    end
    tapArray({{1135, 104, 0xbb9764}})
    back_city()
end
-- qhzb()
--lqcj()
-- get_rc()
-- qhzb()
-- do_buygh(2)
-- make_xhp(6)
-- clear_xhp()
-- clear_xhp(y)
-- x, y = 797+95*2, 135
-- local x1, y1 = findImage("xhp_衣服.png",987,135,1037,185,10000)
-- if x1~=nil then
-- nLog("oo")
-- end

-- if x1 ~= nil then
--     showMessage("找到衣服")
--     -- tapxy(x1 + 50, y1 + 50)
--     -- tapxy(1109, 84)
--     -- cnt = cnt + 1
--     -- break
-- end

-- use_zb_all(false)
--
--   moveTo(746, 513,757, 306,10,800)
