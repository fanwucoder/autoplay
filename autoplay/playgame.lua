require("TSLib")
require("common")
require("tools")
-- 卡分解页面
Unit.Param.playGamer = {
    ["taskRole"] = {
        {
            ["role"] = 1,
            ["副本"] = {"赫顿城", "暮光", "灼热", "勇士", 999, true},
            ["分解装备"] = {true, true, true, true},
            ["出售装备"] = {false, true, true, true}
        },
        {
            ["role"] = 2,
            ["副本"] = {"赫顿城", "暮光", "灼热", "勇士", 999, true},
            ["分解装备"] = {true, true, true, true},
            ["出售装备"] = {false, true, true, true}
        },
        {
            ["role"] = 3,
            ["副本"] = {"赫顿城", "暮光", "灼热", "勇士", 999, true},
            ["分解装备"] = {true, true, true, true},
            ["出售装备"] = {false, true, true, true}
        },
        {
            ["role"] = 4,
            ["副本"] = {"赫顿城", "暮光", "灼热", "勇士", 999, true},
            ["分解装备"] = {true, true, true, true},
            ["出售装备"] = {false, true, true, true}
        }
    },
    appType = APP_SS
}

function Unit.State.playGamer(taskInfo)
    nLog("初始化刷副本的信息！")

    if taskInfo.from == "playGamerOne" then
        nLog("执行完毕，退出脚本")
        lua_exit()
    end

    bid,_ = frontAppBid()
    if bdi ~= PACKAGES[APP_SS] then
        if runAppWithoutLogin(APP_SS) ~= true then
            nLog("启动游戏出错！")
            return "Error"
        end
    else
        nLog("app is running")
    end
    -- nLog(taskInfo.taskRole)
    if wait_bak() then
        nLog("在主城中")
        goChoseGamer()
        SetTableID("上士登录页")
        if waitColor("角色选择", false, 30 * 60, 10) then
            nLog("等待角色选择")
        end
    end
    nLog("xxx")
    Unit.Param.playGamerOne = {
        taskRole = taskInfo.taskRole,
        cur = 1
    }
    return "playGamerOne"
    --   ret=get_num(544,280,584,307,"90ABB4-242926")
end
Unit.Param.playGamerOne = {
    taskRole = {},
    cur = 1
}
function Unit.State.playGamerOne(taskInfo)
    nLog("开始清日常")
    if taskInfo.cur > 4 then
        return "playGamer"
    end
    -- for key, value in pairs(taskInfo) do
    --     nLog("key:" .. key)
    -- end
    mSleep(5000)
    role_info = taskInfo.taskRole[taskInfo.cur]
    nLog(taskInfo.taskRole)
    local role_idx = role_info.role
    nLog("role_idx" .. role_idx)
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
    if role_idx == 1 then
        -- set_base_picture()
        mSleep(2000)
    end
    if fb[6] then
        doPalyOne(fb[1], fb[2], fb[3], fb[4], fb[5])
    end
    mSleep(1000)

    clear_package(fj, cs)
    mSleep(1000)
    goChoseGamer()
    SetTableID("上士登录页")
    if waitColor("角色选择", false, 30 * 60, 10) then
        nLog("等待角色选择")
    end
    mSleep(1000)
    nLog("cur role:" .. taskInfo.cur)
    taskInfo.cur = taskInfo.cur + 1
    return "playGamerOne"
end

function choseGamer(idx)
    nLog("选角色")
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
    toast("tap x:" .. x .. "y:" .. y)
    randomTap(x, y)
    mSleep(1000)
end
-- init(1)
-- choseGamer(8)

function goChoseGamer()
    nLog("通过回城页面到选择色页面")
    -- 通过回城页面到选择色页面
    randomTap(32, 54)
    rndSleep(1000)
    randomTap(863, 604)
    rndSleep(1000)
    -- 等待页面稳定
end
MAP = {["格鲁"] = {321, 164}}
SUB_MAP = {
    ["悬空"] = {963, 292},
    ["暮光"] = {308, 610}
}
SUB_MAP1 = {
    ["悬空"] = {["矿脉"] = {243, 610}},
    ["暮光"] = {["灼热"] = {1104, 411}}
}

function goMap(area, subarea, name, level)
    nLog("走大地图")
    -- area 地图
    -- name 图名
    -- level 等级

    randomTap(1190, 100)
    for i = 0, 5, 1 do
        moveTo(734, 210, 711, 673)
        nLog("滑动地图")
        rndSleep(100)
    end
    -- 其他地图
    SetTableID("进副本")
    local xy = SUB_MAP[subarea]

    for i = 1, 3 do
        nLog("x:" .. xy[1] .. ",y:" .. xy[2])
        randomTap(xy[1], xy[2])
    end

    if waitColor("副本返回", false, 120, 3) ~= true then
        return false
    end
    xy = SUB_MAP1[subarea][name]
    nLog(xy[1])
    nLog(xy[2])
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
    nLog("进图")
    if goMap(area, subarea, name, level) ~= true then
        return false
    end
    mSleep(5000)
    local num = get_num(1142, 12, 1206, 54, "DBDEE0-111111|BFC5CB-111111")
    if num == nil or num <= 0 then
        nLog("没精力了")
        randomTap(60, 25)
        mSleep(3000)
        randomTap(60, 25)
        mSleep(3000)
        randomTap(1232, 48)
        mSleep(5000)
        return false
    end
    randomTap(1095, 632)
    nLog("开始挑战")
    toast("开始挑战副本", 0.5)
    return true
end

function doPalyOne(area, subarea, name, level, times)
    nLog("开始单刷:" .. times .. "次")
    if beginPlayOne(area, subarea, name, level) ~= true then
        return false
    end
    cnt = 0
    local time_cost = 0
    local begin_time = os.time()
    while true do
        if waitPlayBegin() then
            if has_check == false then
                if checkautoplay() == false then
                    --完善一场状态
                    toast("游戏未通关该图", 0.5)
                    return false
                end
                has_check = true
            end
        end

        time_cost = os.time() - begin_time

        local is_end = false
        if waitPlayEnd() then
            is_end = true
        end
        nLog("副本已经结束")
        if is_end then
            doOpenCard(true, true)
            cnt = cnt + 1
            nLog("已经刷了xxx次")
            if cnt >= times then
                nLog("副本刷完了")
                doRePalyOne(false)
                wait_bak()
                break
            else
                doRePalyOne(true)
                nLog("继续副本")
            end
        end
        if multiColor({{918, 177, 0xddbb88}, {926, 187, 0xb79663}, {913, 195, 0xb18a54}, {932, 178, 0xc9aa7b}}) then
            randomsTap(918, 177)
        end
        if find(5, {"登录广告", "精力"}, false) then
            nLog("已经超时回城了")
            if beginPlayOne(area, subarea, name, level) ~= true then
                return false
            end
        end
    end
end
function wait_bak()
    -- 等待回城
    local cnt = 0
    while cnt < 3 do
        if find(5, {"登录广告", "精力"}, false) then
            return true
        end
        cnt = cnt + 1
        mSleep(1000)
    end
    return false
end

function checkautoplay()
    nLog("检查自动挂机")
    SetTableID("进副本")
    if waitPic1(30, 261, 52, 292, "auto_play.png", 5, 1) == true then
        --         if find("未通关", false) then
        --             return false
        --         else
        --             nLog("点击a")
        --   randomTap(35, 273)
        --         end
        local begin = false
        for i = 1, 10 do
            if
                multiColor(
                    {
                        {35, 284, 0xffff50},
                        {40, 284, 0xffff5f},
                        {46, 268, 0xfff096}
                    }
                )
             then
                begin = true
            end
            mSleep(200)
        end
        if begin ~= true then
            randomTap(35, 273)
        else
            return true
        end

        -- if
        --     multiColor(
        --         {
        --             {38, 287, 0xf7e349},
        --             {25, 274, 0x402e09},
        --             {52, 276, 0x896315}
        --         }
        --     )
        --  then
        --     randomTap(35, 273)
        -- else
        --     return false
        -- end

        return true
    end

    return true
end
function waitPlayBegin()
    nLog("等待副本开始")
    SetTableID("进副本")
    cnt = 0
    while cnt < 30 do
        keepScreen(true)
        if
            multiColor(
                {
                    {85, 44, 0xb81313},
                    {86, 62, 0x18386d}
                }
            )
         then
            return true
        end
        keepScreen(false)
        cnt = cnt + 1
    end
    return false
end
function waitPlayEnd()
    nLog("等待副本结束")
    SetTableID("进副本")

    if waitColor("选择卡牌", false, 3, 2) == true then
        nLog("副本结束")
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
    nLog("翻牌")
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
    nLog("翻牌完毕")
end
function closeSR()
    nLog("关闭神秘商人")
    keepScreen(false)
    keepScreen(true)
    x, y =
        findMultiColorInRegionFuzzy(0xb59c73, "-4|26|0x685526,-4|17|0x08101f", 80, 1096, 636, 1096, 636, {orient = 2})
    if x ~= -1 then
        randomsTap(x, y)
    else
        nLog("没有商人1")
    end
    keepScreen(false)
    mSleep(1000)
    keepScreen(true)
    if multiColor({{1113, 112, 0xe7cd90}, {1128, 125, 0xb4935f}, {1114, 130, 0xba9560}, {1128, 116, 0xc9ae84}}) then
        nLog("点击商人2")
        randomsTap(1127, 126)
    else
        nLog("没有商人2")
    end
    keepScreen(false)
    mSleep(1000)
    keepScreen(true)
    if
        (isColor(888, 75, 0xe9cd98, 85) and isColor(899, 86, 0xc6a677, 85) and isColor(912, 100, 0x9a703b, 85) and
            isColor(907, 80, 0xcbac7e, 85) and
            isColor(891, 97, 0xb48b57, 85))
     then
        nLog("点击商人3")
        randomsTap(898, 85)
    else
        nLog("没有商人3")
    end
    keepScreen(false)
    mSleep(1000)
end

function doRePalyOne(bool)
    nLog("点击再来一次")
    local cnt = 0
    SetTableID("进副本")
    -- randomTap( 577,58)
    mSleep(2000)
    while true do
        closeSR()
        if multiColor({{1119, 37, 0xffffff}, {1126, 43, 0x89898c}, {1126, 46, 0x0b1030}, {1113, 45, 0x05081a}}) then
            if bool then
                nLog("点继续")
                randomTap(1105, 147)
            else
                nLog("点回城")
                randomTap(1100, 55)
            end
            return true
        end
        if find("图刷完了", 5, true) then
            nLog("图刷完了，没疲劳了")
            return false
        end

        mSleep(200)
        cnt = cnt + 1
        if cnt >= 5 then
            nLog("等待超时")
            return false
        end
    end
    nLog("没有找到再次挑战！")
    return false
end
function wait_xm()
end
function wait_ss()
    -- 等待上士登录账号
    nLog("等待上士登录")
    SetTableID("上士登录页")
    while true do
        -- 登录页
        if find("登录按钮", true, 5) then
            mSleep(1000)
        end

        if find("绑定手机", true, 5) then
            mSleep(1000)
        end

        if find("公告", true, 5) then
            mSleep(1000)
        end
        if find("排队", false) then
            mSleep(1000)
        -- break
        end
        if find("登录人满", true) then
            -- nLog("人满了")
            mSleep(1000)
        -- break
        end
        if find("游戏登录按钮", true, 5) then
            -- 点击登录
            mSleep(1000)
        -- break
        end
        if waitColor("角色选择", false, 10, 5) then
            nLog("进入游戏成功")
            return true
        end
        mSleep(1000)
        -- nLog("??")
    end
    -- mSleep(5000)
    -- if find("排队", false) then
    --     nLog("排队")
    -- end

    nLog("进入游戏超时")
    return false
end

function runAppWithoutLogin(appType)
    nLog("直接登录，不输入账号")
    local ret = runApp(PACKAGES[appType])
    if ret == 0 then
        if appType == APP_SS then
            return wait_ss()
        elseif APP_SS == APP_XM then
            return wait_xm()
        else
            return false
        end
    end
    return false
end

function closeGG()
    nLog("关闭广告页")
    SetTableID("上士登录页")
    while true do
        if find("广告1", true) then
            nLog("GG")
            mSleep(1000)
        end
        if find("广告2", true) then
            nLog("GG")
            mSleep(1000)
        end
        if find("登录完成", true) then
            nLog("GG")
            mSleep(1000)
            break
        end
        if find("决斗段位", true) then
            nLog("GG")
            mSleep(1000)
            break
        end

        mSleep(1000)
    end
    nLog("登录完成")
end
-- closeGG()
function get_email()
    nLog("领邮件")
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
            nLog("kkkk")
        end
    end
    if has_email == false then
        return has_email
    end

    randomTap(95, 211)
    nLog("邮箱不为空")

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
        nLog("分解")
        randomTap(861, 675)
        mSleep(1000)
    else
        nLog("出售")
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
        nLog("分解装备")
    end
    mSleep(1000)
    local finish = false
    if (isColor(640, 408, 0x104eb6, 80)) then
        nLog("没有装备了")
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
    for i = 1, 10 do
        if fj[1] ~= true and cs[1] ~= true then
            break
        end
        get_email()
        if fj[1] then
            nLog("分解装备")
            if fenjiezb(1, fj[2], fj[3], fj[4]) ~= true then
                nLog("没装备了")
                break
            end
        end
        if cs[1] then
            nLog("出售装备")
            if fenjiezb(2, cs[2], cs[3], cs[4]) ~= true then
                nLog("没装备了")
                break
            end
        end

        if get_email() ~= true then
            nLog("没邮件了")
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

    tap(653, 395)
    mSleep(500)
    tap(541, 535)
    mSleep(500)
    randomsTap(1116, 133)
    mSleep(1000)
end
init(1)
setTable(H)
SetTableID("上士登录页")

-- randomTap(711,338)

-- setTable(H)
-- closeGG()
--   if multiColor({{918, 177, 0xddbb88}, {926, 187, 0xb79663}, {913, 195, 0xb18a54}, {932, 178, 0xc9aa7b}}) then
--             nLog("月卡弹出？")
--             randomsTap(918, 177)
--   end
--     nLog(string.format("0x%X",getColor(918, 177)))
-- todo 配置技能
-- init(1)
-- setTable(H)
-- waitPlayEnd()
-- for i = 1, 300 do
--     if find(5, {"登录广告", "精力"}, false) then
--         nLog("已经超时回城了")
--     -- if beginPlayOne(area, subarea, name, level) ~= true then
--     -- end
--     end
-- end
-- -- if multiColor({{918, 177, 0xddbb88}, {926, 187, 0xb79663}, {913, 195, 0xb18a54}, {932, 178, 0xc9aa7b}}) then
--     randomsTap(918, 177)
-- end
-- if find(5, {"登录广告", "精力"}, false) then
--     nLog("已经超时回城了")
--     if beginPlayOne(area, subarea, name, level) ~= true then
--         return false
--     end
-- end
-- fenjiezb(1,true,true,true)
-- mSleep(3000)

-- clear_package({true, true, true, true}, {false, true, true, true})
-- checkautoplay()
-- checkautoplay()
-- doPalyOne("赫顿城", "暮光", "灼热", "普通", 3)
-- if multiColor({{529, 43, 0x101334}, {87, 37, 0x301630}, {1227, 84, 0xefde99}, {1188, 91, 0x3e3c30}}) then
--     nLog("副本已经开始")
-- -- return true
-- end
-- setTable(H)
-- SetTableID("进副本")

-- init(1)
-- setTable(H)
--
