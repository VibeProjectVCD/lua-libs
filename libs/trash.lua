--[[
    lua-lib

    unused func
]]--


function random_string(length)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    if length <= 0 then
        error("Length must be a positive integer.") -- we shall return -10 random length
        return ""
    end
    
    math.randomseed(tick())
    
    local function randomchar()
        local index = math.random(1, #charset)
        return charset:sub(index, index)
    end
    
    local randomresult = ""
    for i = 1, length do
        randomresult = randomresult .. randomchar()
    end
    
    return randomString
end

-- base64 // not my implementation

local basedummy = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function base64_fake_encode(data)
    return ((data:gsub('.', function(x) 
        local r, b = '', x:byte()
        for i = 8, 1, -1 do r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0') end
        return r
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c = 0
        for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0) end
        return b:sub(c + 1, c + 1)
    end) .. ({ '', '==', '=' })[#data % 3 + 1])
end

function base64_fake_decode(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c = 0
        for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
        return string.char(c)
    end))
end

crypt, base64 = {}, {}

crypt.base64encode = function(arg1)
   return base64encode(arg1)
end

crypt.base64decode = function(arg2)
   return base64decode(arg2)
end

crypt.base64_encode = function(arg1)
   return base64encode(arg1)
end

crypt.base64_decode = function(arg2)
   return base64decode(arg2)
end

crypt.base64 = {}
crypt.base64.encode = function(enc)
   return base64encode(enc)
end

crypt.base64.decode = function(stop_making_me_Write_this)
    return base64decode(stop_making_me_Write_this)
end

base64.encode = function(vanity)
   return base64encode(vanity)
end

base64.decode = function(vanity)
   return base64decode(vanity)
end

base64_encode = function(vanity)
   return base64encode(vanity)
end

base64_decode = function(vanity)
   return base64decode(vanity)
end

crypt.generatebytes = function(size)
    local randomBytes = {}
    for i = 1, size do
        randomBytes[i] = string.char(math.random(0, 255))
    end
    local byteString = table.concat(randomBytes)
    return base64encode(byteString)
end

crypt.generatekey = function()
    return crypt.generatebytes(32)
end

-- ill just admit it these are placeholders - meaning i gotta add actual function so ill add them later
function crypt.encrypt(data, key, iv, mode)
    local iv = iv or crypt.generatebytes(16)  
    local encrypted = "encrypted_" .. data
    return encrypted, iv
end

function crypt.decrypt(data, key, iv, mode)
    local decrypted = string.gsub(data, "^encrypted_", "")
    return decrypted
end
