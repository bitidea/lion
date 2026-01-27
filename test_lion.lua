-- 完整的 lion.lua 单元测试
local lion = require("lion")

-- 测试结果统计
local total_tests = 0
local passed_tests = 0
local failed_tests = 0

-- 测试辅助函数
local function test_case(name, test_func)
    total_tests = total_tests + 1
    local success, err = pcall(test_func)
    if success then
        passed_tests = passed_tests + 1
        print(string.format("[PASS] %s", name))
    else
        failed_tests = failed_tests + 1
        print(string.format("[FAIL] %s: %s", name, err))
    end
end

local function assert_equal(actual, expected, message)
    if actual ~= expected then
        error(string.format("%s: expected %s, got %s", message or "", tostring(expected), tostring(actual)))
    end
end

local function assert_true(value, message)
    if not value then
        error(message or "expected true, got false")
    end
end

local function assert_false(value, message)
    if value then
        error(message or "expected false, got true")
    end
end

print("=== Lion.lua 单元测试开始 ===\n")

-- 1. 数字格式化测试
print("1. 数字格式化测试")
test_case("formatNumberToWan - 小于10000", function()
    local result = lion.formatNumberToWan(9999)
    assert_equal(result, "9999", "formatNumberToWan 小于10000")
end)

test_case("formatNumberToWan - 等于10000", function()
    local result = lion.formatNumberToWan(10000)
    assert_equal(result, "1万", "formatNumberToWan 等于10000")
end)

test_case("formatNumberToWan - 大于10000", function()
    local result = lion.formatNumberToWan(12345)
    assert_equal(result, "1万", "formatNumberToWan 大于10000")
end)

test_case("formatNumberToWan - nil", function()
    local result = lion.formatNumberToWan(nil)
    assert_equal(result, "0", "formatNumberToWan nil")
end)

-- 2. 字符串分割测试
print("\n2. 字符串分割测试")
test_case("stringSplit - 正常分割", function()
    local result = lion.stringSplit("a,b,c,d", ",")
    assert_equal(#result, 4, "stringSplit 长度")
    assert_equal(result[1], "a", "stringSplit 第一个元素")
    assert_equal(result[4], "d", "stringSplit 最后一个元素")
end)

test_case("stringSplit - 空字符串", function()
    local result = lion.stringSplit("", ",")
    assert_equal(#result, 0, "stringSplit 空字符串")
end)

test_case("stringSplit - nil", function()
    local result = lion.stringSplit(nil, ",")
    assert_equal(#result, 0, "stringSplit nil")
end)

-- 3. 时间转换测试
print("\n3. 时间转换测试")
test_case("convertTimestampToDateTime - 正常时间戳", function()
    local testTimestamp = lion.dateToSec("2021-01-01 00:00:00")
    local result = lion.convertTimestampToDateTime(testTimestamp)
    assert_true(string.find(result, "2021%-01%-01") ~= nil, "convertTimestampToDateTime 包含日期")
end)

test_case("convertTimestampToDateTime - nil", function()
    local result = lion.convertTimestampToDateTime(nil)
    assert_true(string.find(result, "%d%d%d%d") ~= nil, "convertTimestampToDateTime nil 返回当前时间")
end)

test_case("secToDate - 正常秒数", function()
    local testTimestamp = lion.dateToSec("2021-01-01 00:00:00")
    local result = lion.secToDate(testTimestamp)
    assert_true(string.find(result, "2021%-01%-01") ~= nil, "secToDate 包含日期")
end)

test_case("dateToSec - 正常日期", function()
    local result = lion.dateToSec("2021-01-01 00:00:00")
    assert_true(result > 0, "dateToSec 返回有效的时间戳")
end)

-- 4. 字符串检查测试
print("\n4. 字符串检查测试")
test_case("checkSymbol - 包含引号", function()
    local result = lion.checkSymbol('test"quote')
    assert_true(result, "checkSymbol 包含引号")
end)

test_case("checkSymbol - 不包含符号", function()
    local result = lion.checkSymbol("test")
    assert_false(result, "checkSymbol 不包含符号")
end)

test_case("replaceSymbol - 替换危险符号", function()
    local result = lion.replaceSymbol('test"quote&symbol')
    assert_equal(result, "testquotesymbol", "replaceSymbol 替换结果")
end)

test_case("checkUnlawfulString - 合法字符串", function()
    local result = lion.checkUnlawfulString("test")
    assert_true(result, "checkUnlawfulString 合法字符串")
end)

test_case("checkUnlawfulString - 包含非法字符", function()
    local result = lion.checkUnlawfulString("test'quote")
    assert_false(result, "checkUnlawfulString 包含非法字符")
end)

test_case("checkTableUnlawfulString - 合法表", function()
    local result = lion.checkTableUnlawfulString({ a = "test", b = "value" })
    assert_true(result, "checkTableUnlawfulString 合法表")
end)

-- 5. 身份证检查测试
print("\n5. 身份证检查测试")
test_case("checkIdCard - 18位合法身份证", function()
    local result = lion.checkIdCard("11010519491231002X")
    assert_true(result, "checkIdCard 18位合法身份证")
end)

test_case("checkIdCard - 15位合法身份证", function()
    local result = lion.checkIdCard("110105491231002")
    assert_true(result, "checkIdCard 15位合法身份证")
end)

test_case("checkIdCard - 非法身份证", function()
    local result = lion.checkIdCard("123456789012345678")
    assert_false(result, "checkIdCard 非法身份证")
end)

-- 6. 随机字符串生成测试
print("\n6. 随机字符串生成测试")
test_case("getRandomAscII - 正常长度", function()
    local result = lion.getRandomAscII(10)
    assert_equal(string.len(result), 10, "getRandomAscII 长度")
end)

test_case("getRandomNumString - 正常长度", function()
    local result = lion.getRandomNumString(6)
    assert_equal(string.len(result), 6, "getRandomNumString 长度")
    assert_true(string.find(result, "^%d+$") ~= nil, "getRandomNumString 全为数字")
end)

-- 7. 表操作测试
print("\n7. 表操作测试")
test_case("tableRemoveAll - 正常删除", function()
    local tab = { 1, 2, 3, 2, 4, 1 }
    lion.tableRemoveAll(tab, { [1] = true, [2] = true })
    assert_equal(#tab, 2, "tableRemoveAll 删除后长度")
    assert_equal(tab[1], 3, "tableRemoveAll 第一个元素")
end)

test_case("tableDuplicate - 去重", function()
    local tab = { 1, 2, 3, 2, 4, 1 }
    local result = lion.tableDuplicate(tab)
    assert_equal(#result, 4, "tableDuplicate 去重后长度")
end)

test_case("countTable - 计算元素个数", function()
    local tab = { a = 1, b = 2, c = 3 }
    local result = lion.countTable(tab)
    assert_equal(result, 3, "countTable 元素个数")
end)

test_case("isTableEmpty - 空表", function()
    local result = lion.isTableEmpty({})
    assert_true(result, "isTableEmpty 空表")
end)

test_case("isTableEmpty - 非空表", function()
    local result = lion.isTableEmpty({ a = 1 })
    assert_false(result, "isTableEmpty 非空表")
end)

test_case("isExistsInTable - 包含值", function()
    local result = lion.isExistsInTable({ 1, 2, 3 }, 2)
    assert_true(result, "isExistsInTable 包含值")
end)

test_case("isExistsInTable - 不包含值", function()
    local result = lion.isExistsInTable({ 1, 2, 3 }, 4)
    assert_false(result, "isExistsInTable 不包含值")
end)

test_case("compareTable - 相同表", function()
    local result = lion.compareTable({ a = 1, b = 2 }, { a = 1, b = 2 })
    assert_true(result, "compareTable 相同表")
end)

test_case("compareTable - 不同表", function()
    local result = lion.compareTable({ a = 1, b = 2 }, { a = 1, b = 3 })
    assert_false(result, "compareTable 不同表")
end)

test_case("deepCopy - 深拷贝", function()
    local original = { a = 1, b = { c = 2 } }
    local copy = lion.deepCopy(original)
    original.b.c = 3
    assert_equal(copy.b.c, 2, "deepCopy 深拷贝不影响原表")
end)

-- 8. 字符串处理测试
print("\n8. 字符串处理测试")
test_case("trimString - 删除空格", function()
    local result = lion.trimString("hello world")
    assert_equal(result, "helloworld", "trimString 删除空格")
end)

test_case("trimSpace - 删除首尾空格", function()
    local result = lion.trimSpace("  hello  ")
    assert_equal(result, "hello", "trimSpace 删除首尾空格")
end)

test_case("subString - 截取字符串", function()
    local result = lion.subString("hello", 3)
    assert_equal(result, "hel", "subString 截取结果")
end)

test_case("getStringLen - 计算字符串长度", function()
    local result = lion.getStringLen("hello")
    assert_equal(result, 5, "getStringLen 英文长度")
end)

test_case("getStringLen - 中文长度", function()
    local result = lion.getStringLen("你好")
    assert_equal(result, 4, "getStringLen 中文长度")
end)

test_case("cutStringLast - 删除最后一个字符", function()
    local result = lion.cutStringLast("hello")
    assert_equal(result, "hell", "cutStringLast 删除结果")
end)

-- 9. Emoji 检查测试
print("\n9. Emoji 检查测试")
test_case("hasEmoji - 包含emoji", function()
    local result = lion.hasEmoji("hello😊")
    assert_true(result, "hasEmoji 包含emoji")
end)

test_case("hasEmoji - 不包含emoji", function()
    local result = lion.hasEmoji("hello")
    assert_false(result, "hasEmoji 不包含emoji")
end)

test_case("deleteEmojiFromString - 删除emoji", function()
    local result = lion.deleteEmojiFromString("hello😊world")
    assert_equal(result, "helloworld", "deleteEmojiFromString 删除结果")
end)

-- 10. 字符串转换测试
print("\n10. 字符串转换测试")
test_case("convertStringToTable - 字符串转表", function()
    local result = lion.convertStringToTable("hello")
    assert_equal(#result, 5, "convertStringToTable 长度")
end)

test_case("convertArrayToString - 表转字符串", function()
    local result = lion.convertArrayToString({ 1, 2, 3 }, ",")
    assert_equal(result, "1,2,3", "convertArrayToString 转换结果")
end)

-- 11. 类型转换测试
print("\n11. 类型转换测试")
test_case("numToBool - 0转false", function()
    local result = lion.numToBool(0)
    assert_false(result, "numToBool 0转false")
end)

test_case("numToBool - 1转true", function()
    local result = lion.numToBool(1)
    assert_true(result, "numToBool 1转true")
end)

test_case("stringToBool - true转true", function()
    local result = lion.stringToBool("true")
    assert_true(result, "stringToBool true转true")
end)

test_case("stringToBool - 其他转false", function()
    local result = lion.stringToBool("false")
    assert_false(result, "stringToBool 其他转false")
end)

test_case("toInt - 正常转换", function()
    local result = lion.toInt("123")
    assert_equal(result, 123, "toInt 正常转换")
end)

test_case("toInt - nil转0", function()
    local result = lion.toInt(nil)
    assert_equal(result, 0, "toInt nil转0")
end)

test_case("isNumber - 数字", function()
    local result = lion.isNumber("123")
    assert_true(result, "isNumber 数字")
end)

test_case("isNumber - 非数字", function()
    local result = lion.isNumber("abc")
    assert_false(result, "isNumber 非数字")
end)

test_case("safeToNum - 数字字符串", function()
    local result = lion.safeToNum("123")
    assert_equal(result, 123, "safeToNum 数字字符串")
end)

test_case("safeToNum - 非数字字符串", function()
    local result = lion.safeToNum("abc")
    assert_equal(result, "abc", "safeToNum 非数字字符串")
end)

test_case("safeTableToNum - 表转数字", function()
    local tab = { a = "123", b = "456" }
    local result = lion.safeTableToNum(tab)
    assert_equal(result.a, 123, "safeTableToNum a值")
    assert_equal(result.b, 456, "safeTableToNum b值")
end)

-- 12. 字符串检查测试
print("\n12. 字符串检查测试")
test_case("isStringEmpty - 空字符串", function()
    local result = lion.isStringEmpty("")
    assert_true(result, "isStringEmpty 空字符串")
end)

test_case("isStringEmpty - nil", function()
    local result = lion.isStringEmpty(nil)
    assert_true(result, "isStringEmpty nil")
end)

test_case("isStringEmpty - 非空字符串", function()
    local result = lion.isStringEmpty("hello")
    assert_false(result, "isStringEmpty 非空字符串")
end)

test_case("findString - 找到字符串", function()
    local result = lion.findString("hello world", "world")
    assert_true(result, "findString 找到字符串")
end)

test_case("findString - 未找到字符串", function()
    local result = lion.findString("hello", "world")
    assert_false(result, "findString 未找到字符串")
end)

-- 13. 时间比较测试
print("\n13. 时间比较测试")
test_case("compareTime - 时间差", function()
    local result = lion.compareTime("2021-01-02 00:00:00", "2021-01-01 00:00:00")
    assert_equal(result, 86400, "compareTime 时间差")
end)

test_case("ifTimeInZone - 在时间范围内", function()
    local result = lion.ifTimeInZone("2021-01-01 12:00:00", "2021-01-01 00:00:00", "2021-01-01 23:59:59")
    assert_true(result, "ifTimeInZone 在时间范围内")
end)

test_case("ifTimeInZone - 不在时间范围内", function()
    local result = lion.ifTimeInZone("2021-01-02 00:00:00", "2021-01-01 00:00:00", "2021-01-01 23:59:59")
    assert_false(result, "ifTimeInZone 不在时间范围内")
end)

test_case("isSameDay - 同一天", function()
    local result = lion.isSameDay("2021-01-01 12:00:00", "2021-01-01 18:00:00")
    assert_true(result, "isSameDay 同一天")
end)

test_case("isSameDay - 不同天", function()
    local result = lion.isSameDay("2021-01-01 12:00:00", "2021-01-02 18:00:00")
    assert_false(result, "isSameDay 不同天")
end)

-- 14. URL 处理测试
print("\n14. URL 处理测试")
test_case("urlEncode - 编码", function()
    local result = lion.urlEncode("hello world")
    assert_equal(result, "hello+world", "urlEncode 编码结果")
end)

test_case("urlDecode - 解码", function()
    local result = lion.urlDecode("hello%20world")
    assert_equal(result, "hello world", "urlDecode 解码结果")
end)

test_case("tableToUrl - 表转URL", function()
    local result = lion.tableToUrl({ a = 1, b = 2 })
    assert_true(string.find(result, "a=1") ~= nil, "tableToUrl 包含a=1")
    assert_true(string.find(result, "b=2") ~= nil, "tableToUrl 包含b=2")
end)

test_case("urlToTable - URL转表", function()
    local result = lion.urlToTable("http://example.com?a=1&b=2")
    assert_equal(result.a, "1", "urlToTable a值")
    assert_equal(result.b, "2", "urlToTable b值")
end)

test_case("urlParamToTable - URL参数转表", function()
    local result = lion.urlParamToTable("a=1&b=2")
    assert_equal(result.a, "1", "urlParamToTable a值")
    assert_equal(result.b, "2", "urlParamToTable b值")
end)

-- 15. 排序测试
print("\n15. 排序测试")
test_case("bubbleSort - 冒泡排序", function()
    local tab = { { value = 3 }, { value = 1 }, { value = 2 } }
    lion.bubbleSort(tab, "value")
    assert_equal(tab[1].value, 3, "bubbleSort 第一个元素")
    assert_equal(tab[3].value, 1, "bubbleSort 最后一个元素")
end)

test_case("antiBubbleSort - 反冒泡排序", function()
    local tab = { { value = 3 }, { value = 1 }, { value = 2 } }
    lion.antiBubbleSort(tab, "value")
    assert_equal(tab[1].value, 1, "antiBubbleSort 第一个元素")
    assert_equal(tab[3].value, 3, "antiBubbleSort 最后一个元素")
end)

-- 16. IP 地址解析测试
print("\n16. IP 地址解析测试")
test_case("getIpAddressInfo - 正常IP地址", function()
    local result = lion.getIpAddressInfo("127.0.0.1:8080")
    assert_equal(result.ip, "127.0.0.1", "getIpAddressInfo IP")
    assert_equal(result.port, 8080, "getIpAddressInfo 端口")
end)

test_case("getIpAddressInfo - 无效IP地址", function()
    local result = lion.getIpAddressInfo("invalid")
    assert_equal(result.ip, "", "getIpAddressInfo 无效IP")
    assert_equal(result.port, 0, "getIpAddressInfo 无效端口")
end)

-- 17. 成功率测试
print("\n17. 成功率测试")
test_case("isSuccess - 100%成功率", function()
    local result = lion.isSuccess(100)
    assert_true(result, "isSuccess 100%成功率")
end)

test_case("isSuccess - 0%成功率", function()
    local result = lion.isSuccess(0)
    assert_false(result, "isSuccess 0%成功率")
end)

-- 18. 文件操作测试
print("\n18. 文件操作测试")
test_case("getFileName - 获取文件名", function()
    local result = lion.getFileName("/path/to/file.txt")
    assert_equal(result, "file.txt", "getFileName 文件名")
end)

test_case("getFileNameWithoutExtension - 去除扩展名", function()
    local result = lion.getFileNameWithoutExtension("file.txt")
    assert_equal(result, "file", "getFileNameWithoutExtension 文件名")
end)

test_case("getFileExtension - 获取扩展名", function()
    local result = lion.getFileExtension("file.txt")
    assert_equal(result, "txt", "getFileExtension 扩展名")
end)

-- 19. 进制转换测试
print("\n19. 进制转换测试")
test_case("binToHex - 二进制转十六进制", function()
    local result = lion.binToHex("hello")
    assert_equal(string.len(result), 10, "binToHex 长度")
end)

test_case("strToHex - 字符串转十六进制", function()
    local result = lion.strToHex("hello")
    assert_equal(string.len(result), 10, "strToHex 长度")
end)

test_case("hexToStr - 十六进制转字符串", function()
    local result = lion.hexToStr("68656C6C6F")
    assert_equal(result, "hello", "hexToStr 转换结果")
end)

-- 20. Redis 表转换测试
print("\n20. Redis 表转换测试")
test_case("redisTableToLuaTable - 一维表转换", function()
    local result = lion.redisTableToLuaTable({ "a", "1", "b", "2" })
    assert_equal(result.a, "1", "redisTableToLuaTable a值")
    assert_equal(result.b, "2", "redisTableToLuaTable b值")
end)

-- 21. 微信签名测试
print("\n21. 微信签名测试")
test_case("makeWxSign - 正常签名", function()
    local args = { a = "1", b = "2" }
    local result = lion.makeWxSign(args, "testkey")
    if result == "" then
        print("  (跳过：md5 不可用)")
        return
    end
    assert_true(string.len(result) > 0, "makeWxSign 签名长度")
end)

-- 22. 数据库安全检查测试
print("\n22. 数据库安全检查测试")
test_case("dbSafeCheck - 正常结果", function()
    local result = lion.dbSafeCheck({})
    assert_true(result, "dbSafeCheck 正常结果")
end)

test_case("dbSafeCheck - nil结果", function()
    local result = lion.dbSafeCheck(nil)
    assert_false(result, "dbSafeCheck nil结果")
end)

test_case("dbSafeCheck - 错误结果", function()
    local result = lion.dbSafeCheck({ badresult = true })
    assert_false(result, "dbSafeCheck 错误结果")
end)

-- 23. 身份证年龄测试
print("\n23. 身份证年龄测试")
test_case("getIdCardAge - 18位身份证", function()
    local result = lion.getIdCardAge("110105200001011234")
    assert_true(result > 0, "getIdCardAge 年龄大于0")
end)

-- 24. XML/JSON 转换测试
print("\n24. XML/JSON 转换测试")
test_case("tableToXml - 表转XML", function()
    local result = lion.tableToXml({ a = 1, b = 2 })
    assert_true(string.find(result, "<a>") ~= nil, "tableToXml 包含<a>")
    assert_true(string.find(result, "<b>") ~= nil, "tableToXml 包含<b>")
end)

-- 25. 从表中删除指定值测试
print("\n25. 从表中删除指定值测试")
test_case("removeFromTable - 删除指定值", function()
    local tab = { a = 1, b = 2, c = 3 }
    local result = lion.removeFromTable(tab, { 2 })
    assert_false(lion.isExistsInTable(result, 2), "removeFromTable 删除2")
end)

-- 26. 时间格式转换测试
print("\n26. 时间格式转换测试")
test_case("stringTimeToDateTime - 字符串时间转日期时间", function()
    local result = lion.stringTimeToDateTime("2021-01-01 12:00:00")
    assert_equal(result.year, "2021", "stringTimeToDateTime 年")
    assert_equal(result.month, "01", "stringTimeToDateTime 月")
end)

test_case("secToDateTime - 秒数转日期时间", function()
    local testTimestamp = lion.dateToSec("2021-01-01 00:00:00")
    local result = lion.secToDateTime(testTimestamp)
    assert_equal(result.year, "2021", "secToDateTime 年")
end)

test_case("dateTimeToStringTime - 日期时间转字符串", function()
    local dateTime = { year = "2021", month = "01", day = "01", hour = "12", minute = "00", second = "00" }
    local result = lion.dateTimeToStringTime(dateTime)
    assert_equal(result, "2021-01-01 12:00:00", "dateTimeToStringTime 转换结果")
end)

-- 27. 超过一天测试
print("\n27. 超过一天测试")
test_case("overOneDay - 超过一天", function()
    local result = lion.overOneDay("2021-01-01")
    assert_true(result, "overOneDay 超过一天")
end)

-- 28. 表去重测试
print("\n28. 表去重测试")
test_case("tableDuplicate - 表去重", function()
    local tab = { 1, 2, 3, 2, 4, 1 }
    local result = lion.tableDuplicate(tab)
    assert_equal(#result, 4, "tableDuplicate 去重后长度")
end)

-- 29. 字符串转数组测试
print("\n29. 字符串转数组测试")
test_case("convertStringToArray - 字符串转数组", function()
    local result = lion.convertStringToArray("a,b,c", ",")
    assert_equal(#result, 3, "convertStringToArray 长度")
end)

-- 30. 检查符号测试
print("\n30. 检查符号测试")
test_case("checkSymbol - 检查符号", function()
    local result = lion.checkSymbol("test@symbol")
    assert_true(result, "checkSymbol 包含@符号")
end)

-- 测试结果汇总
print("\n=== 测试结果汇总 ===")
print(string.format("总测试数: %d", total_tests))
print(string.format("通过: %d", passed_tests))
print(string.format("失败: %d", failed_tests))
print(string.format("通过率: %.2f%%", (passed_tests / total_tests) * 100))

if failed_tests == 0 then
    print("\n✓ 所有测试通过！")
else
    print("\n✗ 有测试失败，请检查错误信息")
end

print("\n=== 单元测试结束 ===")
