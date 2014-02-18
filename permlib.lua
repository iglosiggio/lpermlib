return function (db)
    if type(db) == "table" then
        local function checkPerm(uid, comando)
            local data = db[uid]
            if type(data) == "boolean" then -- Si es booleano devuelvo el valor
                return data
            elseif type(data) == "string" then -- Si es cadena devuelvo la indirección
                return checkPerm(data, comando)
            elseif type(data) == "table" then -- Si es tabla...
                local indirection = data[1]
                if type(data[comando]) ~= "nil" then -- ... y está contenido devuelvo el valor
                    return data[comando]
                elseif type(db[indirection]) ~= "nil" then -- ... y no está contenido pero hay una indirección la chequeo
                    return checkPerm(indirection, comando)
                else -- ... y no está contenido ni hay una indirección entonces no se puede realizar
                    return false
                end
            elseif type(data) == "function" and data ~= checkPerm then -- Si es una función distinta a esta la uso como reemplazo
                return data(uid, comando)
            elseif type(data) == "nil" then -- Si es nulo me remito al "default"
                return checkPerm("default", comando)
            else -- Algo raro pasó acá...
                return false
            end
        end
        return checkPerm
    else
        return "Argument is not of type \"table\""
    end
end