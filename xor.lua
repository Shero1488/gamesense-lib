local xor = {}

function xor.encrypt(data, key)
    if type(data) == "number" then
        data = tostring(data)
    end

    if type(key) == "string" then
        key = string.byte(key, 1)
    end

    local encrypted_data = ""
    for i = 1, #data do
        local char_code = string.byte(data, i)
        local encrypted_char_code = bit.bxor(char_code, key)
        encrypted_data = encrypted_data .. string.char(encrypted_char_code)
    end
    return encrypted_data
end

function xor.decrypt(encrypted_data, key)
    if type(key) == "string" then
        key = string.byte(key, 1)
    end

    local decrypted_data = ""
    for i = 1, #encrypted_data do
        local char_code = string.byte(encrypted_data, i)
        local decrypted_char_code = bit.bxor(char_code, key)
        decrypted_data = decrypted_data .. string.char(decrypted_char_code)
    end
    return decrypted_data
end

return xor