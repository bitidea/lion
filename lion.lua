--[[
Lion Util - Lua 工具库
命名约定：函数与参数均使用 camelCase；表字段与局部变量也建议 camelCase。
]]

local lion = {}

--[[
格式化字符串，超过万的数字用万显示
参数 num 数字
返回值 "***万"字符串
]]
function lion.formatNumberToWan(num)
    return lion.formatNumberToReadable(num, 10000, 1, { "", "万", "亿" })
end

--[[
数字转人类可读单位
参数 num 要转换的数字
参数 unitLength 单位分割长度
参数 decimalPlaces 保留小数位数
参数 unitArray 单位文字数组
返回值 格式化后的字符串
]]
function lion.formatNumberToReadable(num, unitLength, decimalPlaces, unitArray)
    num = tonumber(num) or 0
    unitLength = tonumber(unitLength) or 1000
    decimalPlaces = tonumber(decimalPlaces) or 2
    unitArray = unitArray or { "", "K", "M", "B", "T", "Q", "Qn" }

    if num == 0 then
        return "0" .. unitArray[1]
    end

    local absNum = math.abs(num)
    local unitIndex = 1

    while absNum >= unitLength and unitIndex < #unitArray do
        absNum = absNum / unitLength
        unitIndex = unitIndex + 1
    end

    local result
    if unitIndex == 1 then
        result = tostring(absNum)
    else
        result = string.format("%." .. decimalPlaces .. "f", absNum)
        result = string.gsub(result, "%.?0+$", "")
    end
    result = result .. unitArray[unitIndex]

    return result
end

--[[
字符串分割
参数 fullString 需要分割的字符串
参数 separator 分隔符
返回值 表
]]
function lion.stringSplit(fullString, separator)
    if fullString == nil or fullString == "" then
        return {}
    end
    if separator == nil or separator == "" then
        return {}
    end
    local nFindStartIndex = 1
    local nSplitIndex = 1
    local nSplitArray = {}
    while true do
        local nFindLastIndex = string.find(fullString, separator, nFindStartIndex)
        if not nFindLastIndex then
            nSplitArray[nSplitIndex] = string.sub(fullString, nFindStartIndex, string.len(fullString))
            break
        end
        nSplitArray[nSplitIndex] = string.sub(fullString, nFindStartIndex, nFindLastIndex - 1)
        nFindStartIndex = nFindLastIndex + string.len(separator)
        nSplitIndex = nSplitIndex + 1
    end
    return nSplitArray
end

--[[
检查字符串中是否带有标点符号
参数 str 要检查的字符串
返回 boolen
]]
function lion.checkSymbol(str)
    if str == nil then
        return false
    end

    str = tostring(str)

    if string.find(str, '"') then
        return true
    end

    if string.find(str, "'") then
        return true
    end

    if string.find(str, "/") ~= nil then
        return true
    end

    if string.find(str, "\\") ~= nil then
        return true
    end

    if string.find(str, "#") ~= nil then
        return true
    end

    if string.find(str, "@") ~= nil then
        return true
    end

    if string.find(str, ";") ~= nil then
        return true
    end

    if string.find(str, " ") ~= nil then
        return true
    end

    if string.find(str, "`") ~= nil then
        return true
    end

    if string.find(str, "&") ~= nil then
        return true
    end
    if string.find(str, "=") ~= nil then
        return true
    end

    return false
end

--[[
替换字符串中的危险符号
参数 str 要替换的字符串
返回 str 替换后的字符串
]]
function lion.replaceSymbol(str)
    if str == nil then
        return ""
    end
    str = tostring(str)
    str = string.gsub(str, '"', "")
    str = string.gsub(str, "'", "")
    str = string.gsub(str, "/", "")
    str = string.gsub(str, "\\", "")
    str = string.gsub(str, "#", "")
    str = string.gsub(str, "@", "")
    str = string.gsub(str, ";", "")
    str = string.gsub(str, " ", "")
    str = string.gsub(str, "`", "")
    str = string.gsub(str, "&", "")
    str = string.gsub(str, "=", "")
    return str
end

--[[
检查字符串是否包含半角或全角符号
参数 str 要检查的字符串
返回 boolen
]]
function lion.checkUnlawfulString(str)
    if str == nil then
        return false
    end

    str = tostring(str)

    if string.find(str, "'") ~= nil then
        return false
    end

    if string.find(str, '"') ~= nil then
        return false
    end

    if string.find(str, "-") ~= nil then
        return false
    end

    if string.find(str, "#") ~= nil then
        return false
    end

    if string.find(str, "=") ~= nil then
        return false
    end

    if string.find(str, "!") ~= nil then
        return false
    end

    if string.find(str, "%(") ~= nil then
        return false
    end

    if string.find(str, "*") ~= nil then
        return false
    end

    if string.find(str, " ") ~= nil then
        return false
    end

    if string.find(str, "+") ~= nil then
        return false
    end

    if string.find(str, "%%") ~= nil then
        return false
    end

    if string.find(str, ";") ~= nil then
        return false
    end

    if string.find(str, "/") ~= nil then
        return false
    end

    if string.find(str, "@") ~= nil then
        return false
    end

    if string.find(str, "\\") ~= nil then
        return false
    end

    if string.find(str, "`") ~= nil then
        return false
    end

    if string.find(str, "%&") ~= nil then
        return false
    end

    if string.find(str, "%$") ~= nil then
        return false
    end
    -- 全角符号
    if string.find(str, "￥") ~= nil then
        return false
    end

    if string.find(str, "！") ~= nil then
        return false
    end

    if string.find(str, "％") ~= nil then
        return false
    end

    if string.find(str, "‘") ~= nil then
        return false
    end

    if string.find(str, "“") ~= nil then
        return false
    end

    if string.find(str, "〒_〒") ~= nil then
        return false
    end

    if string.find(str, "%?") ~= nil then
        return false
    end

    return true
end

--[[
检查表是否包含半角符号
参数 args 要检查的table
返回 boolen
]]
function lion.checkTableUnlawfulString(args)
    if args == nil or type(args) ~= "table" then
        return lion.checkUnlawfulString(args)
    end
    for k, v in pairs(args) do
        if type(v) == "table" then
            local res = lion.checkTableUnlawfulString(v)
            if res == false then
                return false
            end
        else
            local res = lion.checkUnlawfulString(v)
            if res == false then
                return false
            end
        end
    end
    return true
end

--[[
判断身份证是否合法
参数 str 身份证号码
返回 boolen
]]
function lion.checkIdCard(str)
    if lion.isStringEmpty(str) == true then
        print("checkIdCard nil")
        return false
    end

    local function checkBirthday(year, month, day)
        year = tonumber(year)
        month = tonumber(month)
        day = tonumber(day)
        local days = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
        if year == nil or month == nil or day == nil then
            print("checkBirthday args is nil", year, month, day)
            return false
        end

        if month < 1 or month > 12 then
            print("checkBirthday month err", month)
            return false
        end

        local isLeapYear = false --闰年
        if (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0) then
            isLeapYear = true
        end

        if isLeapYear == true then
            days[2] = 29
        else
            days[2] = 28
        end

        if days[month] == nil or day < 0 or day > days[month] then
            print("checkBirthday day err", day, days[month])
            return false
        end

        return true
    end

    local function varifyCode(str)
        local tmp = {}
        local len = string.len(str)
        for i = 1, len, 1 do
            table.insert(tmp, string.sub(str, i, i))
        end
        local iS = 0
        local iW = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 }
        local lastCode = { '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2' }
        for i = 1, 17, 1 do
            iS = iS + (string.byte(tmp[i]) - 48) * iW[i]
        end

        local iY = iS % 11
        local ch = lastCode[iY + 1]
        local lastChar = ch
        if lastChar ~= string.sub(str, 18, 18) then
            print("checkBirthday last char err", iY, ch, lastChar, string.sub(str, 18, 18))
            return false
        end

        return true
    end

    local function idCard15to18(str)
        if lion.getStringLen(str) ~= 15 then
            return ""
        end

        local tmp = {}
        local len = string.len(str)
        for i = 1, len, 1 do
            table.insert(tmp, string.sub(str, i, i))
        end

        local iS = 0
        local iW = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 }
        local lastCode = { '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2' }

        local newId = {}
        for i = 1, 6, 1 do
            newId[i] = tmp[i]
        end
        newId[7] = "1"
        newId[8] = "9"

        for i = 9, 17, 1 do
            newId[i] = tmp[i - 2]
        end

        for i = 1, 17, 1 do
            iS = iS + (string.byte(newId[i]) - 48) * iW[i]
        end

        local iY = iS % 11
        newId[18] = lastCode[iY + 1]
        local new = ""
        for i = 1, #newId, 1 do
            new = new .. newId[i]
        end
        if string.len(new) ~= 18 then
            print("idCard15to18 new id not 18 len", new, #newId)
            return ""
        end

        return new
    end

    local function check18IdCard(str)
        local address = { "11", "22", "35", "44", "53", "12", "23", "36", "45", "54", "13", "31", "37", "46", "61", "14",
            "32", "41", "50", "62", "15", "33", "42", "51", "63", "21", "34", "43", "52", "64", "65", "71", "81", "82",
            "91" }
        local addrValid = false
        local prefix = string.sub(str, 1, 2)
        for i = 1, #address do
            if prefix == address[i] then
                addrValid = true
                break
            end
        end
        if not addrValid then
            return false
        end

        local birth = string.sub(str, 7, 14)
        if checkBirthday(string.sub(birth, 1, 4), string.sub(birth, 5, 6), string.sub(birth, 7, 8)) == false then
            return false
        end
        if varifyCode(str) == false then
            return false
        end

        return true
    end

    local function check15IdCard(str)
        str = idCard15to18(str)
        if check18IdCard(str) == false then
            return false
        end

        return true
    end

    -- 18位
    if lion.getStringLen(str) == 18 then
        local res = check18IdCard(str)
        return res
    end

    -- 15位
    if lion.getStringLen(str) == 15 then
        local res = check15IdCard(str)
        return res
    end

    return false
end

--[[
获取随机 ascII 字符串，字符范围是 48~57 65~90 97~122
参数 len 字符串长度
返回 字符串
]]
function lion.getRandomAscII(len)
    if len == nil or len <= 0 then
        return ""
    end
    local str = ""
    while len > 0 do
        local char = ""
        local i = math.random(1, 3)
        if i == 1 then
            char = string.char(math.random(48, 57))
        end
        if i == 2 then
            char = string.char(math.random(65, 90))
        end
        if i == 3 then
            char = string.char(math.random(97, 122))
        end
        str = str .. char
        len = len - 1
    end

    return str
end

--[[
获取随机阿拉伯数字字符串，字符范围是0~9
参数 len 字符串长度
返回 字符串
]]
function lion.getRandomNumString(len)
    if len == nil or len <= 0 then
        print("getRandomNumString args is nil")
        return ""
    end
    local str = ""
    while len > 0 do
        local char = math.random(0, 9)
        str = str .. char
        len = len - 1
    end
    return str
end

--[[
遍历删除表中元素
参数 tab 表
参数 removeValues 需要删除的值的表
返回 无
]]
function lion.tableRemoveAll(tab, removeValues)
    if not tab or type(tab) ~= "table" then
        return
    end
    removeValues = removeValues or {}
    local i = 1
    while i <= #tab do
        if removeValues[tab[i]] then
            table.remove(tab, i)
        else
            i = i + 1
        end
    end
end

--[[
创建微信签名
参数 args 签名参数表
参数 key 密钥
返回 微信签名
]]
function lion.makeWxSign(args, key)
    if type(args) ~= "table" then
        print("makeWxSign args is nil", args)
        return ""
    end
    if not key then
        print("makeWxSign key is nil")
        return ""
    end
    --Key排序
    local key_table = {}
    --取出所有的键
    for k, _ in pairs(args) do
        table.insert(key_table, k)
    end
    --对所有键进行排序
    local sign = ""
    table.sort(key_table)
    for _, k in pairs(key_table) do
        sign = sign .. k .. "=" .. tostring(args[k]) .. "&"
    end

    if lion.isStringEmpty(sign) == true then
        print("makeWxSign sign is empty")
        return ""
    end
    sign = lion.cutStringLast(sign)

    sign = sign .. "&key=" .. key

    if not md5 or not md5.sumhexa then
        print("makeWxSign md5 not available")
        return ""
    end
    sign = md5.sumhexa(sign)
    sign = string.upper(sign)
    return sign
end

--[[
删除字符串的空格
参数 str 要删除空格的字符串
返回 删除空格后的字符串
]]
function lion.trimString(str)
    str = tostring(str)
    str = string.gsub(str, " ", "")
    return str
end

--[[
去除字符串首尾空白（空格、制表等）
参数 str 原字符串
返回值 去除首尾空白后的字符串，nil 时返回 ""
]]
function lion.trimSpace(str)
    if str == nil then
        return ""
    end
    str = tostring(str)
    return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

--[[
截取字符串
参数 inputstr 要截取字符串
参数 len从0开始截取多少个字符
返回 截取到的字符串
]]
function lion.subString(inputstr, len)
    if inputstr == nil or len == nil or len <= 0 then
        print("subString args is nil")
        return ""
    end
    local out = ""
    inputstr = tostring(inputstr)
    local lenInByte = #inputstr
    local width = 0
    local i = 1
    while (i <= lenInByte) do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if curByte > 0 and curByte <= 127 then
            byteCount = 1
        elseif curByte >= 192 and curByte < 223 then
            byteCount = 2
        elseif curByte >= 224 and curByte < 239 then
            byteCount = 3
        elseif curByte >= 240 and curByte <= 247 then
            byteCount = 4
        end

        local char = string.sub(inputstr, i, i + byteCount - 1)
        i = i + byteCount
        out = out .. char
        len = len - 1
        if len <= 0 then
            return out
        end
    end
    return out
end

--[[
计算字符串长度
参数 inputstr 要计算长度的字符串
返回 num 字符串的长度
]]
function lion.getStringLen(inputstr)
    if inputstr == nil then
        return 0
    end
    inputstr = tostring(inputstr)
    local lenInByte = #inputstr
    local width = 0
    local i = 1
    while (i <= lenInByte) do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if curByte > 0 and curByte <= 127 then
            byteCount = 1
        elseif curByte >= 192 and curByte < 223 then
            byteCount = 2
        elseif curByte >= 224 and curByte < 239 then
            byteCount = 3
        elseif curByte >= 240 and curByte <= 247 then
            byteCount = 4
        end

        local char = string.sub(inputstr, i, i + byteCount - 1)
        i = i + byteCount
        if byteCount == 1 then
            width = width + 1
        else
            width = width + 2 --中文算2个字符
        end
    end
    return width
end

--[[
检查字符串是否包含emoji
参数 inputstr 要检查的字符串
返回 boolen
]]
function lion.hasEmoji(inputstr)
    if inputstr == nil then
        return false
    end
    inputstr = tostring(inputstr)
    local lenInByte = #inputstr
    local width = 0
    local i = 1
    while (i <= lenInByte) do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if curByte > 0 and curByte <= 127 then
            byteCount = 1
        elseif curByte >= 192 and curByte < 223 then
            byteCount = 2
        elseif curByte >= 224 and curByte < 239 then
            byteCount = 3
        elseif curByte >= 240 and curByte <= 247 then
            byteCount = 4
        end

        local char = string.sub(inputstr, i, i + byteCount - 1)
        i = i + byteCount
        if byteCount == 1 then
            width = width + 1
        else
            width = width + 2 --中文算2个字符
        end

        if byteCount > 3 then
            return true
        end
    end
    return false
end

--[[
检查字符串是否包含emoji
参数 inputstr 要检查的字符串
返回 boolen
]]
function lion.hasEmojiPro(inputstr)
    if inputstr == nil then
        return false
    end
    inputstr = tostring(inputstr)
    local lenInByte = #inputstr
    local width = 0
    local i = 1
    local emojiFlag = false
    while (i <= lenInByte) do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if curByte > 0 and curByte <= 127 then
            byteCount = 1
        elseif curByte >= 192 and curByte < 223 then
            if curByte == 194 then
                emojiFlag = true
            end
            byteCount = 2
        elseif curByte >= 224 and curByte < 239 then
            if curByte == 226 or curByte == 227 then
                emojiFlag = true
            end
            byteCount = 3
        elseif curByte >= 240 and curByte <= 247 then
            byteCount = 4
        end

        local char = string.sub(inputstr, i, i + byteCount - 1)
        i = i + byteCount
        if byteCount == 1 then
            width = width + 1
        else
            width = width + 2 --中文算2个字符
        end
        if byteCount == 2 and emojiFlag then
            local secByte = string.byte(inputstr, 2)
            if secByte >= 161 then
                return true
            end
        end
        if byteCount == 3 and emojiFlag then
            local secByte = string.byte(inputstr, 2)
            if curByte == 227 then
                if secByte <= 143 then
                    return true
                end
            end
            if curByte == 226 and secByte >= 128 and secByte <= 186 then
                return true
            end
            if curByte == 226 and secByte == 186 then
                local thirdByte = string.byte(inputstr, 3)
                if thirdByte <= 131 then
                    return true
                end
            end
        end
        if byteCount > 3 then
            return true
        end
    end
    return false
end

--[[
检查字符串中 emoji 的位置
参数 inputstr 要检查的字符串
返回 emoji 的位置数字
]]
function lion.emojiPos(inputstr)
    if inputstr == nil then
        return -1
    end
    inputstr = tostring(inputstr)
    local lenInByte = #inputstr
    local width = 0
    local i = 1
    while (i <= lenInByte) do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1
        if curByte > 0 and curByte <= 127 then
            byteCount = 1
        elseif curByte >= 192 and curByte < 223 then
            byteCount = 2
        elseif curByte >= 224 and curByte < 239 then
            byteCount = 3
        elseif curByte >= 240 and curByte <= 247 then
            byteCount = 4
        end

        local char = string.sub(inputstr, i, i + byteCount - 1)
        i = i + byteCount
        if byteCount == 1 then
            width = width + 1
        else
            width = width + 2 --中文算2个字符
        end
        if byteCount > 3 then
            return i - byteCount
        end
    end
    return -1
end

--[[
字符串按 UTF-8 字符拆成表（每个元素为一个 UTF-8 字符）
参数 str 要转换的字符串
返回值 table 字符组成的数组
]]
function lion.stringToTable(str)
    str = tostring(str)
    local tb = {}
    --[[
    UTF8的编码规则：
    1. 字符的第一个字节范围： 0x00—0x7F(0-127),或者 0xC2—0xF4(194-244); UTF8 是兼容 ascii 的，所以 0~127 就和 ascii 完全一致
    2. 0xC0, 0xC1,0xF5—0xFF(192, 193 和 245-255)不会出现在UTF8编码中
    3. 0x80—0xBF(128-191)只会出现在第二个及随后的编码中(针对多字节编码，如汉字)
    ]]
    for utfChar in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(tb, utfChar)
    end
    return tb
end

--[[
去除字符串中的emoji
参数 str 要去除emoji的字符串
返回 去除emoji后的字符串
]]
function lion.deleteEmojiFromString(str)
    str = tostring(str)
    local newStr = ""
    local tab = lion.stringToTable(str)
    for k, v in pairs(tab) do
        if lion.hasEmoji(v) == false then
            newStr = newStr .. tostring(v)
        end
    end

    return newStr
end

--[[
Unicode 转义串（\uXXXX）转 UTF-8 字节串
参数 str 含 \uXXXX 的字符串
返回值 string UTF-8 字符串
]]
function lion.unicodeToUtf8(str)
    local ok, bit = pcall(require, "bit32")
    if not ok or not bit then
        return ""
    end
    if type(str) ~= "string" then
        return str
    end
    local resultStr = ""
    local idx = 1
    while true do
        local num1 = string.byte(str, idx)
        local unicode

        if num1 ~= nil and string.sub(str, idx, idx + 1) == "\\u" then
            unicode = tonumber("0x" .. string.sub(str, idx + 2, idx + 5))
            idx = idx + 6
        elseif num1 ~= nil then
            unicode = num1
            idx = idx + 1
        else
            break
        end

        if unicode <= 0x007f then
            resultStr = resultStr .. string.char(bit.band(unicode, 0x7f))
        elseif unicode >= 0x0080 and unicode <= 0x07ff then
            resultStr = resultStr .. string.char(bit.bor(0xc0, bit.band(bit.rshift(unicode, 6), 0x1f)))
            resultStr = resultStr .. string.char(bit.bor(0x80, bit.band(unicode, 0x3f)))
        elseif unicode >= 0x0800 and unicode <= 0xffff then
            resultStr = resultStr .. string.char(bit.bor(0xe0, bit.band(bit.rshift(unicode, 12), 0x0f)))
            resultStr = resultStr .. string.char(bit.bor(0x80, bit.band(bit.rshift(unicode, 6), 0x3f)))
            resultStr = resultStr .. string.char(bit.bor(0x80, bit.band(unicode, 0x3f)))
        end
    end
    resultStr = resultStr .. '\0'
    return resultStr
end

--[[
UTF-8 字节串转 Unicode 转义串（\uXXXX）
参数 str UTF-8 字符串
返回值 string 含 \uXXXX 的字符串
]]
function lion.utf8ToUnicode(str)
    local ok, bit = pcall(require, "bit32")
    if not ok or not bit then
        return ""
    end
    if type(str) ~= "string" then
        return str
    end
    local resultStr = ""
    local idx = 1
    local num1 = string.byte(str, idx)

    while num1 ~= nil do
        local tempVar1, tempVar2
        if num1 >= 0x00 and num1 <= 0x7f then
            tempVar1 = num1
            tempVar2 = 0
        elseif bit.band(num1, 0xe0) == 0xc0 then
            local t1 = 0
            local t2 = 0
            t1 = bit.band(num1, bit.rshift(0xff, 3))
            idx = idx + 1
            num1 = string.byte(str, idx)
            t2 = bit.band(num1, bit.rshift(0xff, 2))
            tempVar1 = bit.bor(t2, bit.lshift(bit.band(t1, bit.rshift(0xff, 6)), 6))
            tempVar2 = bit.rshift(t1, 2)
        elseif bit.band(num1, 0xf0) == 0xe0 then
            local t1 = 0
            local t2 = 0
            local t3 = 0
            t1 = bit.band(num1, bit.rshift(0xff, 3))
            idx = idx + 1
            num1 = string.byte(str, idx)
            t2 = bit.band(num1, bit.rshift(0xff, 2))
            idx = idx + 1
            num1 = string.byte(str, idx)
            t3 = bit.band(num1, bit.rshift(0xff, 2))
            tempVar1 = bit.bor(bit.lshift(bit.band(t2, bit.rshift(0xff, 6)), 6), t3)
            tempVar2 = bit.bor(bit.lshift(t1, 4), bit.rshift(t2, 2))
        end
        resultStr = resultStr .. string.format("\\u%02x%02x", tempVar2, tempVar1)
        idx = idx + 1
        num1 = string.byte(str, idx)
    end
    return resultStr
end

--[[
表按分隔符拼成字符串（与 tableToJson / tableToUrl 等命名一致）
参数 tab 需要转换的表
参数 separator 分隔符
返回值 string
]]
function lion.tableToString(tab, separator)
    if tab == nil or type(tab) ~= "table" or separator == nil then
        return ""
    end
    local str = ""
    for k, v in pairs(tab) do
        str = str .. v .. separator
    end
    --去掉最后的逗号
    if str ~= "" then
        str = string.sub(str, 1, -2)
    end
    return str
end

--[[
字符串按分隔符拆成数组（等同于 stringSplit）
参数 str 需要转换的字符串
参数 separator 分隔符
返回值 table 字符串数组
]]
function lion.stringToArray(str, separator)
    return lion.stringSplit(str, separator)
end

--[[
删除字符串的最后一个字符
参数 str 原字符串
返回值 去掉最后一个字符后的字符串，若 str 为 nil 返回 ""
]]
function lion.cutStringLast(str)
    if str == nil or str == "" then
        return ""
    end
    str = tostring(str)
    if #str <= 1 then
        return ""
    end
    return string.sub(str, 1, -2)
end

--[[
比较 table
tab1 表
tab2 表
相同返回true
]]
function lion.compareTable(tab1, tab2)
    if tab1 == nil or tab2 == nil then
        return false
    end

    for k, v in pairs(tab1) do
        if v ~= tab2[k] then
            return false
        end
    end

    return true
end

--[[
打印表
tab 要打印的表
]]
function lion.showTable(tab, space)
    if tab == nil or type(tab) ~= "table" then
        print(nil, "show Table : nil table", tab, type(tab))
        return
    end
    if space == nil then
        space = ""
    end
    space = space .. " "
    local count = 0
    for k, v in pairs(tab) do
        if type(v) == "table" then
            print(nil, space, k, "[table]")
            lion.showTable(v, space)
        else
            print(nil, space, k, tostring(v))
        end
        count = count + 1
    end
    if count == 0 then
        print(nil, "show Table : empty table", tab)
    end
end

--[[
解析套接字
]]
function lion.getIpAddressInfo(ipAddress)
    if type(ipAddress) ~= "string" or lion.isStringEmpty(ipAddress) == true then
        print("getIpAddressInfo args err", ipAddress)
        return { ip = "", port = 0 }
    end

    local info = lion.stringSplit(ipAddress, ":")
    if #info ~= 2 then
        print("getIpAddressInfo addr err", ipAddress)
        return { ip = "", port = 0 }
    end

    return { ip = tostring(info[1]), port = tonumber(info[2]) }
end

--[[
冒泡排序
key排序的字段
]]
function lion.bubbleSort(tab, key)
    if tab == nil or type(tab) ~= "table" or key == nil then
        print("bubbleSort : tab or key is nil", tab, key)
        return
    end
    local isF = true
    for m = #tab - 1, 1, -1 do
        isF = true
        for i = #tab - 1, 1, -1 do
            if tab[i][key] < tab[i + 1][key] then
                tab[i], tab[i + 1] = tab[i + 1], tab[i]
                isF = false
            end
        end
        if isF then
            break
        end
    end
end

--[[
反冒泡排序
key排序的字段
]]
function lion.antiBubbleSort(tab, key)
    if tab == nil or type(tab) ~= "table" or key == nil then
        print("bubbleSort : tab or key is nil", tab, key)
        return
    end
    local isF = true
    for m = #tab - 1, 1, -1 do
        isF = true
        for i = #tab - 1, 1, -1 do
            if tab[i][key] > tab[i + 1][key] then
                tab[i], tab[i + 1] = tab[i + 1], tab[i]
                isF = false
            end
        end
        if isF then
            break
        end
    end
end

--[[
深拷贝
]]
function lion.deepCopy(st)
    if st == nil then
        return nil
    end
    local tab = {}
    for k, v in pairs(st or {}) do
        if type(v) ~= "table" then
            tab[k] = v
        else
            tab[k] = lion.deepCopy(v)
        end
    end
    return tab
end

--[[
比较时间字符串
time1 string YYYY-mm-dd HH:MM:SS
time2 string YYYY-mm-dd HH:MM:SS
返回值 int time1比time2多多少秒
]]
function lion.compareTime(time1, time2)
    if time1 == nil or time2 == nil then
        print("compareTime args is nil", time1, time2)
        return 0
    end

    time1 = lion.dateToSec(time1)
    time2 = lion.dateToSec(time2)

    local val = time1 - time2
    return val
end

--[[
比较时间字符串是否在startTime与endTime之间
time string YYYY-mm-dd HH:MM:SS
startTime string YYYY-mm-dd HH:MM:SS
endTime string YYYY-mm-dd HH:MM:SS
返回值 bool
]]
function lion.ifTimeInZone(time, startTime, endTime)
    if time == nil or startTime == nil or endTime == nil then
        print("ifTimeInZone args is nil", time, startTime, endTime)
        return false
    end
    time = lion.dateToSec(time)
    startTime = lion.dateToSec(startTime)
    endTime = lion.dateToSec(endTime)

    if startTime > endTime then
        print("ifTimeInZone : startTime is bigger than endTime", time, startTime, endTime)
        return false
    end

    if time >= startTime and time <= endTime then
        return true
    end
    return false
end

--[[
秒数转为日期时间字符串（时间戳 → "YYYY-MM-DD HH:MM:SS"）
参数 second number|string 秒数时间戳，nil 时用当前时间
返回值 string 日期时间字符串
]]
function lion.secToDate(second)
    second = tonumber(second) or os.time()
    return os.date("%Y-%m-%d %H:%M:%S", second)
end

--[[
指定日期转为秒数
date string YYYY-mm-dd HH:MM::SS
返回值int 秒数
]]
function lion.dateToSec(date)
    if date == nil then
        date = lion.secToDate()
    end

    local function split(str, pat)
        local t = {}
        -- NOTE: use {n = 0} in Lua-5.0
        local fpat = "(.-)" .. pat
        local last_end = 1
        local s, e, cap = str:find(fpat, 1)
        while s do
            if s ~= 1 or cap ~= "" then
                table.insert(t, cap)
            end
            last_end = e + 1
            s, e, cap = str:find(fpat, last_end)
        end
        if last_end <= #str then
            cap = str:sub(last_end)
            table.insert(t, cap)
        end
        return t
    end

    local a = split(date, " ")
    local b = split(a[1], "-")
    local c = split(a[2], ":")
    local t = os.time({ year = b[1], month = b[2], day = b[3], hour = c[1], min = c[2], sec = c[3] })
    return t
end

--[[
stringTime string YYYY-mm-dd HH:MM:SS
]]
function lion.stringTimeToDateTime(stringTime)
    local Y = 0
    local m = 0
    local d = 0
    local H = 0
    local M = 0
    local S = 0
    stringTime = lion.stringSplit(stringTime, " ")
    if #stringTime == 2 then
        local date = lion.stringSplit(stringTime[1], "-")
        local time = lion.stringSplit(stringTime[2], ":")
        Y = date[1]
        m = date[2]
        d = date[3]
        H = time[1]
        M = time[2]
        S = time[3]
    end
    if #stringTime == 1 then
        stringTime = lion.stringSplit(stringTime[1], "-")
        if #stringTime == 1 then
            local time = lion.stringSplit(stringTime[1], ":")
            H = time[1]
            M = time[2]
            S = time[3]
        else
            Y = stringTime[1]
            m = stringTime[2]
            d = stringTime[3]
        end
    end

    return { year = Y, month = m, day = d, hour = H, minute = M, second = S }
end

--[[
second int 秒
]]
function lion.secToDateTime(second)
    second = lion.secToDate(second)
    return lion.stringTimeToDateTime(second)
end

--[[
dateTime {year,month,day,hour,minute,second}
]]
function lion.dateTimeToStringTime(dateTime)
    local year = dateTime.year or "0000"
    local month = dateTime.month or "00"
    local day = dateTime.day or "00"
    local hour = dateTime.hour or "00"
    local minute = dateTime.minute or "00"
    local second = dateTime.second or "00"

    local str = year .. "-" .. month .. "-" .. day .. " " .. hour .. ":" .. minute .. ":" .. second
    return str
end

--[[
数字转 bool
参数 num 数字
返回值 bool值
]]
function lion.numToBool(num)
    num = math.floor(tonumber(num))
    if num == 0 then
        return false
    end
    return true
end

--[[
字符串转bool
参数 str 字符串
返回值 bool值
]]
function lion.stringToBool(str)
    if str == "true" then
        return true
    end
    return false
end

--[[
redis 表转 lua 表
参数 res redis 返回的表
返回值 转换后的 lua 表
]]
function lion.redisTableToLuaTable(res)
    if #res > 0 then
        local rtab = {}
        if #res % 2 ~= 0 then
            return nil
        end
        for i = 1, #res, 2 do
            if i + 1 <= #res then
                rtab[res[i]] = res[i + 1]
            end
        end
        return rtab
    end
    return nil
end

--[[
redis 二维表转 lua 二维表
参数 res redis 返回的二维表
返回值 转换后的 lua 二维表
]]
function lion.redisTableToLuaTable2(res)
    if #res > 0 then
        local list = {}
        if #res % 2 ~= 0 then
            return nil
        end
        for i = 1, #res, 1 do
            local cell = {}
            for j = 1, #res[i], 2 do
                if j + 1 <= #res then
                    cell[res[i][j]] = res[i][j + 1]
                end
            end
            if #res[i] > 0 then
                table.insert(list, cell)
            end
        end
        return list
    end
    return nil
end

--[[
安全数字转换
参数 str 要转换的字符串
返回值 转换后的数字或原始字符串
]]
function lion.safeToNum(str)
    if tonumber(str) == nil then
        return str
    end
    return tonumber(str)
end

--[[
表转数字
参数 tab 要转换的表
返回值 转换后的表
]]
function lion.safeTableToNum(tab)
    if tab == nil or type(tab) ~= "table" then
        print("safeTableToNum : nil table", tab)
        return
    end
    local count = 0
    for k, v in pairs(tab) do
        if type(v) == "table" then
            lion.safeTableToNum(v)
        else
            tab[k] = lion.safeToNum(v)
        end
        count = count + 1
    end
    if count == 0 then
    end

    return tab
end

--[[
从一个table中删除指定的值
]]
function lion.removeFromTable(src, vals)
    local delkey = {}
    local res = {}
    for k, v in pairs(src) do
        for a, b in pairs(vals) do
            if b == v then
                table.insert(delkey, k)
            end
        end
    end

    for k, v in pairs(delkey) do
        src[v] = nil
    end

    for k, v in pairs(src) do
        table.insert(res, v)
    end

    return res
end

--[[
table元素去重
]]
function lion.tableDuplicate(tab)
    local tmp = {}
    for k, v in pairs(tab) do
        tmp[v] = v
    end
    local res = {}
    for k, v in pairs(tmp) do
        table.insert(res, v)
    end
    return res
end

--[[
读取文件内容
]]
function lion.readFile(path)
    local file = io.open(path, "r")
    local data = ""
    if file ~= nil then
        data = file:read("*a")
        file:close()

        if data ~= nil then
            --print("readFile : load OK")
        else
            print("readFile : load fail")
        end
    else
        print("readFile : can not get data:", path)
    end

    return data
end

--[[
获取路径
]]
function lion.getFilePath(filename)
    filename = filename or ""
    return string.match(filename, "(.+)/[^/]*%.%w+$") --*nix system
    --return string.match(filename, “(.+)\\[^\\]*%.%w+$”) — windows
end

--[[
获取文件名
]]
function lion.getFileName(filename)
    filename = filename or ""
    return string.match(filename, ".+/([^/]*%.%w+)$") -- *nix system
    --return string.match(filename, “.+\\([^\\]*%.%w+)$”) — *nix system
end

--[[
去除扩展名
]]
function lion.getFileNameWithoutExtension(filename)
    filename = filename or ""
    local idx = filename:match(".+()%.%w+$")
    if (idx) then
        return filename:sub(1, idx - 1)
    else
        return filename
    end
end

--[[
获取扩展名
]]
function lion.getFileExtension(filename)
    filename = filename or ""
    return filename:match(".+%.(%w+)$")
end

--[[
mysql结果安全判断
tab：table 表
返回值： bool是否安全
]]
function lion.dbSafeCheck(sqlres)
    if sqlres == nil then
        print("dbSafeCheck : sqlres is nil")
        return false
    end
    if sqlres.badresult == true then
        print("dbSafeCheck : sql fail.", "err:", sqlres.err)
        return false
    end
    return true
end

--[[
字符串与16进制互转
]]
function lion.binToHex(s)
    s = string.gsub(s, "(.)", function(x)
        return string.format("%02x", string.byte(x))
    end)
    return s
end

--[[
十六进制字符串转二进制（每两字符一格，支持空格分隔）
参数 hexStr 十六进制字符串，如 "48656C6C 6F"
返回值 二进制字符串，非法输入未做保护时可能抛错
]]
function lion.hexToBin(hexStr)
    local h2b = {
        ["0"] = 0,
        ["1"] = 1,
        ["2"] = 2,
        ["3"] = 3,
        ["4"] = 4,
        ["5"] = 5,
        ["6"] = 6,
        ["7"] = 7,
        ["8"] = 8,
        ["9"] = 9,
        ["A"] = 10,
        ["B"] = 11,
        ["C"] = 12,
        ["D"] = 13,
        ["E"] = 14,
        ["F"] = 15
    }

    local s = string.gsub(hexStr or "", "(.)(.)%s", function(h, l)
        return string.char(h2b[h] * 16 + h2b[l])
    end)
    return s
end

--[[
将字符串按格式转为16进制串
]]
function lion.strToHex(hex)
    --判断输入类型
    if (type(hex) ~= "string") then
        return nil, "str2hex invalid input type"
    end
    --拼接字符串
    local index = 1
    local ret = ""
    for index = 1, hex:len() do
        ret = ret .. string.format("%02X", hex:sub(index):byte())
    end

    return ret
end

--[[
将16进制串转换为字符串
]]
function lion.hexToStr(str)
    --判断输入类型
    if (type(str) ~= "string") then
        print("hex2str invalid input type")
        return nil
    end
    --滤掉分隔符
    str = str:gsub("[%s%p]", ""):upper()
    --检查内容是否合法
    if (str:find("[^0-9A-Fa-f]") ~= nil) then
        print("hex2str invalid input content")
        return nil
    end
    --检查字符串长度
    if (str:len() % 2 ~= 0) then
        print("hex2str invalid input lenth")
        return nil
    end
    --拼接字符串
    local index = 1
    local ret = ""
    for index = 1, str:len(), 2 do
        ret = ret .. string.char(tonumber(str:sub(index, index + 1), 16))
    end

    return ret
end

--[[
table转xml
参数 tab 表
返回值 xml字符串
]]
function lion.tableToXml(tab)
    local function table_to_xml_table(old_table, new_table)
        for key, value in pairs(old_table) do
            if "table" == type(value) then
                table.insert(new_table, "<")
                table.insert(new_table, key)
                table.insert(new_table, ">")
                table_to_xml_table(value, new_table)
                table.insert(new_table, "</")
                table.insert(new_table, key)
                table.insert(new_table, ">")
            else
                table.insert(new_table, "<")
                table.insert(new_table, key)
                table.insert(new_table, ">")
                table.insert(new_table, value)
                table.insert(new_table, "</")
                table.insert(new_table, key)
                table.insert(new_table, ">")
            end
        end
    end

    local newtab = {}
    table_to_xml_table(tab, newtab)
    table.insert(newtab, 1, '<?xml version="' .. "1.0" .. '" encoding="' .. "utf-8" .. '" ?><xml>')
    table.insert(newtab, '</xml>')
    return table.concat(newtab)
end

--[[
--表转json字符串
--tab：table 表
--返回值： stringjson字符串
]]
function lion.tableToJson(tab)
    if tab == nil or type(tab) ~= "table" then
        print("tableToJson : tab is nil", tab, type(tab))
        return ""
    end

    local ok, json = pcall(require, "cjson")
    if not ok or not json then
        return ""
    end
    local ok, val = pcall(json.encode, tab)
    if ok == false then
        return ""
    end
    return val
end

--[[
使用cjson编码表
参数 tab 表
返回值 json字符串
]]
function lion.cjsonEncode(tab)
    if tab == nil or type(tab) ~= "table" then
        print("cjsonEncode : tab is nil", tab, type(tab))
        return ""
    end

    local ok, json = pcall(require, "cjson")
    if not ok or not json then
        return ""
    end
    local ok, val = pcall(json.encode, tab)
    if ok == false then
        return ""
    end
    return val
end

--[[
json字符串转表
text：string json字符串
返回值： table表
]]
function lion.jsonToTable(text)
    if text == nil then
        print("jsonToTable : text is nil", text, type(text))
        return {}
    end

    local ok, json = pcall(require, "cjson")
    if not ok or not json then
        return {}
    end
    local ok, val = pcall(json.decode, text)
    if ok == false then
        print("json2Table decode fail", val)
        return {}
    end
    return val
end

--[[
使用cjson解码json字符串
参数 text json字符串
返回值 表
]]
function lion.cjsonDecode(text)
    if text == nil then
        print("cjsonDecode : text is nil", text, type(text))
        return {}
    end

    local ok, json = pcall(require, "cjson")
    if not ok or not json then
        return {}
    end
    local ok, val = pcall(json.decode, text)
    if ok == false then
        print("json2Table decode fail", val)
        return {}
    end
    return val
end

--[[
xml字符串转表
text：string xml字符串
返回值： table表
]]
function lion.xmlToTable(text)
    if text == nil then
        print("xmlToTable : text is nil", text, type(text))
        return {}
    end

    local ok, xml = pcall(require, "xml")
    if not ok or not xml then
        return {}
    end
    local ok, val = pcall(xml.txml, text)
    if ok == false then
        print("xml2Table err", val)
        return {}
    end
    return val
end

--[[
根据成功率随机获得是否成功
successRateint (0~100) 成功率
返回值 bool是否成功
]]
function lion.isSuccess(successRate)
    if type(successRate) ~= "number" then
        return false
    end

    -- 确保成功率在 0-100 范围内
    successRate = math.max(0, math.min(100, successRate))
    successRate = math.floor(successRate)

    local res = math.random(1, 100)
    return res <= successRate
end

--[[
判断两个时间是否在同一天
参数 time1"YYYY-MM-DD hh:mm:ss"
参数 time2"YYYY-MM-DD hh:mm:ss"
return bool
]]
function lion.isSameDay(time1, time2)
    time1 = lion.dateToSec(os.date("%Y-%m-%d 00:00:00", lion.dateToSec(time1)))
    time2 = lion.dateToSec(os.date("%Y-%m-%d 00:00:00", lion.dateToSec(time2)))
    if time1 == time2 then
        return true
    end
    return false
end

--[[
urlEncode 编码
]]
function lion.urlEncode(s)
    s = string.gsub(s, "([^%w%.%- ])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
    return string.gsub(s, " ", "+")
end

--[[
urlEncode 解码
]]
function lion.urlDecode(s)
    --注意，该urldecode无法把+号转换成空格，如果原字符串有空格需要string.gsub(str, "+", " ")
    s = string.gsub(s, '%%(%x%x)', function(h)
        return string.char(tonumber(h, 16))
    end)
    return s
end

--[[
table 转 url 字符串
参数 tab 表
参数 split 分隔符
参数 symbol 连接符
返回值： url字符串
]]
function lion.tableToUrl(tab, split, symbol)
    if tab == nil or type(tab) ~= "table" then
        print("tableToUrl args is nil", tab)
        return ""
    end

    if lion.countTable(tab) == 0 then
        return ""
    end

    split = split or "&"
    symbol = symbol or "="

    local str = ""
    for k, v in pairs(tab) do
        str = str .. tostring(k) .. symbol .. tostring(v) .. split
    end
    --去掉最后的 &
    str = lion.cutStringLast(str)

    return str
end

--[[
url字符串转表
参数 url url字符串
返回值： table表
]]
function lion.urlToTable(url)
    if url == "" or url == nil then
        return {}
    end
    local parts = lion.stringSplit(url, ',')
    local queryStr = parts[1] or ""
    parts = lion.stringSplit(queryStr, '?')
    local paramStr = parts[2] or parts[1] or ""
    local pairsList = lion.stringSplit(paramStr, '&')
    local res = {}
    for _, pairStr in ipairs(pairsList) do
        local kv = lion.stringSplit(pairStr, '=')
        if kv[1] then
            res[kv[1]] = kv[2]
        end
    end
    return res
end

--[[
查找字符串
参数 str 原字符串
参数 findStr 要查找的字符串
返回值 bool 是否找到
]]
function lion.findString(str, findStr)
    if lion.isStringEmpty(str) == true or lion.isStringEmpty(findStr) == true then
        return false
    end

    if string.find(str, findStr) then
        return true
    end

    return false
end

--[[
url字符串转表
urlstring url字符串
返回值： table表
]]
function lion.urlParamToTable(url, split, symbol)
    if url == "" or url == nil then
        return {}
    end

    split = split or "&"
    symbol = symbol or "="
    local pairList = lion.stringSplit(url, split)
    local res = {}
    for _, pairStr in ipairs(pairList) do
        local kv = lion.stringSplit(pairStr, symbol)
        if kv[1] then
            res[kv[1]] = kv[2]
        end
    end
    return res
end

--[[
url字符串转表（键值转为数字）
参数 url url字符串
参数 split 分隔符，默认 "&"
参数 symbol 键值分隔符，默认 "="
返回值： table表
]]
function lion.urlParamToTableToNum(url)
    local tab = lion.urlParamToTable(url)
    local res = {}
    for k, v in pairs(tab) do
        local new_k = math.floor(tonumber(k))
        local new_v = math.floor(tonumber(v))
        res[new_k] = new_v
    end

    return res
end

--[[
url字符串转itemStruct
urlstring url字符串
返回值： table表
]]
function lion.urlParamToItemStruct(url)
    if url == "" or url == nil then
        return {}
    end

    url = lion.urlParamToTable(url)
    local res = {}
    for k, v in pairs(url) do
        table.insert(res, { itemId = tonumber(k), num = tonumber(v) })
    end

    return res
end

--[[
字符串是否为空
参数 str 字符串
返回值 bool 是否为空
]]
function lion.isStringEmpty(str)
    if str == "" or str == nil then
        return true
    end

    return false
end

--[[
计算表中元素个数
参数 tab 表
返回值 元素个数
]]
function lion.countTable(tab)
    if tab == nil or type(tab) ~= "table" then
        return 0
    end
    local count = 0
    for k, v in pairs(tab) do
        count = count + 1
    end
    return count
end

--[[
table是否为空
参数 tab 表
返回值 bool 是否为空
]]
function lion.isTableEmpty(tab)
    if tab == nil or type(tab) ~= "table" then
        return true
    end

    for k, v in pairs(tab) do
        return false
    end

    return true
end

--[[
table中是否包含某个值
参数 list 表
参数 value 要查找的值
返回值 bool 是否包含
]]
function lion.isExistsInTable(list, value)
    if type(list) ~= "table" then
        print("isExistsInTable not table", type(list))
        return false
    end

    for k, v in pairs(list) do
        if v == value then
            return true
        end
    end

    return false
end

--[[
转整形
参数 val 值
返回值 整数
]]
function lion.toInt(val)
    if val == nil or tonumber(val) == nil then
        return 0
    end

    return math.floor(tonumber(val))
end

--[[
判断是否是数字
参数 num 值
返回值 bool 是否是数字
]]
function lion.isNumber(num)
    if tonumber(num) == nil then
        return false
    end

    return true
end

--[[
生成sql插入语句
]]
function lion.createInsertSQL(tableName, argsTable)
    local sql = string.format("insert into %s(", tableName)
    for k, v in pairs(argsTable) do
        sql = string.format(sql .. "%s,", k)
    end

    sql = string.sub(sql, 1, #sql - 1)
    sql = sql .. ') values('

    for k, v in pairs(argsTable) do
        sql = string.format(sql .. "'%s',", v)
    end

    sql = string.sub(sql, 1, #sql - 1)
    sql = sql .. ");"
    return sql
end

--[[
生成sql更新语句
whereTable table and条件
]]
function lion.createUpdateSQL(tableName, argsTable, whereTable)
    local sql = string.format("update %s set ", tableName)
    for k, v in pairs(argsTable) do
        sql = string.format(sql .. "%s='%s',", k, v)
    end

    sql = string.sub(sql, 1, #sql - 1)
    sql = sql .. " where "
    for k, v in pairs(whereTable) do
        sql = string.format(sql .. " %s='%s' ", k, v)
        sql = sql .. "and"
    end

    sql = string.sub(sql, 1, #sql - 3) --去掉最后的and
    return sql
end

--[[
set string age=10,sex=1
where string where userID=1 limit 1
]]
function lion.createFullUpdateSQL(tableName, set, where)
    if lion.isStringEmpty(tableName) == true or lion.isStringEmpty(where) == true or
        lion.isStringEmpty(set) == true then
        return nil
    end
    local sql = string.format("update %s ", tableName)
    sql = sql .. " " .. set
    sql = sql .. " " .. where
    return sql
end

--[[
生成sql删除语句
]]
function lion.createDeleteSQL(tableName, whereTable)
    local sql = string.format("delete from %s ", tableName)
    sql = sql .. " where "
    for k, v in pairs(whereTable) do
        sql = string.format(sql .. " %s='%s' ", k, v)
        sql = sql .. "and"
    end

    sql = string.sub(sql, 1, #sql - 3) --去掉最后的and
    return sql
end

--[[
生成sql查询语句
fields string * 或 "aaa,bbb,ccc"
whereTable 条件，没有传nil,否则传key=value的表 {name="aa",age=10} and条件
]]
function lion.createSelectSQL(tableName, fields, whereTable)
    local sql = string.format("select %s from %s ", fields, tableName)
    if whereTable == nil or lion.countTable(whereTable) == 0 then
        return sql
    end
    sql = sql .. " where "
    for k, v in pairs(whereTable) do
        sql = string.format(sql .. " %s='%s' ", k, v)
        sql = sql .. "and"
    end

    sql = string.sub(sql, 1, #sql - 3) --去掉最后的and
    return sql
end

--[[
生成完整sql查询语句
参数 tableName 表名
参数 fields 字段列表，如 "*" 或 "aaa,bbb,ccc"
参数 where 条件字符串，如 "where userID=123 and userName='aaa' limit 1"
]]
function lion.createFullSelectSQL(tableName, fields, where)
    local sql = string.format("select %s from %s ", fields, tableName)
    if lion.isStringEmpty(where) == true then
        return sql
    end
    sql = sql .. " " .. where
    return sql
end

--[[
生成sql替换语句
]]
function lion.createReplaceSQL(tableName, argsTable)
    local sql = string.format("replace into %s(", tableName)
    for k, v in pairs(argsTable) do
        sql = string.format(sql .. "%s,", k)
    end

    sql = string.sub(sql, 1, #sql - 1)
    sql = sql .. ') values('

    for k, v in pairs(argsTable) do
        sql = string.format(sql .. "'%s',", v)
    end

    sql = string.sub(sql, 1, #sql - 1)
    sql = sql .. ");"
    return sql
end

--[[
判断与今天是否相隔超过1天
]]
function lion.overOneDay(date)
    --获得当前日期
    local nowY = os.date("%Y", os.time())
    local nowM = os.date("%m", os.time())
    local nowD = os.date("%d", os.time())

    --解析记录中的日期时间
    local lastDate = lion.stringSplit(date, "-")
    if not lastDate or #lastDate < 3 then
        return false
    end
    local lastY = tonumber(lastDate[1])
    local lastM = tonumber(lastDate[2])
    local lastD = tonumber(lastDate[3])
    if not lastY or not lastM or not lastD then
        return false
    end
    nowY = tonumber(nowY)
    nowM = tonumber(nowM)
    nowD = tonumber(nowD)
    --超过1年
    if nowY - lastY >= 1 then
        return true
    end
    --超过1个月
    if nowM - lastM >= 1 then
        return true
    end
    --超过1天
    if nowD - lastD >= 1 then
        return true
    end
    return false
end

--[[
获取该用户身份证的年龄
data: str类型 身份证号
return：int类型 身份证年龄
]]
function lion.getIdCardAge(data)
    --获得当前日期
    local nowY = tonumber(os.date("%Y", os.time()))
    local nowM = tonumber(os.date("%m", os.time()))
    local nowD = tonumber(os.date("%d", os.time()))

    --解析身份证中的日期时间
    local lastY = 0
    local lastM = 0
    local lastD = 0
    if lion.getStringLen(data) == 18 then
        lastY = tonumber(string.sub(data, 7, 10))
        lastM = tonumber(string.sub(data, 11, 12))
        lastD = tonumber(string.sub(data, 13, 14))
    else
        lastY = tonumber("19" .. string.sub(data, 7, 8))
        lastM = tonumber(string.sub(data, 9, 10))
        lastD = tonumber(string.sub(data, 11, 12))
    end

    if nowM > lastM or (nowM == lastM and nowD > lastD) then
        return nowY - lastY
    else
        return nowY - lastY - 1
    end
end

--[[
开始计时
]]
function lion.startStopWatch()
    return { start = os.time() }
end

--[[
停止计时
]]
function lion.stopStopWatch(stopWatch, text)
    if stopWatch == nil then
        stopWatch = { start = os.time() }
    end
    print(nil, tostring(text), os.time() - stopWatch.start)
end

--[[
--打印调用堆栈
]]
function lion.showDebugStack()
    print(debug.traceback())
end

--[[
功能描述：获取系统日期和时间
参数：无
]]
function lion.getTime(time)
    local tabTime = os.date("*t", time)
    local formatTime = ""
    local format = "-"
    formatTime = formatTime ..
        "[" ..
        tabTime.year ..
        format ..
        tabTime.month .. format .. tabTime.day .. " " .. tabTime.hour .. ":" .. tabTime.min .. ":" .. tabTime.sec .. "]"
    return formatTime
end

--[[
功能描述：获取系统日期
参数：无
]]
function lion.getDate(time)
    local tabTime = os.date("*t", time)
    local formatDate = ""
    local format = "-"
    formatDate = "[" .. tabTime.year .. format .. tabTime.month .. format .. tabTime.day .. "]"
    return formatDate
end

--[[
功能描述：获取系统日期和时间
参数：无
]]
function lion.getTimeRaw(time)
    local tabTime = os.date("*t", time)
    local formatTime = ""
    local format = "-"
    formatTime = formatTime ..
        tabTime.year ..
        format ..
        tabTime.month .. format .. tabTime.day .. " " .. tabTime.hour .. ":" .. tabTime.min .. ":" .. tabTime.sec
    return formatTime
end

--[[
功能描述：写日志
参数说明：1、fileName:文件名;2、日志内容
]]
function lion.writeLog(fileName, ...)
    if "string" ~= type(fileName) then
        print("ERROR writeLog: fileName is not string.")
        return
    end
    local path = "./log/" .. fileName .. ".log"
    local f = io.open(path, "a+")
    if f then
        local logHead = "\n"
        f:write(logHead, ...)
        f:close()
    end
end

--[[
写入文件
]]
function lion.writeFile(fileName, logHead, str)
    if "string" ~= type(fileName) then
        print("ERROR writeLog: fileName is not string.")
        return
    end
    local path = fileName
    local f = io.open(path, "a+")
    if f then
        f:write(logHead, str)
        f:close()
    end
end

--[[
功能描述：写消息日志 模式为w+ 换行符
参数说明：1、fileName:文件名;2、日志内容
]]
function lion.writeMsgLog(fileName, ...)
    if "string" ~= type(fileName) then
        print("ERROR writeLog: fileName is not string.")
        return
    end
    local path = "./log/" .. fileName .. ".log"
    local f = io.open(path, "w+")
    if f then
        f:write(...)
        f:flush()
        f:close()
    end
end

--[[
Queue
]]
local Queue = {}
function Queue.new(maxLen)
    if nil ~= maxLen and "number" == type(maxLen) and maxLen > 0 then
        return { first = 0, last = -1, maxLen = maxLen }
    else
        return { first = 0, last = -1 }
    end
end

--[[
向队列尾添加元素
]]
function Queue.push_last(queue, value)
    if queue.maxLen and (queue.last - queue.first + 1) >= queue.maxLen then
        return -1
    end

    local last = queue.last + 1
    queue.last = last
    queue[last] = value
    return 0
end

--[[
弹出队列头
]]
function Queue.pop_first(queue)
    local first = queue.first
    if first > queue.last then
        --队列空
        return nil
    end

    local value = queue[first]
    queue[first] = nil
    queue.first = first + 1
    return value
end

--[[
判断队列是否为空
参数 queue 队列对象
返回值 boolean 为空返回 true
]]
function Queue.isEmpty(queue)
    if queue.first > queue.last then
        --队列空
        return true
    end
    return false
end

--[[
判断队列是否已满（仅当创建时指定了 maxLen 时有效）
参数 queue 队列对象
返回值 boolean 已满返回 true，无长度限制时返回 false
]]
function Queue.isFull(queue)
    if nil == queue.maxLen then
        return false
    end

    if (queue.last - queue.first + 1) > queue.maxLen then
        --队列满
        return true
    end
    return false
end

--[[
获取队列当前元素个数
参数 queue 队列对象
返回值 number
]]
function Queue.getLen(queue)
    return queue.last - queue.first + 1
end

--[[
获取队列最大长度（若创建时未指定则返回 nil）
参数 queue 队列对象
返回值 number|nil
]]
function Queue.getMaxLen(queue)
    return queue.maxLen
end

--[[
设置队列最大长度
参数 queue 队列对象
参数 maxLen 最大元素个数
]]
function Queue.setMaxLen(queue, maxLen)
    queue.maxLen = maxLen
end

lion.Queue = Queue


--[[
比较两个时间字符串的大小
参数 time1 时间字符串，格式 "YYYY-MM-DD HH:MM:SS"
参数 time2 同上
返回值 boolean true 表示 time1 > time2，否则为 false
]]
function lion.compareTimes(time1, time2)
    local y1, mon1, d1 = string.match(time1, "(%d+)-(%d+)-(%d+)")
    local h1, m1, s1 = string.match(time1, "(%d+):(%d+):(%d+)")

    local y2, mon2, d2 = string.match(time2, "(%d+)-(%d+)-(%d+)")
    local h2, m2, s2 = string.match(time2, "(%d+):(%d+):(%d+)")

    local temp1 = os.time({ year = y1, month = mon1, day = d1, hour = h1, min = m1, sec = s1 })
    local temp2 = os.time({ year = y2, month = mon2, day = d2, hour = h2, min = m2, sec = s2 })

    return temp1 > temp2
end

--[[
根据userID创建伪随机的编号
]]
function lion.getFakeRandomUserCode(userID)
    local bitlen = 26
    local bit = { data = {} }
    for i = 1, bitlen do
        bit.data[i] = 2 ^ (bitlen - i)
    end

    function bit:dToB(arg)
        local tr = {}
        for i = 1, bitlen do
            if arg >= self.data[i] then
                tr[i] = 1
                arg = arg - self.data[i]
            else
                tr[i] = 0
            end
        end
        return tr
    end --bit:dToB

    function bit:bToD(arg)
        local nr = 0
        for i = 1, bitlen do
            if arg[i] == 1 then
                nr = nr + 2 ^ (bitlen - i)
            end
        end
        return nr
    end --bit:bToD

    function bit:_xor(a, b)
        local op1 = self:dToB(a)
        local op2 = self:dToB(b)
        local r = {}

        for i = 1, bitlen do
            if op1[i] == op2[i] then
                r[i] = 0
            else
                r[i] = 1
            end
        end
        return self:bToD(r)
    end --bit:xor

    function bit:_and(a, b)
        local op1 = self:dToB(a)
        local op2 = self:dToB(b)
        local r = {}

        for i = 1, bitlen do
            if op1[i] == 1 and op2[i] == 1 then
                r[i] = 1
            else
                r[i] = 0
            end
        end
        return self:bToD(r)
    end --bit:_and

    function bit:_or(a, b)
        local op1 = self:dToB(a)
        local op2 = self:dToB(b)
        local r = {}

        for i = 1, bitlen do
            if op1[i] == 1 or op2[i] == 1 then
                r[i] = 1
            else
                r[i] = 0
            end
        end
        return self:bToD(r)
    end --bit:_or

    function bit:_not(a)
        local op1 = self:dToB(a)
        local r = {}

        for i = 1, bitlen do
            if op1[i] == 1 then
                r[i] = 0
            else
                r[i] = 1
            end
        end
        return self:bToD(r)
    end --bit:_not

    function bit:_rshift(a, n)
        local op1 = self:dToB(a)
        local r = self:dToB(0)

        if n < bitlen and n > 0 then
            for i = 1, n do
                for i = 31, 1, -1 do
                    op1[i + 1] = op1[i]
                end
                op1[1] = 0
            end
            r = op1
        end
        return self:bToD(r)
    end --bit:_rshift

    function bit:_lshift(a, n)
        local op1 = self:dToB(a)
        local r = self:dToB(0)

        if n < bitlen and n > 0 then
            for i = 1, n do
                for i = 1, 31 do
                    op1[i] = op1[i + 1]
                end
                op1[bitlen] = 0
            end
            r = op1
        end
        return self:bToD(r)
    end --bit:_lshift

    function bit:print(ta)
        local sr = ""
        for i = 1, bitlen do
            sr = sr .. ta[i]
        end
        print(sr)
    end

    function bit:toStr(ta)
        local sr = ""
        for i = 1, bitlen, 1 do
            sr = sr .. ta[i]
        end
        return sr
    end

    function bit:reverseTable(tab)
        local rand = { 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 }
        local tmp = {}
        for i = 1, #rand, 1 do
            local key = rand[i]
            tmp[i] = tab[key]
        end

        return tmp
    end

    local bs = bit:dToB(tonumber(userID))
    local arr = bit:reverseTable(bs)
    return math.floor(tonumber(bit:bToD(arr)) + 10000000) --凑齐8为数
end

--[[
根据伪随机号推算出userID
]]
function lion.getUserIDByCode(code)
    local bitlen = 26
    local bit = { data = {} }
    for i = 1, bitlen do
        bit.data[i] = 2 ^ (bitlen - i)
    end

    function bit:dToB(arg)
        local tr = {}
        for i = 1, bitlen do
            if arg >= self.data[i] then
                tr[i] = 1
                arg = arg - self.data[i]
            else
                tr[i] = 0
            end
        end
        return tr
    end --bit:dToB

    function bit:bToD(arg)
        local nr = 0
        for i = 1, bitlen do
            if arg[i] == 1 then
                nr = nr + 2 ^ (bitlen - i)
            end
        end
        return nr
    end --bit:bToD

    function bit:_xor(a, b)
        local op1 = self:dToB(a)
        local op2 = self:dToB(b)
        local r = {}

        for i = 1, bitlen do
            if op1[i] == op2[i] then
                r[i] = 0
            else
                r[i] = 1
            end
        end
        return self:bToD(r)
    end --bit:xor

    function bit:_and(a, b)
        local op1 = self:dToB(a)
        local op2 = self:dToB(b)
        local r = {}

        for i = 1, bitlen do
            if op1[i] == 1 and op2[i] == 1 then
                r[i] = 1
            else
                r[i] = 0
            end
        end
        return self:bToD(r)
    end --bit:_and

    function bit:_or(a, b)
        local op1 = self:dToB(a)
        local op2 = self:dToB(b)
        local r = {}

        for i = 1, bitlen do
            if op1[i] == 1 or op2[i] == 1 then
                r[i] = 1
            else
                r[i] = 0
            end
        end
        return self:bToD(r)
    end --bit:_or

    function bit:_not(a)
        local op1 = self:dToB(a)
        local r = {}

        for i = 1, bitlen do
            if op1[i] == 1 then
                r[i] = 0
            else
                r[i] = 1
            end
        end
        return self:bToD(r)
    end --bit:_not

    function bit:_rshift(a, n)
        local op1 = self:dToB(a)
        local r = self:dToB(0)

        if n < bitlen and n > 0 then
            for i = 1, n do
                for i = 31, 1, -1 do
                    op1[i + 1] = op1[i]
                end
                op1[1] = 0
            end
            r = op1
        end
        return self:bToD(r)
    end --bit:_rshift

    function bit:_lshift(a, n)
        local op1 = self:dToB(a)
        local r = self:dToB(0)

        if n < bitlen and n > 0 then
            for i = 1, n do
                for i = 1, 31 do
                    op1[i] = op1[i + 1]
                end
                op1[bitlen] = 0
            end
            r = op1
        end
        return self:bToD(r)
    end --bit:_lshift

    function bit:print(ta)
        local sr = ""
        for i = 1, bitlen do
            sr = sr .. ta[i]
        end
        print(sr)
    end

    function bit:toStr(ta)
        local sr = ""
        for i = 1, bitlen, 1 do
            sr = sr .. ta[i]
        end
        return sr
    end

    function bit:reverseTable(tab)
        local rand = { 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 }
        local tmp = {}
        for i = 1, #rand, 1 do
            local key = rand[i]
            tmp[i] = tab[key]
        end

        return tmp
    end

    local bs = bit:dToB(tonumber(code - 10000000))
    local arr = bit:reverseTable(bs)
    return math.floor(tonumber(bit:bToD(arr)))
end

--[[
HTML 数字实体（&#123;）转 UTF-8 字符
参数 str 含 &#十进制; 的字符串
返回值 string 转换后的 UTF-8 字符串
]]
function lion.htmlEntitiesToUtf8(str)
    local function tail(n, k)
        local u, r = '', 0
        for i = 1, k do
            n, r = math.floor(n / 0x40), n % 0x40
            u = string.char(r + 0x80) .. u
        end
        return u, n
    end

    local function to_utf8(a)
        local n, u = tonumber(a), ''
        if n < 0x80 then
            -- 1 byte
            return string.char(n)
        elseif n < 0x800 then
            -- 2 byte
            u, n = tail(n, 1)
            return string.char(n + 0xc0) .. u
        elseif n < 0x10000 then
            -- 3 byte
            u, n = tail(n, 2)
            return string.char(n + 0xe0) .. u
        elseif n < 0x200000 then
            -- 4 byte
            u, n = tail(n, 3)
            return string.char(n + 0xf0) .. u
        elseif n < 0x4000000 then
            -- 5 byte
            u, n = tail(n, 4)
            return string.char(n + 0xf8) .. u
        else
            -- 6 byte
            u, n = tail(n, 5)
            return string.char(n + 0xfc) .. u
        end
    end

    return string.gsub(str, '&#(%d+);', to_utf8)
end

--[[
获得utf8长度
]]
function lion.getUtf8Len(input)
    local len = string.len(input)
    local left = len
    local cnt = 0
    local arr = { 0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc }
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

--[[
是否包含中文
]]
function lion.hasChinese(str)
    if str == nil then
        return false
    end
    str = tostring(str)
    local len = lion.getUtf8Len(str)
    --判断是否全部为中文
    for i = 1, #str, 1 do
        local tmp = string.byte(str, i)
        if tmp < 240 and tmp >= 224 then
            return true
        end
    end
    return false
end

--[[
检查中文昵称
]]
function lion.checkChineseName(str)
    if str == nil then
        return false
    end
    str = tostring(str)

    local len = lion.getUtf8Len(str)
    if len <= 1 or len > 6 then
        return false
    end

    if #str > 0 and #str / 3 % 1 == 0 then
        --判断是否全部为中文
        for i = 1, #str, 3 do
            local tmp = string.byte(str, i)
            print(" ---- ----", tmp) --230
            if tmp >= 240 or tmp < 224 then
                return false
            end
        end
        --判断中文中是否有中文标点符号
        for i = 1, #str, 3 do
            local tmp1 = string.byte(str, i)
            local tmp2 = string.byte(str, i + 1)
            local tmp3 = string.byte(str, i + 2)
            print("mp1,mp2,mp3", tmp1, tmp2, tmp3)
            --228 184 128 -- 233 191 191
            if tmp1 < 228 or tmp1 > 233 then
                return false
            elseif tmp1 == 228 then
                if tmp2 < 184 then
                    return false
                elseif tmp2 == 184 then
                    if tmp3 < 128 then
                        return false
                    end
                end
            elseif tmp1 == 233 then
                if tmp2 > 191 then
                    return false
                elseif tmp2 == 191 then
                    if tmp3 > 191 then
                        return false
                    end
                end
            end
        end
        return true
    end
    return false
end

--[[
功能描述：读取外部json文件
参数：path 文件路径
返回：jsonData or nil
]]
function lion.readJsonFile(path)
    if "string" ~= type(path) then
        print("ERROR writeLog: fileName is not string.")
        return
    end

    local f = io.open(path, "r")
    if f then
        local t = f:read("*all")
        --print("-----> ",t)
        if nil ~= t and "" ~= t then
            local ok, jsonData = pcall(json.decode, t)
            if not ok or not jsonData then
                print("Json decode error")
            else
                f:close()
                return jsonData
            end
        else
            print("empty file :", path)
        end
        f:close()
    else
        print("can not find this file ", path)
    end
end

--[[
判断是否是手机号
]]
function lion.checkPhone(phone)
    if phone == nil then
        print("checkPhone phone is nil", phone)
        return false
    end

    return string.match(phone, "[1][3,4,5,6,7,8,9]%d%d%d%d%d%d%d%d%d") == tostring(phone)
end

--[[
生成指定长度的随机验证码
]]
function lion.getRandomAuthCode(len)
    len = tonumber(len)
    return math.random(1, 9) .. lion.getRandomNumString(len - 1) --保证开头不为0
end

--[[
反转table
]]
function lion.tableReverse(list)
    local tp = {}
    local index = 1
    for i = #list, 0, -1 do
        tp[index] = list[i]
        index = index + 1
    end
    return tp
end

--[[

]]
function lion.randomBool(current, max)
    if current <= 0 then
        return false
    end

    max = max or 100
    math.randomseed(tostring(os.time()):reverse():sub(1, 5))
    local p = math.random(1, max)
    if p <= current then
        return true
    else
        return false
    end
end

--[[
查询table是否包含指定的键值对
]]
function lion.containsKeyValue(table, key, value)
    local containsKey = false
    for i = 1, #table do
        local p1 = table[i]
        if tostring(p1[key]) == tostring(value) then
            containsKey = true
            return containsKey, p1
        end
    end
    return containsKey
end

--[[
值判断
]]
function lion.valueCheck(obj, desc)
    desc = desc or ""
    if obj then
        print("not nil ", desc, type(obj), obj)
    else
        print(" obj nil ", desc)
    end
end

--[[
检查日期格式y-m-d H:M:S格式为true 其他格式为false
]]
function lion.checkTimeFormat(time)
    if not time then
        print("checkTimeFormat time is nil ")
        return false
    end
    local res = string.match(time, "(%d+)-(%d+)-(%d+).+(%d+):(%d+):(%d+)")
    if res then
        return true
    else
        print("checkTimeFormat time format error")
        return false
    end
end

--[[
处理 x-www-form-urlencoded 类型数据，并自动urldecode
]]
function lion.parseUrlencoded(form)
    if form == nil or form == "" then
        return {}
    end
    local t = {}
    local arr = lion.stringSplit(form, "&")
    for _, v in ipairs(arr) do
        local dataArr = lion.stringSplit(v, "=")
        if dataArr[1] then
            local val = dataArr[2]
            if val then
                val = string.gsub(val, "+", " ")
                t[dataArr[1]] = lion.urlDecode(val)
            else
                t[dataArr[1]] = ""
            end
        end
    end
    return t
end

--[[
获取日期前后几天的日期
自定义一个函数，time为指定的日期格式YYYY-MM-DD，
dayChange为指定日期前后天数，用法：前一天 -1 后一天 1.
]]
function lion.dateChange(time, dayChange)
    local year = string.sub(time, 0, 4);                                                 --年份
    local month = string.sub(time, 6, 7);                                                --月
    local day = string.sub(time, 9, 10);                                                 --日
    local time1 = os.time({ year = year, month = month, day = day }) + dayChange * 86400 --一天86400秒
    return os.date('%Y', time1) .. "-" .. os.date('%m', time1) .. "-" .. os.date('%d', time1)
end

--[[
检查特殊屏蔽字符
1圆/园/员/快/毛/yuan （1等数字前缀）
一圆/园/员/快/毛/yuan （一等数字前缀）
壹圆/园/员/快/毛/yuan（壹等数字前缀）
]]
function lion.checkSpecialBannedWords(data)
    if type(data) ~= "string" then
        return nil
    end
    local preStrTab = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "零", "一", "二", "三", "四", "五", "六",
        "七", "八", "九", "十", "壹", "贰", "叁", "肆", "伍", "陸", "柒", "捌", "玖", "拾" }
    local bannedWordsTab = { "圆", "园", "员", "快", "毛", "yuan" }
    local startIdx, endIdx
    for _, prefix in ipairs(preStrTab) do
        for _, bannedWord in ipairs(bannedWordsTab) do
            startIdx, endIdx = string.find(data, prefix .. bannedWord)
            if startIdx ~= nil then
                return bannedWord
            end
        end
    end
    startIdx, endIdx = string.find(data, "[$]")
    if startIdx then
        return string.sub(data, startIdx, endIdx)
    end
    return nil
end

return lion
