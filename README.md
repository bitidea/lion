# Lion

一个功能强大的Lua工具库，提供 100+ 个实用函数，涵盖字符串处理、时间转换、表操作、URL处理、进制转换、数据库操作等多个领域。

## 特性

- 🚀 **轻量级**: 纯Lua实现，无外部依赖
- 📦 **功能丰富**: 100+ 个实用函数
- 🧪 **测试完善**: 98 个单元测试，100% 通过率
- 🌍 **跨平台**: 支持 Windows/Linux/macOS
- 🔧 **易于使用**: 简洁的 API 设计

## 功能分类

### 1. 数字格式化
- `formatNumberToWan(num)` - 数字格式化为万单位

### 2. 字符串处理
- `stringSplit(fullString, separator)` - 字符串分割
- `trimString(str)` - 删除字符串内所有空格
- `trimSpace(str)` - 去除首尾空白（空格、制表等）
- `subString(inputstr, len)` - 按字符数截取字符串（支持中文）
- `getStringLen(inputstr)` - 计算字符串显示长度（中文算 2）
- `cutStringLast(str)` - 删除最后一个字符
- `findString(str, findStr)` - 查找子串
- `isStringEmpty(str)` - 检查字符串是否为空

### 3. 符号检查
- `checkSymbol(str)` - 检查字符串中是否带有标点符号
- `replaceSymbol(str)` - 替换特殊符号
- `checkUnlawfulString(str)` - 检查非法字符串
- `checkTableUnlawfulString(args)` - 检查表中的非法字符串

### 4. 身份证验证
- `checkIdCard(str)` - 身份证号码验证
- `getIdCardAge(data)` - 根据身份证获取年龄

### 5. 随机字符串生成
- `getRandomAscII(len)` - 生成随机 ASCII 字符串
- `getRandomNumString(len)` - 生成随机数字字符串

### 6. 表操作
- `tableRemoveAll(tab, removeValues)` - 删除表中指定值
- `tableDuplicate(tab)` - 表去重
- `countTable(tab)` - 计算表元素个数
- `isTableEmpty(tab)` - 检查表是否为空
- `isExistsInTable(list, value)` - 检查值是否在表中
- `compareTable(tab1, tab2)` - 比较两个表是否相同
- `deepCopy(st)` - 深拷贝表
- `showTable(tab, space)` - 打印表内容
- `removeFromTable(src, vals)` - 从表中删除指定值

### 7. Emoji处理
- `hasEmoji(inputstr)` - 检查是否包含emoji
- `hasEmojiPro(inputstr)` - 专业版 emoji 检查
- `emojiPos(inputstr)` - 获取 emoji 位置
- `deleteEmojiFromString(str)` - 从字符串中删除 emoji

### 8. 字符串/表转换（命名风格：源To目标）
- `stringToTable(str)` - 字符串按 UTF-8 字符拆成表
- `tableToString(tab, separator)` - 表用分隔符拼成字符串
- `stringToArray(str, separator)` - 字符串按分隔符拆成数组（等同 stringSplit）

### 9. Unicode/UTF-8 转换
- `unicodeToUtf8(str)` - \uXXXX 转义串转 UTF-8
- `utf8ToUnicode(str)` - UTF-8 转 \uXXXX 转义串
- `htmlEntitiesToUtf8(str)` - HTML 数字实体（&#123;）转 UTF-8

### 10. 时间处理
- `secToDate(second)` - 秒数/时间戳转日期时间字符串（"YYYY-MM-DD HH:MM:SS"）
- `dateToSec(date)` - 日期字符串转秒数
- `stringTimeToDateTime(stringTime)` - 字符串时间转日期时间表
- `secToDateTime(second)` - 秒数转日期时间表
- `dateTimeToStringTime(dateTime)` - 日期时间表转字符串
- `compareTime(time1, time2)` - 比较时间
- `ifTimeInZone(time, startTime, endTime)` - 检查时间是否在范围内
- `isSameDay(time1, time2)` - 检查是否同一天
- `overOneDay(date)` - 检查是否超过一天
- `getTime(time)` - 获取时间
- `getDate(time)` - 获取日期
- `getTimeRaw(time)` - 获取原始时间

### 11. 类型转换
- `numToBool(num)` - 数字转布尔值
- `stringToBool(str)` - 字符串转布尔值
- `toInt(val)` - 转换为整数
- `isNumber(num)` - 检查是否为数字
- `safeToNum(str)` - 安全转换为数字
- `safeTableToNum(tab)` - 表安全转换为数字

### 12. URL处理
- `urlEncode(s)` - URL 编码
- `urlDecode(s)` - URL 解码
- `tableToUrl(tab, split, symbol)` - 表转 URL 参数
- `urlToTable(url)` - URL 转表
- `urlParamToTable(url, split, symbol)` - URL 参数转表
- `urlParamToTableToNum(url)` - URL 参数转数字表
- `urlParamToItemStruct(url)` - URL 参数转结构体

### 13. 排序算法
- `bubbleSort(tab, key)` - 冒泡排序
- `antiBubbleSort(tab, key)` - 反向冒泡排序

### 14. IP地址处理
- `getIpAddressInfo(ipAddress)` - 获取 IP 地址信息

### 15. 进制转换
- `binToHex(s)` - 二进制转十六进制
- `hexToBin(hexstr)` - 十六进制转二进制
- `strToHex(hex)` - 字符串转十六进制
- `hexToStr(str)` - 十六进制转字符串

### 16. XML/JSON处理
- `tableToXml(tab)` - 表转 XML
- `xmlToTable(text)` - XML 转表
- `tableToJson(tab)` - 表转 JSON
- `jsonToTable(text)` - JSON 转表
- `cjsonEncode(tab)` - CJSON 编码
- `cjsonDecode(text)` - CJSON 解码

### 17. 数据库操作
- `createInsertSQL(tableName, argsTable)` - 创建插入 SQL
- `createUpdateSQL(tableName, argsTable, whereTable)` - 创建更新 SQL
- `createFullUpdateSQL(tableName, set, where)` - 创建完整更新 SQL
- `createDeleteSQL(tableName, whereTable)` - 创建删除SQL
- `createSelectSQL(tableName, fields, whereTable)` - 创建查询 SQL
- `createFullSelectSQL(tableName, fields, where)` - 创建完整查询 SQL
- `createReplaceSQL(tableName, argsTable)` - 创建替换SQL
- `dbSafeCheck(sqlres)` - 数据库安全检查

### 18. Redis操作
- `redisTableToLuaTable(res)` - Redis 表转 Lua表
- `redisTableToLuaTable2(res)` - Redis 表转 Lua 表（版本 2）

### 19. 文件操作
- `readFile(path)` - 读取文件
- `writeFile(fileName, logHead, str)` - 写入文件
- `getFilePath(filename)` - 获取文件路径
- `getFileName(filename)` - 获取文件名
- `getFileNameWithoutExtension(filename)` - 获取无扩展名文件名
- `getFileExtension(filename)` - 获取文件扩展名

### 20. 日志记录
- `writeLog(fileName, ...)` - 写入日志
- `writeMsgLog(fileName, ...)` - 写入消息日志

### 21. 性能监控
- `startStopWatch()` - 开始计时
- `stopStopWatch(stopWatch, text)` - 停止计时
- `showDebugStack()` - 显示调试堆栈

### 22. 其他工具
- `isSuccess(successRate)` - 检查成功率
- `makeWxSign(args, key)` - 生成微信签名
- `getFakeRandomUserCode(userID)` - 生成伪随机用户码
- `getUserIDByCode(code)` - 根据伪随机号推算userID

## 安装

### 方法1: 直接复制
```bash
# 将lion.lua复制到你的项目目录
cp lion.lua /path/to/your/project/
```

### 方法2: 使用LuaRocks（如果支持）
```bash
luarocks install lion
```

## 使用方法

### 基本使用
```lua
local lion = require("lion")

-- 数字格式化
local result = lion.formatNumberToWan(15000)
print(result)  -- 输出: "1万"

-- 字符串分割
local parts = lion.stringSplit("a,b,c", ",")
print(parts[1])  -- 输出: "a"

-- 时间转换
local timestamp = lion.dateToSec("2021-01-01 00:00:00")
local dateStr = lion.secToDate(timestamp)
print(dateStr)  -- 输出: "2021-01-01 00:00:00"

-- 表操作
local tab = {1, 2, 3, 2, 1}
local uniqueTab = lion.tableDuplicate(tab)
print(#uniqueTab)  -- 输出: 3

-- URL编码
local encoded = lion.urlEncode("你好世界")
print(encoded)  -- 输出编码后的字符串
```

### 高级使用
```lua
-- 身份证验证
local isValid = lion.checkIdCard("11010519491231002X")
if isValid then
    local age = lion.getIdCardAge("11010519491231002X")
    print("年龄:", age)
end

-- Emoji处理
local text = "Hello 😊 World"
if lion.hasEmoji(text) then
    local cleanText = lion.deleteEmojiFromString(text)
    print(cleanText)  -- 输出: "Hello  World"
end

-- 数据库SQL生成
local insertSQL = lion.createInsertSQL("users", {
    name = "张三",
    age = 25,
    email = "zhangsan@example.com"
})
print(insertSQL)
-- 输出: INSERT INTO users (name, age, email) VALUES ('张三', 25, 'zhangsan@example.com')
```

## 测试

### 运行测试
```bash
# Windows（推荐 lua55.exe）
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
lua55.exe test_lion.lua

# Linux/macOS
lua test_lion.lua
```

### 测试结果
运行 `lua55.exe test_lion.lua`（Windows）或 `lua test_lion.lua`（Linux/macOS）后，将输出总测试数、通过数、失败数与通过率。当前约 98 个用例，通过率 100%。

## 依赖

- Lua 5.1 或更高版本
- 可选: cjson（用于JSON处理）

## 贡献

欢迎提交Issue和Pull Request！

### 开发流程
1. Fork本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个Pull Request

### 代码规范
- **命名约定**：函数与参数使用 camelCase；转换类 API 使用「源To目标」风格（如 `secToDate`、`stringToTable`、`tableToJson`）
- 遵循现有代码风格
- 添加适当注释
- 为新功能编写测试用例
- 确保所有测试通过

## 许可证

MIT License

## 常见问题

### Q: 如何处理中文乱码？
A: 在 Windows PowerShell 中运行测试前，设置输出编码为UTF-8：
```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
```

### Q: 时间戳转换不准确？
A: 确保使用服务器本地时区，不要硬编码特定时区的时间戳。

### Q: 如何添加新功能？
A: 在 lion.lua 中添加函数，并在 test_lion.lua 中添加对应的测试用例。