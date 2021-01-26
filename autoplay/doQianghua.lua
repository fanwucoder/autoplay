-- 自动强化装备
require("playgame")
require("tools")
-- tapArray({{955, 37, 0x4f270f},{108, 524, 0x0e1117},{728, 288, 0x0c2449},
--     {1197, 102, 0x14418d},{1199, 384, 0x101721},{993, 102, 0xbecbe0},{992, 212, 0x111822},{993, 102, 0xbecbe0},{992, 212, 0x111822}})
-- local num = get_num(942,13,1052,50, "DBDEE0-111111|BFC5CB-111111") or 0
-- showMessage("绿石数量:"..num)
-- mSleep(2000)
--  num = get_num(1135,15,1239,51, "DBDEE0-111111|BFC5CB-111111") or 0
-- nLog("绿石数量:"..num)
function buy_zb(num)
    -- 购买装备
    for i = 1, num do
        tapArray({{1204, 547, 0x422909}, {642, 650, 0xc1c2c4}, {803, 18, 0x0f1420}})
    end
end
-- back_city()
-- 打开背包，消除新字
-- tapArray({{1230, 672, 0x663b23}})
-- back_city()
-- 打开强化界面
-- tapArray({{1232, 543, 0xb79969},{1063, 584, 0x654020}})
function moveItem(direct)
    local sx = 1073 + getRnd(0, 5)
    local sy = 229 + getRnd(0, 5)
    touchDown(sx, sy)
    for i = 1, 3 do
        sy = sy + getRnd(8, 12) * direct
        touchMove(sx, sy)

        mSleep(10)
    end
    touchUp(sx + 1, sy)
end

function match_type()
    sx = 1096
    sy = 160
    tapArray({{1096, 160, 0x202838}})
    local cntout = 0
    local split_line = {{0, 0xffc30c}, {2, 0x0f1626}, {12, 0x445577}, {14, 0x232335}}
    while true do
        local found = true
        for i = 1, #split_line do
            p = split_line[i]
            if isColor(sx, sy + p[1], p[2]) ~= true then
                found = false
                break
            end
        end
        if found then
            return sx, sy + 12
        end

        sy = sy + 1
        cntout = cntout + 1
        if cntout > 120 then
            break
        end
    end
    return -1, -1
end

function qh_level(level)
    -- 点击强化装备
    if level == 8 then
        tapArray({{788, 578, 0x151d2c}, {786, 495, 0x132b47}, {960, 494, 0x431dae}, {778, 643, 0x144497}})
    elseif level == 9 then
        tapArray({{787, 581, 0x111927}, {876, 500, 0x122a46}, {960, 497, 0x5c3aba}, {777, 645, 0x144391}})
    elseif level == 10 then
        tapArray(
            {
                {784, 584, 0x5d636c},
                {698, 324, 0x132b47},
                {963, 417, 0x122a46},
                {963, 504, 0x4725a6},
                {780, 645, 0x475263}
            }
        )
    elseif level > 10 then
        tapArray({{780, 645, 0x475263}})
    end

    if multiColor({{550, 475, 0x12459a}, {822, 479, 0x144393}}) then
        tapArray({{822, 479, 0x144393}})
    end
end

function qhwc()
    keepScreen(true)
    local x, y = findImageInRegionFuzzy("qhwc.png", 90, 604, 591, 667, 628, 0, 2)
    keepScreen(false)
    if x ~= -1 then
        return true, 0
    end
    return false, -1
end
function qhret()
    keepScreen(true)
    local ret = multiColor({{562, 100, 0xc01004}, {610, 131, 0xea1404}, {634, 129, 0x000101}})
    keepScreen(false)
    if ret then
        return true, 1
    end

    if x ~= -1 then
        return true, 1
    end
    keepScreen(true)
    x, y = findImageInRegionFuzzy("qhcg.png", 90, 628, 94, 752, 130, 0, 1)
    keepScreen(false)
    if x ~= -1 then
        return true, 2
    end
end

function getzb_dj()
    local qhdj = get_num(753, 568, 824, 598, "EFEFF0-222222|7B8088-222222")
    if qhdj == nil then
        qhdj = 1
    end
    qhdj = qhdj - 1
    return qhdj
end

function qhz_level(begin_level, level, num, times)
    -- 强化到level等级num个装备
    move_times = 0
    direct = -1
    try_times = 0
    success = 0
    while (true) do
        local a, b = match_type()
        if a ~= -1 then
            if isColor(938, b + 7, 0x00ce08) then
                showMessage("跳过穿戴装备")
                direct = -1
            else
                showMessage("找到可强化的装备")
                local px, py = a, b + 50
                local px1, py1 = get_from_page(px, py, begin_level, level)
                if px1 ~= -1 then
                    -- 根据当前的强化等级滑动
                    local ret = qhz_level_one(px, py, begin_level, level)
                    if ret ~= -1 then
                        try_times = try_times + 1
                    end
                    if ret == 0 or ret == 1 then
                        success = success + 1
                    end
                end
                local start_dj = getzb_dj()
                if start_dj <= level then
                    direct = -1
                end
                if level > begin_level then
                    direct = 1
                end
            end
        end
        if try_times >= times or success >= num then
            return
        end

        moveItem(direct)
        move_times = move_times + 1
    end
end
function get_from_page(px, py, begin_level, level)
    for i = py, 720, 124 do
        start_dj = getzb_dj()
        tapArray({{px, i, 0x22293b}})
        if start_dj < level and (start_dj == begin_level or begin_level == -1) then
            return px, i
        end
    end
    return -1, -1
end

function qhz_level_one(px, py, begin_level, level)
    tapArray({{px, py, 0x22293b}})
    start_dj = getzb_dj()
    local find, pos, ret = false, 0, -1
    qh_level(level)
    if level - start_dj > 1 then
        find, pos, ret = waitFound2(60, 0.3, qhwc)
    else
        find, pos, ret = waitFound2(60, 0.3, qhret)
    end
    if ret == 0 then
        tapArray({{638, 610, 0x5275b0}})
    elseif ret == 1 then
        tapArray({{560, 82, 0x101d30}, {560, 82, 0x101d30}})
    elseif ret == 2 then
        tapArray({{560, 82, 0x101d30}, {560, 82, 0x101d30}})
    end
    return ret
end
mSleep(1000)
qhz_level(-1, 8, 5, 999)

-- tapArray({{1088, 228, 0x22293b}})

-- showMessage("当前等级："..qhdj)
-- 强化8级

--
-- local find, pos, ret = waitFound2(60, 0.3, qhwc)
-- nLog(find)
-- nLog(ret)
-- mSleep(1000)

-- mSleep(2000)
--   keepScreen(true)
--     x, y = findImageInRegionFuzzy("qhsb.png", 90, 628,94,752,130, 0, 1)
--     keepScreen(false)
--     if x ~= -1 then
--       nLog("xxx")
--       else nLog("gg")
--     end

-- snapshot("/sdcard/qhwc.png", 604, 591, 667, 628)

-- imageBinaryzation("/sdcard/qhwc.png")
-- ret=qhwc()
-- nLog(ret)
-- nLog("xxx")
