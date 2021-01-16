VERSION = "1.4.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")

-- Returns Loc-tuple w/ current marked text or whole line (begin, end)
function getTextLoc()
    local v = micro.CurPane()
    local a, b, c = nil, nil, v.Cursor
    if c:HasSelection() then
        if c.CurSelection[1]:GreaterThan(-c.CurSelection[2]) then
            a, b = c.CurSelection[2], c.CurSelection[1]
        else
            a, b = c.CurSelection[1], c.CurSelection[2]
        end
    else
        local eol = string.len(v.Buf:Line(c.Loc.Y))
        a, b = c.Loc, buffer.Loc(eol, c.Y)
    end
    return buffer.Loc(a.X, a.Y), buffer.Loc(b.X, b.Y)
end

-- Returns the current marked text or whole line
function getText(a, b)
    local txt, buf = {}, micro.CurPane().Buf

    -- Editing a single line?
    if a.Y == b.Y then
        return buf:Line(a.Y):sub(a.X+1, b.X)
    end

    -- Add first part of text selection (a.X+1 as Lua is 1-indexed)
    table.insert(txt, buf:Line(a.Y):sub(a.X+1))

    -- Stuff in the middle
    for lineNo = a.Y+1, b.Y-1 do
        table.insert(txt, buf:Line(lineNo))
    end

    -- Insert last part of selection
    table.insert(txt, buf:Line(b.Y):sub(1, b.X))

    return table.concat(txt, "\n")
end

function encrypt()
    local v = micro.CurPane()
    local a, b = getTextLoc()
    local oldTxt = getText(a,b)
    local newTxt, err = shell.ExecCommand("bash", "-c", "echo " .. "'" .. oldTxt .. "'" .. " | gpg -c -a --quiet")

    if err ~= nil then
        micro.InfoBar():Error(err)
    else
        v.Buf:Replace(a, b, newTxt)
    end
end

function decrypt()
    local v = micro.CurPane()
    local a, b = getTextLoc()
    local oldTxt = getText(a,b)
    local newTxt, err = shell.ExecCommand("bash", "-c", "echo " .. "'" .. oldTxt .. "'" .. " | gpg -d --quiet")

    if err ~= nil then
        micro.InfoBar():Error(err)
    else
        v.Buf:Replace(a, b, newTxt)
    end
end

function init()
    config.MakeCommand("encrypt", encrypt, config.NoComplete)
    config.MakeCommand("decrypt", decript, config.NoComplete)
    config.TryBindKey("F11", "lua:crypto.encrypt", false)
    config.TryBindKey("F12", "lua:crypto.decrypt", false)
end
