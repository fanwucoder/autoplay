-- 项目公用函数
require("TSLib")
require("tools")
PACKAGES = {"com.hegu.dnl.mi", "com.hegu.dnl.sn79"}
-- appType类型
APP_XM = 1 -- 小米
APP_SS = 2 -- 上士
H = {}
-- 原始偏色格式
H["进副本"] = {
    {"副本返回", 0.9, 19, 30, 40, 60, "0x273755-0x111111", "7|9|0xBE9E6B-0x111111"},
    {"开始挑战", 0.9, 1003, 614, 1022, 648, "0xEDA314-0x111111", "0|14|0xDA8C11-0x111111"},
    {"血条", 0.8, 83, 38, 91, 65, "0xb81512", "-1|14|0x16376a"},
    {"副本血条", {{85, 44, 0xb81313}, {86, 62, 0x18386d}}, {0, 0}},
    {"副本结束", {{193, 116, 0xf0b02d}, {192, 96, 0x243755}, {205, 58, 0x192535}}, {0, 0}},
    {"未通关", 0.9, 27, 261, 52, 290, "0x4C4C4C", "-3|14|0xD0D0D0"},
    {"选择卡牌", 0.9, 556, 35, 575, 59, "0x131939-0x111111", "2|7|0xffffff-0x111111,0|11|0x161538-0x111111"},
    {"再来一次", 0.9, 1043, 128, 1051, 139, "0x1F286E-0x111111", "1|4|0xF2F2F5-0x111111,-1|8|0x172062-0x111111"},
    {"神秘商人", 0.9, 1067, 619, 1088, 654, "0x09101F-0x111111", "1|5|0xCCAB72-0x111111,-2|8|0x0D1320-0x111111"},
    {"神秘商人1", 0.9, 1097, 92, 1124, 125, "0x101A28-0x111111", "0|6|0x95724C-0x111111,-2|15|0x101A28-0x111111"},
    {"神秘商人2", 0.9, 875, 64, 891, 82, "0x101A28-0x111111", "-1|4|0xECCBA5-0x111111,-5|7|0x101A28-0x111111"},
    {"图刷完了", {{1186, 48, 0x162168}, {1197, 143, 0x2e2b29}, {1200, 241, 0xd58914}}, {1100, 55}},
    {"变强卡屏", {{778, 450, 0x101a28}, {804, 458, 0x15418a}, {919, 209, 0x101a28}, {918, 189, 0xc2a171}}, {917, 191}},
    {"自动副本", {{34, 268, 0xffd278}, {48, 268, 0xffffbb}, {40, 286, 0xffff67}, {27, 277, 0xffbb2a}}, {0, 0}},
    {"关闭设置", {{1102, 122, 0xe9cc9b}, {1127, 144, 0x9d733d}, {1107, 144, 0x986c38}, {1124, 124, 0xc9ac7d}}, {1116, 135}},
    {
        "商人没精力",
        {{190, 117, 0xedaa2a}, {190, 110, 0xfbea84}, {995, 233, 0xda9113}, {1062, 144, 0x7e7e7e}, {1092, 145, 0x7f7f7f}},
        {1091, 48}
    },
    {"拜师", {{637, 275, 0x101a28}, {477, 388, 0x101a28}, {571, 431, 0x1152be}, {786, 433, 0x104fb7}}, {534, 452}}
}
-- H["进副本"] = {
--     {"副本返回", {{26, 40, 0x202f49}, {29, 47, 0x5b411a}, {23, 51, 0x17253a}}, {26, 40}},
--     {"开始挑战", 0.9, 1003, 614, 1022, 648, "0xDC9203-0xFEB425", "0|14|0xC97B00-0xEB9D22"},
--     {"血条", 0.8, 83, 38, 91, 65, "0xA70401-0xC92623", "-1|14|0x052659-0x27487B"},
--     {"未通关", 0.9, 27, 261, 52, 290, "0x3B3B3B-0x5D5D5D", "-3|14|0xBFBFBF-0xE1E1E1"},
--     {"选择卡牌", 0.9, 556, 35, 575, 59, "0x020828-0x242A4A", "2|7|0xEEEEEE-0xFFFFFF,0|11|0x050427-0x272649"},
--     {"再来一次", 0.9, 1043, 128, 1051, 139, "0x0E175D-0x30397F", "1|4|0xE1E1E4-0xFFFFFF,-1|8|0x060F51-0x283173"},
--     {"神秘商人", 0.9, 1067, 619, 1088, 654, "0x00000E-0x1A2130", "1|5|0xBB9A61-0xDDBC83,-2|8|0x00020F-0x1E2431"},
--     {"神秘商人1", 0.9, 1097, 92, 1124, 125, "0x000917-0x212B39", "0|6|0x84613B-0xA6835D,-2|15|0x000917-0x212B39"},
--     {"神秘商人2", 0.9, 875, 64, 891, 82, "0x000917-0x212B39", "-1|4|0xDBBA94-0xFDDCB6,-5|7|0x000917-0x212B39"}
-- }
H["登录广告"] = {
    {"活动广告", 0.9, 1225, 2, 1279, 67, "0xE1C193-0x111111", "9|9|0xC0A070-0x111111,19|19|0xA07741-0x111111"},
    {"福利", 0.9, 1098, 111, 1145, 161, "0xE8D18B-0x111111", "9|10|0xC4A475-0x111111,21|21|0xA07842-0x111111"},
    {"精力", 70, 89, 0, 126, 42, "0x00ff00-0x111111", "8|23|0x254432-0x111111,12|21|0x677418-0x111111"},
    {"精力xy", {{100, 8, 0x00ff00}, {107, 30, 0x1e3f32}, {114, 26, 0xa5bd2e}}, {0, 0}},
    {
        "宠物广告",
        {
            {103, 8, 0x00ff00},
            {124, 67, 0x1b5454},
            {110, 28, 0x79872b},
            {506, 160, 0x153774},
            {809, 510, 0x0c2570},
            {1111, 156, 0xc3a373}
        },
        {1113, 155}
    },
    -- {"精力", 70,89, 0, 126, 42, "0x00ff00-0x11ee11", "8|23|0x143321-0x365543,12|21|0x566307-0x788529"},
    {"电池", 0.9, 87, 0, 120, 15, "0x005A00-0x111111", "4|6|0x005800-0x111111"}
}
-- H["登录广告"] = {
--     {"活动广告", 0.9, 1225, 2, 1279, 67, "0xD0B082-0xF2D2A4", "9|9|0xAF8F5F-0xD1B181,19|19|0x8F6630-0xB18852"},
--     {"福利", 0.9, 1098, 111, 1145, 161, "0xD7C07A-0xF9E29C", "9|10|0xB39364-0xD5B586,21|21|0x8F6731-0xB18953"},
--     {"精力", 90, 89, 0, 126, 42, "0x00EE00-0x11FF11", "8|23|0x143321-0x365543,12|21|0x566307-0x788529"},
--     {"电池", 0.9, 87, 0, 120, 15, "0x004900-0x116B11", "4|6|0x004700-0x116911"}
-- }

H["登录界面"] = {
    {"上士登录按钮", 0.9, 603, 399, 625, 422, "0xFFFFFF-0x111111", "-4|2|0xFF6D2D-0x111111,0|5|0xFFFFFF-0x111111"},
    {
        "登录按钮",
        0.8,
        608,
        588,
        682,
        631,
        "0x144393-0x000000",
        "-7|-2|0xC7CDD7-0x000000,-15|6|0xCECECF-0x000000,13|-1|0x144495-0x000000"
    },
    {
        "进入游戏",
        0.8,
        542,
        485,
        656,
        549,
        "0xFFFDF5-0x000000",
        "-2|8|0xFDF6D6-0x000000,30|25|0xF98C41-0x000000,25|2|0xF75520-0x000000,40|14|0xFB7440-0x000000"
    },
    {
        "进入游戏1",
        0.8,
        623,
        652,
        664,
        681,
        "0x9A2818-0x000000",
        "0|10|0x9C3822-0x000000,0|14|0xEEDD99-0x000000,8|14|0xF3D298-0x000000"
    }
}
-- H["登录界面"] = {
--     {"上士登录按钮", 0.9, 603, 399, 625, 422, "0xEEEEEE-0xFFFFFF", "-4|2|0xEE5C1C-0xFF7E3E,0|5|0xEEEEEE-0xFFFFFF"},
--     {
--         "登录按钮",
--         0.8,
--         608,
--         588,
--         682,
--         631,
--         "0x144393-0x144393",
--         "-7|-2|0xC7CDD7-0xC7CDD7,-15|6|0xCECECF-0xCECECF,13|-1|0x144495-0x144495"
--     },
--     {
--         "进入游戏",
--         0.8,
--         542,
--         485,
--         656,
--         549,
--         "0xFFFDF5-0xFFFDF5",
--         "-2|8|0xFDF6D6-0xFDF6D6,30|25|0xF98C41-0xF98C41,25|2|0xF75520-0xF75520,40|14|0xFB7440-0xFB7440"
--     },
--     {
--         "进入游戏1",
--         0.8,
--         623,
--         652,
--         664,
--         681,
--         "0x9A2818-0x9A2818",
--         "0|10|0x9C3822-0x9C3822,0|14|0xEEDD99-0xEEDD99,8|14|0xF3D298-0xF3D298"
--     }
-- }

H["上士登录页"] = {
    {"登录按钮", {{1037, 295, 0x000000}, {756, 419, 0xff6d2d}, {765, 183, 0xededed}}, {633, 419}},
    {"绑定手机", {{1007, 527, 0x000000}, {912, 521, 0xededed}, {762, 519, 0xff6d2d}}, {876, 160}},
    {"绑定手机xy1", {{881, 158, 0x818181}, {622, 146, 0xf6b226}, {784, 432, 0xff6d2d}, {804, 547, 0xff6d2d}}, {876, 160}},
    {
        "绑定手机xy",
        {{1016, 553, 0x000000}, {830, 556, 0xff6d2d}, {831, 435, 0xff6d2d}, {621, 144, 0xf5b323}, {641, 156, 0x683f31}},
        {876, 160}
    },
    {"绑定手机1", {{804, 522, 0xff6d2d}, {811, 440, 0xff6d2d}, {813, 466, 0xededed}, {608, 156, 0xf2941c}}, {876, 160}},
    {"公告", {{684, 603, 0x124498}, {751, 606, 0x101a28}, {703, 101, 0x1c2d49}, {623, 98, 0xffffff}}, {650, 602}},
    {"排队", {{689, 457, 0x104eb5}, {662, 385, 0x263653}, {1176, 57, 0x2f100f}}, {0, 0}},
    {
        "排队xy",
        {
            {564, 181, 0x19253d},
            {590, 389, 0x263653},
            {625, 455, 0x104fb9},
            {622, 511, 0x101a28},
            {821, 294, 0x65f205},
            {821, 315, 0x65f205}
        },
        {0, 0}
    },
    {
        "游戏登录按钮",
        {{113, 52, 0x152740}, {102, 43, 0xf4f6f7}, {1171, 59, 0x89312a}, {1169, 82, 0xf8f880}, {638, 497, 0xf3401c}},
        {633, 515}
    },
    {"邮件", 0.9, 412, 350, 499, 625, "0x2f73ac", "-3|16|0xd90100,-3|31|0x0c2745,7|9|0xf2e3c9"},
    {"角色选择", {{564, 23, 0xffffff}, {73, 42, 0xbfa476}, {96, 23, 0x324366}, {582, 654, 0x882414}}, {0, 0}},
    {"广告1", {{103, 9, 0x005900}, {1256, 29, 0xc3a374}, {1242, 39, 0xbc9761}}, {1249, 33}},
    {"广告2", {{1119, 134, 0xc0a06f}, {1065, 131, 0x101a28}, {700, 105, 0x1f2f4e}}, {1121, 136}},
    {"登录完成", {{102, 8, 0x00ff00}, {107, 29, 0x133532}, {109, 59, 0xdd9b58}}, {0, 0}},
    {"邮箱", {{507, 589, 0xd90906}, {507, 605, 0x0c2644}, {513, 574, 0x3678af}}, {507, 589}},
    {"决斗段位", {{283, 353, 0x245698}, {863, 401, 0x8f2025}, {687, 656, 0x144391}}, {638, 653}},
    {"登录人满", {{1173, 57, 0x2d100e}, {725, 248, 0x101a28}, {699, 476, 0x134393}, {108, 53, 0x070e16}}, {641, 481}},
    {"拜师", {{717, 277, 0x101a28}, {603, 448, 0x12469c}, {826, 457, 0x163f88}, {104, 8, 0x005c00}}, {524, 460}},
    {"决斗段位1", {{694, 648, 0x1148a3}, {822, 648, 0x280d0f}, {756, 100, 0xffcf7b}, {640, 90, 0xe5a36a}}, {643, 654}},
    {
        "工会地下城",
        {{877, 563, 0xf7c52e}, {1192, 130, 0xc8a979}, {104, 11, 0x005c00}, {702, 452, 0x5b2a40}, {779, 462, 0x54263b}},
        {1197, 138}
    },
    {"绑定手机g", {"绑定手机", "绑定手机xy1", "绑定手机xy", "绑定手机1"}}
}
H["分解装备"] = {
    {"分解确认", 0.8, 793, 359, 829, 586, "0x114bac", "-2|26|0x183b76"},
    -- {"分解确认", 0.8, 793, 359, 829, 586, "0x003A9B-0x225CBD", "-2|26|0x072A65-0x294C87"},
    {"分解完成", {{885, 146, 0xe4c696}, {893, 157, 0xbf9b69}, {902, 163, 0xa17a43}, {891, 139, 0x101a28}}, {893, 154}}
}
H["学习技能"] = {
    {"技能图标", {{1161, 672, 0xffffff}, {1232, 12, 0x13202e}, {102, 10, 0x00ff00}}, {}}
}
AREA_MG_CONFIG = "开通"
function startApp(appType)
    local package = PACKAGES[appType]
    local ret = runApp(package, true)
    nLog("启动应用:" .. APP_XM .. "启动结果：" .. ret)

    return ret == 0
end

function startSS()
    local ret = runApp(PACKAGES[APP_SS])
    mSleep(2000)
    if ret == 0 then
        if waitPic1(598, 146, 680, 197, "start_ok.png", 120, 20) ~= true then
            nLog("账号首次登录启动app成功")
            return false
        end
        if waitPic1(391, 331, 520, 382, "ss_fisrt_login.png", 1, 1) then
            nLog("账号首次登录启动app成功")
            return true
        end

        if waitPic1(602, 399, 672, 435, "ss_login.png", 1, 1) then
            nLog("启动app成功")
            return true
        end
    end
    return true
end
function startToAccount()
    if startSS() ~= true then
        return false
    end

    if waitPic1(391, 331, 520, 382, "ss_fisrt_login.png", 3, 1) then
        nLog("账号首次登录启动app成功")
        randomTap(815, 408)
    else
        randomTap(788, 502)
    end
    rndSleep(300, 600)
    randomTap(817, 421)
    rndSleep(300, 600)
    return true
end

function stopSSApp()
    closeApp(PACKAGES[APP_SS])
    rndSleep(3000, 5000)
end
PLAY_TASK_INFO = {
    ["区域"] = {"赫顿城"},
    ["区域1"] = {"悬空", "暮光"},
    ["zl_account"] = "",
    ["zl_password"] = ""
}

function init_config()
    message_log = true
    showMessage("初始化全局公共配置")
    init(1)
    setTable(H)
    message_log = true
    local file = userPath() .. "/res/run_config.txt"
    local config_data = readFileString(file)
    local lines = strSplit(config_data, "\n")
    for i = 1, #lines do
        line = lines[i]
        line=string.gsub(line,"\r","")
        showMessage("读取配置:" .. line)
        local kv = strSplit(line, "::")
        k = kv[1]
        v = kv[2]
        if k == "task" then
            PLAY_TASK_INFO["task"] = v
        end
        if k == "role" then
            PLAY_TASK_INFO["role"] = strSplit(v, ",")
            PLAY_TASK_INFO["max_role"] = #PLAY_TASK_INFO["role"]
        end
        if k == "commonapi_addr" then
            SERVER_ADDR = v
        end
        if k == "副本" then
            v1 = strSplit(v, ",")
            nLogTab(v1)
            PLAY_TASK_INFO["副本"] = {
                v1[1],
                v1[2],
                v1[3],
                v1[4],
                tonumber(v1[5]),
                v1[6] == "true"
            }
        end
        if k == "副本方式" then
            PLAY_TASK_INFO["副本方式"] = v
        end
        if k == "分解装备" then
            v1 = strSplit(v, ",")
            nLogTab(v1)
            PLAY_TASK_INFO["分解装备"] = {
                v1[1] == "true",
                v1[2] == "true",
                v1[3] == "true",
                v1[4] == "true"
            }
        end
        if k == "出售装备" then
            v1 = strSplit(v, ",")
            PLAY_TASK_INFO["出售装备"] = {
                v1[1] == "true",
                v1[2] == "true",
                v1[3] == "true",
                v1[4] == "true"
            }
        end
        if k == "appType" then
            if v == "小米" then
                PLAY_TASK_INFO["appType"] = APP_XM
            elseif v == "上士" then
                PLAY_TASK_INFO["appType"] = APP_SS
            end
            nLog(tostring(v == "小米"))
        end
        if k == "zl_account" then
            PLAY_TASK_INFO["zl_account"] = v
        end

        if k == "zl_password" then
            PLAY_TASK_INFO["zl_password"] = v
        end
        if k == "区域" then
            v1 = strSplit(v, "-")
            nLogTab(v1)
            PLAY_TASK_INFO["区域"] = v1
        end
    end

    roles = PLAY_TASK_INFO["role"]
    PLAY_TASK_INFO["role_info"] = {}

    for i = 1, #roles do
        PLAY_TASK_INFO["role_info"][i] = {
            ["role"] = roles[i],
            ["副本"] = PLAY_TASK_INFO["副本"],
            ["分解装备"] = PLAY_TASK_INFO["分解装备"],
            ["出售装备"] = PLAY_TASK_INFO["出售装备"],
            ["副本方式"] = PLAY_TASK_INFO["副本方式"],
            ["区域"] = PLAY_TASK_INFO["区域"]
        }
    end
    -- table.remove(PLAY_TASK_INFO, "role")
    -- table.remove(PLAY_TASK_INFO, "副本")
    -- table.remove(PLAY_TASK_INFO, "分解装备")
    -- table.remove(PLAY_TASK_INFO, "出售装备")
    -- table.remove(PLAY_TASK_INFO, "副本方式")
    writeFileString("/sdcard/zlaccount.txt ", "", "w")
    initLog("runinfo", 1)
    nLogTab(PLAY_TASK_INFO)
    get_num=get_num_ts
    --读取文件内容，返回全部内容的 string
end
local token_info = {
    ["access_token"] = "",
    ["expires_in"] = 0,
    ["last_time"] = 0
}
function get_num_ts(x1, y1, x2, y2, tab)
    ts = require("ts")
    json = ts.json
    local API = "LIDqc8lxXgbDa8dtXHVm7FTX"
    local Secret = "uFod2vGXK3HhWw3MYFkeXaNF82akB2TH"
    local token = ""
    if os.time() - token_info["last_time"] < token_info["expires_in"] - 3600 then
        token = token_info["access_token"]
    else
        code, access_token = getAccessToken(API, Secret)
        if code == true then
            token_info["access_token"] = access_token
            token_info["expires_in"] = os.time() + 3500
            token_info["last_time"] = os.time()
            token = access_token
        end
    end
    if token == "" then
        return nil
    end

    local ret = mybinaryzation(x1, y1, x2, y2, tab)
    if ret == nil then
        return nil
    end
    local code2, body = baiduAI(token, ret)
    if code2 == true then
        local tmp = json.decode(body)
        nLog(body)
        if #tmp['words_result']>0 then
           return tonumber( tmp['words_result'][1]['words'])
        end
        return nil
    end
end
function mybinaryzation(x1, y1, x2, y2, tab)
    local image = require("tsimg")
    snapshot("/sdcard/a.png", x1, y1, x2, y2)
    -- 将文件转换为图片对象
    local newImage, msg = image.loadFile("/sdcard/a.png")
    if image.is(newImage) then
        --将图片对象进行二值化
        --图片中 0xFF27FF - 0x012815 区间内颜色值二值化后变为白色，不在区间内的颜色值都转换为黑色，可以写入多个 table
        -- 方式一
        -- {0x757475,0x979697}
        local binaMat, msg = image.binaryzation(newImage, tab)
        -- 方式二
        -- local binaMat,msg = image.binaryzation(newImage, "FF27FF-012815")
        if image.is(binaMat) then
            --将图片对象转换成图片保存在 res 文件夹下
            local boo, msg = image.saveToPngFile(binaMat, "/sdcard/aa.png")
            return "/sdcard/aa.png"
        else
            return nil
        end
    else
        return nil
    end
end
-- init(1)
-- -- ctab = {{0xfefefe, 0x111111}, {0xbab9ba, 0x222222}, {0x757575, 0x222222}, {0xe3e3e3, 0x111111}}
-- ctab = "fefefe-111111|bab9ba-222222|757575-222222|e3e3e3-111111"
-- -- mybinaryzation(949, 187, 989, 221, ctab)
-- nLog(get_num_ts(949, 187, 989, 221, ctab))
-- 0x868586

-- get_num_ts()
init_config()
-- mSleep(2000)
-- x={1,2,3}
-- table.remove(x,1)
-- nLogTab(x)

