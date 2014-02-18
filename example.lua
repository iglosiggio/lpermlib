test = {
    default = {                                 -- True, False
        ["true"] = true,
        ["false"] = false
    },
    test_bool_true = true,                      -- True, True
    test_bool_false = false,                    -- False, False
    test_nil = nil,                             -- True, False
    test_indirect_table = {                     -- True, True
        "default",
        ["false"] = true
    },
    test_string2Tbool = "test_bool_true",       -- True, True
    test_string2Fbool = "test_bool_false",      -- False, False
    test_string2string = "test_string2Tbool",   -- True, True
    test_string2table = "default"               -- True, False
}

permlib = require("permlib") -- Require library
test.checkPerm = permlib(test) -- Init it on a table, in this case i also put it on the table

for k,_ in pairs(test) do
    print(k)
    print(test.checkPerm(k,"true"), test.checkPerm(k, "false")) -- Enjoy!
end
print("test_nil")
print(test.checkPerm("test_nil", "true"), test.checkPerm("test_nil", "false"))