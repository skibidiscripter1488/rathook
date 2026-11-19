local _ky50q837=(177+53)
local function _crqcum82(s)
local o={}
for i=1,#s do
o[i]=string.char(bit32.bxor(string.byte(s,i),(_ky50q837+((i-1)*7))%256))
end
return table.concat(o)
end
local _DEOBF_NOTICE = _crqcum82("\178\133\157\136\034\096\099\055\113\075\064\074\026\053\032\042\118\017\011\010\022\028\242\167\249\253\245\192\194\145\208\222\181\237\186\180\194\159\145\155\139\096\032\051\105\078\008\086\089\072\100\060\051\042\020\002\010\085\005\236\255\227\184\235\207\192\209")
local __lpAt = 0
local function __lpFatal(err)
    local firstLine = string.match(tostring(err), _crqcum82("\184\182\170\246\008\084\058")) or _crqcum82("")
    local text = _crqcum82("\170\152\149\171\112\102\100\114\125\081\012\080\085\052\036\043\118\051\011\031\082\010\244\230\252\225\166\131") .. string.sub(firstLine, 1, 220) .. (__lpAt > 0 and (_crqcum82("\198\197\151\147\103\106\123\103\113\076\066\071\026") .. __lpAt .. _crqcum82("\207")) or _crqcum82("")) .. _crqcum82("\198\192\212\139\110\108\113\100\123\005\094\086\023\036\048\042\053\040\016\014\082\013\232\226\174\230\255\209\195\193\204\145")
    pcall(warn, _crqcum82("\189\161\129\154\082\123\127\099\123\070\088\110\026") .. text)
    pcall(function()
        local parent = nil
        if gethui then pcall(function() parent = gethui() end) end
        parent = parent or game:GetService(_crqcum82("\165\130\134\158\069\124\121"))
        local gui = Instance.new(_crqcum82("\181\142\134\158\103\103\087\098\119"))
        gui.Name = _crqcum82("\170\152\149\171\112\102\100\114\125\081\106\082\078\032\036")
        gui.ResetOnSpawn = false
        gui.DisplayOrder = 30
        local box = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
        box.AnchorPoint = Vector2.new(1, 1)
        box.Position = UDim2.new(1, -16, 1, -16)
        box.Size = UDim2.new(0, 340, 0, 0)
        box.AutomaticSize = Enum.AutomaticSize.Y
        box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        box.TextColor3 = Color3.fromRGB(255, 120, 120)
        box.TextWrapped = true
        box.TextXAlignment = Enum.TextXAlignment.Left
        box.TextSize = 14
        box.Font = Enum.Font.Code
        box.Text = text
        box.Parent = gui
        gui.Parent = parent
        task.delay(15, function() gui:Destroy() end)
    end)
end
local __lpOk, __lpErr = xpcall(function()
local LP_T0 = os.clock()
local LP_TIMING = false
pcall(function() LP_TIMING = getgenv and getgenv().LUAPROTECT_TIMING == true or false end)
local function safeGenv()
    if not getgenv then return nil end
    local ok, g = pcall(getgenv)
    if ok and type(g) == _crqcum82("\146\140\150\151\103") then return g end
    return nil
end
local _FENV_USABLE = nil
local function safeFenv(level)
    if not getfenv then return nil, _crqcum82("\149\140\154\159\096\102\104\114\122") end
    if _FENV_USABLE == false then return nil, _crqcum82("\149\140\154\159\096\102\104\114\122") end
    local lvl = level or 1
    local ok, env = pcall(getfenv, lvl)
    if not ok then
        local msg = tostring(env):lower()
        if lvl > 1 and msg:find(_crqcum82("\143\131\130\154\110\096\116\055\114\064\090\086\086"), 1, true) then
            return nil, _crqcum82("\148\140\154\156\103")
        end
        _FENV_USABLE = false
        return nil, _crqcum82("\149\140\154\159\096\102\104\114\122")
    end
    _FENV_USABLE = true
    if type(env) == _crqcum82("\146\140\150\151\103") then return env, _crqcum82("\137\134") end
    return nil, _crqcum82("\137\134")
end
local _lpGenv0 = safeGenv()
local LP_LS0 = loadstring or (_lpGenv0 and _lpGenv0.loadstring)
local LP_LOAD0 = load or (_lpGenv0 and _lpGenv0.load)
local LP_COMPILE = LP_LS0 or LP_LOAD0 or loadstring or load
local LP_COMPILER = { jobs = {}, alive = true, lastBeat = os.clock() }
local lpCompileOffSandbox
local function lpWrapEnv(fn, chunkName)
    if type(setfenv) ~= _crqcum82("\128\152\154\152\118\096\127\121") or type(getfenv) ~= _crqcum82("\128\152\154\152\118\096\127\121") then return end
    local okE, base = pcall(getfenv, fn)
    if not okE or type(base) ~= _crqcum82("\146\140\150\151\103") then return end
    local function sub(src, name, ...)
        if type(src) == _crqcum82("\149\153\134\146\108\110") and coroutine.running() ~= LP_COMPILER.thread then
            local job = lpCompileOffSandbox(src, type(name) == _crqcum82("\149\153\134\146\108\110") and name ~= _crqcum82("") and name or chunkName)
            if job then
                if job.ok then return job.fn, job.err end
                return nil, tostring(job.fn)
            end
        end
        local orig = base.loadstring or base.load
        if orig then return orig(src, name, ...) end
        return nil, _crqcum82("\138\130\149\159\113\125\098\126\112\066\004\026\026\040\059\111\056\050\016\075\019\015\225\238\226\244\254\207\207")
    end
    local env = setmetatable({ loadstring = sub, load = sub }, {
        __index = base,
        __newindex = function(_, k, v) base[k] = v end,
    })
    pcall(setfenv, fn, env)
end
pcall(function()
    task.spawn(function()
        LP_COMPILER.thread = coroutine.running()
        while LP_COMPILER.alive do
            LP_COMPILER.lastBeat = os.clock()
            local job = table.remove(LP_COMPILER.jobs, 1)
            while job do
                job.picked = true
                local okC, fnC, errC = pcall(LP_COMPILE or loadstring, job.src, job.name)
                if okC and type(fnC) == _crqcum82("\128\152\154\152\118\096\127\121") then pcall(lpWrapEnv, fnC, job.name) end
                job.ok, job.fn, job.err = okC, fnC, errC
                job.done = true
                job = table.remove(LP_COMPILER.jobs, 1)
            end
            if LP_COMPILER.needed == false then LP_COMPILER.alive = false break end
            if LP_COMPILER.stale and LP_COMPILER.stale() then LP_COMPILER.alive = false break end
            task.wait()
        end
    end)
end)
local function lpProbeSandboxed()
    local okP, sandboxed = pcall(function()
        local f = (LP_COMPILE or loadstring)(_crqcum82("\138\130\151\154\110\041\127\124\082\005\017\019\074\034\041\035\058\117\008\004\019\029\243\243\252\252\242\196\134\145\159\205\163\185\161\169\140\201\193\208\215\037\126\118\110\084\090\065\022\082\047\007\126\121\063\056\034\037\035\197\193\177\230\162\134\195\221\215"), _crqcum82("\219\129\132\139\112\102\114\114"))
        if type(f) ~= _crqcum82("\128\152\154\152\118\096\127\121") then return false end
        local okRun, okL, hasFK = pcall(f)
        if not okRun then return false end 
        if not okL then return true end 
        local ge = safeGenv()
        local published = (ge and ge.__LP_FK ~= nil) or (_G ~= nil and _G.__LP_FK ~= nil)
        return published and not hasFK
    end)
    return okP and sandboxed == true
end
lpCompileOffSandbox = function(src, name)
    local c = LP_COMPILER
    if c.needed == nil then
        c.needed = lpProbeSandboxed()
        if not c.needed then c.alive = false end
    end
    if not c.needed then return nil end
    if not c.alive or os.clock() - c.lastBeat > 2 then return nil end
    local job = { src = src, name = name }
    c.jobs[#c.jobs + 1] = job
    local queuedAt = os.clock()
    while not job.done do
        if not job.picked and os.clock() - queuedAt > 3 then
            for i, j in ipairs(c.jobs) do if j == job then table.remove(c.jobs, i) break end end
            return nil
        end
        if os.clock() - queuedAt > 90 then return nil end
        task.wait()
    end
    return job
end
local function closureLooksHooked(fn)
    if type(fn) ~= _crqcum82("\128\152\154\152\118\096\127\121") then return false end
    local okL, isL = pcall(function() return islclosure ~= nil and islclosure(fn) end)
    if okL and isL == true then return true, _crqcum82("\143\158\152\152\110\102\099\098\108\064") end
    local okC, isC = pcall(function()
        if iscclosure == nil then return nil end
        return iscclosure(fn)
    end)
    if okC and isC == false then return true, _crqcum82("\143\158\151\152\110\102\099\098\108\064\017\085\091\045\059\042") end
    return false
end
local function detectTamper()
    local flagged, reason = false, nil
    pcall(function()
        local hooked, why = closureLooksHooked(LP_COMPILE)
        if hooked then flagged, reason = true, why end
    end)
    return flagged, reason
end
local LP_MARKS, LP_TRACE, LP_PERF_SENT = {}, {}, false
local LP_NET = { tries = 0, netMs = 0, keyMs = 0, t0 = os.clock(), trail = {} }
function LP_NET.note(what)
    local t = LP_NET.trail
    t[#t + 1] = _crqcum82("\205") .. tostring(math.floor(os.clock() - LP_NET.t0)) .. _crqcum82("\149\205") .. tostring(what):gsub(_crqcum82("\195\158\223"), _crqcum82("\198")):sub(1, 160)
    if #t > 8 then table.remove(t, 1) end
end
local LP_DEC = { ms = 0 }
LP_DEC.gc = function()
    pcall(task.spawn, function()
        for _ = 1, 40 do
            local ok, done = pcall(collectgarbage, _crqcum82("\149\153\145\139"), 64)
            if not ok or done then break end
            task.wait()
        end
    end)
end
local function lpMark(label)
    local ms = (os.clock() - LP_T0) * 1000
    if LP_MARKS[label] == nil then LP_MARKS[label] = ms end
    if #LP_TRACE < 24 then LP_TRACE[#LP_TRACE + 1] = { label, ms } end
    if LP_TIMING then
        local kb = 0
        pcall(function() kb = collectgarbage(_crqcum82("\133\130\129\149\118")) end)
        local line = string.format(_crqcum82("\189\161\129\154\082\123\127\099\123\070\088\110\026\100\101\125\102\046\068\078\074\087\177\225\174\248\239\131\138\217\221\222\182\237\241\236\204\216\150\215\179\071"), label, ms, kb / 1024)
        print(line)
        pcall(function()
            if not appendfile then return end
            if isfile and not isfile(_crqcum82("\138\152\149\139\112\102\100\114\125\081\001\071\083\044\033\033\049\115\016\019\006")) and writefile then writefile(_crqcum82("\138\152\149\139\112\102\100\114\125\081\001\071\083\044\033\033\049\115\016\019\006"), _crqcum82("")) end
            appendfile(_crqcum82("\138\152\149\139\112\102\100\114\125\081\001\071\083\044\033\033\049\115\016\019\006"), line .. _crqcum82("\236"))
        end)
    end
end
local LP_FRAMES = { base = {}, n = 0, last = os.clock(), win = nil, conn = nil }
pcall(function()
    LP_FRAMES.conn = game:GetService(_crqcum82("\180\152\154\168\103\123\102\126\125\064")).Heartbeat:Connect(function()
        local now = os.clock()
        local dt = (now - LP_FRAMES.last) * 1000
        LP_FRAMES.last = now
        local win = LP_FRAMES.win
        if win then return win(dt, now) end
        local b = math.min(100, math.floor(dt / 2))
        LP_FRAMES.base[b] = (LP_FRAMES.base[b] or 0) + 1
        LP_FRAMES.n = LP_FRAMES.n + 1
    end)
    task.delay(180, function()
        if not LP_FRAMES.win and LP_FRAMES.conn then LP_FRAMES.conn:Disconnect() end
    end)
end)
lpMark(_crqcum82("\149\136\128\142\114\041\033"))
local HttpService  = game:GetService(_crqcum82("\174\153\128\139\081\108\098\097\119\070\073"))
local jsonEncodeMethod = HttpService.JSONEncode
local function encodeJSON(data)
    if type(jsonEncodeMethod) == _crqcum82("\128\152\154\152\118\096\127\121") then
        return jsonEncodeMethod(HttpService, data)
    end
    return HttpService:JSONEncode(data)
end
local TweenService = game:GetService(_crqcum82("\178\154\145\158\108\090\117\101\104\076\079\086"))
local CoreGui      = game:GetService(_crqcum82("\165\130\134\158\069\124\121"))
local Players      = game:GetService(_crqcum82("\182\129\149\130\103\123\099"))
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    while not Players.LocalPlayer do
        task.wait()
    end
    LocalPlayer = Players.LocalPlayer
end
local username = LocalPlayer.Name
local userId   = LocalPlayer.UserId
local placeId  = game.PlaceId
local jobId    = game.JobId
local gameId   = game.GameId
local _CFG = {}
pcall(function()
    _CFG = (typeof(_LP_CONFIG) == _crqcum82("\146\140\150\151\103") and _LP_CONFIG)
        or (typeof(_LP_RUNNER_CONFIG) == _crqcum82("\146\140\150\151\103") and _LP_RUNNER_CONFIG)
        or (typeof(getgenv) == _crqcum82("\128\152\154\152\118\096\127\121") and getgenv()._LP_RUNNER_CONFIG)
        or (typeof(shared) == _crqcum82("\146\140\150\151\103") and shared._LP_RUNNER_CONFIG)
        or (typeof(_G) == _crqcum82("\146\140\150\151\103") and _G._LP_RUNNER_CONFIG)
        or (typeof(getrenv) == _crqcum82("\128\152\154\152\118\096\127\121") and getrenv()._LP_RUNNER_CONFIG)
        or {}
end)
pcall(function() if typeof(getgenv) == _crqcum82("\128\152\154\152\118\096\127\121") then getgenv()._LP_RUNNER_CONFIG = nil end end)
pcall(function() if typeof(shared) == _crqcum82("\146\140\150\151\103") then shared._LP_RUNNER_CONFIG = nil end end)
pcall(function() if typeof(_G) == _crqcum82("\146\140\150\151\103") then _G._LP_RUNNER_CONFIG = nil end end)
local function cfgv(name, ph)
    local marker = _crqcum82("\157\150") .. name .. _crqcum82("\155\144")
    local v = _CFG[name]
    if v ~= nil and v ~= _crqcum82("") and v ~= marker then return tostring(v) end
    if ph ~= nil and ph ~= _crqcum82("") and ph ~= marker then return ph end
    return nil
end
local HOST_URL = cfgv(_crqcum82("\174\162\167\175\093\092\066\091"), "https://exec.luaprotect.dev") or _crqcum82("\142\153\128\139\113\051\063\056\123\093\073\080\020\045\061\046\038\047\011\031\023\026\244\169\234\240\234")
local WS_URL = cfgv(_crqcum82("\177\190\171\174\080\069"), "wss://exec.luaprotect.dev/ws") or _crqcum82("\145\158\135\193\045\038\117\111\123\070\002\095\079\032\056\061\057\041\001\008\006\087\228\226\248\186\235\208")
local WS_HOSTS, wsHostIndex, WS_SCHEME = {}, 1, _crqcum82("\145\158\135")
do
    local scheme, primary = WS_URL:match(_crqcum82("\184\197\131\136\113\054\057\045\049\010\004\104\100\110\114\018\125\116"))
    if scheme and primary and primary:match(_crqcum82("\195\195\152\142\099\121\098\120\106\064\079\071\031\111\044\042\032\121")) and not primary:find(_crqcum82("\149\153\149\156\107\103\119"), 1, true) then
        WS_SCHEME = scheme
        WS_HOSTS[1] = primary
        for _, h in ipairs({ _crqcum82("\131\149\145\152\044\101\101\118\110\087\067\071\095\034\060\097\050\056\018"), _crqcum82("\135\157\157\213\110\124\113\103\108\074\088\086\089\053\102\043\051\043"), _crqcum82("\133\137\154\213\110\124\113\103\108\074\088\086\089\053\102\043\051\043") }) do
            if h ~= primary then WS_HOSTS[#WS_HOSTS + 1] = h end
        end
    end
end
local function rotateWsHost()
    if #WS_HOSTS < 2 then return end
    wsHostIndex = wsHostIndex % #WS_HOSTS + 1
    WS_URL = WS_SCHEME .. _crqcum82("\220\194\219") .. WS_HOSTS[wsHostIndex] .. _crqcum82("\201\154\135")
end
local function rotateApiHost()
    if #WS_HOSTS < 2 then return end
    if not HOST_URL:match(_crqcum82("\184\133\128\143\114\122\042\056\049\126\009\068\031\111\109\098\011\118\065\069\030\012\225\247\252\250\232\198\201\197\157\145\162\168\162\255")) or HOST_URL:find(_crqcum82("\149\153\149\156\107\103\119"), 1, true) then return end
    rotateWsHost()
    HOST_URL = _crqcum82("\142\153\128\139\113\051\063\056") .. WS_HOSTS[wsHostIndex]
end
local SCRIPT_ID = cfgv(_crqcum82("\181\174\166\178\082\093\079\094\090"), "1_rQjbldjgp80dMJ") or _crqcum82("")
local SCRIPT_NAME = cfgv(_crqcum82("\181\174\166\178\082\093\079\089\095\104\105"), "rat.hook") or _crqcum82("")
local IS_TELEPORT_RECONNECT = ((_CFG.CONTINUOUS_RECONNECT ~= nil and _CFG.CONTINUOUS_RECONNECT ~= _crqcum82("")) and _CFG.CONTINUOUS_RECONNECT or "0") == _crqcum82("\215")
local HANDOFF_RUNNER_ID = cfgv(_crqcum82("\174\172\186\191\077\079\086\072\076\112\098\125\127\019\023\006\018"), "") or _crqcum82("")
local HANDOFF_KEY = cfgv(_crqcum82("\174\172\186\191\077\079\086\072\085\096\117"), "") or _crqcum82("")
local HANDOFF_RUN_ID = cfgv(_crqcum82("\174\172\186\191\077\079\086\072\076\112\098\108\115\005"), "") or _crqcum82("")
local HANDOFF_SESSION_ID = cfgv(_crqcum82("\174\172\186\191\077\079\086\072\077\096\127\096\115\014\006\016\031\025"), "") or _crqcum82("")
local SECRET_KEY = cfgv(_crqcum82("\180\184\186\181\071\091\079\092\091\124"), "f22a86589d655bd46f783d9761d418c8253becd147c69d3f61cf96173d5e58e9") or _crqcum82("")
local RUNNER_ID = cfgv(_crqcum82("\180\184\186\181\071\091\079\094\090"), "671afb9c8c26a0f236683ac61b862e2e") or _crqcum82("")
local KEY_FLOW_URL = cfgv(_crqcum82("\173\168\173\164\068\069\095\064\065\112\126\127"), "") or _crqcum82("")
local DISCORD_INVITE = cfgv(_crqcum82("\162\164\167\184\077\091\084\072\087\107\122\122\110\004"), "") or _crqcum82("")
local label       = (SCRIPT_NAME ~= _crqcum82("") and SCRIPT_NAME ~= "rat.hook") and SCRIPT_NAME or _crqcum82("\170\152\149\139\112\102\100\114\125\081")
local function getGuiParent()
    local parentGui = nil
    if gethui then
        pcall(function()
            local hui = gethui()
            if hui and hui.FindFirstChild then parentGui = hui end
        end)
    end
    if not parentGui then
        pcall(function()
            if CoreGui and CoreGui.FindFirstChild then parentGui = CoreGui end
        end)
    end
    if not parentGui then
        pcall(function()
            if LocalPlayer and LocalPlayer.FindFirstChild then
                parentGui = LocalPlayer:FindFirstChild(_crqcum82("\182\129\149\130\103\123\087\098\119")) or LocalPlayer:WaitForChild(_crqcum82("\182\129\149\130\103\123\087\098\119"), 5)
            end
        end)
    end
    return parentGui or CoreGui
end
local function cleanupExistingGui(name)
    pcall(function()
        local parents = {}
        if CoreGui then table.insert(parents, CoreGui) end
        if LocalPlayer then
            local pg = LocalPlayer:FindFirstChild(_crqcum82("\182\129\149\130\103\123\087\098\119"))
            if pg then table.insert(parents, pg) end
        end
        if gethui then
            pcall(function()
                local hui = gethui()
                if hui and hui ~= CoreGui then table.insert(parents, hui) end
            end)
        end
        for _, p in ipairs(parents) do
            local found = p:FindFirstChild(name)
            while found do
                found:Destroy()
                found = p:FindFirstChild(name)
            end
        end
    end)
end
cleanupExistingGui(_crqcum82("\170\152\149\171\112\102\100\114\125\081\103\086\067\020\001"))
cleanupExistingGui(_crqcum82("\170\152\149\171\112\102\100\114\125\081\104\090\073\034\039\061\050\017\013\005\025"))
cleanupExistingGui(_crqcum82("\170\152\149\171\112\102\100\114\125\081\109\093\084\046\061\033\053\056\009\014\028\013\199\242\231"))
cleanupExistingGui(_crqcum82("\170\152\149\171\112\102\100\114\125\081\111\092\084\050\039\035\051\019\011\031\027\031\233\228\239\225\245\204\196\194"))
local announcementSerial = 0
local BQ = {} 
local BP = {} 
local LPS = { pending = {}, subs = {}, seq = 0 }
do
    local Storage = {}
    local function decodeValue(r)
        if type(r) ~= _crqcum82("\146\140\150\151\103") or r.value == nil then return nil end
        if r.encoding == _crqcum82("\147\153\146\195") and type(r.contentType) == _crqcum82("\149\153\134\146\108\110") and r.contentType:find(_crqcum82("\140\158\155\149"), 1, true) then
            local ok, v = pcall(HttpService.JSONDecode, HttpService, r.value)
            if ok then return v end
        end
        return r.value
    end
    local function request(msg, timeout)
        if not LPS.send then return nil, _crqcum82("\136\130\128\219\097\102\126\121\123\070\088\086\094"), _crqcum82("\168\162\160\164\065\070\094\089\091\102\120\118\126") end
        LPS.seq = LPS.seq + 1
        local id = tostring(LPS.seq)
        msg.type = _crqcum82("\149\153\155\137\099\110\117")
        msg.id = id
        local slot = { done = false }
        LPS.pending[id] = slot
        if not pcall(LPS.send, msg) then
            LPS.pending[id] = nil
            return nil, _crqcum82("\149\136\154\159\034\111\113\126\114\064\072"), _crqcum82("\181\168\186\191\093\079\081\094\082\096\104")
        end
        local deadline = os.clock() + (timeout or 15)
        while not slot.done and os.clock() < deadline do task.wait(0.03) end
        LPS.pending[id] = nil
        if not slot.done then return nil, _crqcum82("\146\132\153\158\109\124\100"), _crqcum82("\178\164\185\190\077\092\068") end
        local r = slot.result
        if type(r) ~= _crqcum82("\146\140\150\151\103") or r.ok ~= true then
            return nil, tostring(type(r) == _crqcum82("\146\140\150\151\103") and (r.message or r.error) or _crqcum82("\149\153\155\137\099\110\117\055\123\087\094\092\072")), type(r) == _crqcum82("\146\140\150\151\103") and r.error or nil
        end
        return r
    end
    local function args(first, ...)
        if first == Storage then return ... end
        return first, ...
    end
    function Storage.Get(...)
        local key = args(...)
        local r, err = request({ op = _crqcum82("\129\136\128"), key = tostring(key) })
        if not r then return nil, err end
        if not r.found then return nil end
        return decodeValue(r), { version = r.version, contentType = r.contentType, expiresAt = r.expiresAt, encoding = r.encoding }
    end
    local Player = {}
    local function pargs(first, ...)
        if first == Player then return ... end
        return first, ...
    end
    function Player.Get(...)
        local key = pargs(...)
        local r, err = request({ op = _crqcum82("\150\129\149\130\103\123\079\112\123\081"), key = tostring(key) })
        if not r then return nil, err end
        if not r.found then return nil end
        return decodeValue(r), { version = r.version, contentType = r.contentType, expiresAt = r.expiresAt }
    end
    function Player.List(...)
        local prefix = pargs(...)
        local r, err = request({ op = _crqcum82("\150\129\149\130\103\123\079\123\119\086\088"), prefix = prefix and tostring(prefix) or _crqcum82("") })
        if not r then return nil, err end
        return r.items or {}
    end
    Storage.Player = Player
    local Save = {}
    local function sargs(first, ...)
        if first == Save then return ... end
        return first, ...
    end
    function Save.Get(...)
        local name = sargs(...)
        local r, err = request({ op = _crqcum82("\149\140\130\158\093\110\117\099"), name = tostring(name) })
        if not r then return nil, err end
        if not r.found then return nil end
        return decodeValue(r)
    end
    function Save.Set(...)
        local name, value = sargs(...)
        local msg = { op = _crqcum82("\149\140\130\158\093\122\117\099"), name = tostring(name) }
        local t = type(value)
        if t == _crqcum82("\146\140\150\151\103") or t == _crqcum82("\136\152\153\153\103\123") or t == _crqcum82("\132\130\155\151\103\104\126") then
            msg.value = encodeJSON(value)
            msg.contentType = _crqcum82("\135\157\132\151\107\106\113\099\119\074\066\028\080\050\039\033")
        else
            msg.value = value == nil and _crqcum82("") or tostring(value)
            msg.contentType = _crqcum82("\146\136\140\143\045\121\124\118\119\075\023\019\089\041\041\061\037\056\016\086\007\013\230\170\182")
        end
        local r, err = request(msg)
        if not r then return false, err end
        return true
    end
    function Save.Delete(...)
        local name = sargs(...)
        local r, err = request({ op = _crqcum82("\149\140\130\158\093\109\117\123\123\081\073"), name = tostring(name) })
        if not r then return false, err end
        return r.deleted == true
    end
    function Save.List(...)
        local r, err = request({ op = _crqcum82("\149\140\130\158\093\101\121\100\106") })
        if not r then return nil, err end
        return r.items or {}, { used = r.used, limit = r.limit }
    end
    Storage.Save = Save
    function Storage.List(...)
        local prefix, cursor = args(...)
        local r, err = request({ op = _crqcum82("\138\132\135\143"), prefix = prefix and tostring(prefix) or _crqcum82(""), cursor = cursor })
        if not r then return nil, err end
        return r.items or {}, r.nextCursor
    end
    function Storage.Subscribe(...)
        local key, callback = args(...)
        key = key == nil and _crqcum82("") or tostring(key)
        if type(callback) ~= _crqcum82("\128\152\154\152\118\096\127\121") then return nil, _crqcum82("\133\140\152\151\096\104\115\124\062\072\089\064\078\097\042\042\118\060\068\013\007\023\227\243\231\250\242") end
        local list = LPS.subs[key]
        if not list then
            list = {}
            LPS.subs[key] = list
            task.spawn(request, { op = _crqcum82("\149\152\150\136\097\123\121\117\123"), key = key })
        end
        table.insert(list, callback)
        local conn = { Connected = true }
        function conn.Disconnect()
            if not conn.Connected then return end
            conn.Connected = false
            local l = LPS.subs[key]
            if not l then return end
            for i = #l, 1, -1 do if l[i] == callback then table.remove(l, i) end end
            if #l == 0 then
                LPS.subs[key] = nil
                task.spawn(request, { op = _crqcum82("\147\131\135\142\096\122\115\101\119\071\073"), key = key })
            end
        end
        conn.disconnect = conn.Disconnect
        return conn
    end
    LPS.dispatch = function(change)
        local key = tostring(change.key or _crqcum82(""))
        local value = decodeValue(change)
        if change.valueOmitted and change.op == _crqcum82("\149\136\128") then
            local r = request({ op = _crqcum82("\129\136\128"), key = key })
            if r and r.found then value = decodeValue(r) end
        end
        local evt = { key = key, op = change.op, value = value, version = change.version, expiresAt = change.expiresAt }
        for subKey, list in pairs(LPS.subs) do
            local hit = change.op == _crqcum82("\133\129\145\154\112") or key == subKey or ((subKey == _crqcum82("") or subKey:sub(-1) == _crqcum82("\201")) and key:sub(1, #subKey) == subKey)
            if hit then
                for _, cb in ipairs(list) do task.spawn(cb, evt) end
            end
        end
    end
    LPS.resubscribe = function()
        task.wait(2 + math.random() * 10)
        for key in pairs(LPS.subs) do
            local r = request({ op = _crqcum82("\149\152\150\136\097\123\121\117\123"), key = key })
            if not r then task.wait(2 + math.random() * 4); request({ op = _crqcum82("\149\152\150\136\097\123\121\117\123"), key = key }) end
        end
    end
    LPS.expose = function()
        pcall(function()
            for _, g in ipairs({ (getgenv and getgenv()) or false, shared or false, _G or false }) do
                if type(g) == _crqcum82("\146\140\150\151\103") then
                    g.LuaProtect = type(g.LuaProtect) == _crqcum82("\146\140\150\151\103") and g.LuaProtect or {}
                    g.LuaProtect.Storage = Storage
                end
            end
        end)
    end
end
local showAdminAnnouncement = (function(title, message, duration, colorHex, prefix, verified, ask, broadcastId, poll)
    duration = tonumber(duration) or 8
    BQ.onResult = nil
    BP.onResult = nil
    announcementSerial = announcementSerial + 1
    local serial = announcementSerial
    task.spawn(function()
        local parentGui = getGuiParent()
        if not parentGui then return end
        cleanupExistingGui(_crqcum82("\170\152\149\171\112\102\100\114\125\081\109\093\084\046\061\033\053\056\009\014\028\013\199\242\231"))
        local screenGui = Instance.new(_crqcum82("\181\142\134\158\103\103\087\098\119"))
        screenGui.Name = _crqcum82("\170\152\149\171\112\102\100\114\125\081\109\093\084\046\061\033\053\056\009\014\028\013\199\242\231")
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.DisplayOrder = 50
        pcall(function() if syn and syn.protect_gui then syn.protect_gui(screenGui) elseif protect_gui then protect_gui(screenGui) end end)
        screenGui.Parent = parentGui
        local fadeLayer = screenGui
        local layered = pcall(function()
            local group = Instance.new(_crqcum82("\165\140\154\141\099\122\087\101\113\080\092"))
            group.Name = _crqcum82("\167\131\154\148\119\103\115\114\115\064\066\071\124\032\044\042")
            group.BackgroundTransparency = 1
            group.Size = UDim2.new(1, 0, 1, 0)
            group.GroupTransparency = 1
            group.Parent = screenGui
            fadeLayer = group
        end)
        layered = layered and fadeLayer ~= screenGui
        local function fadeTo(value, time)
            if layered then
                TweenService:Create(fadeLayer, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    GroupTransparency = value
                }):Play()
            end
        end
        local nameColor = Color3.fromRGB(240, 65, 65)
        if type(colorHex) == _crqcum82("\149\153\134\146\108\110") and #colorHex >= 6 then
            local cleanHex = colorHex:gsub(_crqcum82("\197"), _crqcum82(""))
            local r = tonumber(cleanHex:sub(1, 2), 16)
            local g = tonumber(cleanHex:sub(3, 4), 16)
            local b = tonumber(cleanHex:sub(5, 6), 16)
            if r and g and b then
                nameColor = Color3.fromRGB(r, g, b)
            end
        end
        local PANEL = Color3.fromRGB(20, 20, 25)
        local OPTION = Color3.fromRGB(33, 33, 40)
        local OPTION_HOVER = Color3.fromRGB(45, 45, 54)
        local MUTED = Color3.fromRGB(150, 150, 162)
        local WHITE = Color3.fromRGB(244, 244, 248)
        local DANGER = Color3.fromRGB(248, 113, 113)
        local function corner(parent, radius)
            local item = Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"))
            item.CornerRadius = UDim.new(0, radius)
            item.Parent = parent
            return item
        end
        local function stroke(parent, color, transparency)
            local item = Instance.new(_crqcum82("\179\164\167\143\112\102\123\114"))
            item.Color = color
            item.Thickness = 1
            item.Transparency = transparency
            item.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            item.Parent = parent
            return item
        end
        local function constrain(parent, maxWidth)
            local item = Instance.new(_crqcum82("\179\164\167\146\120\108\083\120\112\086\088\065\091\040\038\059"))
            item.MaxSize = Vector2.new(maxWidth, 2000)
            item.MinSize = Vector2.new(220, 0)
            item.Parent = parent
            return item
        end
        local function tween(gui, time, style, direction, props)
            local item = TweenService:Create(gui, TweenInfo.new(time, style, direction), props)
            item:Play()
            return item
        end
        local function serverNowMs()
            local ok, value = pcall(workspace.GetServerTimeNow, workspace)
            if ok and type(value) == _crqcum82("\136\152\153\153\103\123") and value > 0 then return value * 1000 end
            return DateTime.now().UnixTimestampMillis
        end
        local function closeAnnouncement()
            announcementSerial = announcementSerial + 1
            fadeTo(1, 0.25)
            task.delay(0.26, function()
                if screenGui then screenGui:Destroy() end
            end)
        end
        local card = Instance.new(_crqcum82("\160\159\149\150\103"))
        card.Name = _crqcum82("\167\131\154\148\119\103\115\114\115\064\066\071\121\032\058\043")
        card.AnchorPoint = Vector2.new(0.5, 0)
        card.Position = UDim2.new(0.5, 0, 0, -100)
        card.Size = UDim2.new(1, 0, 0, 44)
        card.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        card.BackgroundTransparency = 0
        card.BorderSizePixel = 0
        card.Parent = fadeLayer
        local gradient = Instance.new(_crqcum82("\179\164\179\137\099\109\121\114\112\081"))
        gradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.25, 0.4),
            NumberSequenceKeypoint.new(0.75, 0.4),
            NumberSequenceKeypoint.new(1, 1)
        })
        gradient.Parent = card
        local contentContainer = Instance.new(_crqcum82("\160\159\149\150\103"))
        contentContainer.BackgroundTransparency = 1
        contentContainer.Size = UDim2.new(1, 0, 1, 0)
        contentContainer.Parent = card
        local listLayout = Instance.new(_crqcum82("\179\164\184\146\113\125\092\118\103\074\089\071"))
        listLayout.FillDirection = Enum.FillDirection.Horizontal
        listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 0)
        listLayout.Parent = contentContainer
        local nameLabel = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
        nameLabel.Name = _crqcum82("\168\140\153\158\078\104\114\114\114")
        nameLabel.BackgroundTransparency = 1
        nameLabel.Size = UDim2.new(0, 0, 1, 0)
        nameLabel.AutomaticSize = Enum.AutomaticSize.X
        nameLabel.Font = Enum.Font.GothamMedium
        nameLabel.TextSize = 16
        nameLabel.TextColor3 = nameColor
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.TextYAlignment = Enum.TextYAlignment.Center
        nameLabel.Text = tostring(prefix or _crqcum82("\170\152\149\139\112\102\100\114\125\081"))
        nameLabel.LayoutOrder = 1
        nameLabel.Parent = contentContainer
        local nameStroke = Instance.new(_crqcum82("\179\164\167\143\112\102\123\114"))
        nameStroke.Color = Color3.fromRGB(0, 0, 0)
        nameStroke.Thickness = 1
        nameStroke.Parent = nameLabel
        if verified then
            local preBadgeSpacer = Instance.new(_crqcum82("\160\159\149\150\103"))
            preBadgeSpacer.Name = _crqcum82("\182\159\145\185\099\109\119\114\077\085\077\080\095\051")
            preBadgeSpacer.BackgroundTransparency = 1
            preBadgeSpacer.Size = UDim2.new(0, 5, 1, 0)
            preBadgeSpacer.LayoutOrder = 2
            preBadgeSpacer.Parent = contentContainer
            local badge = Instance.new(_crqcum82("\175\128\149\156\103\069\113\117\123\073"))
            badge.Name = _crqcum82("\176\136\134\146\100\096\117\115\092\068\072\084\095")
            badge.BackgroundTransparency = 1
            badge.Size = UDim2.new(0, 20, 0, 20)
            badge.Image = _crqcum82("\148\143\140\154\113\122\117\099\119\065\022\028\021\112\125\119\099\100\083\092\066\072\184\179")
            badge.LayoutOrder = 3
            badge.Parent = contentContainer
            local badgeSpacer = Instance.new(_crqcum82("\160\159\149\150\103"))
            badgeSpacer.Name = _crqcum82("\164\140\144\156\103\090\096\118\125\064\094")
            badgeSpacer.BackgroundTransparency = 1
            badgeSpacer.Size = UDim2.new(0, 5, 1, 0)
            badgeSpacer.LayoutOrder = 4
            badgeSpacer.Parent = contentContainer
        end
        local msgLabel = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
        msgLabel.Name = _crqcum82("\171\136\135\136\099\110\117\091\127\071\073\095")
        msgLabel.BackgroundTransparency = 1
        msgLabel.Size = UDim2.new(0, 0, 1, 0)
        msgLabel.AutomaticSize = Enum.AutomaticSize.X
        msgLabel.Font = Enum.Font.GothamMedium
        msgLabel.TextSize = 16
        msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        msgLabel.TextXAlignment = Enum.TextXAlignment.Left
        msgLabel.TextYAlignment = Enum.TextYAlignment.Center
        msgLabel.Text = _crqcum82("\220\205") .. tostring(message or _crqcum82(""))
        msgLabel.LayoutOrder = 5
        msgLabel.Parent = contentContainer
        local msgStroke = Instance.new(_crqcum82("\179\164\167\143\112\102\123\114"))
        msgStroke.Color = Color3.fromRGB(0, 0, 0)
        msgStroke.Thickness = 1
        msgStroke.Parent = msgLabel
        tween(card, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, {
            Position = UDim2.new(0.5, 0, 0, 60)
        })
        local askBox, askFrame
        local askBusy = false
        if ask and type(broadcastId) == _crqcum82("\149\153\134\146\108\110") and broadcastId ~= _crqcum82("") then
            askFrame = Instance.new(_crqcum82("\160\159\149\150\103"))
            askFrame.Name = _crqcum82("\167\158\159\189\112\104\125\114")
            askFrame.AnchorPoint = Vector2.new(0.5, 0)
            askFrame.Position = UDim2.new(0.5, 0, 0, -150)
            askFrame.Size = UDim2.new(1, -28, 0, 46)
            askFrame.BackgroundColor3 = PANEL
            askFrame.BackgroundTransparency = 0.05
            askFrame.BorderSizePixel = 0
            askFrame.ClipsDescendants = true
            askFrame.Parent = fadeLayer
            corner(askFrame, 12)
            constrain(askFrame, 620)
            askBox = Instance.new(_crqcum82("\178\136\140\143\064\102\104"))
            askBox.Name = _crqcum82("\167\158\159\178\108\121\101\099")
            askBox.BackgroundTransparency = 1
            askBox.Position = UDim2.new(0, 14, 0, 0)
            askBox.Size = UDim2.new(1, -106, 1, 0)
            askBox.Font = Enum.Font.GothamMedium
            askBox.TextSize = 14
            askBox.TextColor3 = WHITE
            askBox.PlaceholderColor3 = MUTED
            askBox.PlaceholderText = _crqcum82("\167\158\159\219\118\097\117\055\113\082\066\086\072\097\041\111\039\040\001\024\006\016\239\233\160\187\178")
            askBox.Text = _crqcum82("")
            askBox.ClearTextOnFocus = false
            askBox.TextXAlignment = Enum.TextXAlignment.Left
            askBox.TextTruncate = Enum.TextTruncate.AtEnd
            askBox.Parent = askFrame
            local sendBtn = Instance.new(_crqcum82("\178\136\140\143\064\124\100\099\113\075"))
            sendBtn.Name = _crqcum82("\167\158\159\168\103\103\116")
            sendBtn.AnchorPoint = Vector2.new(1, 0.5)
            sendBtn.Position = UDim2.new(1, -7, 0.5, 0)
            sendBtn.Size = UDim2.new(0, 78, 0, 32)
            sendBtn.BackgroundColor3 = nameColor
            sendBtn.BorderSizePixel = 0
            sendBtn.AutoButtonColor = false
            sendBtn.Font = Enum.Font.GothamBold
            sendBtn.TextSize = 13
            sendBtn.TextColor3 = WHITE
            sendBtn.Text = _crqcum82("\181\136\154\159")
            sendBtn.Parent = askFrame
            corner(sendBtn, 9)
            sendBtn.MouseEnter:Connect(function()
                tween(sendBtn, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    BackgroundColor3 = nameColor:Lerp(Color3.new(1, 1, 1), 0.14)
                })
            end)
            sendBtn.MouseLeave:Connect(function()
                tween(sendBtn, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                    BackgroundColor3 = nameColor
                })
            end)
            local function submitQuestion()
                if askBusy then return end
                local text = tostring(askBox.Text or _crqcum82(""))
                if #text:gsub(_crqcum82("\195\158"), _crqcum82("")) < 2 then return end
                if not BQ.send then return end
                askBusy = true
                sendBtn.Text = _crqcum82("\200\195\218")
                BQ.onResult = function(ok, msg)
                    if announcementSerial ~= serial or not askBox or not askBox.Parent then return end
                    askBox.Text = _crqcum82("")
                    askBox.PlaceholderText = tostring(msg or (ok and _crqcum82("\181\136\154\143\035") or _crqcum82("\165\130\129\151\102\041\126\120\106\005\095\086\084\037\102")))
                    sendBtn.Text = ok and _crqcum82("\181\136\154\143") or _crqcum82("\181\136\154\159")
                    if ok then
                        askBox.TextEditable = false
                        task.delay(2.2, function()
                            if announcementSerial == serial and card and card.Parent then
                                closeAnnouncement()
                            end
                        end)
                    else
                        askBusy = false
                    end
                end
                if not pcall(BQ.send, broadcastId, text) then
                    askBusy = false
                    sendBtn.Text = _crqcum82("\181\136\154\159")
                    askBox.PlaceholderText = _crqcum82("\165\130\129\151\102\041\126\120\106\005\095\086\084\037\102")
                end
            end
            sendBtn.MouseButton1Click:Connect(submitQuestion)
            askBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then submitQuestion() end
            end)
            tween(askFrame, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {
                Position = UDim2.new(0.5, 0, 0, 112)
            })
        end
        local pollFrame, pollButtons, pollStatus, pollVoted, voteBusy, pollTimeFill, pollTimeTween
        if type(poll) == _crqcum82("\146\140\150\151\103") and type(poll.options) == _crqcum82("\146\140\150\151\103") and type(broadcastId) == _crqcum82("\149\153\134\146\108\110") and broadcastId ~= _crqcum82("") then
            local options = {}
            for i = 1, math.min(#poll.options, 6) do
                local optionText = tostring(poll.options[i] or _crqcum82("")):gsub(_crqcum82("\184\200\135\208"), _crqcum82("")):gsub(_crqcum82("\195\158\223\223"), _crqcum82(""))
                if optionText ~= _crqcum82("") then table.insert(options, optionText) end
            end
            if #options >= 2 then
                pollVoted = false
                voteBusy = false
                pollFrame = Instance.new(_crqcum82("\160\159\149\150\103"))
                pollFrame.Name = _crqcum82("\182\130\152\151\068\123\113\122\123")
                pollFrame.AnchorPoint = Vector2.new(0.5, 0)
                pollFrame.Position = UDim2.new(0.5, 0, 0, -180)
                pollFrame.Size = UDim2.new(1, -28, 0, 0)
                pollFrame.AutomaticSize = Enum.AutomaticSize.Y
                pollFrame.BackgroundColor3 = PANEL
                pollFrame.BackgroundTransparency = 0.05
                pollFrame.BorderSizePixel = 0
                pollFrame.ClipsDescendants = true
                pollFrame.Parent = fadeLayer
                corner(pollFrame, 14)
                constrain(pollFrame, 430)
                local padding = Instance.new(_crqcum82("\179\164\164\154\102\109\121\121\121"))
                padding.PaddingTop = UDim.new(0, 14)
                padding.PaddingBottom = UDim.new(0, 14)
                padding.PaddingLeft = UDim.new(0, 14)
                padding.PaddingRight = UDim.new(0, 14)
                padding.Parent = pollFrame
                local layout = Instance.new(_crqcum82("\179\164\184\146\113\125\092\118\103\074\089\071"))
                layout.FillDirection = Enum.FillDirection.Vertical
                layout.SortOrder = Enum.SortOrder.LayoutOrder
                layout.Padding = UDim.new(0, 9)
                layout.Parent = pollFrame
                local header = Instance.new(_crqcum82("\160\159\149\150\103"))
                header.Name = _crqcum82("\182\130\152\151\074\108\113\115\123\087")
                header.BackgroundTransparency = 1
                header.Size = UDim2.new(1, 0, 0, 22)
                header.LayoutOrder = 1
                header.Parent = pollFrame
                local pollTag = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
                pollTag.Name = _crqcum82("\182\130\152\151\086\104\119")
                pollTag.BackgroundTransparency = 1
                pollTag.Size = UDim2.new(0, 0, 1, 0)
                pollTag.AutomaticSize = Enum.AutomaticSize.X
                pollTag.Font = Enum.Font.GothamBold
                pollTag.TextSize = 12
                pollTag.TextColor3 = nameColor
                pollTag.TextXAlignment = Enum.TextXAlignment.Left
                pollTag.Text = _crqcum82("\182\162\184\183")
                pollTag.Parent = header
                local pollClock = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
                pollClock.Name = _crqcum82("\182\130\152\151\065\101\127\116\117")
                pollClock.BackgroundTransparency = 1
                pollClock.AnchorPoint = Vector2.new(1, 0.5)
                pollClock.Position = UDim2.new(1, 0, 0.5, 0)
                pollClock.Size = UDim2.new(0, 100, 1, 0)
                pollClock.Font = Enum.Font.GothamMedium
                pollClock.TextSize = 12
                pollClock.TextColor3 = MUTED
                pollClock.TextXAlignment = Enum.TextXAlignment.Right
                pollClock.Text = _crqcum82("\176\130\128\158\034\103\127\096")
                pollClock.Parent = header
                local pollQuestion = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
                pollQuestion.Name = _crqcum82("\182\130\152\151\083\124\117\100\106\076\067\093")
                pollQuestion.BackgroundTransparency = 1
                pollQuestion.Size = UDim2.new(1, 0, 0, 0)
                pollQuestion.AutomaticSize = Enum.AutomaticSize.Y
                pollQuestion.Font = Enum.Font.GothamMedium
                pollQuestion.TextSize = 15
                pollQuestion.TextWrapped = true
                pollQuestion.TextXAlignment = Enum.TextXAlignment.Left
                pollQuestion.TextColor3 = WHITE
                pollQuestion.Text = tostring(message or _crqcum82(""))
                pollQuestion.LayoutOrder = 2
                pollQuestion.Parent = pollFrame
                local timeTrack = Instance.new(_crqcum82("\160\159\149\150\103"))
                timeTrack.Name = _crqcum82("\182\130\152\151\086\096\125\114\074\087\077\080\081")
                timeTrack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                timeTrack.BackgroundTransparency = 0.92
                timeTrack.BorderSizePixel = 0
                timeTrack.Size = UDim2.new(1, 0, 0, 3)
                timeTrack.LayoutOrder = 3
                timeTrack.Parent = pollFrame
                corner(timeTrack, 2)
                pollTimeFill = Instance.new(_crqcum82("\160\159\149\150\103"))
                pollTimeFill.Name = _crqcum82("\182\130\152\151\086\096\125\114\088\076\064\095")
                pollTimeFill.BackgroundColor3 = nameColor
                pollTimeFill.BackgroundTransparency = 0.35
                pollTimeFill.BorderSizePixel = 0
                pollTimeFill.Size = UDim2.new(1, 0, 1, 0)
                pollTimeFill.Parent = timeTrack
                corner(pollTimeFill, 2)
                pollButtons = {}
                local optionRows = {}
                for i = 1, #options do
                    local btn = Instance.new(_crqcum82("\178\136\140\143\064\124\100\099\113\075"))
                    btn.Name = _crqcum82("\182\130\152\151\077\121\100\126\113\075") .. tostring(i)
                    btn.Size = UDim2.new(1, 0, 0, 40)
                    btn.BackgroundColor3 = OPTION
                    btn.BackgroundTransparency = 1
                    btn.BorderSizePixel = 0
                    btn.AutoButtonColor = false
                    btn.Text = _crqcum82("")
                    btn.LayoutOrder = 4 + i
                    btn.Parent = pollFrame
                    corner(btn, 9)
                    local btnStroke = stroke(btn, Color3.fromRGB(255, 255, 255), 0.9)
                    local fill = Instance.new(_crqcum82("\160\159\149\150\103"))
                    fill.Name = _crqcum82("\160\132\152\151")
                    fill.BackgroundColor3 = nameColor
                    fill.BackgroundTransparency = 0.8
                    fill.BorderSizePixel = 0
                    fill.Size = UDim2.new(0, 0, 1, 0)
                    fill.Parent = btn
                    corner(fill, 9)
                    local label = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
                    label.Name = _crqcum82("\170\140\150\158\110")
                    label.BackgroundTransparency = 1
                    label.Position = UDim2.new(0, 12, 0, 0)
                    label.Size = UDim2.new(1, -70, 1, 0)
                    label.Font = Enum.Font.GothamMedium
                    label.TextSize = 14
                    label.TextColor3 = WHITE
                    label.TextTransparency = 1
                    label.TextXAlignment = Enum.TextXAlignment.Left
                    label.TextTruncate = Enum.TextTruncate.AtEnd
                    label.Text = options[i]
                    label.Parent = btn
                    local count = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
                    count.Name = _crqcum82("\165\130\129\149\118")
                    count.AnchorPoint = Vector2.new(1, 0.5)
                    count.Position = UDim2.new(1, -12, 0.5, 0)
                    count.Size = UDim2.new(0, 54, 1, 0)
                    count.BackgroundTransparency = 1
                    count.Font = Enum.Font.GothamMedium
                    count.TextSize = 12
                    count.TextColor3 = MUTED
                    count.TextXAlignment = Enum.TextXAlignment.Right
                    count.Text = _crqcum82("")
                    count.Parent = btn
                    optionRows[i] = { button = btn, fill = fill, label = label, count = count, stroke = btnStroke }
                    pollButtons[i] = btn
                    task.delay(0.05 * i, function()
                        if announcementSerial ~= serial then return end
                        tween(btn, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                            BackgroundTransparency = 0
                        })
                        tween(label, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                            TextTransparency = 0
                        })
                    end)
                    btn.MouseEnter:Connect(function()
                        if pollVoted or voteBusy then return end
                        tween(btn, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                            BackgroundColor3 = OPTION_HOVER
                        })
                    end)
                    btn.MouseLeave:Connect(function()
                        if pollVoted or voteBusy then return end
                        tween(btn, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                            BackgroundColor3 = OPTION
                        })
                    end)
                    btn.MouseButton1Click:Connect(function()
                        if pollVoted or voteBusy then return end
                        voteBusy = true
                        pollStatus.Text = _crqcum82("\181\136\154\159\107\103\119\057\048\011")
                        pollStatus.TextColor3 = MUTED
                        for j = 1, #pollButtons do pollButtons[j].Active = false end
                        if not pcall(BP.send, broadcastId, i - 1) then
                            voteBusy = false
                            pollStatus.Text = _crqcum82("\165\130\129\151\102\041\126\120\106\005\095\086\084\037\102")
                            pollStatus.TextColor3 = DANGER
                            for j = 1, #pollButtons do pollButtons[j].Active = true end
                        end
                    end)
                end
                pollStatus = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
                pollStatus.Name = _crqcum82("\182\130\152\151\081\125\113\099\107\086")
                pollStatus.BackgroundTransparency = 1
                pollStatus.Size = UDim2.new(1, 0, 0, 16)
                pollStatus.Font = Enum.Font.GothamMedium
                pollStatus.TextSize = 11
                pollStatus.TextColor3 = MUTED
                pollStatus.TextXAlignment = Enum.TextXAlignment.Left
                pollStatus.Text = _crqcum82("\169\131\145\219\116\102\100\114\062\085\073\065\026\049\036\046\047\056\022")
                pollStatus.LayoutOrder = 5 + #options
                pollStatus.Parent = pollFrame
                local function paintVote(chosen, counts, total)
                    total = tonumber(total) or 0
                    pollStatus.TextColor3 = MUTED
                    for i = 1, #optionRows do
                        local row = optionRows[i]
                        local count = 0
                        if type(counts) == _crqcum82("\146\140\150\151\103") then count = tonumber(counts[i]) or 0 end
                        local pct = 0
                        if total > 0 then pct = math.floor(count / total * 100 + 0.5) end
                        row.button.Active = false
                        row.button.AutoButtonColor = false
                        row.count.Text = total > 0 and (tostring(count) .. _crqcum82("\198\090\212") .. tostring(pct) .. _crqcum82("\195")) or _crqcum82("")
                        if row.pct ~= pct then
                            row.pct = pct
                            tween(row.fill, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {
                                Size = UDim2.new(pct / 100, 0, 1, 0)
                            })
                        end
                        if i - 1 == chosen then
                            row.button.BackgroundColor3 = nameColor
                            row.button.BackgroundTransparency = 0.68
                            row.stroke.Transparency = 0.25
                            row.label.TextColor3 = Color3.fromRGB(255, 255, 255)
                            row.count.TextColor3 = Color3.fromRGB(255, 255, 255)
                        else
                            row.stroke.Transparency = 0.75
                            row.label.TextColor3 = MUTED
                            row.count.TextColor3 = MUTED
                        end
                    end
                    pollStatus.Text = total > 0 and (tostring(total) .. (total == 1 and _crqcum82("\198\155\155\143\103") or _crqcum82("\198\155\155\143\103\122"))) or _crqcum82("\176\130\128\158\034\106\127\098\112\081\073\087")
                end
                BP.onResult = function(ok, msg, chosenOption, counts, total)
                    if announcementSerial ~= serial or not pollFrame or not pollFrame.Parent then return end
                    voteBusy = false
                    if ok or type(counts) == _crqcum82("\146\140\150\151\103") then
                        pollVoted = true
                        if pollTimeTween then
                            pollTimeTween:Cancel()
                            pollTimeTween = nil
                        end
                        paintVote(tonumber(chosenOption) or -1, counts, total)
                        if not ok and msg then pollStatus.Text = tostring(msg) end
                        task.delay(5, function()
                            if announcementSerial ~= serial or not pollFrame or not pollFrame.Parent then return end
                            closeAnnouncement()
                        end)
                    else
                        pollStatus.Text = tostring(msg or _crqcum82("\165\130\129\151\102\041\126\120\106\005\090\092\078\036\102"))
                        pollStatus.TextColor3 = DANGER
                        for i = 1, #pollButtons do pollButtons[i].Active = true end
                    end
                end
                local untilMs = type(poll) == _crqcum82("\146\140\150\151\103") and tonumber(poll[_crqcum82("\147\131\128\146\110")]) or 0
                local startMs = serverNowMs()
                if not untilMs or untilMs <= 0 then
                    untilMs = startMs + duration * 1000
                end
                local remainingSeconds = math.max(0, (untilMs - startMs) / 1000)
                if pollTimeFill then
                    if remainingSeconds > 0 then
                        pollTimeTween = TweenService:Create(
                            pollTimeFill,
                            TweenInfo.new(remainingSeconds, Enum.EasingStyle.Linear),
                            { Size = UDim2.new(0, 0, 1, 0) }
                        )
                        pollTimeTween:Play()
                    else
                        pollTimeFill.Size = UDim2.new(0, 0, 1, 0)
                    end
                end
                task.spawn(function()
                    local lastLeft = -1
                    while pollFrame and pollFrame.Parent and announcementSerial == serial and not pollVoted do
                        local left = math.max(0, math.ceil((untilMs - serverNowMs()) / 1000))
                        if left ~= lastLeft then
                            lastLeft = left
                            if left <= 0 then
                                if pollTimeTween then
                                    pollTimeTween:Cancel()
                                    pollTimeTween = nil
                                end
                                if pollTimeFill then pollTimeFill.Size = UDim2.new(0, 0, 1, 0) end
                                pollClock.Text = _crqcum82("\165\129\155\136\103\109")
                                for i = 1, #optionRows do
                                    optionRows[i].button.Active = false
                                    tween(optionRows[i].button, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
                                        BackgroundTransparency = 0.6
                                    })
                                end
                                pollStatus.Text = _crqcum82("\176\130\128\146\108\110\048\127\127\086\012\080\086\046\059\042\050\115")
                                break
                            end
                            pollClock.Text = tostring(left) .. _crqcum82("\149\205\152\158\100\125")
                        end
                        task.wait(1)
                    end
                end)
                tween(pollFrame, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {
                    Position = UDim2.new(0.5, 0, 0, 112)
                })
            end
        end
        fadeTo(0, 0.25)
        task.delay(duration, function()
            if announcementSerial ~= serial or not card.Parent then return end
            local waited = 0
            while askBox and askBox.Parent and (askBox:IsFocused() or askBusy) and waited < 60 do
                task.wait(0.5)
                waited = waited + 0.5
                if announcementSerial ~= serial or not card.Parent then return end
            end
            if askFrame then
                tween(askFrame, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In, {
                    Position = UDim2.new(0.5, 0, 0, -150)
                })
            end
            if pollFrame then
                tween(pollFrame, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In, {
                    Position = UDim2.new(0.5, 0, 0, -180)
                })
            end
            local out = tween(card, 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In, {
                Position = UDim2.new(0.5, 0, 0, -100)
            })
            fadeTo(1, 0.3)
            out.Completed:Connect(function()
                if announcementSerial == serial and screenGui then screenGui:Destroy() end
            end)
        end)
    end)
end)
local CONSOLE_TOAST_LIMIT = 4
local CONSOLE_TOAST_WIDTH = 340
local CONSOLE_TOAST_HEIGHT = 68
local CONSOLE_TOAST_MAX_TEXT = 1000
local consoleToastSerial = 0
local consoleToastEntries = {}
local recentConsoleOutput = {}
local themeColor = (function(hex, fallback)
    hex = tostring(hex or _crqcum82("")):gsub(_crqcum82("\197"), _crqcum82(""))
    if #hex ~= 6 or not hex:match(_crqcum82("\184\200\140\208\038")) then return fallback end
    return Color3.fromRGB(tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16))
end)
local THEME_BG = themeColor((_CFG.THEME_BG ~= nil and _CFG.THEME_BG ~= _crqcum82("")) and _CFG.THEME_BG or "", Color3.fromRGB(20, 20, 20))
local PROMPT_FOR_KEY = ((_CFG.RUNNER_KEY_PROMPT ~= nil and _CFG.RUNNER_KEY_PROMPT ~= _crqcum82("")) and _CFG.RUNNER_KEY_PROMPT or "0") == _crqcum82("\215")
local THEME_TEXT = themeColor((_CFG.THEME_TEXT ~= nil and _CFG.THEME_TEXT ~= _crqcum82("")) and _CFG.THEME_TEXT or "", Color3.fromRGB(255, 255, 255))
local THEME_ACCENT = themeColor((_CFG.THEME_ACCENT ~= nil and _CFG.THEME_ACCENT ~= _crqcum82("")) and _CFG.THEME_ACCENT or "", nil) 
local THEME_MUTED = THEME_TEXT:Lerp(THEME_BG, 0.4)
local fontBold = Enum.Font.RobotoMono
local fontRegular = Enum.Font.RobotoMono
pcall(function()
    if not Enum.Font.RobotoMono then
        fontBold = Enum.Font.Code
        fontRegular = Enum.Font.Code
    end
end)
local consoleOutputStyle = (function(level)
    if level == _crqcum82("\131\159\134\148\112") then
        return {
            title = (label ~= _crqcum82("") and label ~= _crqcum82("\170\152\149\139\112\102\100\114\125\081") and label) or _crqcum82("\170\152\149\171\112\102\100\114\125\081\012\118\072\051\039\061"),
            accent = Color3.fromRGB(239, 68, 68),
            icon = _crqcum82("\148\143\140\154\113\122\117\099\119\065\022\028\021\112\120\120\098\106\087\083\070\074\185\179"),
            duration = 8
        }
    elseif level == _crqcum82("\145\140\134\149\107\103\119") then
        return {
            title = (label ~= _crqcum82("") and label ~= _crqcum82("\170\152\149\139\112\102\100\114\125\081") and label) or _crqcum82("\177\140\134\149\107\103\119"),
            accent = Color3.fromRGB(245, 158, 11),
            icon = _crqcum82("\148\143\140\154\113\122\117\099\119\065\022\028\021\112\120\120\102\100\083\094\065\072\180\190"),
            duration = 8
        }
    elseif level == _crqcum82("\149\152\151\152\103\122\099") then
        return {
            title = (label ~= _crqcum82("") and label ~= _crqcum82("\170\152\149\139\112\102\100\114\125\081") and label) or _crqcum82("\170\152\149\171\112\102\100\114\125\081"),
            accent = Color3.fromRGB(16, 185, 129),
            icon = _crqcum82("\148\143\140\154\113\122\117\099\119\065\022\028\021\112\120\120\102\100\083\082\066\079\180\179"),
            duration = 6
        }
    end
    return {
        title = (label ~= _crqcum82("") and label ~= _crqcum82("\170\152\149\139\112\102\100\114\125\081") and label) or _crqcum82("\170\152\149\171\112\102\100\114\125\081"),
        accent = THEME_ACCENT or Color3.fromRGB(59, 130, 246),
        icon = _crqcum82("\148\143\140\154\113\122\117\099\119\065\022\028\021\112\120\120\102\100\083\094\064\064\185\177"),
        duration = 6
    }
end)
local trimConsoleOutput = (function(value)
    local text = tostring(value or _crqcum82("")):gsub(_crqcum82("\235"), _crqcum82("")):gsub(_crqcum82("\184\200\135\208"), _crqcum82("")):gsub(_crqcum82("\195\158\223\223"), _crqcum82(""))
    if #text > CONSOLE_TOAST_MAX_TEXT then
        text = text:sub(1, CONSOLE_TOAST_MAX_TEXT - 3) .. _crqcum82("\200\195\218")
    end
    return text
end)
local isConsoleError = (function(value)
    local text = string.lower(tostring(value or _crqcum82("")))
    local errorMarkers = {
        _crqcum82("\131\159\134\148\112"), _crqcum82("\128\140\157\151\103\109"), _crqcum82("\128\140\157\151\119\123\117"), _crqcum82("\133\130\129\151\102\041\126\120\106"), _crqcum82("\133\140\154\149\109\125"), _crqcum82("\143\131\130\154\110\096\116\055\117\064\085"),
        _crqcum82("\132\140\154\149\103\109"), _crqcum82("\148\136\146\142\113\108\116"), _crqcum82("\148\140\128\158\034\101\121\122\119\081\073\087"), _crqcum82("\149\152\132\158\112\122\117\115\123\065"),
    }
    for _, marker in ipairs(errorMarkers) do
        if text:find(marker, 1, true) then return true end
    end
    return false
end)
local isConsoleSuccess = (function(value)
    local text = string.lower(tostring(value or _crqcum82("")))
    local successMarkers = {
        _crqcum82("\133\130\154\149\103\106\100\114\122"), _crqcum82("\135\152\128\147\103\103\100\126\125\068\088\086\094"), _crqcum82("\149\152\151\152\103\122\099"), _crqcum82("\149\136\151\142\112\108\124\110"), _crqcum82("\135\152\128\147\109\123\121\109\123\065"), _crqcum82("\138\130\149\159\103\109")
    }
    for _, marker in ipairs(successMarkers) do
        if text:find(marker, 1, true) then return true end
    end
    return false
end)
local removeConsoleToast = (function(entry, immediate)
    if not entry or entry.removed then return end
    entry.removed = true
    for index, activeEntry in ipairs(consoleToastEntries) do
        if activeEntry == entry then
            table.remove(consoleToastEntries, index)
            break
        end
    end
    if not entry.card or not entry.card.Parent then return end
    if immediate then
        entry.card:Destroy()
        return
    end
    local fadeInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    pcall(function()
        TweenService:Create(entry.card, fadeInfo, { BackgroundTransparency = 1, Position = UDim2.new(0, 24, 0, 0) }):Play()
        if entry.stroke then TweenService:Create(entry.stroke, fadeInfo, { Transparency = 1 }):Play() end
        if entry.iconFrame then TweenService:Create(entry.iconFrame, fadeInfo, { BackgroundTransparency = 1 }):Play() end
        if entry.iconImg then TweenService:Create(entry.iconImg, fadeInfo, { ImageTransparency = 1 }):Play() end
        TweenService:Create(entry.title, fadeInfo, { TextTransparency = 1 }):Play()
        local messageTween = TweenService:Create(entry.message, fadeInfo, { TextTransparency = 1 })
        messageTween:Play()
        messageTween.Completed:Connect(function()
            if entry.card then entry.card:Destroy() end
        end)
    end)
end)
local DISABLE_NOTIFICATIONS = (_CFG.DISABLE_NOTIFICATIONS ~= nil and tonumber(_CFG.DISABLE_NOTIFICATIONS) == 1) or (0 == 1)
local showConsoleNotification = (function(level, message)
    if DISABLE_NOTIFICATIONS and level ~= _crqcum82("\131\159\134\148\112") then return end
    pcall(function()
        local text = trimConsoleOutput(message)
        if text == _crqcum82("") then return end
        local now = tick()
        local outputKey = tostring(level) .. _crqcum82("\220") .. text
        if recentConsoleOutput[outputKey] and now - recentConsoleOutput[outputKey] < 1.5 then return end
        recentConsoleOutput[outputKey] = now
        for key, timestamp in pairs(recentConsoleOutput) do
            if now - timestamp > 8 then recentConsoleOutput[key] = nil end
        end
        local parentGui = getGuiParent()
        if not parentGui then return end
        local screenGui = parentGui:FindFirstChild(_crqcum82("\170\152\149\171\112\102\100\114\125\081\111\092\084\050\039\035\051\019\011\031\027\031\233\228\239\225\245\204\196\194"))
        if not screenGui then
            screenGui = Instance.new(_crqcum82("\181\142\134\158\103\103\087\098\119"))
            screenGui.Name = _crqcum82("\170\152\149\171\112\102\100\114\125\081\111\092\084\050\039\035\051\019\011\031\027\031\233\228\239\225\245\204\196\194")
            screenGui.ResetOnSpawn = false
            screenGui.IgnoreGuiInset = true
            screenGui.DisplayOrder = 25
            screenGui.Parent = parentGui
        end
        local stack = screenGui:FindFirstChild(_crqcum82("\168\130\128\146\100\096\115\118\106\076\067\093\105\053\041\044\061"))
        if not stack then
            stack = Instance.new(_crqcum82("\160\159\149\150\103"))
            stack.Name = _crqcum82("\168\130\128\146\100\096\115\118\106\076\067\093\105\053\041\044\061")
            stack.AnchorPoint = Vector2.new(1, 1)
            stack.Position = UDim2.new(1, -16, 1, -16)
            stack.Size = UDim2.new(0, CONSOLE_TOAST_WIDTH, 0, 0)
            stack.AutomaticSize = Enum.AutomaticSize.Y
            stack.Active = false
            stack.BackgroundTransparency = 1
            stack.BorderSizePixel = 0
            stack.Parent = screenGui
            local sizeConstraint = Instance.new(_crqcum82("\179\164\167\146\120\108\083\120\112\086\088\065\091\040\038\059"))
            sizeConstraint.MaxSize = Vector2.new(CONSOLE_TOAST_WIDTH, 720)
            sizeConstraint.MinSize = Vector2.new(0, 0)
            sizeConstraint.Parent = stack
            local layout = Instance.new(_crqcum82("\179\164\184\146\113\125\092\118\103\074\089\071"))
            layout.Name = _crqcum82("\181\153\149\152\105\069\113\110\113\080\088")
            layout.FillDirection = Enum.FillDirection.Vertical
            layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
            layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 8)
            layout.Parent = stack
        end
        while #consoleToastEntries >= CONSOLE_TOAST_LIMIT do
            removeConsoleToast(consoleToastEntries[1], true)
        end
        local style = consoleOutputStyle(level)
        consoleToastSerial = consoleToastSerial + 1
        local card = Instance.new(_crqcum82("\160\159\149\150\103"))
        card.Name = _crqcum82("\165\130\154\136\109\101\117\067\113\068\095\071")
        card.LayoutOrder = consoleToastSerial
        card.Size = UDim2.new(1, 0, 0, 0)
        card.AutomaticSize = Enum.AutomaticSize.Y
        card.BackgroundColor3 = THEME_BG
        card.BackgroundTransparency = 1
        card.BorderSizePixel = 0
        card.ClipsDescendants = true
        card.Parent = stack
        local corner = Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"))
        corner.CornerRadius = UDim.new(0, 3)
        corner.Parent = card
        local stroke = Instance.new(_crqcum82("\179\164\167\143\112\102\123\114"))
        stroke.Color = Color3.fromRGB(45, 45, 45)
        stroke.Transparency = 1
        stroke.Thickness = 1
        stroke.Parent = card
        local cardPadding = Instance.new(_crqcum82("\179\164\164\154\102\109\121\121\121"))
        cardPadding.PaddingTop = UDim.new(0, 12)
        cardPadding.PaddingBottom = UDim.new(0, 12)
        cardPadding.PaddingLeft = UDim.new(0, 14)
        cardPadding.PaddingRight = UDim.new(0, 12)
        cardPadding.Parent = card
        local row = Instance.new(_crqcum82("\160\159\149\150\103"))
        row.Name = _crqcum82("\180\130\131")
        row.Size = UDim2.new(1, 0, 0, 0)
        row.AutomaticSize = Enum.AutomaticSize.Y
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.Parent = card
        local rowLayout = Instance.new(_crqcum82("\179\164\184\146\113\125\092\118\103\074\089\071"))
        rowLayout.FillDirection = Enum.FillDirection.Horizontal
        rowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        rowLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        rowLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rowLayout.Padding = UDim.new(0, 10)
        rowLayout.Parent = row
        local iconFrame = Instance.new(_crqcum82("\160\159\149\150\103"))
        iconFrame.Name = _crqcum82("\175\142\155\149\068\123\113\122\123")
        iconFrame.Size = UDim2.new(0, 24, 0, 24)
        iconFrame.BackgroundColor3 = style.accent
        iconFrame.BackgroundTransparency = 1
        iconFrame.BorderSizePixel = 0
        iconFrame.LayoutOrder = 1
        iconFrame.Parent = row
        local iconCorner = Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"))
        iconCorner.CornerRadius = UDim.new(0, 3)
        iconCorner.Parent = iconFrame
        local iconImg = Instance.new(_crqcum82("\175\128\149\156\103\069\113\117\123\073"))
        iconImg.Name = _crqcum82("\175\142\155\149")
        iconImg.Size = UDim2.new(0, 16, 0, 16)
        iconImg.AnchorPoint = Vector2.new(0.5, 0.5)
        iconImg.Position = UDim2.new(0.5, 0, 0.5, 0)
        iconImg.BackgroundTransparency = 1
        iconImg.BorderSizePixel = 0
        iconImg.Image = style.icon
        iconImg.ImageColor3 = style.accent
        iconImg.ImageTransparency = 1
        iconImg.Parent = iconFrame
        local content = Instance.new(_crqcum82("\160\159\149\150\103"))
        content.Name = _crqcum82("\165\130\154\143\103\103\100")
        content.Size = UDim2.new(1, -34, 0, 0)
        content.AutomaticSize = Enum.AutomaticSize.Y
        content.BackgroundTransparency = 1
        content.BorderSizePixel = 0
        content.LayoutOrder = 2
        content.Parent = row
        local contentLayout = Instance.new(_crqcum82("\179\164\184\146\113\125\092\118\103\074\089\071"))
        contentLayout.FillDirection = Enum.FillDirection.Vertical
        contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 2)
        contentLayout.Parent = content
        local titleLabel = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
        titleLabel.Name = _crqcum82("\178\132\128\151\103")
        titleLabel.Size = UDim2.new(1, 0, 0, 16)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Font = fontBold
        titleLabel.Text = style.title
        titleLabel.TextSize = 13
        titleLabel.TextColor3 = THEME_TEXT
        titleLabel.TextTransparency = 1
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextYAlignment = Enum.TextYAlignment.Center
        titleLabel.LayoutOrder = 1
        titleLabel.Parent = content
        local messageLabel = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
        messageLabel.Name = _crqcum82("\171\136\135\136\099\110\117")
        messageLabel.Size = UDim2.new(1, 0, 0, 0)
        messageLabel.AutomaticSize = Enum.AutomaticSize.Y
        messageLabel.BackgroundTransparency = 1
        messageLabel.Font = fontRegular
        messageLabel.Text = text
        messageLabel.TextSize = 12
        messageLabel.TextColor3 = THEME_MUTED
        messageLabel.TextTransparency = 1
        messageLabel.TextWrapped = true
        messageLabel.TextTruncate = Enum.TextTruncate.None
        messageLabel.TextXAlignment = Enum.TextXAlignment.Left
        messageLabel.TextYAlignment = Enum.TextYAlignment.Top
        messageLabel.LayoutOrder = 2
        messageLabel.Parent = content
        local entry = {
            card = card,
            stroke = stroke,
            iconFrame = iconFrame,
            iconImg = iconImg,
            title = titleLabel,
            message = messageLabel,
            removed = false,
        }
        table.insert(consoleToastEntries, entry)
        card.Position = UDim2.new(0, 20, 0, 0)
        local fadeIn = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(card, fadeIn, { BackgroundTransparency = 0.05, Position = UDim2.new(0, 0, 0, 0) }):Play()
        TweenService:Create(stroke, fadeIn, { Transparency = 0 }):Play()
        TweenService:Create(iconFrame, fadeIn, { BackgroundTransparency = 0.86 }):Play()
        TweenService:Create(iconImg, fadeIn, { ImageTransparency = 0 }):Play()
        TweenService:Create(titleLabel, fadeIn, { TextTransparency = 0 }):Play()
        TweenService:Create(messageLabel, fadeIn, { TextTransparency = 0 }):Play()
        task.delay(style.duration, function() removeConsoleToast(entry, false) end)
    end)
end)
local function runnerWarn(message, forceError)
    local text = tostring(message or _crqcum82(""))
    warn(_crqcum82("\189") .. label .. _crqcum82("\187\205") .. text)
    local level = (forceError or isConsoleError(text)) and _crqcum82("\131\159\134\148\112") or _crqcum82("\145\140\134\149\107\103\119")
    showConsoleNotification(level, text)
end
local waitWithCountdown
local linkPanel = nil
local DISCORD_BLURPLE = THEME_ACCENT or Color3.fromRGB(88, 101, 242)
local formatLinkCode = (function(code)
    code = tostring(code or _crqcum82(""))
    if #code == 6 then return code:sub(1, 3) .. _crqcum82("\198") .. code:sub(4, 6) end
    return code
end)
local hideDiscordLinkPanel = (function(linked)
    local panel = linkPanel
    if not panel then return end
    linkPanel = nil
    panel.closed = true
    pcall(function()
        if linked then
            panel.title.Text = _crqcum82("\162\132\135\152\109\123\116\055\114\076\066\088\095\037")
            panel.message.Text = _crqcum82("\181\153\149\137\118\096\126\112\062\081\068\086\026\050\043\061\063\045\016\069\092\087")
            panel.codeLabel.Text = _crqcum82("\162\130\154\158")
            panel.codeLabel.TextColor3 = Color3.fromRGB(16, 185, 129)
            panel.timer.Text = _crqcum82("")
            task.wait(1.2)
        end
        local fade = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        TweenService:Create(panel.card, fade, { BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 16) }):Play()
        for _, obj in ipairs(panel.card:GetDescendants()) do
            if obj:IsA(_crqcum82("\178\136\140\143\078\104\114\114\114")) or obj:IsA(_crqcum82("\178\136\140\143\064\124\100\099\113\075")) then
                TweenService:Create(obj, fade, { TextTransparency = 1, BackgroundTransparency = 1 }):Play()
            elseif obj:IsA(_crqcum82("\175\128\149\156\103\069\113\117\123\073")) then
                TweenService:Create(obj, fade, { ImageTransparency = 1, BackgroundTransparency = 1 }):Play()
            elseif obj:IsA(_crqcum82("\179\164\167\143\112\102\123\114")) then
                TweenService:Create(obj, fade, { Transparency = 1 }):Play()
            elseif obj:IsA(_crqcum82("\160\159\149\150\103")) and obj.BackgroundTransparency < 1 then
                TweenService:Create(obj, fade, { BackgroundTransparency = 1 }):Play()
            end
        end
        task.wait(0.3)
        if panel.gui then panel.gui:Destroy() end
    end)
end)
local showDiscordLinkPanel = (function(info, sendEvent)
    local enterMode = info and info.mode == _crqcum82("\130\132\135\152\109\123\116")
    local function requestNewCode() sendEvent({ event = _crqcum82("\138\132\154\144\093\106\127\115\123\122\094\086\092\051\045\060\062") }) end
    local code = tostring(info and info.code or _crqcum82(""))
    local expiresAt = os.clock() + (tonumber(info and info.expiresIn) or 300)
    local servers = {}
    if info and type(info.servers) == _crqcum82("\146\140\150\151\103") then
        for _, name in ipairs(info.servers) do table.insert(servers, tostring(name)) end
    end
    if #servers == 0 and info and info.server then table.insert(servers, tostring(info.server)) end
    local whereText
    if #servers == 1 then
        whereText = _crqcum82("\179\158\145\219\045\101\121\121\117\005\091\090\078\041\104\059\062\052\023\075\017\022\228\226\174\252\242\131\222\217\221\159") .. servers[1] .. _crqcum82("\198\169\157\136\097\102\098\115\062\086\073\065\076\036\058\097")
    elseif #servers > 1 then
        local last = table.remove(servers)
        whereText = _crqcum82("\179\158\145\219\045\101\121\121\117\005\091\090\078\041\104\059\062\052\023\075\017\022\228\226\174\252\242\131\203\223\193\159\169\171\244\175\138\140\131\146\222\065\101\096\121\078\090\075\022\078\033\057\036\060\018\020\084\085") .. table.concat(servers, _crqcum82("\202\205")) .. _crqcum82("\198\130\134\219") .. last .. _crqcum82("\200")
    else
        whereText = _crqcum82("\179\158\145\219\045\101\121\121\117\005\091\090\078\041\104\059\062\052\023\075\017\022\228\226\174\252\242\131\222\217\221\159\181\174\166\178\146\157\215\132\222\065\101\096\121\078\090\075\022\078\033\057\036\060\018\073")
    end
    if enterMode then
        whereText = whereText:gsub(_crqcum82("\184\184\135\158\034\038\124\126\112\078\012\068\083\053\032\111\034\053\013\024\082\026\239\227\235\181\245\205"), _crqcum82("\180\152\154\219\045\101\121\121\117\005\069\093")):gsub(_crqcum82("\195\195\208"), _crqcum82("")) .. _crqcum82("\202\205\128\147\103\103\048\114\112\081\073\065\026\053\032\042\118\062\011\015\023\089\233\243\174\242\245\213\207\194\152\198\169\184\244\179\135\155\149\217")
    end
    if linkPanel and linkPanel.card and linkPanel.card.Parent then
        if linkPanel.enterMode then
            linkPanel.message.Text = whereText
            return
        end
        linkPanel.code = code
        linkPanel.expiresAt = expiresAt
        linkPanel.refreshing = false
        linkPanel.message.Text = whereText
        linkPanel.codeLabel.Text = formatLinkCode(code)
        return
    end
    pcall(function()
        local parentGui = getGuiParent()
        if not parentGui then return end
        cleanupExistingGui(_crqcum82("\170\152\149\171\112\102\100\114\125\081\104\090\073\034\039\061\050\017\013\005\025"))
        local gui = Instance.new(_crqcum82("\181\142\134\158\103\103\087\098\119"))
        gui.Name = _crqcum82("\170\152\149\171\112\102\100\114\125\081\104\090\073\034\039\061\050\017\013\005\025")
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 30
        gui.Parent = parentGui
        local backdrop = Instance.new(_crqcum82("\160\159\149\150\103"))
        backdrop.Name = _crqcum82("\164\140\151\144\102\123\127\103")
        backdrop.Size = UDim2.new(1, 0, 1, 0)
        backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        backdrop.BackgroundTransparency = 1
        backdrop.BorderSizePixel = 0
        backdrop.Active = true
        backdrop.Parent = gui
        local card = Instance.new(_crqcum82("\160\159\149\150\103"))
        card.Name = _crqcum82("\170\132\154\144\065\104\098\115")
        card.AnchorPoint = Vector2.new(0.5, 0.5)
        card.Position = UDim2.new(0.5, 0, 0.5, 16)
        card.Size = UDim2.new(0, 440, 0, 0)
        card.AutomaticSize = Enum.AutomaticSize.Y
        card.BackgroundColor3 = THEME_BG
        card.BackgroundTransparency = 1
        card.BorderSizePixel = 0
        card.Parent = gui
        Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), card).CornerRadius = UDim.new(0, 3)
        local cardSize = Instance.new(_crqcum82("\179\164\167\146\120\108\083\120\112\086\088\065\091\040\038\059"))
        cardSize.MaxSize = Vector2.new(440, 600)
        cardSize.Parent = card
        local stroke = Instance.new(_crqcum82("\179\164\167\143\112\102\123\114"))
        stroke.Color = Color3.fromRGB(45, 45, 45)
        stroke.Transparency = 1
        stroke.Parent = card
        local pad = Instance.new(_crqcum82("\179\164\164\154\102\109\121\121\121"))
        pad.PaddingTop, pad.PaddingBottom = UDim.new(0, 22), UDim.new(0, 22)
        pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 22), UDim.new(0, 22)
        pad.Parent = card
        local list = Instance.new(_crqcum82("\179\164\184\146\113\125\092\118\103\074\089\071"))
        list.FillDirection = Enum.FillDirection.Vertical
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Padding = UDim.new(0, 14)
        list.Parent = card
        local header = Instance.new(_crqcum82("\160\159\149\150\103"))
        header.Size = UDim2.new(1, 0, 0, 36)
        header.BackgroundTransparency = 1
        header.LayoutOrder = 1
        header.Parent = card
        local iconFrame = Instance.new(_crqcum82("\160\159\149\150\103"))
        iconFrame.Size = UDim2.new(0, 36, 0, 36)
        iconFrame.BackgroundColor3 = DISCORD_BLURPLE
        iconFrame.BackgroundTransparency = 0.86
        iconFrame.BorderSizePixel = 0
        iconFrame.Parent = header
        Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), iconFrame).CornerRadius = UDim.new(0, 3)
        local icon = Instance.new(_crqcum82("\175\128\149\156\103\069\113\117\123\073"))
        icon.Size = UDim2.new(0, 22, 0, 22)
        icon.AnchorPoint = Vector2.new(0.5, 0.5)
        icon.Position = UDim2.new(0.5, 0, 0.5, 0)
        icon.BackgroundTransparency = 1
        icon.Image = _crqcum82("\148\143\140\154\113\122\117\099\119\065\022\028\021\112\120\120\102\100\083\094\064\064\185\177")
        icon.ImageColor3 = DISCORD_BLURPLE
        icon.Parent = iconFrame
        local title = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
        title.Position = UDim2.new(0, 48, 0, 0)
        title.Size = UDim2.new(1, -48, 1, 0)
        title.BackgroundTransparency = 1
        title.Font = fontBold
        title.TextSize = 20
        title.TextColor3 = THEME_TEXT
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Text = _crqcum82("\170\132\154\144\034\112\127\098\108\005\104\090\073\034\039\061\050\125\016\004\082\009\236\230\247")
        title.Parent = header
        local message = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
        message.Size = UDim2.new(1, 0, 0, 0)
        message.AutomaticSize = Enum.AutomaticSize.Y
        message.BackgroundTransparency = 1
        message.Font = fontRegular
        message.TextSize = 15
        message.TextColor3 = THEME_MUTED
        message.TextWrapped = true
        message.TextXAlignment = Enum.TextXAlignment.Left
        message.Text = whereText
        message.LayoutOrder = 2
        message.Parent = card
        local codeBox = Instance.new(_crqcum82("\160\159\149\150\103"))
        codeBox.Size = UDim2.new(1, 0, 0, 64)
        codeBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        codeBox.BackgroundTransparency = 0.96
        codeBox.BorderSizePixel = 0
        codeBox.LayoutOrder = 3
        codeBox.Parent = card
        Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), codeBox).CornerRadius = UDim.new(0, 3)
        local codeLabel = Instance.new(enterMode and _crqcum82("\178\136\140\143\064\102\104") or _crqcum82("\178\136\140\143\078\104\114\114\114"))
        if enterMode then
            codeLabel.PlaceholderText = _crqcum82("\214\221\196\219\050\057\032")
            codeLabel.PlaceholderColor3 = THEME_MUTED
            codeLabel.ClearTextOnFocus = false
        end
        codeLabel.Position = UDim2.new(0, 16, 0, 0)
        codeLabel.Size = UDim2.new(1, -110, 1, 0)
        codeLabel.BackgroundTransparency = 1
        codeLabel.Font = Enum.Font.RobotoMono
        codeLabel.TextSize = 34
        codeLabel.TextColor3 = THEME_TEXT
        codeLabel.TextXAlignment = Enum.TextXAlignment.Left
        codeLabel.Text = enterMode and _crqcum82("") or formatLinkCode(code)
        codeLabel.Parent = codeBox
        local copyBtn = Instance.new(_crqcum82("\178\136\140\143\064\124\100\099\113\075"))
        copyBtn.AnchorPoint = Vector2.new(1, 0.5)
        copyBtn.Position = UDim2.new(1, -12, 0.5, 0)
        copyBtn.Size = UDim2.new(0, 80, 0, 38)
        copyBtn.BackgroundColor3 = DISCORD_BLURPLE
        copyBtn.AutoButtonColor = true
        copyBtn.Font = fontBold
        copyBtn.TextSize = 15
        copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        copyBtn.Text = enterMode and _crqcum82("\170\132\154\144") or _crqcum82("\165\130\132\130")
        copyBtn.Parent = codeBox
        Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), copyBtn).CornerRadius = UDim.new(0, 3)
        local timer = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
        timer.Size = UDim2.new(1, 0, 0, 18)
        timer.BackgroundTransparency = 1
        timer.Font = fontRegular
        timer.TextSize = 13
        timer.TextColor3 = THEME_MUTED
        timer.TextXAlignment = Enum.TextXAlignment.Left
        timer.Text = _crqcum82("")
        timer.LayoutOrder = 5
        timer.Parent = card
        local invite = info and info.invite and tostring(info.invite) or nil
        if invite and invite ~= _crqcum82("") then
            local inviteRow = Instance.new(_crqcum82("\160\159\149\150\103"))
            inviteRow.Size = UDim2.new(1, 0, 0, 40)
            inviteRow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            inviteRow.BackgroundTransparency = 0.97
            inviteRow.BorderSizePixel = 0
            inviteRow.LayoutOrder = 4
            inviteRow.Parent = card
            Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), inviteRow).CornerRadius = UDim.new(0, 3)
            local inviteLabel = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
            inviteLabel.Position = UDim2.new(0, 14, 0, 0)
            inviteLabel.Size = UDim2.new(1, -110, 1, 0)
            inviteLabel.BackgroundTransparency = 1
            inviteLabel.Font = fontRegular
            inviteLabel.TextSize = 14
            inviteLabel.TextColor3 = THEME_MUTED
            inviteLabel.TextXAlignment = Enum.TextXAlignment.Left
            inviteLabel.TextTruncate = Enum.TextTruncate.AtEnd
            inviteLabel.Text = _crqcum82("\168\130\128\219\107\103\048\099\118\064\012\064\095\051\062\042\036\098\068") .. invite:gsub(_crqcum82("\184\133\128\143\114\122\047\045\049\010"), _crqcum82(""))
            inviteLabel.Parent = inviteRow
            local inviteBtn = Instance.new(_crqcum82("\178\136\140\143\064\124\100\099\113\075"))
            inviteBtn.AnchorPoint = Vector2.new(1, 0.5)
            inviteBtn.Position = UDim2.new(1, -8, 0.5, 0)
            inviteBtn.Size = UDim2.new(0, 84, 0, 28)
            inviteBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            inviteBtn.BackgroundTransparency = 0.9
            inviteBtn.AutoButtonColor = true
            inviteBtn.Font = fontBold
            inviteBtn.TextSize = 13
            inviteBtn.TextColor3 = THEME_TEXT
            inviteBtn.Text = _crqcum82("\165\130\132\130\034\096\126\097\119\081\073")
            inviteBtn.Parent = inviteRow
            Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), inviteBtn).CornerRadius = UDim.new(0, 3)
            inviteBtn.MouseButton1Click:Connect(function()
                local copied = false
                pcall(function()
                    local clip = setclipboard or toclipboard or (syn and syn.write_clipboard)
                    if clip then clip(invite); copied = true end
                end)
                inviteBtn.Text = copied and _crqcum82("\165\130\132\146\103\109") or _crqcum82("\169\157\145\149\034\096\100")
                task.delay(1.5, function() if inviteBtn.Parent then inviteBtn.Text = _crqcum82("\165\130\132\130\034\096\126\097\119\081\073") end end)
            end)
        end
        linkPanel = {
            gui = gui, card = card, title = title, message = message,
            codeLabel = codeLabel, timer = timer, code = code,
            expiresAt = expiresAt, refreshing = false, closed = false,
            enterMode = enterMode, submitBtn = copyBtn,
        }
        local panel = linkPanel
        if enterMode then
            local function submit()
                local entered = tostring(codeLabel.Text or _crqcum82("")):gsub(_crqcum82("\195\158\223"), _crqcum82(""))
                if not entered:match(_crqcum82("\184\200\144\222\102\044\116\050\122\000\072\022\094\101")) then
                    timer.Text = _crqcum82("\163\131\128\158\112\041\100\127\123\005\026\030\094\040\047\038\034\125\007\004\022\028\160\225\252\250\241\131\133\221\209\209\173\227")
                    return
                end
                copyBtn.Text = _crqcum82("\200\195\218")
                timer.Text = _crqcum82("\165\133\145\152\105\096\126\112\062\081\068\086\026\034\039\043\051\115\074\069")
                sendEvent({ event = _crqcum82("\138\132\154\144\093\106\127\115\123\122\095\070\088\044\033\059"), code = entered })
            end
            copyBtn.MouseButton1Click:Connect(submit)
            codeLabel.FocusLost:Connect(function(enterPressed) if enterPressed then submit() end end)
        end
        if not enterMode then copyBtn.MouseButton1Click:Connect(function()
            local copied = false
            pcall(function()
                local clip = setclipboard or toclipboard or (syn and syn.write_clipboard)
                if clip then clip(tostring(panel.code)); copied = true end
            end)
            copyBtn.Text = copied and _crqcum82("\165\130\132\146\103\109") or _crqcum82("\178\148\132\158\034\096\100")
            task.delay(1.5, function() if copyBtn.Parent then copyBtn.Text = _crqcum82("\165\130\132\130") end end)
        end) end
        local fadeIn = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(card, fadeIn, { BackgroundTransparency = 0.03, Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
        TweenService:Create(backdrop, fadeIn, { BackgroundTransparency = 0.45 }):Play()
        TweenService:Create(stroke, fadeIn, { Transparency = 0 }):Play()
        if not enterMode then task.spawn(function()
            while not panel.closed and card.Parent do
                local left = math.max(0, math.floor(panel.expiresAt - os.clock()))
                if left > 0 then
                    timer.Text = string.format(_crqcum82("\165\130\144\158\034\108\104\103\119\087\073\064\026\040\038\111\115\057\094\078\066\075\228"), math.floor(left / 60), left % 60)
                elseif not panel.refreshing then
                    panel.refreshing = true
                    timer.Text = _crqcum82("\165\130\144\158\034\108\104\103\119\087\073\087\026\108\104\040\051\041\016\002\028\030\160\230\174\251\249\212\138\222\214\218\232\227\250")
                    pcall(requestNewCode)
                end
                task.wait(1)
            end
        end) end
    end)
end)
local showDiscordLinkError = (function(message)
    local panel = linkPanel
    if not panel or not panel.enterMode then return end
    pcall(function()
        panel.timer.Text = tostring(message or _crqcum82("\178\133\149\143\034\106\127\115\123\005\072\090\094\047\111\059\118\042\011\025\025\087"))
        if panel.submitBtn then panel.submitBtn.Text = _crqcum82("\170\132\154\144") end
    end)
end)
local function runnerPrint(message)
    local text = tostring(message or _crqcum82(""))
    print(_crqcum82("\189") .. label .. _crqcum82("\187\205") .. text)
    local level = isConsoleSuccess(text) and _crqcum82("\149\152\151\152\103\122\099") or _crqcum82("\143\131\146\148")
    showConsoleNotification(level, text)
end
local LP_RUNNER_T0 = os.clock()
local function inStartGrace() return (os.clock() - LP_RUNNER_T0) < 20 end
local function runnerQuiet(message)
    local text = tostring(message or _crqcum82(""))
    if text == _crqcum82("") then return end
    showConsoleNotification(isConsoleError(text) and _crqcum82("\131\159\134\148\112") or _crqcum82("\145\140\134\149\107\103\119"), text)
end
local function runnerLog(message)
    local text = tostring(message or _crqcum82(""))
    if text ~= _crqcum82("") then warn(_crqcum82("\189") .. label .. _crqcum82("\187\205") .. text) end
end
local sha256 = {}
sha256.hmac = (function(key, message)
    local band, rshift, lshift, bxor, bnot = bit32.band, bit32.rshift, bit32.lshift, bit32.bxor, bit32.bnot
    local unpack = table.unpack or unpack
    local rrotate = bit32.rrotate or function(x, n)
        return bxor(rshift(x, n), lshift(x, 32 - n))
    end
    local function add(a, b, c, d, e)
        return (a + b + (c or 0) + (d or 0) + (e or 0)) % 4294967296
    end
local h_init = {
        0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
        0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
    }
local k = {
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
        0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
        0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
        0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
        0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
        0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
        0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
    }
    local function str_to_bytes(str)
        local bytes = {}
        for i = 1, #str do bytes[i] = string.byte(str, i) end
        return bytes
    end
    local function bytes_to_hex(bytes)
        local hex = {}
        for i = 1, #bytes do hex[i] = string.format(_crqcum82("\195\221\198\131"), bytes[i]) end
        return table.concat(hex)
    end
    local function block_hash(block, h)
        local w = {}
        for i = 1, 16 do
            w[i] = add(lshift(block[4*i - 3], 24), lshift(block[4*i - 2], 16), lshift(block[4*i - 1], 8), block[4*i])
        end
        for i = 17, 64 do
            local s0 = bxor(bxor(rrotate(w[i-15], 7), rrotate(w[i-15], 18)), rshift(w[i-15], 3))
            local s1 = bxor(bxor(rrotate(w[i-2], 17), rrotate(w[i-2], 19)), rshift(w[i-2], 10))
            w[i] = add(w[i-16], s0, w[i-7], s1)
        end
        local a, b, c, d, e, f, g, h_val = h[1], h[2], h[3], h[4], h[5], h[6], h[7], h[8]
        for i = 1, 64 do
            local S1 = bxor(bxor(rrotate(e, 6), rrotate(e, 11)), rrotate(e, 25))
            local ch = bxor(band(e, f), band(bnot(e), g))
            local temp1 = add(h_val, S1, ch, k[i], w[i])
            local S0 = bxor(bxor(rrotate(a, 2), rrotate(a, 13)), rrotate(a, 22))
            local maj = bxor(bxor(band(a, b), band(a, c)), band(b, c))
            local temp2 = add(S0, maj)
            h_val = g; g = f; f = e; e = add(d, temp1); d = c; c = b; b = a; a = add(temp1, temp2)
        end
        h[1] = add(h[1], a); h[2] = add(h[2], b); h[3] = add(h[3], c); h[4] = add(h[4], d)
        h[5] = add(h[5], e); h[6] = add(h[6], f); h[7] = add(h[7], g); h[8] = add(h[8], h_val)
    end
    local function digest(str)
        local h = { unpack(h_init) }
        local bytes = str_to_bytes(str)
        local bit_len = #bytes * 8
        bytes[#bytes + 1] = 0x80
        while (#bytes % 64) ~= 56 do bytes[#bytes + 1] = 0 end
        for i = 7, 0, -1 do bytes[#bytes + 1] = band(rshift(bit_len, i * 8), 0xFF) end
        for chunk = 1, #bytes / 64 do
            local block = {}
            for i = 1, 64 do block[i] = bytes[(chunk-1)*64 + i] end
            block_hash(block, h)
        end
        local result = {}
        for _, val in ipairs(h) do
            for i = 3, 0, -1 do result[#result + 1] = band(rshift(val, i * 8), 0xFF) end
        end
        return result
    end
    local key_bytes = str_to_bytes(key)
    if #key_bytes > 64 then key_bytes = digest(key) end
    while #key_bytes < 64 do key_bytes[#key_bytes + 1] = 0 end
    local ipad, opad = {}, {}
    for i = 1, 64 do ipad[i] = bxor(key_bytes[i], 0x36); opad[i] = bxor(key_bytes[i], 0x5C) end
    local inner_payload = {}
    for _, b in ipairs(ipad) do inner_payload[#inner_payload + 1] = string.char(b) end
    for _, b in ipairs(str_to_bytes(message)) do inner_payload[#inner_payload + 1] = string.char(b) end
    local inner_hash = digest(table.concat(inner_payload))
    local outer_payload = {}
    for _, b in ipairs(opad) do outer_payload[#outer_payload + 1] = string.char(b) end
    for _, b in ipairs(inner_hash) do outer_payload[#outer_payload + 1] = string.char(b) end
    return bytes_to_hex(digest(table.concat(outer_payload)))
end)
local LP_WORKER = {}
local LP_WORKERS = (function()
    local ok, g = pcall(function() return (getgenv and getgenv()) or shared or _G end)
    if not ok or type(g) ~= _crqcum82("\146\140\150\151\103") then return {} end
    if type(g._lp_workers) ~= _crqcum82("\146\140\150\151\103") then g._lp_workers = {} end
    return g._lp_workers
end)()
local function lpSliceLimit()
    local now = os.clock()
    LP_WORKERS[LP_WORKER] = now
    local n = 0
    for k, t in pairs(LP_WORKERS) do
        if now - t > 0.25 then LP_WORKERS[k] = nil else n = n + 1 end
    end
    return 0.009 / math.max(1, n)
end
local FK = { sk = nil, ct = {}, HEX = {}, B64 = {} }
for i = 0, 9 do FK.HEX[48 + i] = i end
for i = 0, 5 do FK.HEX[97 + i] = 10 + i; FK.HEX[65 + i] = 10 + i end
do
    local alphabet = _crqcum82("\167\175\183\191\071\079\087\095\087\111\103\127\119\015\007\031\007\015\055\063\039\047\215\223\215\207\253\193\201\213\221\217\161\165\189\177\137\133\157\153\145\117\125\097\105\085\093\089\065\069\061\049\098\104\082\084\090\064\074\180\178\168\179\176")
    for i = 1, 64 do FK.B64[alphabet:byte(i)] = i - 1 end
end
FK.hexToBytes = (function(hex)
    local HEX, t = FK.HEX, {}
    for i = 1, #hex - 1, 2 do t[#t + 1] = string.char((HEX[hex:byte(i)] or 0) * 16 + (HEX[hex:byte(i + 1)] or 0)) end
    return table.concat(t)
end)
FK.toHex = (function(s)
    local t = {}
    for i = 1, #s do t[i] = string.format(_crqcum82("\195\221\198\131"), s:byte(i)) end
    return table.concat(t)
end)
FK.b64decode = (function(s)
    local B64 = {}
    do
        local alphabet = _crqcum82("\167\175\183\191\071\079\087\095\087\111\103\127\119\015\007\031\007\015\055\063\039\047\215\223\215\207\253\193\201\213\221\217\161\165\189\177\137\133\157\153\145\117\125\097\105\085\093\089\065\069\061\049\098\104\082\084\090\064\074\180\178\168\179\176")
        for i = 1, 64 do B64[string.byte(alphabet, i)] = i - 1 end
    end
    local unpack, schar, sbyte = table.unpack or unpack, string.char, string.byte
    local band, rshift = bit32.band, bit32.rshift
    local len, pad = #s, 0
    if sbyte(s, len) == 61 then pad = pad + 1 end
    if sbyte(s, len - 1) == 61 then pad = pad + 1 end
    local out, outn, i = {}, 0, 1
    local clock, sliceStart, wait = os.clock, os.clock(), task and task.wait
    while i <= len do
        local j = i + 4095
        if j > len then j = len end
        local src = { sbyte(s, i, j) }
        local dst, m = {}, 0
        for k = 1, #src, 4 do
            local n = (B64[src[k]] or 0) * 262144 + (B64[src[k + 1]] or 0) * 4096 + (B64[src[k + 2]] or 0) * 64 + (B64[src[k + 3]] or 0)
            dst[m + 1] = rshift(n, 16)
            dst[m + 2] = band(rshift(n, 8), 255)
            dst[m + 3] = band(n, 255)
            m = m + 3
        end
        if j == len then m = m - pad end
        outn = outn + 1
        out[outn] = schar(unpack(dst, 1, m))
        i = j + 1
        if wait and clock() - sliceStart > lpSliceLimit() then wait(); sliceStart = clock() end
    end
    return table.concat(out)
end)
FK.chacha = (function(key, nonce, data, offset)
    local bxor, lrot = bit32.bxor, bit32.lrotate
    local schar, sbyte, ssub, sunpack, spack = string.char, string.byte, string.sub, string.unpack, string.pack
    local function le32(s, o)
        local a, b, c, d = sbyte(s, o, o + 3)
        return a + b * 256 + c * 65536 + d * 16777216
    end
    local M = 4294967296
    local s0, s1, s2, s3 = 0x61707865, 0x3320646e, 0x79622d32, 0x6b206574
    local s4, s5, s6, s7 = le32(key, 1), le32(key, 5), le32(key, 9), le32(key, 13)
    local s8, s9, s10, s11 = le32(key, 17), le32(key, 21), le32(key, 25), le32(key, 29)
    local s13, s14, s15 = le32(nonce, 1), le32(nonce, 5), le32(nonce, 9)
    local FMT = _crqcum82("\218\164\192\178\054\064\036\094\042\108\024\122\014\008\124\006\098\020\080\034\070\048\180\206\186\220\168\234\158\248\140\246\242")
    local final, pos = #data, offset + 1
    local out, outn, counter = {}, 0, 0
    local doubleRounds = 4 
    local clock, sliceStart = os.clock, os.clock()
    while pos <= final do
        local n = final - pos + 1
        local chunk
        if n >= 64 then n = 64; chunk = ssub(data, pos, pos + 63)
        else chunk = ssub(data, pos, final) .. string.rep(_crqcum82("\230"), 64 - n) end
        local d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15 = sunpack(FMT, chunk)
        local x0, x1, x2, x3 = s0, s1, s2, s3
        local x4, x5, x6, x7 = s4, s5, s6, s7
        local x8, x9, x10, x11 = s8, s9, s10, s11
        local x12, x13, x14, x15 = counter, s13, s14, s15
        for _ = 1, doubleRounds do
            x0=(x0+x4)%M; x12=lrot(bxor(x12,x0),16); x8=(x8+x12)%M; x4=lrot(bxor(x4,x8),12); x0=(x0+x4)%M; x12=lrot(bxor(x12,x0),8); x8=(x8+x12)%M; x4=lrot(bxor(x4,x8),7)
            x1=(x1+x5)%M; x13=lrot(bxor(x13,x1),16); x9=(x9+x13)%M; x5=lrot(bxor(x5,x9),12); x1=(x1+x5)%M; x13=lrot(bxor(x13,x1),8); x9=(x9+x13)%M; x5=lrot(bxor(x5,x9),7)
            x2=(x2+x6)%M; x14=lrot(bxor(x14,x2),16); x10=(x10+x14)%M; x6=lrot(bxor(x6,x10),12); x2=(x2+x6)%M; x14=lrot(bxor(x14,x2),8); x10=(x10+x14)%M; x6=lrot(bxor(x6,x10),7)
            x3=(x3+x7)%M; x15=lrot(bxor(x15,x3),16); x11=(x11+x15)%M; x7=lrot(bxor(x7,x11),12); x3=(x3+x7)%M; x15=lrot(bxor(x15,x3),8); x11=(x11+x15)%M; x7=lrot(bxor(x7,x11),7)
            x0=(x0+x5)%M; x15=lrot(bxor(x15,x0),16); x10=(x10+x15)%M; x5=lrot(bxor(x5,x10),12); x0=(x0+x5)%M; x15=lrot(bxor(x15,x0),8); x10=(x10+x15)%M; x5=lrot(bxor(x5,x10),7)
            x1=(x1+x6)%M; x12=lrot(bxor(x12,x1),16); x11=(x11+x12)%M; x6=lrot(bxor(x6,x11),12); x1=(x1+x6)%M; x12=lrot(bxor(x12,x1),8); x11=(x11+x12)%M; x6=lrot(bxor(x6,x11),7)
            x2=(x2+x7)%M; x13=lrot(bxor(x13,x2),16); x8=(x8+x13)%M; x7=lrot(bxor(x7,x8),12); x2=(x2+x7)%M; x13=lrot(bxor(x13,x2),8); x8=(x8+x13)%M; x7=lrot(bxor(x7,x8),7)
            x3=(x3+x4)%M; x14=lrot(bxor(x14,x3),16); x9=(x9+x14)%M; x4=lrot(bxor(x4,x9),12); x3=(x3+x4)%M; x14=lrot(bxor(x14,x3),8); x9=(x9+x14)%M; x4=lrot(bxor(x4,x9),7)
        end
        local piece = spack(FMT,
            bxor(d0,(x0+s0)%M), bxor(d1,(x1+s1)%M), bxor(d2,(x2+s2)%M), bxor(d3,(x3+s3)%M),
            bxor(d4,(x4+s4)%M), bxor(d5,(x5+s5)%M), bxor(d6,(x6+s6)%M), bxor(d7,(x7+s7)%M),
            bxor(d8,(x8+s8)%M), bxor(d9,(x9+s9)%M), bxor(d10,(x10+s10)%M), bxor(d11,(x11+s11)%M),
            bxor(d12,(x12+counter)%M), bxor(d13,(x13+s13)%M), bxor(d14,(x14+s14)%M), bxor(d15,(x15+s15)%M))
        outn = outn + 1
        out[outn] = n == 64 and piece or ssub(piece, 1, n)
        pos = pos + n
        counter = counter + 1
        if counter % 16 == 0 and clock() - sliceStart > lpSliceLimit() then task.wait(); sliceStart = clock() end
    end
    return table.concat(out)
end)
FK.unpack = (function(pt)
    local sbyte, ssub, schar = string.byte, string.sub, string.char
    local tmove, unpack = table.move, table.unpack or unpack
    local flag = sbyte(pt, 1)
    if flag == 0 then return ssub(pt, 2) end
    if flag ~= 1 then return nil, _crqcum82("\132\140\144\219\100\102\098\122\127\081") end
    local a, b, c, d = sbyte(pt, 2, 5)
    local outLen = a + b * 256 + c * 65536 + d * 16777216
    local buf = table.create and table.create(outLen) or {}
    local n, ip, op = #pt, 6, 0
    local clock, sliceStart, seqs = os.clock, os.clock(), 0
    while ip <= n do
        local token = sbyte(pt, ip); ip = ip + 1
        local litLen = (token - token % 16) / 16
        if litLen == 15 then
            local e
            repeat e = sbyte(pt, ip); ip = ip + 1; litLen = litLen + e until e ~= 255
        end
        if litLen > 0 then
            local s, last = ip, ip + litLen - 1
            while s <= last do
                local t = s + 3999
                if t > last then t = last end
                tmove({ sbyte(pt, s, t) }, 1, t - s + 1, op + 1, buf)
                op = op + (t - s + 1)
                s = t + 1
            end
            ip = last + 1
        end
        if ip > n then break end
        local o1, o2 = sbyte(pt, ip, ip + 1); ip = ip + 2
        local offset = o1 + o2 * 256
        local ml = token % 16
        if ml == 15 then
            local e
            repeat e = sbyte(pt, ip); ip = ip + 1; ml = ml + e until e ~= 255
        end
        ml = ml + 4
        local from = op - offset + 1
        if offset == 0 or from < 1 then return nil, _crqcum82("\132\140\144\219\111\104\100\116\118") end
        if offset >= ml then
            tmove(buf, from, from + ml - 1, op + 1)
        else
            for k = 0, ml - 1 do buf[op + 1 + k] = buf[from + k] end
        end
        op = op + ml
        seqs = seqs + 1
        if seqs % 32 == 0 and clock() - sliceStart > lpSliceLimit() then task.wait(); sliceStart = clock() end
    end
    if op ~= outLen then return nil, _crqcum82("\138\136\154\156\118\097\048\122\119\086\065\082\078\034\032") end
    local out, outn = {}, 0
    for i = 1, op, 4000 do
        outn = outn + 1
        out[outn] = schar(unpack(buf, i, math.min(i + 3999, op)))
    end
    return table.concat(out)
end)
FK.polyHash = (function(raw, r1, r2, r3, r4)
    local byte = string.byte
    local P = 67108859
    local h1, h2, h3, h4 = 0, 0, 0, 0
    local n = #raw
    local full = n - n % 3
    local clock, sliceStart, wait = os.clock, os.clock(), task and task.wait
    for i = 1, full, 3 do
        if i % 24576 == 1 and wait and clock() - sliceStart > lpSliceLimit() then wait(); sliceStart = clock() end
        local a, b, c = byte(raw, i, i + 2)
        local m = a * 65536 + b * 256 + c
        h1 = (h1 * r1 + m) % P
        h2 = (h2 * r2 + m) % P
        h3 = (h3 * r3 + m) % P
        h4 = (h4 * r4 + m) % P
    end
    local rem = n - full
    if rem > 0 then
        local m
        if rem == 1 then
            m = byte(raw, full + 1)
        else
            local a, b = byte(raw, full + 1, full + 2)
            m = a * 256 + b
        end
        h1 = (h1 * r1 + m) % P
        h2 = (h2 * r2 + m) % P
        h3 = (h3 * r3 + m) % P
        h4 = (h4 * r4 + m) % P
    end
    local len = n % P
    return (h1 * r1 + len) % P, (h2 * r2 + len) % P, (h3 * r3 + len) % P, (h4 * r4 + len) % P
end)
FK.fullTag = (function(skHex, blockId, raw)
    local P = 67108859
    local h = sha256.hmac(skHex, _crqcum82("\128\134\153\144\056") .. blockId .. _crqcum82("\220") .. #raw .. _crqcum82("\220") .. FK.toHex(string.sub(raw, 1, 44)))
    local w = {}
    for i = 1, 8 do w[i] = tonumber(string.sub(h, (i - 1) * 8 + 1, i * 8), 16) end
    local h1, h2, h3, h4 = FK.polyHash(raw, 1 + w[1] % (P - 1), 1 + w[2] % (P - 1), 1 + w[3] % (P - 1), 1 + w[4] % (P - 1))
    return string.format(_crqcum82("\195\221\195\131\039\057\039\111\059\021\027\075\031\113\127\055"), (h1 + w[5]) % P, (h2 + w[6]) % P, (h3 + w[7]) % P, (h4 + w[8]) % P)
end)
FK.decrypt = function(ent, blockId)
    local sk = (type(ent) == _crqcum82("\146\140\150\151\103") and type(ent.k) == _crqcum82("\149\153\134\146\108\110") and ent.k ~= _crqcum82("")) and ent.k or FK.sk
    if type(sk) ~= _crqcum82("\149\153\134\146\108\110") or sk == _crqcum82("") then return nil, _crqcum82("\136\130\212\136\103\122\099\126\113\075\012\088\095\056") end
    if type(ent) ~= _crqcum82("\146\140\150\151\103") or type(ent.b) ~= _crqcum82("\149\153\134\146\108\110") or type(ent.w) ~= _crqcum82("\149\153\134\146\108\110") or #ent.b < 60 then return nil, _crqcum82("\132\140\144\219\096\101\127\116\117") end
    local raw = FK.b64decode(ent.b)
    ent.b = nil
    if #raw < 44 then return nil, _crqcum82("\132\140\144\219\096\101\127\116\117") end
    if type(ent.s) ~= _crqcum82("\149\153\134\146\108\110") or FK.fullTag(sk, blockId, raw) ~= ent.s then lpMark(_crqcum82("\132\129\155\153\034\068\081\084\062\099\109\122\118\004\012\111") .. tostring(blockId)); return nil, _crqcum82("\132\129\155\153\034\068\081\084\062\067\077\090\086\036\044") end
    lpMark(_crqcum82("\132\129\155\153\034\068\081\084\062\074\071\019") .. tostring(blockId))
    local pad = FK.hexToBytes(sha256.hmac(sk, _crqcum82("\128\134\131\137\099\121\042") .. blockId))
    local w = FK.hexToBytes(ent.w)
    if #pad ~= 32 or #w ~= 32 then return nil, _crqcum82("\132\140\144\219\105\108\105") end
    local kb = {}
    for i = 1, 32 do kb[i] = string.char(bit32.bxor(w:byte(i), pad:byte(i))) end
    local bk = table.concat(kb)
    local bkHex = FK.toHex(bk)
    local nonce = raw:sub(33, 44)
    local clen = #raw - 44
    local lenLE = string.char(clen % 256, math.floor(clen / 256) % 256, math.floor(clen / 65536) % 256, math.floor(clen / 16777216) % 256)
    if sha256.hmac(bkHex, _crqcum82("\138\157\146\144\054") .. nonce .. lenLE .. raw:sub(45, 44 + 8192)) ~= FK.toHex(raw:sub(1, 32)) then
        return nil, _crqcum82("\143\131\128\158\101\123\121\099\103\005\079\091\095\034\035\111\048\060\013\007\023\029")
    end
    local packed = FK.chacha(bk, nonce, raw, 44)
    raw = nil
    return FK.unpack(packed)
end
FK.get = function(blockId)
    local waited = 0
    while not FK.ct[blockId] and waited < 60 do task.wait(0.1); waited = waited + 0.1 end
    local ent = FK.ct[blockId]
    if type(ent) ~= _crqcum82("\146\140\150\151\103") then return nil end
    if blockId == _crqcum82("\128\134\171\150\099\096\126") then FK.ct[blockId] = nil end
    lpMark(_crqcum82("\150\159\145\139\099\123\121\121\121\005\095\080\072\040\056\059"))
    local decT = os.clock()
    local src, err = FK.decrypt(ent, blockId)
    LP_DEC.ms = LP_DEC.ms + (os.clock() - decT) * 1000
    lpMark(_crqcum82("\149\142\134\146\114\125\048\103\108\064\092\082\072\036\044"))
    if not src then runnerWarn(_crqcum82("\163\131\151\137\123\121\100\114\122\005\095\080\072\040\056\059\118\062\011\030\030\029\160\233\225\225\188\193\207\145\205\209\170\162\183\176\135\141\208\223") .. tostring(err) .. _crqcum82("\207")) end
    return src
end
pcall(function() if getgenv then getgenv().__LP_FK = FK.get end end)
pcall(function() if _G then _G.__LP_FK = FK.get end end)
lpMark(_crqcum82("\138\130\149\159\103\123\048\100\106\068\094\071\095\037"))
local decryptXORNative = (function(hexText, secret)
    local HEX_NIBBLE = {}
    for i = 0, 9 do HEX_NIBBLE[48 + i] = i end
    for i = 0, 5 do HEX_NIBBLE[97 + i] = 10 + i; HEX_NIBBLE[65 + i] = 10 + i end
    local DECRYPT_BATCH = 4096          
    local DECRYPT_YIELD_EVERY = 262144  
    local unpack = table.unpack or unpack
    local n = #secret
    local keyBytes = { string.byte(secret, 1, n) }
    local stream = {}
    for r = 0, n - 1 do
        stream[r] = keyBytes[((r + keyBytes[r + 1]) % n) + 1]
    end
    local bxor, char, sbyte, concat = bit32.bxor, string.char, string.byte, table.concat
    local total = #hexText
    local canYield = total > DECRYPT_YIELD_EVERY and task and task.wait
    local out = {}
    local r = 0
    local sliceStart = os.clock()
    local i = 1
    while i <= total do
        local j = i + DECRYPT_BATCH - 1
        if j > total then j = total end
        local bytes = { sbyte(hexText, i, j) }
        local batch = {}
        local bn = 0
        for k = 1, #bytes - 1, 2 do
            local hi, lo = HEX_NIBBLE[bytes[k]], HEX_NIBBLE[bytes[k + 1]]
            if hi and lo then
                bn = bn + 1
                batch[bn] = bxor(hi * 16 + lo, stream[r])
                r = r + 1
                if r == n then r = 0 end
            end
        end
        local parts = {}
        for s = 1, bn, 1024 do
            local e = s + 1023
            if e > bn then e = bn end
            parts[#parts + 1] = char(unpack(batch, s, e))
        end
        out[#out + 1] = concat(parts)
        i = j + 1
        if canYield and os.clock() - sliceStart > lpSliceLimit() then
            task.wait()
            sliceStart = os.clock()
        end
    end
    return concat(out)
end)
local TOKEN_KEY = nil
local function decryptXOR(hexText, seedKey)
    return decryptXORNative(hexText, seedKey .. (TOKEN_KEY or SECRET_KEY))
end
local DEVICE_ID_FILE = _crqcum82("\138\152\149\139\112\102\100\114\125\081\115\087\095\055\033\044\051\115\013\015")
local function persistentDeviceId()
    local id
    pcall(function()
        if isfile and readfile and isfile(DEVICE_ID_FILE) then
            local saved = tostring(readfile(DEVICE_ID_FILE)):gsub(_crqcum82("\195\158"), _crqcum82(""))
            if saved:match(_crqcum82("\184\161\164\222\047\044\104\060\058")) and #saved >= 35 then id = saved end
        end
    end)
    if id then return id end
    pcall(function()
        if not writefile then return end
        local http = game:GetService(_crqcum82("\174\153\128\139\081\108\098\097\119\070\073"))
        local fresh = _crqcum82("\170\189\217") .. (http:GenerateGUID(false) .. http:GenerateGUID(false)):gsub(_crqcum82("\189\179\209\131\095"), _crqcum82("")):lower()
        writefile(DEVICE_ID_FILE, fresh)
        if isfile and readfile and isfile(DEVICE_ID_FILE) and tostring(readfile(DEVICE_ID_FILE)):gsub(_crqcum82("\195\158"), _crqcum82("")) == fresh then id = fresh end
    end)
    return id
end
local hwid = _crqcum82("\160\140\152\151\096\104\115\124\051\109\123\122\126\108") .. tostring(userId)
pcall(function()
    if gethwid then hwid = gethwid()
    elseif syn and syn.gethwid then hwid = syn.gethwid()
    else hwid = persistentDeviceId() or hwid end
end)
local executor = _crqcum82("\179\131\159\149\109\126\126")
pcall(function()
    local function getVal(fnName)
        if getgenv then
            local ok, val = pcall(function() return getgenv()[fnName] end)
            if ok and val ~= nil then return val end
        end
        if _G then
            local ok, val = pcall(function() return _G[fnName] end)
            if ok and val ~= nil then return val end
        end
        if shared then
            local ok, val = pcall(function() return shared[fnName] end)
            if ok and val ~= nil then return val end
        end
        local bare = ({
            identifyexecutor = function() return identifyexecutor end,
            getexecutorname = function() return getexecutorname end,
            getexecutor = function() return getexecutor end,
            getexecutorinfo = function() return getexecutorinfo end,
        })[fnName]
        if bare then
            local ok, val = pcall(bare)
            if ok and val ~= nil then return val end
        end
        return nil
    end
    local idFn = getVal(_crqcum82("\143\137\145\149\118\096\118\110\123\093\073\080\079\053\039\061"))
        or getVal(_crqcum82("\129\136\128\158\122\108\115\098\106\074\094\093\091\044\045"))
        or getVal(_crqcum82("\129\136\128\158\122\108\115\098\106\074\094"))
        or (syn and syn.identifyexecutor)
        or (delta and delta.identifyexecutor)
        or (fluxus and fluxus.identifyexecutor)
    if type(idFn) == _crqcum82("\128\152\154\152\118\096\127\121") then
        local ok, res1, res2 = pcall(idFn)
        if ok and res1 then
            if type(res1) == _crqcum82("\149\153\134\146\108\110") and res1 ~= _crqcum82("") then
                local ver = (type(res2) == _crqcum82("\149\153\134\146\108\110") and res2 ~= _crqcum82("")) and (_crqcum82("\198") .. res2) or _crqcum82("")
                executor = res1 .. ver
            elseif type(res1) == _crqcum82("\146\140\150\151\103") then
                executor = tostring(res1.name or res1.Name or res1[1] or _crqcum82("\179\131\159\149\109\126\126"))
            end
        end
    end
    if executor == _crqcum82("\179\131\159\149\109\126\126") then
        local infoFn = getVal(_crqcum82("\129\136\128\158\122\108\115\098\106\074\094\090\084\039\039"))
        if type(infoFn) == _crqcum82("\128\152\154\152\118\096\127\121") then
            local ok, info = pcall(infoFn)
            if ok and info then
                if type(info) == _crqcum82("\146\140\150\151\103") then
                    executor = tostring(info.name or info.Name or info[1] or _crqcum82("\179\131\159\149\109\126\126"))
                elseif type(info) == _crqcum82("\149\153\134\146\108\110") and info ~= _crqcum82("") then
                    executor = info
                end
            end
        end
    end
    if executor == _crqcum82("\179\131\159\149\109\126\126") then
        if getVal(_crqcum82("\182\162\160\186\081\090\089\066\083\122\096\124\123\005\013\011")) or getVal(_crqcum82("\150\130\128\154\113\122\121\098\115")) then executor = _crqcum82("\182\130\128\154\113\122\121\098\115")
        elseif getVal(_crqcum82("\181\162\184\186\080\072\079\091\081\100\104\118\126")) or getVal(_crqcum82("\149\130\152\154\112\104")) then executor = _crqcum82("\181\130\152\154\112\104")
        elseif getVal(_crqcum82("\177\172\162\190\093\069\095\086\090\096\104")) or getVal(_crqcum82("\145\140\130\158")) then executor = _crqcum82("\177\140\130\158")
        elseif getVal(_crqcum82("\162\168\184\175\067\086\092\088\095\097\105\119")) or getVal(_crqcum82("\130\136\152\143\099")) then executor = _crqcum82("\162\136\152\143\099")
        elseif getVal(_crqcum82("\165\162\176\190\090\086\092\088\095\097\105\119")) or getVal(_crqcum82("\133\130\144\158\122")) then executor = _crqcum82("\165\130\144\158\122")
        elseif getVal(_crqcum82("\171\172\183\168\082\069\095\094\074\122\096\124\123\005\013\011")) or getVal(_crqcum82("\139\140\151\136\114\101\127\126\106")) then executor = _crqcum82("\171\140\151\168\114\101\127\126\106")
        elseif getVal(_crqcum82("\176\168\184\180\065\064\068\078\065\105\099\114\126\004\012")) or getVal(_crqcum82("\144\136\152\148\097\096\100\110")) then executor = _crqcum82("\176\136\152\148\097\096\100\110")
        elseif getVal(_crqcum82("\176\162\184\175\093\069\095\086\090\096\104")) or getVal(_crqcum82("\144\130\152\143")) then executor = _crqcum82("\176\130\152\143")
        elseif getVal(_crqcum82("\190\168\186\180\093\069\095\086\090\096\104")) or getVal(_crqcum82("\158\136\154\148")) then executor = _crqcum82("\190\136\154\148")
        elseif getVal(_crqcum82("\181\186\189\189\086\086\092\088\095\097\105\119")) or getVal(_crqcum82("\149\154\157\157\118")) then executor = _crqcum82("\181\154\157\157\118")
        elseif getVal(_crqcum82("\173\191\186\183\093\069\095\086\090\096\104")) or getVal(_crqcum82("\141\159\154\151")) then executor = _crqcum82("\173\191\186\183")
        elseif getVal(_crqcum82("\174\180\176\169\077\078\085\089\065\105\099\114\126\004\012")) or getVal(_crqcum82("\142\148\144\137\109\110\117\121")) then executor = _crqcum82("\174\148\144\137\109\110\117\121")
        elseif getVal(_crqcum82("\160\161\161\163\087\090\079\091\081\100\104\118\126")) or getVal(_crqcum82("\128\129\129\131\119\122")) then executor = _crqcum82("\160\129\129\131\119\122")
        elseif getVal(_crqcum82("\167\191\183\190\087\090\079\091\081\100\104\118\126")) or getVal(_crqcum82("\135\159\151\158\119\122")) then executor = _crqcum82("\167\159\151\158\119\122")
        elseif getVal(_crqcum82("\165\168\184\190\080\080\079\091\081\100\104\118\126")) or getVal(_crqcum82("\133\136\152\158\112\112")) then executor = _crqcum82("\165\136\152\158\112\112")
        elseif getVal(_crqcum82("\167\189\164\183\071\094\081\069\091\122\096\124\123\005\013\011")) or getVal(_crqcum82("\135\157\132\151\103\126\113\101\123")) then executor = _crqcum82("\167\157\132\151\103\126\113\101\123")
        elseif getVal(_crqcum82("\165\184\182\178\090\086\092\088\095\097\105\119")) or getVal(_crqcum82("\133\152\150\146\122")) then executor = _crqcum82("\165\152\150\146\122")
        elseif getVal(_crqcum82("\168\168\174\174\080\086\092\088\095\097\105\119")) or getVal(_crqcum82("\136\136\142\142\112")) then executor = _crqcum82("\168\136\142\142\112")
        elseif getVal(_crqcum82("\180\168\181\183\093\069\095\086\090\096\104")) or getVal(_crqcum82("\148\136\149\151")) then executor = _crqcum82("\180\136\149\151")
        elseif getVal(_crqcum82("\171\172\176\178\087\068\079\091\081\100\104\118\126")) or getVal(_crqcum82("\139\140\144\146\119\100")) then executor = _crqcum82("\171\140\144\146\119\100")
        elseif getVal(_crqcum82("\165\162\167\182\075\074\079\091\081\100\104\118\126")) or getVal(_crqcum82("\133\130\135\150\107\106")) then executor = _crqcum82("\165\130\135\150\107\106")
        elseif syn then executor = _crqcum82("\181\148\154\154\114\122\117") end
    end
end)
local isLowSyncExecutor = false
pcall(function()
    local execLower = string.lower(tostring(executor or _crqcum82("")))
    isLowSyncExecutor = execLower:find(_crqcum82("\158\136\154\148"), 1, true) ~= nil
        or execLower:find(_crqcum82("\149\130\152\154\112\104"), 1, true) ~= nil
        or execLower:find(_crqcum82("\130\136\152\143\099"), 1, true) ~= nil
        or execLower:find(_crqcum82("\150\130\128\154\113\122\121\098\115"), 1, true) ~= nil
        or execLower:find(_crqcum82("\135\159\151\158\119\122"), 1, true) ~= nil
        or execLower:find(_crqcum82("\184\159\145\154\110\044\118\076\059\100\113")) ~= nil
end)
local isEnvironmentTampered = false
pcall(function()
    if type(math) ~= _crqcum82("\146\140\150\151\103") or type(math.floor) ~= _crqcum82("\128\152\154\152\118\096\127\121") then isEnvironmentTampered = true end
    if type(string) ~= _crqcum82("\146\140\150\151\103") or type(string.byte) ~= _crqcum82("\128\152\154\152\118\096\127\121") or type(string.char) ~= _crqcum82("\128\152\154\152\118\096\127\121") then isEnvironmentTampered = true end
    if type(table) ~= _crqcum82("\146\140\150\151\103") or type(table.concat) ~= _crqcum82("\128\152\154\152\118\096\127\121") or type(table.insert) ~= _crqcum82("\128\152\154\152\118\096\127\121") then isEnvironmentTampered = true end
    if type(bit32) ~= _crqcum82("\146\140\150\151\103") or type(bit32.bxor) ~= _crqcum82("\128\152\154\152\118\096\127\121") then isEnvironmentTampered = true end
end)
if isEnvironmentTampered then
    SECRET_KEY = string.reverse(tostring(SECRET_KEY)) .. _crqcum82("\185\185\181\182\082\076\066\082\090")
end
local SCRIPT_TAG = (SCRIPT_ID ~= _crqcum82("") and SCRIPT_ID ~= "1_rQjbldjgp80dMJ") and tostring(SCRIPT_ID) or _crqcum82("\130\136\146\154\119\101\100")
local _LP_STORE = nil
pcall(function()
    local g = (getgenv and getgenv()) or shared or _G
    if g then
        if type(g._luaprotect_store) ~= _crqcum82("\146\140\150\151\103") then
            g._luaprotect_store = {
                sockets = {},
                sessions = {},
                invocations = {},
                executed = {},
                keys = {},
                rids = {},
                run_ids = {}
            }
        end
        _LP_STORE = g._luaprotect_store
        if type(_LP_STORE.closed) ~= _crqcum82("\146\140\150\151\103") then _LP_STORE.closed = setmetatable({}, { __mode = _crqcum82("\141") }) end
        if getgenv then getgenv()._luaprotect_store = _LP_STORE end
        if shared then shared._luaprotect_store = _LP_STORE end
        if _G then _G._luaprotect_store = _LP_STORE end
    end
end)
if _LP_STORE then
    if _LP_STORE.fk_keys and _LP_STORE.fk_keys[SCRIPT_TAG] then FK.sk = _LP_STORE.fk_keys[SCRIPT_TAG] end
end
lpMark(_crqcum82("\149\153\155\137\103\041\098\114\127\065\085"))
local _SAFE_GE = safeGenv()
local _PARENT_WS = (_LP_STORE and _LP_STORE.sockets[SCRIPT_TAG]) or (SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") and ((_SAFE_GE and _SAFE_GE.sentinel_ws) or (shared and shared.sentinel_ws) or (_G and _G.sentinel_ws)) or nil)
local _PARENT_KEY = (_LP_STORE and _LP_STORE.keys[SCRIPT_TAG]) or (SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") and ((_SAFE_GE and _SAFE_GE._luaprotect_key) or (shared and shared._luaprotect_key) or (_G and _G._luaprotect_key)) or nil)
local _PERSISTED_RUNNER_ID = (_LP_STORE and _LP_STORE.rids[SCRIPT_TAG]) or (SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") and ((_SAFE_GE and _SAFE_GE._luaprotect_rid) or (shared and shared._luaprotect_rid) or (_G and _G._luaprotect_rid)) or nil)
local _PERSISTED_RUN_ID = (_LP_STORE and _LP_STORE.run_ids[SCRIPT_TAG]) or (SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") and ((_SAFE_GE and _SAFE_GE._luaprotect_run_id) or (shared and shared._luaprotect_run_id) or (_G and _G._luaprotect_run_id)) or nil)
if IS_TELEPORT_RECONNECT then
    if HANDOFF_RUNNER_ID ~= _crqcum82("") then _PERSISTED_RUNNER_ID = HANDOFF_RUNNER_ID end
    if HANDOFF_KEY ~= _crqcum82("") then _PARENT_KEY = HANDOFF_KEY end
    if HANDOFF_RUN_ID ~= _crqcum82("") then _PERSISTED_RUN_ID = HANDOFF_RUN_ID end
end
local IS_NESTED_IMPORT = ((_CFG.NESTED_IMPORT ~= nil and _CFG.NESTED_IMPORT ~= _crqcum82("")) and _CFG.NESTED_IMPORT or "0") == _crqcum82("\215")
local IS_FRESH_FALLBACK = false
local MY_LAST_CONNECT_ATTEMPT = 0
local INVOCATION_MARKER = table.concat({
    tostring(os.time()),
    tostring(math.floor(os.clock() * 1000000)),
    tostring(math.random(100000, 999999)),
    tostring({})
}, _crqcum82("\220"))
local INVOCATION_OWNER = (safeGenv() and safeGenv().sentinel_invocation)
    or (shared and shared.sentinel_invocation)
    or (_G and _G.sentinel_invocation)
if _LP_STORE and _LP_STORE.invocations[SCRIPT_TAG] then
    INVOCATION_OWNER = _LP_STORE.invocations[SCRIPT_TAG]
elseif SCRIPT_TAG ~= _crqcum82("\130\136\146\154\119\101\100") then
    INVOCATION_OWNER = nil
end
if not IS_NESTED_IMPORT and not IS_TELEPORT_RECONNECT then
    if _LP_STORE then _LP_STORE.invocations[SCRIPT_TAG] = INVOCATION_MARKER end
    if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
        do local _ge = safeGenv(); if _ge then _ge.sentinel_invocation = INVOCATION_MARKER end end
        if shared then shared.sentinel_invocation = INVOCATION_MARKER end
        if _G then _G.sentinel_invocation = INVOCATION_MARKER end
    end
    INVOCATION_OWNER = INVOCATION_MARKER
    if _LP_STORE then _LP_STORE.executed[SCRIPT_TAG] = {} end
    if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
        do local _ge = safeGenv(); if _ge then _ge._luaprotect_executed = {} end end
        if shared then shared._luaprotect_executed = {} end
        if _G then _G._luaprotect_executed = {} end
    end
end
local canUseParentImport = false
if IS_NESTED_IMPORT and not canUseParentImport then
    IS_FRESH_FALLBACK = true
end
if canUseParentImport then
    local parentImportSucceeded = false
    local requestFunc = (syn and syn.request) or request or http_request or (http and http.request)
    local childRunnerId, childKey = nil, nil
    local importCheck = nil
    local importRequestId = nil
    do
        local keyUrl = HOST_URL .. _crqcum82("\201\140\132\146\045\123\101\121\112\064\094\030\081\036\049\112\037\062\022\002\002\013\201\227\179") .. SCRIPT_ID
        local keyBody = nil
        local IMPORT_KEY_MAX_RETRIES = 3
        for _attempt = 1, IMPORT_KEY_MAX_RETRIES do
            keyBody = nil
            importCheck = nil
            local requestTransportFailed = false
            if requestFunc then
                local ok, res = pcall(requestFunc, { Url = keyUrl, Method = _crqcum82("\161\168\160") })
                if ok and res then
                    importCheck = tostring(res.StatusCode or res.status or _crqcum82("\147\131\159\149\109\126\126"))
                    importRequestId = res.Headers and (res.Headers[_crqcum82("\190\192\184\142\099\089\098\120\106\064\079\071\023\019\045\062\035\056\023\031\095\048\228")] or res.Headers[_crqcum82("\158\192\152\142\099\121\098\120\106\064\079\071\023\051\045\062\035\056\023\031\095\016\228")])
                    local statusCode = tonumber(res.StatusCode or res.status)
                    if statusCode == 200 then
                        keyBody = res.Body
                    elseif statusCode == 429 then
                        local retryAfter = 5
                        pcall(function()
                            local h = res.Headers or res.headers or {}
                            local ra = h[_crqcum82("\180\136\128\137\123\036\081\113\106\064\094")] or h[_crqcum82("\148\136\128\137\123\036\113\113\106\064\094")]
                            if ra then retryAfter = tonumber(ra) or 5 end
                        end)
                        waitWithCountdown(retryAfter)
                    end
                else
                    importCheck = _crqcum82("\148\136\133\142\103\122\100\058\123\087\094\092\072")
                    requestTransportFailed = true
                end
            else
                requestTransportFailed = true
            end
            if not keyBody and requestTransportFailed and statusCode ~= 429 then
                local ok, response = pcall(function() return game:HttpGet(keyUrl) end)
                if ok then keyBody = response else importCheck = importCheck or _crqcum82("\142\153\128\139\101\108\100\058\123\087\094\092\072") end
            end
            if keyBody then break end
        end
        if keyBody then
            local ok, data = pcall(HttpService.JSONDecode, HttpService, keyBody)
            if ok and data and data.runnerId and data.key then
                childRunnerId = tostring(data.runnerId)
                childKey = tostring(data.key)
            end
        end
    end
    if childKey and childRunnerId then
        local url = HOST_URL .. (_crqcum82("\201\140\132\146\045\122\115\101\119\085\088\030\089\046\038\059\051\051\016\068")) .. SCRIPT_ID
        local timestamp = tostring(os.time())
        pcall(function()
            local serverTime = workspace:GetServerTimeNow()
            if serverTime and serverTime > 0 then timestamp = tostring(math.floor(serverTime)) end
        end)
        local chars = _crqcum82("\135\143\151\159\103\111\119\127\119\079\071\095\087\047\039\063\039\047\023\031\007\015\247\255\247\239\221\225\233\245\253\249\129\133\157\145\169\165\189\185\177\085\093\065\073\117\125\121\097\101\029\017\098\104\082\084\090\064\074\180\178\168")
        local nonce = {}
        local rng = Random.new()
        for _ = 1, (16) do
            local idx = rng:NextInteger(1, #chars)
            table.insert(nonce, chars:sub(idx, idx))
        end
        nonce = table.concat(nonce)
        local sigPayload = tostring(userId) .. _crqcum82("\200") .. tostring(hwid) .. _crqcum82("\200") .. timestamp .. _crqcum82("\200") .. nonce .. _crqcum82("\200\221")
        local signature = sha256.hmac(childKey, sigPayload)
        local body = nil
        local bodyFromSigned = false
        if requestFunc then
            local ok, res = pcall(requestFunc, { Url = url, Method = _crqcum82("\161\168\160"), Headers = {
                [_crqcum82("\190\192\167\146\101\103\113\099\107\087\073")] = signature, [_crqcum82("\190\192\160\146\111\108\099\099\127\072\092")] = timestamp, [_crqcum82("\190\192\186\148\108\106\117")] = nonce,
                [_crqcum82("\190\192\161\136\103\123\061\094\122")] = tostring(userId), [_crqcum82("\190\192\188\140\107\109")] = tostring(hwid), [_crqcum82("\190\192\166\142\108\103\117\101\051\108\072")] = childRunnerId
            }})
            if ok and res and res.StatusCode == 200 then body = res.Body; bodyFromSigned = true end
        end
        if not body and not bodyFromSigned then
            importCheck = importCheck or _crqcum82("\149\132\147\149\103\109\061\101\123\084\089\086\073\053\101\041\055\052\008\014\022")
        end
        if body then
            local refused = false
            if not bodyFromSigned then
                if body:sub(1, 1) == _crqcum82("\157") then
                    pcall(function()
                        local data = HttpService:JSONDecode(body)
                        if data and (data.error or data.message) then
                            runnerWarn(_crqcum82("\175\128\132\148\112\125\048\114\108\087\067\065\000\097") .. tostring(data.error or data.message))
                        end
                    end)
                    refused = true
                elseif body:sub(1, 2) == _crqcum82("\203\192") then
                    runnerWarn(_crqcum82("\175\128\132\148\112\125\048\101\123\067\089\064\095\037\114\111") .. body:sub(1, 120))
                    refused = true
                end
            end
            if not refused then
                body = body:gsub(_crqcum82("\009\086\075"), _crqcum82(""))
                body = body:gsub(_crqcum82("\004\109\175\112\047\134\077"), _crqcum82(""))
                local fn, err = loadstring(body)
                if fn then
                    parentImportSucceeded = true
                    local execOk, execErr = pcall(fn)
                    if not execOk then
                        runnerWarn(_crqcum82("\175\128\132\148\112\125\048\114\102\064\079\070\078\040\039\033\118\056\022\025\029\011\186\167") .. tostring(execErr))
                    end
                else
                    runnerWarn(_crqcum82("\175\128\132\148\112\125\048\123\113\068\072\064\078\051\033\033\049\125\001\025\000\022\242\189\174") .. tostring(err))
                end
            end
        else
            local suffix = importCheck and (_crqcum82("\198\197\181\171\075\041\115\127\123\070\071\019") .. tostring(importCheck) .. (importRequestId and (_crqcum82("\202\205\134\158\115\124\117\100\106\005") .. tostring(importRequestId)) or _crqcum82("")) .. _crqcum82("\207")) or _crqcum82("")
            runnerQuiet(_crqcum82("\160\140\157\151\103\109\048\099\113\005\069\094\074\046\058\059\118\046\007\025\027\009\244\167") .. SCRIPT_ID .. suffix)
        end
    else
        runnerQuiet(_crqcum82("\165\130\129\151\102\041\126\120\106\005\065\090\084\053\104\038\059\045\011\025\006\089\235\226\247\181\250\204\216\145") .. SCRIPT_ID .. _crqcum82("\198\192\212\157\099\101\124\126\112\066\012\081\091\034\035\111\034\050\068\007\027\015\229\167\234\240\240\202\220\212\202\198"))
    end
    if parentImportSucceeded then return end
    IS_FRESH_FALLBACK = true
end
if IS_FRESH_FALLBACK and not IS_TELEPORT_RECONNECT then
    if _LP_STORE then _LP_STORE.invocations[SCRIPT_TAG] = INVOCATION_MARKER end
    if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
        do local _ge = safeGenv(); if _ge then _ge.sentinel_invocation = INVOCATION_MARKER end end
        if shared then shared.sentinel_invocation = INVOCATION_MARKER end
        if _G then _G.sentinel_invocation = INVOCATION_MARKER end
    end
    INVOCATION_OWNER = INVOCATION_MARKER
end
local function fetchRunnerKey(forceFresh)
    if not forceFresh and SECRET_KEY and SECRET_KEY ~= _crqcum82("") and SECRET_KEY ~= "f22a86589d655bd46f783d9761d418c8253becd147c69d3f61cf96173d5e58e9"
       and RUNNER_ID and RUNNER_ID ~= _crqcum82("") and RUNNER_ID ~= "671afb9c8c26a0f236683ac61b862e2e" then
        if _LP_STORE then
            _LP_STORE.keys[SCRIPT_TAG] = SECRET_KEY
            _LP_STORE.rids[SCRIPT_TAG] = RUNNER_ID
        end
        if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
            do
                local _ge = safeGenv()
                if _ge then
                    _ge._luaprotect_key = SECRET_KEY
                    _ge._luaprotect_rid = RUNNER_ID
                end
            end
            if shared then
                shared._luaprotect_key = SECRET_KEY
                shared._luaprotect_rid = RUNNER_ID
            end
            if _G then
                _G._luaprotect_key = SECRET_KEY
                _G._luaprotect_rid = RUNNER_ID
            end
        end
        return true
    end
    if IS_TELEPORT_RECONNECT and not forceFresh then
        if not _PERSISTED_RUNNER_ID or not _PERSISTED_RUN_ID or not _PARENT_KEY then
            runnerWarn(_crqcum82("\165\140\154\149\109\125\048\101\123\086\088\092\072\036\104\044\057\051\016\002\028\012\239\242\253\181\239\198\217\194\209\208\168\237\189\191\135\135\132\158\138\124\055\051\106\077\077\078\069\088\100\057\055\116\005\031\011\022\009\247\239\177\236\247\195\141\199\216\176\160\160\163"))
            return false
        end
        RUNNER_ID = tostring(_PERSISTED_RUNNER_ID)
        SECRET_KEY = tostring(_PARENT_KEY)
        return true
    end
    local url = HOST_URL .. (_crqcum82("\201\140\132\146\045\123\101\121\112\064\094\030\081\036\049"))
    if SCRIPT_ID ~= _crqcum82("") and SCRIPT_ID ~= "1_rQjbldjgp80dMJ" then url = url .. _crqcum82("\217\158\151\137\107\121\100\094\122\024") .. SCRIPT_ID end
    local body = nil
    local keyCheck = nil
    local KEY_FETCH_MAX_RETRIES = (3)
    for _attempt = 1, KEY_FETCH_MAX_RETRIES do
        body = nil
        keyCheck = nil
        local requestTransportFailed = false
        local statusCode = nil
        local requestFunc = (syn and syn.request) or request or http_request or (http and http.request)
        if requestFunc then
            local ok, res = pcall(requestFunc, {
                Url = url,
                url = url,
                Method = _crqcum82("\161\168\160"),
                method = _crqcum82("\161\168\160"),
                Headers = {
                    [_crqcum82("\179\158\145\137\047\072\119\114\112\081")] = (_crqcum82("\180\130\150\151\109\113\063\064\119\075\101\093\095\053")),
                },
            })
            if ok and type(res) == _crqcum82("\146\140\150\151\103") then
                statusCode = tonumber(res.StatusCode or res.status or res.status_code)
                keyCheck = tostring(statusCode or _crqcum82("\147\131\159\149\109\126\126"))
                if statusCode == 200 then
                    body = res.Body or res.body
                elseif statusCode == 429 then
                    local retryAfter = 5
                    pcall(function()
                        local h = res.Headers or res.headers or {}
                        local ra = h[_crqcum82("\180\136\128\137\123\036\081\113\106\064\094")] or h[_crqcum82("\148\136\128\137\123\036\113\113\106\064\094")]
                        if ra then retryAfter = tonumber(ra) or 5 end
                    end)
                    runnerWarn(_crqcum82("\180\152\154\149\103\123\048\124\123\092\012\085\095\053\043\039\118\047\005\031\023\084\236\238\227\252\232\198\206\145\144\139\244\244\253\251\207\201\130\146\138\119\117\122\116\070\008\070\088\029") .. retryAfter .. _crqcum82("\149"))
                    waitWithCountdown(retryAfter)
                else
                    requestTransportFailed = true
                end
            else
                keyCheck = _crqcum82("\148\136\133\142\103\122\100\058\123\087\094\092\072")
                requestTransportFailed = true
            end
        else
            requestTransportFailed = true
        end
        if not body and requestTransportFailed and (not statusCode or statusCode ~= 429) then
            local ok, response = pcall(function() return game:HttpGet(url) end)
            if ok and response and response ~= _crqcum82("") then
                body = response
            else
                keyCheck = keyCheck or _crqcum82("\142\153\128\139\101\108\100\058\123\087\094\092\072")
            end
        end
        if body then break end
        if _attempt < KEY_FETCH_MAX_RETRIES then task.wait(_attempt * 1.5) end
    end
    if body then
        local ok, data = pcall(HttpService.JSONDecode, HttpService, body)
        if ok and data and data.runnerId and data.key then
            RUNNER_ID = data.runnerId
            SECRET_KEY = data.key
            if _LP_STORE then
                _LP_STORE.keys[SCRIPT_TAG] = data.key
                _LP_STORE.rids[SCRIPT_TAG] = data.runnerId
            end
            if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
                do
                    local _ge = safeGenv()
                    if _ge then
                        _ge._luaprotect_key = data.key
                        _ge._luaprotect_rid = data.runnerId
                    end
                end
                if shared then
                    shared._luaprotect_key = data.key
                    shared._luaprotect_rid = data.runnerId
                end
                if _G then
                    _G._luaprotect_key = data.key
                    _G._luaprotect_rid = data.runnerId
                end
            end
            return true
        end
    end
    runnerWarn(_crqcum82("\160\140\157\151\103\109\048\099\113\005\074\086\078\034\032\111\036\040\010\005\023\011\160\236\235\236\188\139\235\225\241\159\165\165\177\184\137\201") .. tostring(keyCheck or _crqcum82("\147\131\159\149\109\126\126")) .. _crqcum82("\207"))
    return false
end
lpMark(_crqcum82("\133\129\155\136\107\103\119\055\113\073\072\019\073\046\043\036\051\041"))
pcall(function()
    local existing = (_LP_STORE and _LP_STORE.sockets[SCRIPT_TAG])
    if not existing and SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
        existing = (getgenv and getgenv().sentinel_ws)
            or (shared and shared.sentinel_ws)
            or (_G and _G.sentinel_ws)
    end
    if _LP_STORE then _LP_STORE.sockets[SCRIPT_TAG] = nil end
    if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
        if getgenv and getgenv().sentinel_ws == existing then getgenv().sentinel_ws = nil end
        if shared and shared.sentinel_ws == existing then shared.sentinel_ws = nil end
        if _G and _G.sentinel_ws == existing then _G.sentinel_ws = nil end
    end
end)
lpMark(_crqcum82("\137\129\144\219\113\102\115\124\123\081\012\080\086\046\059\042\050"))
LP_DEC.gc()
if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
    do local _ge = safeGenv(); if _ge then _ge.sentinel_reconnect = false end end
end
local function makeRequest(url, data, isReconnectFlag)
    local jsonStr = encodeJSON(data)
    local timestamp = tostring(os.time())
    pcall(function()
        local serverTime = workspace:GetServerTimeNow()
        if serverTime and serverTime > 0 then timestamp = tostring(math.floor(serverTime)) end
    end)
    local chars = _crqcum82("\135\143\151\159\103\111\119\127\119\079\071\095\087\047\039\063\039\047\023\031\007\015\247\255\247\239\221\225\233\245\253\249\129\133\157\145\169\165\189\185\177\085\093\065\073\117\125\121\097\101\029\017\098\104\082\084\090\064\074\180\178\168")
    local nonce = {}
    local rng = Random.new()
    for _ = 1, (16) do
        local idx = rng:NextInteger(1, #chars)
        table.insert(nonce, chars:sub(idx, idx))
    end
    nonce = table.concat(nonce)
    local reconnectBit = (function(flag) return flag and _crqcum82("\215") or _crqcum82("\214") end)(isReconnectFlag)
    local sigPayload = tostring(userId) .. _crqcum82("\200") .. tostring(hwid) .. _crqcum82("\200") .. timestamp .. _crqcum82("\200") .. nonce .. _crqcum82("\200") .. reconnectBit .. _crqcum82("\200") .. tostring(data.sessionId or _crqcum82("")) .. _crqcum82("\200") .. tostring(data.runId or _crqcum82(""))
    local signedWith = SECRET_KEY
    local isTokenRequest = url:find(_crqcum82("\201\140\132\146\045\104\101\099\118\010\088\092\081\036\038"), 1, true) ~= nil
    local signature = sha256.hmac(signedWith, sigPayload)
    local headers = {
        [_crqcum82("\165\130\154\143\103\103\100\058\074\092\092\086")] = _crqcum82("\135\157\132\151\107\106\113\099\119\074\066\028\080\050\039\033"), [_crqcum82("\179\158\145\137\047\072\119\114\112\081")] = (_crqcum82("\180\130\150\151\109\113\063\064\119\075\101\093\095\053")),
        [_crqcum82("\190\192\167\146\101\103\113\099\107\087\073")] = signature, [_crqcum82("\190\192\160\146\111\108\099\099\127\072\092")] = timestamp, [_crqcum82("\190\192\186\148\108\106\117")] = nonce,
    }
    local requestFunc = (syn and syn.request) or request or http_request or (http and http.request)
    if requestFunc then
        local ok, res = pcall(requestFunc, { Url = url, Method = _crqcum82("\182\162\167\175"), Headers = headers, Body = jsonStr })
        if ok and type(res) == _crqcum82("\146\140\150\151\103") then
            local sc = tonumber(res.StatusCode or res.status or res.status_code) or (res.Success == true and 200 or nil)
            res = { StatusCode = sc, Body = res.Body or res.body or _crqcum82(""), Headers = res.Headers or res.headers }
            if not sc then return false, _crqcum82("\168\168\160\172\077\091\091\072\091\119\126\124\104\097\058\042\037\045\011\005\001\028\160\239\239\241\188\205\197\145\203\203\167\185\161\168\194\138\159\147\155") end
            if sc <= 0 then return false, _crqcum82("\168\168\160\172\077\091\091\072\091\119\126\124\104\097\000\027\002\013\068") .. tostring(sc) .. _crqcum82("\198\197\154\148\034\123\117\100\110\074\066\064\095\097\046\061\057\048\068\031\026\028\160\244\235\231\234\198\216\152") end
            if res.StatusCode == 200 then
                if isTokenRequest then TOKEN_KEY = signedWith end
                return true, res.Body
            elseif res.StatusCode == 429 then
                local retryAfter = 5
                pcall(function()
                    local h = res.Headers or res.headers or {}
                    local ra = h[_crqcum82("\180\136\128\137\123\036\081\113\106\064\094")] or h[_crqcum82("\148\136\128\137\123\036\113\113\106\064\094")]
                    if ra then retryAfter = tonumber(ra) or 5 end
                end)
                return false, _crqcum82("\180\172\160\190\093\069\089\090\087\113\105\119"), retryAfter
            elseif res.StatusCode == 409 then
                return false, _crqcum82("\181\184\164\190\080\090\085\083\091\097")
            elseif res.StatusCode == 423 then
                local retryAfter = 5
                local restrictCode = _crqcum82("\177\191\187\181\069\086\087\086\083\096")
                local restrictMsg = _crqcum82("\178\133\157\136\034\122\115\101\119\085\088\019\083\050\104\035\057\062\015\014\022\089\244\232\174\244\188\199\195\215\222\218\180\168\186\175\194\142\145\154\155\043")
                pcall(function()
                    local h = res.Headers or res.headers or {}
                    local ra = h[_crqcum82("\180\136\128\137\123\036\081\113\106\064\094")] or h[_crqcum82("\148\136\128\137\123\036\113\113\106\064\094")]
                    if ra then retryAfter = tonumber(ra) or 5 end
                    local data = HttpService:JSONDecode(res.Body)
                    if data then
                        if data.error then restrictCode = tostring(data.error) end
                        if data.message then restrictMsg = tostring(data.message) end
                    end
                end)
                return false, restrictCode, retryAfter, restrictMsg
            elseif res.StatusCode == 403 then return false, _crqcum82("\164\172\186\181\071\077\042") .. tostring(res.Body)
            elseif res.StatusCode >= 500 or res.StatusCode == 408 then
                local retryAfter = 5
                pcall(function()
                    local h = res.Headers or res.headers or {}
                    local ra = h[_crqcum82("\180\136\128\137\123\036\081\113\106\064\094")] or h[_crqcum82("\148\136\128\137\123\036\113\113\106\064\094")]
                    if ra then retryAfter = tonumber(ra) or 5 end
                end)
                local code = tonumber(res.StatusCode) or 0
                local detail
                if code == 502 or code == 503 or code == 504 then
                    detail = _crqcum82("\181\136\134\141\103\123\048\126\109\005\094\086\073\053\041\061\034\052\010\012\082\081\200\211\218\197\188") .. tostring(code) .. _crqcum82("\207\205\217\219\112\108\115\120\112\075\073\080\078\040\038\040")
                elseif code == 408 then
                    detail = _crqcum82("\181\136\134\141\103\123\048\099\119\072\073\087\026\046\061\059\118\117\044\063\038\041\160\179\190\173\181\131\135\145\202\218\165\162\186\181\135\138\132\158\144\098")
                else
                    detail = _crqcum82("\181\136\134\141\103\123\048\114\108\087\067\065\026\105\000\027\002\013\068") .. tostring(code) .. _crqcum82("\207\205\217\219\112\108\115\120\112\075\073\080\078\040\038\040")
                end
                return false, _crqcum82("\181\168\166\173\071\091\079\082\076\119\099\097\026") .. detail, retryAfter
            else return false, _crqcum82("\174\185\160\171\034") .. tostring(res.StatusCode) .. _crqcum82("\220\205") .. tostring(res.Body) end
        end
        return false, _crqcum82("\168\168\160\172\077\091\091\072\091\119\126\124\104\097") .. tostring(res)
    end
    local ok, res = pcall(function()
        return HttpService:PostAsync(url, jsonStr, Enum.HttpContentType.ApplicationJson)
    end)
    if not ok then
        local errorText = tostring(res)
        if errorText:find(_crqcum82("\181\184\164\190\080\090\085\083\091\097"), 1, true) or errorText:find(_crqcum82("\210\221\205"), 1, true) then
            return false, _crqcum82("\181\184\164\190\080\090\085\083\091\097")
        end
        return false, _crqcum82("\168\168\160\172\077\091\091\072\091\119\126\124\104\097") .. errorText
    end
    if isTokenRequest then TOKEN_KEY = signedWith end
    return ok, res
end
local function openWebSocket(wsUrl)
    local errs = {}
    local function try(name, fn)
        local ok, ws = pcall(fn, wsUrl)
        if ok and ws then
            if _LP_STORE then
                local keep = _LP_STORE.keep
                if not keep then keep = {}; _LP_STORE.keep = keep end
                keep[#keep + 1] = ws
            end
            return ws
        end
        errs[#errs + 1] = name .. _crqcum82("\220\205") .. (ok and _crqcum82("\148\136\128\142\112\103\117\115\062\075\067\071\082\040\038\040") or tostring(ws):gsub(_crqcum82("\195\158\223"), _crqcum82("\198")):sub(1, 120))
    end
    local ws
    if WebSocket and WebSocket.connect then ws = try(_crqcum82("\177\136\150\168\109\106\123\114\106\011\079\092\084\047\045\044\034"), WebSocket.connect); if ws then return ws end end
    if WebSocket and WebSocket.new then ws = try(_crqcum82("\177\136\150\168\109\106\123\114\106\011\066\086\077"), WebSocket.new); if ws then return ws end end
    if websocket and websocket.connect then ws = try(_crqcum82("\145\136\150\136\109\106\123\114\106\011\079\092\084\047\045\044\034"), websocket.connect); if ws then return ws end end
    if syn and syn.websocket and syn.websocket.connect then ws = try(_crqcum82("\149\148\154\213\117\108\114\100\113\070\071\086\078"), syn.websocket.connect); if ws then return ws end end
    return nil, (#errs > 0 and table.concat(errs, _crqcum82("\221\205")) or _crqcum82("\136\130\212\172\103\107\067\120\125\078\073\071\026\000\024\006"))
end
local LP_POLL = { failStreak = 0, skipDelay = false, untilAt = 0 }
LP_POLL.diagSent, LP_POLL.diagSeen = 0, {}
function LP_POLL.diag(kind, message, detail, phase)
    pcall(function()
        local reqFn = LP_POLL.requestFn()
        if not reqFn or (LP_POLL.diagSent >= 8 and kind ~= _crqcum82("\129\140\130\158\093\124\096")) or LP_POLL.diagSent >= 12 then return end
        local key = tostring(kind) .. _crqcum82("\154") .. tostring(message)
        local nowT = os.time()
        if LP_POLL.diagSeen[key] and nowT - LP_POLL.diagSeen[key] < 30 then return end
        LP_POLL.diagSeen[key] = nowT
        LP_POLL.diagSent = LP_POLL.diagSent + 1
        local event = {
            kind = kind, message = tostring(message or _crqcum82("")):sub(1, 400), detail = ((detail and tostring(detail) or _crqcum82("")) .. (__lpAt > 0 and (_crqcum82("\198\182\151\147\103\106\123\103\113\076\066\071\026") .. __lpAt .. _crqcum82("\187")) or _crqcum82(""))):sub(1, 1500),
            phase = phase, executor = tostring(executor), scriptId = SCRIPT_ID, userId = tostring(userId),
            version = nil and (_crqcum82("\133\153\154\219") .. tostring(nil)) or _crqcum82("\150\129\149\146\108"),
            placeId = tostring(game.PlaceId), transport = (LP_POLL.active() and _crqcum82("\142\153\128\139\113") or _crqcum82("\145\158")),
            wsHost = WS_URL:match(_crqcum82("\184\154\135\136\061\051\063\056\054\126\114\028\000\028\099\102")), attempts = LP_POLL.diagSent,
        }
        task.spawn(function()
            pcall(reqFn, {
                Url = HOST_URL .. _crqcum82("\201\140\132\146\045\123\101\121\112\064\094\030\094\040\041\040"), Method = _crqcum82("\182\162\167\175"),
                Headers = { [_crqcum82("\165\130\154\143\103\103\100\058\074\092\092\086")] = _crqcum82("\135\157\132\151\107\106\113\099\119\074\066\028\080\050\039\033") },
                Body = encodeJSON({ events = { event } }),
            })
        end)
    end)
end
function LP_POLL.requestFn() return (syn and syn.request) or request or http_request or (http and http.request) end
function LP_POLL.hasWsApi()
    return ((WebSocket and (WebSocket.connect or WebSocket.new)) or websocket or (syn and syn.websocket)) ~= nil
end
function LP_POLL.active()
    local at = (_LP_STORE and _LP_STORE.pollUntil) or LP_POLL.untilAt
    return os.time() < at
end
function LP_POLL.noteWsFailure(reason)
    LP_POLL.failStreak = LP_POLL.failStreak + 1
    LP_POLL.diag(_crqcum82("\145\158\171\157\099\096\124\114\122"), reason or _crqcum82("\177\136\150\168\109\106\123\114\106\005\074\082\083\045\045\043"), _crqcum82("\128\140\157\151\119\123\117\055") .. LP_POLL.failStreak, _crqcum82("\133\130\154\149\103\106\100"))
    if LP_POLL.failStreak < 2 or LP_POLL.active() or not LP_POLL.requestFn() then return false end
    LP_POLL.failStreak = 0
    LP_POLL.untilAt = os.time() + 1800
    if _LP_STORE then _LP_STORE.pollUntil = LP_POLL.untilAt end
    LP_POLL.skipDelay = true 
    LP_POLL.diag(_crqcum82("\128\140\152\151\096\104\115\124\065\074\066"), _crqcum82("\177\136\150\168\109\106\123\114\106\005\078\095\085\034\035\042\050\102\068\024\005\016\244\228\230\240\248\131\222\222\152\203\174\168\244\147\182\189\160\164\222\099\109\127\118\067\073\076\093"), reason, _crqcum82("\133\130\154\149\103\106\100"))
    runnerLog(_crqcum82("\177\136\150\168\109\106\123\114\106\005\069\064\026\035\036\032\053\054\001\015\082\022\238\167\250\253\245\208\138\223\221\203\177\162\166\176\217\201\133\132\151\107\107\051\110\073\077\015\126\105\016\027\001\121\006\006\002\025\030\226\233\250"))
    return true
end
function LP_POLL.call(path, body)
    local requestFunc = LP_POLL.requestFn()
    if not requestFunc then return 0, _crqcum82("") end
    local ok, res = pcall(requestFunc, {
        Url = HOST_URL .. _crqcum82("\201\140\132\146\045\101\096\056") .. path, Method = _crqcum82("\182\162\167\175"),
        Headers = { [_crqcum82("\165\130\154\143\103\103\100\058\074\092\092\086")] = _crqcum82("\135\157\132\151\107\106\113\099\119\074\066\028\080\050\039\033"), [_crqcum82("\179\158\145\137\047\072\119\114\112\081")] = (_crqcum82("\180\130\150\151\109\113\063\064\119\075\101\093\095\053")) },
        Body = encodeJSON(body),
    })
    if not ok or type(res) ~= _crqcum82("\146\140\150\151\103") then return 0, tostring(res) end
    local status = tonumber(res.StatusCode or res.status or res.status_code) or (res.Success == true and 200 or 0)
    return status, res.Body or res.body or _crqcum82("")
end
function LP_POLL.open(token)
    local status, text = LP_POLL.call(_crqcum82("\137\157\145\149"), { token = token })
    if status ~= 200 then
        return nil, (status == 0 and (_crqcum82("\136\130\212\137\103\122\096\120\112\086\073\019\018") .. tostring(text):sub(1, 100) .. _crqcum82("\207")) or (_crqcum82("\174\185\160\171\034") .. tostring(status) .. _crqcum82("\198") .. tostring(text):gsub(_crqcum82("\195\158\223"), _crqcum82("\198")):sub(1, 100)))
    end
    local okDecode, info = pcall(HttpService.JSONDecode, HttpService, text)
    if not okDecode or type(info) ~= _crqcum82("\146\140\150\151\103") or type(info.sid) ~= _crqcum82("\149\153\134\146\108\110") then return nil, _crqcum82("\147\131\145\131\114\108\115\099\123\065\012\092\074\036\038\111\036\056\023\027\029\023\243\226") end
    local sid = info.sid
    local S = {}
    local closed = false
    local handlers = { message = {}, close = {}, error = {} }
    local function signal(list)
        return { Connect = function(_, fn)
            list[#list + 1] = fn
            return { Disconnect = function()
                for i, h in ipairs(list) do if h == fn then table.remove(list, i); break end end
            end }
        end }
    end
    S.OnMessage, S.OnClose, S.OnError = signal(handlers.message), signal(handlers.close), signal(handlers.error)
    local function fireClose(code, reason)
        if closed then return end
        closed = true
        for _, h in ipairs({ table.unpack(handlers.close) }) do task.spawn(h, code, reason) end
    end
    local outq, sent, flushing = {}, 0, false
    local function flush()
        if flushing or closed then return end
        flushing = true
        task.spawn(function()
            local attempt = 0
            while #outq > 0 and not closed do
                local n, bytes = 0, 0
                for i = 1, math.min(#outq, 32) do
                    if n > 0 and bytes + #outq[i] > 180000 then break end
                    n, bytes = n + 1, bytes + #outq[i]
                end
                local batch = {}
                for i = 1, n do batch[i] = outq[i] end
                local status = LP_POLL.call(_crqcum82("\149\136\154\159"), { sid = sid, seq = sent, f = batch })
                if status == 200 then
                    attempt = 0
                    for _ = 1, n do table.remove(outq, 1) end
                    sent = sent + n
                elseif status == 404 or status == 409 then
                    break 
                elseif status == 400 or status == 413 then
                    for _ = 1, n do table.remove(outq, 1) end
                    sent = sent + n
                else
                    attempt = attempt + 1
                    if attempt > 5 then fireClose(1006, _crqcum82("\150\130\152\151\034\125\098\118\112\086\092\092\072\053\104\042\036\047\011\025\082\081\245\247\226\250\253\199\138\215\217\214\170\168\176\242")); break end
                    task.wait(math.min(0.5 * 2 ^ attempt, 8))
                end
            end
            flushing = false
        end)
    end
    function S:Send(data)
        if closed then error(_crqcum82("\149\130\151\144\103\125\048\116\114\074\095\086\094")) end
        outq[#outq + 1] = tostring(data)
        task.defer(flush)
    end
    function S:Close()
        if closed then return end
        task.spawn(LP_POLL.call, _crqcum82("\133\129\155\136\103"), { sid = sid })
        fireClose(1000, _crqcum82(""))
    end
    task.spawn(function()
        local ack, fails = 0, 0
        while not closed do
            local startedAt = os.clock()
            local status, body = LP_POLL.call(_crqcum82("\150\130\152\151"), { sid = sid, ack = ack })
            if closed then break end
            if status == 200 then
                local okDecode2, d = pcall(HttpService.JSONDecode, HttpService, body)
                if okDecode2 and type(d) == _crqcum82("\146\140\150\151\103") then
                    fails = 0
                    local first = tonumber(d.s) or (ack + 1)
                    local frames = type(d.f) == _crqcum82("\146\140\150\151\103") and d.f or {}
                    for i, frame in ipairs(frames) do
                        if first + i - 1 == ack + 1 then
                            ack = ack + 1
                            for _, h in ipairs({ table.unpack(handlers.message) }) do task.spawn(h, frame) end
                        end
                    end
                    if type(d.c) == _crqcum82("\146\140\150\151\103") then fireClose(tonumber(d.c[1]) or 1006, tostring(d.c[2] or _crqcum82(""))); break end
                    if #frames == 0 and os.clock() - startedAt < 1 then task.wait(1) end
                else
                    fails = fails + 1
                    task.wait(1)
                end
            elseif status == 404 then
                fireClose(1006, _crqcum82("\149\136\135\136\107\102\126\055\123\093\092\090\072\036\044"))
                break
            elseif status == 429 then
                task.wait(2)
            else
                fails = fails + 1
                if fails >= 6 then fireClose(1006, _crqcum82("\150\130\152\151\034\125\098\118\112\086\092\092\072\053\104\042\036\047\011\025\082\081") .. tostring(status) .. _crqcum82("\207")); break end
                task.wait(math.min(0.5 * 2 ^ fails, 8))
            end
        end
    end)
    return S
end
local lastConnectFailure = nil
local MAX_RETRIES = 5 
local MAX_RETRIES_AFTER_STABLE = 12
local lastFailWasTransient = false
local BASE_DELAY  = 2
local MAX_DELAY   = 60
local STABLE_CONNECTION_THRESHOLD_SECONDS = 10
local connectionOpenedAt   = nil
local stableConnectionSeen = false
local MAX_BUSY_RETRIES     = 6
local BUSY_MIN_DELAY       = 10
local lastCloseWasBusy     = false
local reconnectDisabled    = false
local hbThread = nil
local function lpSendWs(ws, data)
    if not ws then return false end
    local reg = _LP_STORE and _LP_STORE.closed
    if reg and reg[ws] then return false end
    if ws.Send then ws:Send(data) elseif ws.send then ws:send(data) end
    return true
end
local function closeWebSocket(ws)
    if not ws then return end
    local reg = _LP_STORE and _LP_STORE.closed
    if reg then
        if reg[ws] then return end
        reg[ws] = true
    end
    pcall(function()
        if ws.Close then ws:Close()
        elseif ws.close then ws:close()
        elseif ws.Disconnect then ws:Disconnect()
        elseif ws.disconnect then ws:disconnect() end
    end)
end
lpMark(_crqcum82("\149\136\135\136\107\102\126\055\109\081\077\065\078\040\038\040"))
local maxSession = 0
if _LP_STORE and type(_LP_STORE.sessions[SCRIPT_TAG]) == _crqcum82("\136\152\153\153\103\123") then
    maxSession = _LP_STORE.sessions[SCRIPT_TAG]
elseif SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
    local _ge = safeGenv()
    if _ge and type(_ge.sentinel_session) == _crqcum82("\136\152\153\153\103\123") then maxSession = math.max(maxSession, _ge.sentinel_session) end
    if shared and type(shared.sentinel_session) == _crqcum82("\136\152\153\153\103\123") then maxSession = math.max(maxSession, shared.sentinel_session) end
    if _G and type(_G.sentinel_session) == _crqcum82("\136\152\153\153\103\123") then maxSession = math.max(maxSession, _G.sentinel_session) end
end
local CURRENT_SESSION = (IS_TELEPORT_RECONNECT and tonumber(HANDOFF_SESSION_ID)) or (IS_TELEPORT_RECONNECT and maxSession) or (maxSession + 1)
local RUN_ID = (IS_TELEPORT_RECONNECT and _PERSISTED_RUN_ID) or (tostring(os.time()) .. _crqcum82("\203") .. tostring(math.random(100000, 999999)) .. _crqcum82("\203") .. tostring(CURRENT_SESSION))
if _LP_STORE then _LP_STORE.sessions[SCRIPT_TAG] = CURRENT_SESSION end
if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
    do local _ge = safeGenv(); if _ge then _ge.sentinel_session = CURRENT_SESSION end end
    if shared then shared.sentinel_session = CURRENT_SESSION end
    if _G then _G.sentinel_session = CURRENT_SESSION end
end
local function isCurrentSession()
    if reconnectDisabled then return false end
    if not IS_TELEPORT_RECONNECT and INVOCATION_OWNER then
        if _LP_STORE and _LP_STORE.invocations[SCRIPT_TAG] then
            if _LP_STORE.invocations[SCRIPT_TAG] ~= INVOCATION_OWNER then return false end
        elseif SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
            local _ge = safeGenv()
            if _ge and _ge.sentinel_invocation and _ge.sentinel_invocation ~= INVOCATION_OWNER then return false end
            if shared and shared.sentinel_invocation and shared.sentinel_invocation ~= INVOCATION_OWNER then return false end
            if _G and _G.sentinel_invocation and _G.sentinel_invocation ~= INVOCATION_OWNER then return false end
        end
    end
    if _LP_STORE and type(_LP_STORE.sessions[SCRIPT_TAG]) == _crqcum82("\136\152\153\153\103\123") then
        if _LP_STORE.sessions[SCRIPT_TAG] > CURRENT_SESSION then return false end
    elseif SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
        local _ge = safeGenv()
        if _ge and type(_ge.sentinel_session) == _crqcum82("\136\152\153\153\103\123") and _ge.sentinel_session > CURRENT_SESSION then return false end
        if shared and type(shared.sentinel_session) == _crqcum82("\136\152\153\153\103\123") and shared.sentinel_session > CURRENT_SESSION then return false end
        if _G and type(_G.sentinel_session) == _crqcum82("\136\152\153\153\103\123") and _G.sentinel_session > CURRENT_SESSION then return false end
    end
    return true
end
waitWithCountdown = function(totalSeconds)
    if totalSeconds <= 0 then return end
    if totalSeconds > 120 then totalSeconds = 120 end
    for remaining = totalSeconds - 1, 0, -1 do
        if not isCurrentSession() then return end
        task.wait(1)
    end
end
if _LP_STORE and _LP_STORE.sockets[SCRIPT_TAG] then
    _LP_STORE.sockets[SCRIPT_TAG] = nil
elseif SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
    local _ge0 = safeGenv()
    if _ge0 and _ge0.sentinel_ws then _ge0.sentinel_ws = nil end
    if shared and shared.sentinel_ws then shared.sentinel_ws = nil end
    if _G and _G.sentinel_ws then _G.sentinel_ws = nil end
end
local EARLY_KEY = nil
pcall(function()
    local function pick(env)
        if type(env) ~= _crqcum82("\146\140\150\151\103") then return nil end
        local v = env.script_key or env.Script_Key or env.SCRIPT_KEY or env.key or env.Key
        if v ~= nil and tostring(v):match(_crqcum82("\195\190")) then return v end
        return nil
    end
    if getgenv then EARLY_KEY = pick(getgenv()) end
    if not EARLY_KEY and _G then EARLY_KEY = pick(_G) end
    if not EARLY_KEY and shared then EARLY_KEY = pick(shared) end
    if not EARLY_KEY then
        for level = 1, 12 do
            local env, status = safeFenv(level)
            if status ~= _crqcum82("\137\134") then break end
            EARLY_KEY = pick(env)
            if EARLY_KEY then break end
        end
    end
end)
local function getProvidedKey()
    local k = nil
    pcall(function()
        if getgenv and (getgenv().script_key or getgenv().key) then k = getgenv().script_key or getgenv().key
        elseif _G and (_G.script_key or _G.key) then k = _G.script_key or _G.key
        elseif shared and (shared.script_key or shared.key) then k = shared.script_key or shared.key
        elseif getfenv then
            for level = 1, 12 do
                local env, status = safeFenv(level)
                if status ~= _crqcum82("\137\134") then break end
                if env and (env.script_key or env.key) then k = env.script_key or env.key end
                if k then break end
            end
        end
    end)
    if k == nil then k = EARLY_KEY end
    return k and tostring(k):gsub(_crqcum82("\184\200\135\209\042\039\061\062\059\086\006\023"), _crqcum82("\195\220")) or _crqcum82("")
end
__lpAt = 0 or 0
if not fetchRunnerKey() then return end
if not IS_TELEPORT_RECONNECT then
    RUN_ID = tostring(RUNNER_ID) .. _crqcum82("\220") .. RUN_ID
end
if _LP_STORE then _LP_STORE.run_ids[SCRIPT_TAG] = RUN_ID end
if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
    do local _ge = safeGenv(); if _ge then _ge._luaprotect_run_id = RUN_ID end end
    if shared then shared._luaprotect_run_id = RUN_ID end
    if _G then _G._luaprotect_run_id = RUN_ID end
end
local AUTH = { pre = nil, rxAt = nil } 
AUTH.body = function(keyCode, isReconnect)
    return {
        userId = userId, username = username, placeId = placeId, jobId = jobId, gameId = gameId,
        hwid = hwid, scriptId = SCRIPT_ID, scriptName = SCRIPT_NAME, executor = executor,
        keyCode = keyCode, runnerId = RUNNER_ID, isReconnect = isReconnect or false, sessionId = CURRENT_SESSION, runId = RUN_ID,
        caps = { chunks = true, fk = true, sec2 = true, sec3 = true }
    }
end
if not IS_TELEPORT_RECONNECT and isCurrentSession() then
    local pre = { done = false }
    AUTH.pre = pre
    task.spawn(function()
        local startedAt = os.clock()
        local r = table.pack(pcall(makeRequest, HOST_URL .. _crqcum82("\201\140\132\146\045\104\101\099\118\010\088\092\081\036\038"), AUTH.body(getProvidedKey(), false), false))
        if r[1] then
            pre.r = { r[2], r[3], r[4], r[5] }
        else
            pre.r = { false, _crqcum82("\168\168\160\172\077\091\091\072\091\119\126\124\104\097") .. tostring(r[2]) }
        end
        pre.ms = (os.clock() - startedAt) * 1000
        pre.done = true
        lpMark(_crqcum82("\135\152\128\147\034\123\117\103\114\092"))
        if pre.waiter then task.spawn(pre.waiter) end
    end)
end
local isKeyPromptClosed = false
local showKeyPromptPanel = (function(submitCallback, keyFlowUrl)
    local parentGui = getGuiParent()
    if not parentGui then return end
    cleanupExistingGui(_crqcum82("\170\152\149\171\112\102\100\114\125\081\103\086\067\020\001"))
    local gui = Instance.new(_crqcum82("\181\142\134\158\103\103\087\098\119"))
    gui.Name = _crqcum82("\170\152\149\171\112\102\100\114\125\081\103\086\067\020\001")
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 35
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) elseif protect_gui then protect_gui(gui) end end)
    local parented = pcall(function() gui.Parent = parentGui end)
    if not parented or not gui.Parent then
        pcall(function()
            gui.Parent = (LocalPlayer and (LocalPlayer:FindFirstChild(_crqcum82("\182\129\149\130\103\123\087\098\119")) or LocalPlayer:WaitForChild(_crqcum82("\182\129\149\130\103\123\087\098\119"), 5))) or CoreGui
        end)
    end
    local backdrop = Instance.new(_crqcum82("\160\159\149\150\103"))
    backdrop.Name = _crqcum82("\164\140\151\144\102\123\127\103")
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 1
    backdrop.BorderSizePixel = 0
    backdrop.Active = true
    backdrop.Parent = gui
    local card = Instance.new(_crqcum82("\160\159\149\150\103"))
    card.Name = _crqcum82("\173\136\141\184\099\123\116")
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Position = UDim2.new(0.5, 0, 0.5, 16)
    card.Size = UDim2.new(0, 440, 0, 0)
    card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = THEME_BG
    card.BackgroundTransparency = 1
    card.BorderSizePixel = 0
    card.Parent = gui
    Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), card).CornerRadius = UDim.new(0, 3)
    local cardSize = Instance.new(_crqcum82("\179\164\167\146\120\108\083\120\112\086\088\065\091\040\038\059"))
    cardSize.MaxSize = Vector2.new(440, 600)
    cardSize.Parent = card
    local stroke = Instance.new(_crqcum82("\179\164\167\143\112\102\123\114"))
    stroke.Color = Color3.fromRGB(45, 45, 45)
    stroke.Transparency = 1
    stroke.Parent = card
    local pad = Instance.new(_crqcum82("\179\164\164\154\102\109\121\121\121"))
    pad.PaddingTop, pad.PaddingBottom = UDim.new(0, 22), UDim.new(0, 22)
    pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 22), UDim.new(0, 22)
    pad.Parent = card
    local list = Instance.new(_crqcum82("\179\164\184\146\113\125\092\118\103\074\089\071"))
    list.FillDirection = Enum.FillDirection.Vertical
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 14)
    list.Parent = card
    local header = Instance.new(_crqcum82("\160\159\149\150\103"))
    header.Size = UDim2.new(1, 0, 0, 36)
    header.BackgroundTransparency = 1
    header.LayoutOrder = 1
    header.Parent = card
    local iconFrame = Instance.new(_crqcum82("\160\159\149\150\103"))
    iconFrame.Size = UDim2.new(0, 36, 0, 36)
    iconFrame.BackgroundColor3 = THEME_ACCENT or Color3.fromRGB(168, 85, 247)
    iconFrame.BackgroundTransparency = 0.86
    iconFrame.BorderSizePixel = 0
    iconFrame.Parent = header
    Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), iconFrame).CornerRadius = UDim.new(0, 3)
    local icon = Instance.new(_crqcum82("\175\128\149\156\103\069\113\117\123\073"))
    icon.Size = UDim2.new(0, 22, 0, 22)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.Position = UDim2.new(0.5, 0, 0.5, 0)
    icon.BackgroundTransparency = 1
    icon.Image = _crqcum82("\148\143\140\154\113\122\117\099\119\065\022\028\021\112\120\120\102\100\083\094\064\064\185\177")
    icon.ImageColor3 = THEME_ACCENT or Color3.fromRGB(168, 85, 247)
    icon.Parent = iconFrame
    local title = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
    title.Position = UDim2.new(0, 48, 0, 0)
    title.Size = UDim2.new(1, -84, 1, 0)
    title.BackgroundTransparency = 1
    title.Font = fontBold
    title.TextSize = 20
    title.TextColor3 = THEME_TEXT
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Text = (SCRIPT_NAME ~= _crqcum82("") and SCRIPT_NAME) or _crqcum82("\167\152\128\147\103\103\100\126\125\068\088\090\085\047\104\029\051\044\017\002\000\028\228")
    title.Parent = header
    local closeBtn = Instance.new(_crqcum82("\178\136\140\143\064\124\100\099\113\075"))
    closeBtn.AnchorPoint = Vector2.new(1, 0.5)
    closeBtn.Position = UDim2.new(1, 0, 0.5, 0)
    closeBtn.Size = UDim2.new(0, 26, 0, 26)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Font = fontBold
    closeBtn.TextSize = 16
    closeBtn.TextColor3 = THEME_MUTED
    closeBtn.Text = _crqcum82("\243")
    closeBtn.Parent = header
    if DISCORD_INVITE ~= _crqcum82("") then
        title.Size = UDim2.new(1, -100, 1, 0)
        local BLURPLE = Color3.fromRGB(88, 101, 242)
        local dcBtn = Instance.new(_crqcum82("\178\136\140\143\064\124\100\099\113\075"))
        dcBtn.Name = _crqcum82("\162\132\135\152\109\123\116\085\106\075")
        dcBtn.AnchorPoint = Vector2.new(1, 0.5)
        dcBtn.Position = UDim2.new(1, -32, 0.5, 0)
        dcBtn.Size = UDim2.new(0, 28, 0, 28)
        dcBtn.BackgroundColor3 = BLURPLE
        dcBtn.BorderSizePixel = 0
        dcBtn.AutoButtonColor = true
        dcBtn.Text = _crqcum82("")
        dcBtn.Parent = header
        Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), dcBtn).CornerRadius = UDim.new(0, 6)
        local logoAsset = nil
        if type(logoAsset) == _crqcum82("\149\153\134\146\108\110") and logoAsset ~= _crqcum82("") then
            local logo = Instance.new(_crqcum82("\175\128\149\156\103\069\113\117\123\073"))
            logo.AnchorPoint = Vector2.new(0.5, 0.5)
            logo.Position = UDim2.new(0.5, 0, 0.5, 0)
            logo.Size = UDim2.new(0, 18, 0, 18)
            logo.BackgroundTransparency = 1
            logo.Image = logoAsset
            logo.ScaleType = Enum.ScaleType.Fit
            logo.Parent = dcBtn
        else
            local function mark(size, pos, rot, radius, color)
                local f = Instance.new(_crqcum82("\160\159\149\150\103"))
                f.AnchorPoint = Vector2.new(0.5, 0.5)
                f.Size = size
                f.Position = pos
                f.Rotation = rot or 0
                f.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
                f.BorderSizePixel = 0
                f.Active = false
                f.Parent = dcBtn
                Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), f).CornerRadius = radius
                return f
            end
            local white = Color3.fromRGB(255, 255, 255)
            mark(UDim2.new(0, 5, 0, 5), UDim2.new(0.5, -7, 0.5, -6), 45, UDim.new(0, 1), white)
            mark(UDim2.new(0, 5, 0, 5), UDim2.new(0.5, 7, 0.5, -6), 45, UDim.new(0, 1), white)
            mark(UDim2.new(0, 18, 0, 13), UDim2.new(0.5, 0, 0.5, 1), 0, UDim.new(0, 6), white)
            mark(UDim2.new(0, 3, 0, 5), UDim2.new(0.5, -3.5, 0.5, 1), 0, UDim.new(1, 0), BLURPLE)
            mark(UDim2.new(0, 3, 0, 5), UDim2.new(0.5, 3.5, 0.5, 1), 0, UDim.new(1, 0), BLURPLE)
        end
        dcBtn.MouseButton1Click:Connect(function()
            local copied = false
            pcall(function()
                local clip = setclipboard or toclipboard or (syn and syn.write_clipboard)
                if clip then clip(DISCORD_INVITE); copied = true end
            end)
            pcall(function()
                local open = openurl or (syn and syn.open_url)
                if open then open(DISCORD_INVITE) end
            end)
            if copied then dcBtn.BackgroundColor3 = Color3.fromRGB(59, 165, 93) end
            task.delay(1.5, function() if dcBtn.Parent then dcBtn.BackgroundColor3 = BLURPLE end end)
        end)
    end
    local message = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
    message.Size = UDim2.new(1, 0, 0, 0)
    message.AutomaticSize = Enum.AutomaticSize.Y
    message.BackgroundTransparency = 1
    message.Font = fontRegular
    message.TextSize = 15
    message.TextColor3 = THEME_MUTED
    message.TextWrapped = true
    message.TextXAlignment = Enum.TextXAlignment.Left
    message.Text = _crqcum82("\182\129\145\154\113\108\048\114\112\081\073\065\026\056\039\058\036\125\005\008\017\028\243\244\174\254\249\218\138\197\215\159\165\162\186\175\139\135\133\146\208")
    message.LayoutOrder = 2
    message.Parent = card
    local codeBox = Instance.new(_crqcum82("\160\159\149\150\103"))
    codeBox.Size = UDim2.new(1, 0, 0, 52)
    codeBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    codeBox.BackgroundTransparency = 0.96
    codeBox.BorderSizePixel = 0
    codeBox.LayoutOrder = 3
    codeBox.Parent = card
    Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), codeBox).CornerRadius = UDim.new(0, 3)
    local inputBox = Instance.new(_crqcum82("\178\136\140\143\064\102\104"))
    inputBox.Position = UDim2.new(0, 16, 0, 0)
    inputBox.Size = UDim2.new(1, -114, 1, 0)
    inputBox.BackgroundTransparency = 1
    inputBox.Font = fontRegular
    inputBox.TextSize = 15
    inputBox.TextColor3 = THEME_TEXT
    inputBox.TextXAlignment = Enum.TextXAlignment.Left
    inputBox.PlaceholderText = _crqcum82("\182\140\135\143\103\041\105\120\107\087\012\088\095\056\104\039\051\047\001\069\092\087")
    inputBox.PlaceholderColor3 = THEME_MUTED
    inputBox.Text = _crqcum82("")
    inputBox.ClearTextOnFocus = false
    inputBox.Parent = codeBox
    local submitBtn = Instance.new(_crqcum82("\178\136\140\143\064\124\100\099\113\075"))
    submitBtn.AnchorPoint = Vector2.new(1, 0.5)
    submitBtn.Position = UDim2.new(1, -8, 0.5, 0)
    submitBtn.Size = UDim2.new(0, 84, 0, 36)
    submitBtn.BackgroundColor3 = THEME_ACCENT or Color3.fromRGB(168, 85, 247)
    submitBtn.AutoButtonColor = true
    submitBtn.Font = fontBold
    submitBtn.TextSize = 15
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.Text = _crqcum82("\165\130\154\143\107\103\101\114")
    submitBtn.Parent = codeBox
    Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), submitBtn).CornerRadius = UDim.new(0, 3)
    local activeKeyFlowUrl = (keyFlowUrl ~= nil and keyFlowUrl ~= _crqcum82("")) and keyFlowUrl or KEY_FLOW_URL
    activeKeyFlowUrl = (activeKeyFlowUrl and activeKeyFlowUrl ~= "") and tostring(activeKeyFlowUrl):gsub(_crqcum82("\184\200\135\209\042\039\061\062\059\086\006\023"), _crqcum82("\195\220")) or _crqcum82("")
    local timer = Instance.new(_crqcum82("\178\136\140\143\078\104\114\114\114"))
    timer.Size = UDim2.new(1, 0, 0, 18)
    timer.BackgroundTransparency = 1
    timer.Font = fontRegular
    timer.TextSize = 13
    timer.TextColor3 = THEME_MUTED
    timer.TextXAlignment = Enum.TextXAlignment.Left
    timer.Text = _crqcum82("")
    timer.LayoutOrder = (activeKeyFlowUrl ~= _crqcum82("")) and 5 or 4
    timer.Parent = card
    local getKeyBtn = nil
    if activeKeyFlowUrl ~= _crqcum82("") then
        getKeyBtn = Instance.new(_crqcum82("\178\136\140\143\064\124\100\099\113\075"))
        getKeyBtn.Name = _crqcum82("\161\136\128\176\103\112\082\099\112")
        getKeyBtn.Size = UDim2.new(1, 0, 0, 36)
        getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        getKeyBtn.BackgroundTransparency = 0.94
        getKeyBtn.BorderSizePixel = 0
        getKeyBtn.AutoButtonColor = true
        getKeyBtn.Font = fontBold
        getKeyBtn.TextSize = 14
        getKeyBtn.TextColor3 = THEME_TEXT
        getKeyBtn.Text = _crqcum82("\161\136\128\219\073\108\105")
        getKeyBtn.LayoutOrder = 4
        getKeyBtn.Parent = card
        Instance.new(_crqcum82("\179\164\183\148\112\103\117\101"), getKeyBtn).CornerRadius = UDim.new(0, 3)
        local btnStroke = Instance.new(_crqcum82("\179\164\167\143\112\102\123\114"))
        btnStroke.Color = Color3.fromRGB(55, 55, 55)
        btnStroke.Transparency = 0.5
        btnStroke.Parent = getKeyBtn
        getKeyBtn.MouseButton1Click:Connect(function()
            local copied = false
            pcall(function()
                local clip = setclipboard or toclipboard or (syn and syn.write_clipboard)
                if clip then
                    clip(activeKeyFlowUrl)
                    copied = true
                end
            end)
            pcall(function()
                local open = openurl or (syn and syn.open_url)
                if open then open(activeKeyFlowUrl) end
            end)
            if copied then
                getKeyBtn.Text = _crqcum82("\170\132\154\144\034\074\127\103\119\064\072\019\078\046\104\012\058\052\020\009\029\024\242\227\175")
                timer.Text = _crqcum82("\173\136\141\219\110\096\126\124\062\070\067\067\083\036\044\111\034\050\068\008\030\016\240\229\225\244\238\199\132\145\251\208\171\189\184\190\150\140\208\148\150\096\111\120\106\078\065\065\066\078\100\034\060\121\025\008\027\007\092\225\248\254\239\236\195\223\154")
            else
                getKeyBtn.Text = _crqcum82("\169\157\145\149\034\096\126\055\092\087\067\068\073\036\058")
                timer.Text = _crqcum82("\165\130\153\139\110\108\100\114\062\070\068\086\089\042\056\032\063\051\016\024\072\089") .. activeKeyFlowUrl
            end
            task.delay(2.5, function()
                if getKeyBtn.Parent then getKeyBtn.Text = _crqcum82("\161\136\128\219\073\108\105") end
                if timer.Parent and (timer.Text == _crqcum82("\173\136\141\219\110\096\126\124\062\070\067\067\083\036\044\111\034\050\068\008\030\016\240\229\225\244\238\199\132\145\251\208\171\189\184\190\150\140\208\148\150\096\111\120\106\078\065\065\066\078\100\034\060\121\025\008\027\007\092\225\248\254\239\236\195\223\154") or timer.Text:find(_crqcum82("\165\130\153\139\110\108\100\114\062\070\068\086\089\042\056\032\063\051\016\024\072"), 1, true)) then
                    timer.Text = _crqcum82("")
                end
            end)
        end)
    end
    local function closeOut()
        isKeyPromptClosed = true
        pcall(function()
            local fade = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            TweenService:Create(card, fade, { BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 16) }):Play()
            TweenService:Create(backdrop, fade, { BackgroundTransparency = 1 }):Play()
            TweenService:Create(stroke, fade, { Transparency = 1 }):Play()
            for _, obj in ipairs(card:GetDescendants()) do
                if obj:IsA(_crqcum82("\178\136\140\143\078\104\114\114\114")) or obj:IsA(_crqcum82("\178\136\140\143\064\124\100\099\113\075")) or obj:IsA(_crqcum82("\178\136\140\143\064\102\104")) then
                    TweenService:Create(obj, fade, { TextTransparency = 1 }):Play()
                elseif obj:IsA(_crqcum82("\175\128\149\156\103\069\113\117\123\073")) then
                    TweenService:Create(obj, fade, { ImageTransparency = 1 }):Play()
                end
            end
            task.wait(0.25)
            gui:Destroy()
        end)
    end
    closeBtn.MouseButton1Click:Connect(function()
        submitCallback(_crqcum82(""))
        closeOut()
    end)
    local function doSubmit()
        local text = inputBox.Text:gsub(_crqcum82("\184\200\135\209\042\039\061\062\059\086\006\023"), _crqcum82("\195\220"))
        if text ~= _crqcum82("") then
            submitBtn.Text = _crqcum82("\200\195\218")
            timer.Text = _crqcum82("\165\133\145\152\105\096\126\112\062\078\073\074\020\111\102")
            submitCallback(text)
            closeOut()
        end
    end
    submitBtn.MouseButton1Click:Connect(doSubmit)
    inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            doSubmit()
        end
    end)
    local fadeIn = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(card, fadeIn, { BackgroundTransparency = 0.03, Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
    TweenService:Create(backdrop, fadeIn, { BackgroundTransparency = 0.45 }):Play()
    TweenService:Create(stroke, fadeIn, { Transparency = 0 }):Play()
end)
lpMark(_crqcum82("\138\130\149\159\103\123\048\101\123\068\072\074"))
local runnerKeyRenewals = 0
local function tryConnect
(isInternalReconnect)
    if not isCurrentSession() then
        return nil, true, _crqcum82("\181\184\164\190\080\090\085\083\091\097")
    end
    __lpAt = 0 or 0
    local currentKeyCode = getProvidedKey()
    lpMark(_crqcum82("\133\130\154\149\103\106\100\126\112\066"))
    local success, response, retryAfter, rejectMsg
    local pre = AUTH.pre
    AUTH.pre = nil
    if pre then
        if not pre.done then
            pre.waiter = coroutine.running()
            coroutine.yield()
        end
        success, response, retryAfter, rejectMsg = pre.r[1], pre.r[2], pre.r[3], pre.r[4]
        LP_NET.netMs = LP_NET.netMs + pre.ms
    else
        local reqStartedAt = os.clock()
        success, response, retryAfter, rejectMsg = makeRequest(HOST_URL .. _crqcum82("\201\140\132\146\045\104\101\099\118\010\088\092\081\036\038"), AUTH.body(currentKeyCode, isInternalReconnect), isInternalReconnect)
        LP_NET.netMs = LP_NET.netMs + (os.clock() - reqStartedAt) * 1000
    end
    LP_NET.tries = LP_NET.tries + 1
    if success then LP_NET.rlStreak = 0 end
    if not success then
        if response == _crqcum82("\180\172\160\190\093\069\089\090\087\113\105\119") then
            LP_NET.rlStreak = (LP_NET.rlStreak or 0) + 1
            local waitTime = math.floor((retryAfter or 15) + math.random() * 3 + math.min((LP_NET.rlStreak - 1) * 2, 20) + 0.5)
            lastConnectFailure = _crqcum82("\148\140\128\158\034\101\121\122\119\081\073\087\026\035\049\111\034\053\001\075\001\028\242\241\235\231\188\139\226\229\236\239\230\249\230\226\203")
            LP_NET.lastFailWs = false
            LP_NET.note(_crqcum82("\135\152\128\147\056\041\098\118\106\064\012\095\083\044\033\059\051\057\072\075\005\024\233\243\231\251\251\131") .. waitTime .. _crqcum82("\149"))
            waitWithCountdown(waitTime)
            return nil, false, _crqcum82("\181\165\177\191")
        elseif response == _crqcum82("\177\191\187\181\069\086\087\086\083\096") or response == _crqcum82("\161\172\185\190\093\091\085\068\074\119\101\112\110\004\012") then
            runnerWarn(rejectMsg or _crqcum82("\177\159\155\149\101\041\119\118\115\064\012\030\026\053\032\038\037\125\023\008\000\016\240\243\174\252\239\131\198\222\219\212\163\169\244\175\141\201\145\215\154\108\106\117\127\083\077\065\066\029\035\042\063\060"), true)
            return nil, true, nil
        elseif response == _crqcum82("\163\181\177\184\087\093\095\069\065\119\105\096\110\019\001\012\002\024\032") then
            runnerWarn(rejectMsg or _crqcum82("\191\130\129\137\034\108\104\114\125\080\088\092\072\097\033\060\118\051\011\031\082\024\240\247\252\250\234\198\206\145\222\208\180\237\160\179\139\154\208\132\157\119\101\099\110\015\008\118\089\072\054\107\051\058\003\008\027\027\008\163\227\226\184\209\233\249\148\200\183\186\160\178\176\129\137\151\218\044\040\123\126\120\004\088\081\075\041\055\058\117\051\020\004\020\010\095\233\227\248\226\130\200\220\219\209\178\191\243\169\145\141\140\159\155\109\104\050\124\088\066\077\064\072\044\056\034\118"), true)
            return nil, true, nil
        elseif response and response:find(_crqcum82("\181\184\164\190\080\090\085\083\091\097"), 1, true) then
            reconnectDisabled = true
            return nil, true, _crqcum82("\181\184\164\190\080\090\085\083\091\097")
        elseif response and (response:find(_crqcum82("\173\168\173\164\080\076\065\066\087\119\105\119")) or response:find(_crqcum82("\173\136\141\219\080\108\097\098\119\087\073\087"))) then
            local providedKey = getProvidedKey()
            local serverKeyFlowUrl = nil
            pcall(function()
                local data = HttpService:JSONDecode((tostring(response):gsub(_crqcum82("\184\175\181\181\076\076\084\045"), _crqcum82(""))))
                if data and data.keyFlowUrl then
                    serverKeyFlowUrl = data.keyFlowUrl
                end
            end)
            local hasKeyFlow = (serverKeyFlowUrl ~= nil and serverKeyFlowUrl ~= _crqcum82("")) or (KEY_FLOW_URL ~= _crqcum82("") and KEY_FLOW_URL ~= "")
            if providedKey == _crqcum82("") and (PROMPT_FOR_KEY or hasKeyFlow) then
                local enteredKey
                local done = false
                showKeyPromptPanel(function(k)
                    enteredKey = k
                    done = true
                end, serverKeyFlowUrl)
                local keyPromptAt = os.clock()
                local promptDeadline = os.clock() + 900
                while not done and isCurrentSession() and os.clock() < promptDeadline do task.wait(0.1) end
                LP_NET.keyMs = LP_NET.keyMs + (os.clock() - keyPromptAt) * 1000
                if enteredKey and enteredKey ~= _crqcum82("") then
                    do local _ge = safeGenv(); if _ge then _ge.script_key = enteredKey end end
                    if _G then _G.script_key = enteredKey end
                    local ok, fatal, reason = tryConnect(isInternalReconnect)
                    if not ok then
                        local _ge2 = safeGenv()
                        if _ge2 and _ge2.script_key == enteredKey then _ge2.script_key = nil end
                        if _G and _G.script_key == enteredKey then _G.script_key = nil end
                    end
                    return ok, fatal, reason
                end
            end
            local msg
            if providedKey == _crqcum82("") then
                msg = _crqcum82("\168\130\212\144\103\112\048\100\123\081\002\019\111\050\045\117\118\046\007\025\027\009\244\216\229\240\229\131\151\145\154\230\137\152\134\132\169\172\169\213\222\113\100\118\116\001\090\074\027\088\060\046\049\044\020\002\064")
            else
                local serverMsg = _crqcum82("")
                pcall(function()
                    local data = HttpService:JSONDecode((tostring(response):gsub(_crqcum82("\184\175\181\181\076\076\084\045"), _crqcum82(""))))
                    if data and (data.message or data.error) then serverMsg = data.message or data.error end
                end)
                msg = _crqcum82("\175\131\130\154\110\096\116\055\117\064\085\009\026\099") .. providedKey .. _crqcum82("\196\195\212") .. (serverMsg ~= _crqcum82("") and serverMsg or _crqcum82("\173\136\141\219\108\102\100\055\108\064\079\092\093\047\033\060\051\057\074"))
            end
            reconnectDisabled = true
            runnerWarn(msg, true)
            return nil, true, nil
        elseif response and type(response) == _crqcum82("\149\153\134\146\108\110") and response:sub(1, 7) == _crqcum82("\164\172\186\181\071\077\042") then
            local reason = _crqcum82("\191\130\129\219\099\123\117\055\124\068\066\093\095\037\102")
            pcall(function()
                local body = response:sub(8)
                local data = HttpService:JSONDecode(body)
                if data then reason = tostring(data.message or data.reason or data.error or _crqcum82("\191\130\129\219\099\123\117\055\124\068\066\093\095\037\102")) end
            end)
            runnerWarn(reason, true)
            return nil, true, reason
        elseif response:find(_crqcum82("\181\168\166\173\071\091\079\082\076\119\099\097"), 1, true) then
            local serverDetail = response:gsub(_crqcum82("\184\190\177\169\084\076\066\072\091\119\126\124\104\097"), _crqcum82(""))
            lastConnectFailure = serverDetail
            LP_NET.lastFailWs = false
            LP_NET.note(_crqcum82("\135\152\128\147\056\041") .. serverDetail)
            LP_POLL.diag(_crqcum82("\136\136\128\140\109\123\123"), serverDetail, nil, _crqcum82("\135\152\128\147"))
            return nil, false, _crqcum82("\178\191\181\181\081\064\085\089\074")
        elseif response:find(_crqcum82("\168\168\160\172\077\091\091\072\091\119\126\124\104"), 1, true) then
            local netDetail = response:gsub(_crqcum82("\184\163\177\175\085\070\066\092\065\096\126\097\117\019\104"), _crqcum82(""))
            lastConnectFailure = _crqcum82("\136\136\128\140\109\123\123\055\123\087\094\092\072\097\096") .. netDetail .. _crqcum82("\207")
            LP_NET.lastFailWs = false
            LP_NET.note(_crqcum82("\135\152\128\147\056\041\126\114\106\082\067\065\081\097\045\061\036\050\022\075") .. netDetail)
            LP_POLL.diag(_crqcum82("\136\136\128\140\109\123\123"), netDetail, nil, _crqcum82("\135\152\128\147"))
            runnerLog(_crqcum82("\168\136\128\140\109\123\123\055\123\087\094\092\072\097\058\042\055\062\012\002\028\030\160\244\235\231\234\198\216\145\144") .. netDetail .. _crqcum82("\207\214\212\140\107\101\124\055\108\064\088\065\067"))
            rotateApiHost()
            return nil, false, _crqcum82("\178\191\181\181\081\064\085\089\074")
        elseif response:find(_crqcum82("\180\152\154\149\103\123\048\100\123\086\095\090\085\047\104\042\046\045\013\025\023\029"), 1, true) and runnerKeyRenewals < 3 then
            runnerKeyRenewals = runnerKeyRenewals + 1
            if runnerKeyRenewals > 1 then task.wait(runnerKeyRenewals) end
            if not fetchRunnerKey(true) then return nil, true end
            return tryConnect(isInternalReconnect)
        else
            runnerWarn(_crqcum82("\167\152\128\147\034\111\113\126\114\064\072\009\026") .. tostring(response):gsub(_crqcum82("\195\158\223"), _crqcum82("\198")):sub(1, 140))
            return nil, true
        end
    end
    local ok, data = pcall(HttpService.JSONDecode, HttpService, response)
    if not ok or not data or not data.token then
        runnerWarn(_crqcum82("\164\140\144\219\099\124\100\127\062\087\073\064\074\046\038\060\051\103\068") .. tostring(response):gsub(_crqcum82("\195\158\223"), _crqcum82("\198")):sub(1, 140))
        lastConnectFailure = _crqcum82("\147\131\145\131\114\108\115\099\123\065\012\065\095\050\056\032\056\046\001\075\020\011\239\234\174\225\244\198\138\194\221\205\176\168\166")
        LP_NET.lastFailWs = false
        LP_NET.note(_crqcum82("\135\152\128\147\056\041\101\121\123\093\092\086\089\053\045\043\118\047\001\024\002\022\238\244\235\181") .. tostring(response):gsub(_crqcum82("\195\158\223"), _crqcum82("\198")):sub(1, 80))
        return nil, false, _crqcum82("\178\191\181\181\081\064\085\089\074")
    end
    runnerKeyRenewals = 0
    if type(data.fk) == _crqcum82("\149\153\134\146\108\110") and data.fk ~= _crqcum82("") then
        FK.sk = data.fk
        if _LP_STORE then _LP_STORE.fk_keys = _LP_STORE.fk_keys or {}; _LP_STORE.fk_keys[SCRIPT_TAG] = FK.sk end
    end
    MY_LAST_CONNECT_ATTEMPT = os.clock()
    do local _ge = safeGenv(); if _ge then _ge._luaprotect_last_connect_attempt = MY_LAST_CONNECT_ATTEMPT end end
    __lpAt = 0 or 0
    local wsOpenedAt = os.clock()
    local usePoll = LP_POLL.active() or not LP_POLL.hasWsApi()
    local ws, openErr
    LP_NET.serverClose = nil
    if usePoll then ws, openErr = LP_POLL.open(data.token) else ws, openErr = openWebSocket(WS_URL .. _crqcum82("\217\153\155\144\103\103\045") .. data.token) end
    LP_NET.netMs = LP_NET.netMs + (os.clock() - wsOpenedAt) * 1000
    if not ws and not usePoll then LP_POLL.noteWsFailure(_crqcum82("\177\136\150\168\109\106\123\114\106\005\079\092\079\045\044\111\056\050\016\075\029\009\229\233\180\181") .. tostring(openErr)) end
    if not ws and usePoll then LP_POLL.diag(_crqcum82("\128\140\152\151\096\104\115\124\065\067\077\090\086\036\044"), _crqcum82("\174\185\160\171\081\041\118\118\114\073\078\082\089\042\104\044\057\040\008\015\082\023\239\243\174\250\236\198\196\145\217\159\181\168\167\168\139\134\158"), openErr, _crqcum82("\133\130\154\149\103\106\100")) end
    if not ws then
        lastConnectFailure = (usePoll and _crqcum82("\174\185\160\171\081\041\118\118\114\073\078\082\089\042\104\044\057\040\008\015\082\023\239\243\174\250\236\198\196\139\152") or _crqcum82("\177\136\150\168\109\106\123\114\106\005\079\092\079\045\044\111\056\050\016\075\029\009\229\233\180\181")) .. tostring(openErr or _crqcum82("\147\131\159\149\109\126\126"))
        LP_NET.lastFailWs = not usePoll
        LP_NET.note(_crqcum82("\135\152\128\147\034\102\123\044\062") .. lastConnectFailure)
        runnerQuiet(_crqcum82("\165\130\129\151\102\041\126\120\106\005\094\086\091\034\032\111\034\053\001\075\001\028\242\241\235\231\167\131\221\216\212\211\230\191\177\175\144\144"))
        return nil, false, _crqcum82("\178\191\181\181\081\064\085\089\074")
    end
    LP_NET.note(_crqcum82("\135\152\128\147\034\102\123\044\062") .. (usePoll and _crqcum82("\174\185\160\171\081\041\099\114\109\086\069\092\084") or _crqcum82("\177\136\150\168\109\106\123\114\106")) .. _crqcum82("\198\130\132\158\108"))
    if _LP_STORE then _LP_STORE.sockets[SCRIPT_TAG] = ws end
    if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
        do local _ge = safeGenv(); if _ge then _ge.sentinel_ws = ws end end
        if shared then shared.sentinel_ws = ws end
        if _G then _G.sentinel_ws = ws end
    end
    connectionOpenedAt = os.clock()
    local lastReportedErrors = {}
    local function sendErrorReport(errMsg, stackTrace)
        local msgKey = tostring(errMsg)
        local now = os.time()
        if lastReportedErrors[msgKey] and (now - lastReportedErrors[msgKey]) < 3 then return end
        lastReportedErrors[msgKey] = now
        pcall(function()
            if ws then
                local reportStr = encodeJSON({ type = _crqcum82("\149\142\134\146\114\125\079\101\123\085\067\065\078"), level = _crqcum82("\131\159\134\148\112"), message = msgKey, stackTrace = tostring(stackTrace or _crqcum82("")) })
                lpSendWs(ws, reportStr)
            end
        end)
    end
    task.spawn(function()
        pcall(function()
            local function isSpyName(s)
                if type(s) ~= _crqcum82("\149\153\134\146\108\110") or #s > 200 then return false end
                local l = s:lower()
                return l:find(_crqcum82("\142\153\128\139\113\121\105"), 1, true) ~= nil or l:find(_crqcum82("\142\153\128\139\034\122\096\110"), 1, true) ~= nil or l:find(_crqcum82("\142\153\128\139\093\122\096\110"), 1, true) ~= nil
            end
            local found
            local envs = { safeGenv(), _G, shared }
            for _, e in ipairs(envs) do
                if type(e) == _crqcum82("\146\140\150\151\103") and not found then
                    for _, k in ipairs({ _crqcum82("\174\153\128\139\081\121\105"), _crqcum82("\142\153\128\139\113\121\105"), _crqcum82("\174\185\160\171\081\121\105"), _crqcum82("\174\185\160\171\081\089\073"), _crqcum82("\142\153\128\139\093\122\096\110"), _crqcum82("\174\153\128\139\081\121\105\091\113\068\072\086\094"), _crqcum82("\174\153\128\139\081\121\105\072\082\074\077\087\095\037") }) do
                        local ok, v = pcall(function() return rawget(e, k) end)
                        if ok and v ~= nil then found = _crqcum82("\149\157\141\219\101\101\127\117\127\073\012") .. k; break end
                    end
                end
            end
            if found and ws then
                local reportStr = encodeJSON({ type = _crqcum82("\149\142\134\146\114\125\079\101\123\085\067\065\078"), level = _crqcum82("\145\140\134\149"), message = _crqcum82("\174\185\160\171\034\122\096\110\062\065\073\071\095\034\060\042\050\125\076") .. found .. _crqcum82("\207"), stackTrace = _crqcum82("\131\149\145\152\119\125\127\101\062") .. tostring(executor) })
                lpSendWs(ws, reportStr)
            end
        end)
    end)
    local function sendPerfReport(totalMs, blockMs, scriptKb, run)
        if not ws then return end
        local m = LP_MARKS
        if not (m[_crqcum82("\133\130\154\149\103\106\100\126\112\066")] and m[_crqcum82("\133\130\154\149\103\106\100\114\122")] and m[_crqcum82("\149\142\134\146\114\125\048\115\113\082\066\095\085\032\044\042\050")]) then return end
        local function r(v) return math.floor((tonumber(v) or 0) + 0.5) end
        local dev = {}
        pcall(function()
            local uis = game:GetService(_crqcum82("\179\158\145\137\075\103\096\098\106\118\073\065\076\040\043\042"))
            local touch, keyboard, gamepad = uis.TouchEnabled, uis.KeyboardEnabled, uis.GamepadEnabled
            if game:GetService(_crqcum82("\161\152\157\168\103\123\102\126\125\064")):IsTenFootInterface() or (gamepad and not keyboard and not touch) then dev.d = _crqcum82("\133\130\154\136\109\101\117")
            elseif touch and not keyboard then dev.d = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X >= 900) and _crqcum82("\146\140\150\151\103\125") or _crqcum82("\139\130\150\146\110\108")
            elseif keyboard then dev.d = _crqcum82("\150\142")
            else dev.d = _crqcum82("\137\153\156\158\112") end
        end)
        pcall(function() dev.mem = r(game:GetService(_crqcum82("\181\153\149\143\113")):GetTotalMemoryUsageMb()) end)
        local tr = {}
        for i, e in ipairs(LP_TRACE) do tr[i] = e[1] .. _crqcum82("\219") .. r(e[2]) end
        local payload = encodeJSON({
            type = _crqcum82("\150\136\134\157\093\123\117\103\113\087\088"), v = 1, run = RUN_ID, rc = IS_TELEPORT_RECONNECT,
            t = r(totalMs), blk = r(blockMs), kb = scriptKb,
            ex = r(run.execMs), dn = run.done, st = r(run.stall), hz = run.hitches, mx = r(run.maxFrame), fp = r(run.fps),
            dc = r(run.decPre), dr = r(run.decRun), ob = r(run.obfMs),
            bl = r(run.base), se = r(run.settle), nt = LP_NET.tries, nm = r(LP_NET.netMs), kw = r(LP_NET.keyMs),
            m = { conn0 = r(m[_crqcum82("\133\130\154\149\103\106\100\126\112\066")]), conn1 = r(m[_crqcum82("\133\130\154\149\103\106\100\114\122")]), dl = r(m[_crqcum82("\149\142\134\146\114\125\048\115\113\082\066\095\085\032\044\042\050")]) },
            dev = dev, tr = table.concat(tr, _crqcum82("\221")),
        })
        lpSendWs(ws, payload)
    end
    local chunkState = nil
    local wsConnections = {}
    pcall(function()
        local scriptContext = game:GetService(_crqcum82("\181\142\134\146\114\125\083\120\112\081\073\075\078"))
        local reported = 0
        local conn = scriptContext.Error:Connect(function(message, stackTrace, origin)
            if origin ~= nil then return end
            local text = tostring(message or _crqcum82(""))
            if text == _crqcum82("") or text:find(_crqcum82("\189\161\129\154\082\123\127\099\123\070\088\110"), 1, true) then return end
            reported = reported + 1
            if reported > 25 then return end
            sendErrorReport(text, tostring(stackTrace or _crqcum82("")))
        end)
        if conn then table.insert(wsConnections, conn) end
    end)
    local function bindSignal(signalName, altName, handler)
        pcall(function()
            local sig = ws[signalName] or ws[altName]
            if sig and (typeof(sig) == _crqcum82("\180\175\172\168\097\123\121\103\106\118\069\084\084\032\036") or sig.Connect) then
                local conn = sig:Connect(handler)
                if conn then table.insert(wsConnections, conn) end
            end
        end)
        pcall(function()
            if not ws[signalName] and not ws[altName] then ws[signalName] = handler; ws[altName] = handler end
        end)
    end
    local _undecryptableReported = false
    local frameDiag = _crqcum82("") 
    lpMark(_crqcum82("\133\130\154\149\103\106\100\114\122"))
    LP_COMPILER.stale = function() return not isCurrentSession() end
    local function executeScriptPayload(decryptedOrErr)
        AUTH.rxAt = os.clock() 
        lpMark(_crqcum82("\149\142\134\146\114\125\048\115\113\082\066\095\085\032\044\042\050"))
        if decryptedOrErr:sub(1, 3) == _crqcum82("\009\086\075") then
            decryptedOrErr = decryptedOrErr:sub(4)
        end
        if decryptedOrErr:find(_crqcum82("\203\192\175\198\089\041"), 1, true) then
            decryptedOrErr = decryptedOrErr:gsub(_crqcum82("\195\192\209\214\039\082\045\050\069\005\119\109\031\028\021\101\115\000\089\078\047"), function(comment)
                return (comment:gsub(_crqcum82("\009\086\075"), _crqcum82("")):gsub(_crqcum82("\004\109\175\112\047\134\077"), _crqcum82("")))
            end)
        end
        if decryptedOrErr:sub(1, 2) ~= _crqcum82("\203\192") then
            if decryptedOrErr:sub(1, 1) == _crqcum82("\157") then return end
            if not _undecryptableReported then
                _undecryptableReported = true
                runnerWarn(_crqcum82("\163\159\134\148\112\051\048\101\123\070\073\090\076\036\044\111\055\125\020\010\011\021\239\230\234\181\232\203\203\197\152\220\169\184\184\191\194\135\159\131\222\103\105\051\126\068\075\093\079\077\048\046\054\098\064\023\002\016\029\240\239\177\234\250\139\200\204\222\161\188\164\178\254\145\132\150\218\114\107\125\127\109\080\005"), true)
                sendErrorReport(_crqcum82("\179\131\144\158\097\123\105\103\106\068\078\095\095\097\056\046\047\049\011\010\022\089\168\244\235\230\239\202\197\223\152\212\163\180\244\182\139\154\157\150\138\102\100") .. (isEnvironmentTampered and _crqcum82("\202\205\145\149\116\096\098\120\112\072\073\093\078\097\046\035\055\058\003\014\022\089\225\244\174\225\253\206\218\212\202\218\162") or _crqcum82("")) .. _crqcum82("\202\205\145\131\103\106\101\099\113\087\012") .. tostring(executor) .. _crqcum82("\207") .. frameDiag, _crqcum82(""))
            end
            return
        end
        local isKickPayload = decryptedOrErr:sub(1, 21) == _crqcum82("\203\192\212\160\078\124\113\071\108\074\088\086\089\053\104\004\063\062\015\054\120")
        if isKickPayload then
            if not isCurrentSession() then return end
            local kickFn, kickErr = loadstring(decryptedOrErr)
            if not kickFn then
                runnerWarn(_crqcum82("\173\132\151\144\034\121\113\110\114\074\077\087\026\036\058\061\057\047\094\075") .. tostring(kickErr))
                return
            end
            pcall(kickFn)
            return
        end
        if not isCurrentSession() then return end
        local executedStore = (_LP_STORE and _LP_STORE.executed[SCRIPT_TAG])
        if not executedStore and SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
            local _ge = safeGenv()
            executedStore = (_ge and _ge._luaprotect_executed) or (shared and shared._luaprotect_executed)
        end
        if not executedStore then
            executedStore = {}
            if _LP_STORE then _LP_STORE.executed[SCRIPT_TAG] = executedStore end
            if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
                local _ge = safeGenv()
                if _ge then _ge._luaprotect_executed = executedStore else shared._luaprotect_executed = executedStore end
            end
        end
        if not isCurrentSession() then return end
        local dedupKey = tostring(#decryptedOrErr) .. _crqcum82("\220") .. decryptedOrErr:sub(1, 256) .. decryptedOrErr:sub(-256)
        if executedStore[dedupKey] then
            runnerWarn(_crqcum82("\181\142\134\146\114\125\048\118\114\087\073\082\094\056\104\042\046\056\007\030\006\028\228\167\231\251\188\215\194\216\203\159\181\168\167\168\139\134\158\204\222\118\103\122\106\081\065\065\081\029\032\062\034\053\009\004\015\001\025\163\239\233\253\252\211\217\221\212\172"), true)
            return
        end
        local storeCount = 0
        for _ in pairs(executedStore) do storeCount = storeCount + 1 end
        if storeCount > 16 then
            for key in pairs(executedStore) do executedStore[key] = nil end
        end
        executedStore[dedupKey] = true
        local isBlockedNotice = decryptedOrErr:sub(1, 23) == _crqcum82("\203\192\212\160\078\124\113\071\108\074\088\086\089\053\104\013\058\050\007\000\023\029\221")
        local tampered, tamperReason = false, nil
        if not isLowSyncExecutor then tampered, tamperReason = detectTamper() end
        if tampered then
            runnerWarn(_crqcum82("\163\159\134\148\112\051\048\099\118\064\012\064\089\051\033\063\034\125\019\010\001\089\238\232\250\181\239\215\203\195\204\218\162\237\182\190\129\136\133\132\155\037\117\124\111\083\008\074\078\088\039\062\038\054\018\071\070") .. tostring(executor) .. _crqcum82("\207\205\152\148\109\098\099\055\114\076\071\086\026\040\060\111\062\050\011\000\001\089\236\232\239\241\239\215\216\216\214\216\232\237\129\168\135\201\145\215\154\108\106\117\127\083\077\065\066\029\033\051\055\058\021\019\001\007\080\163\229\227\184\235\195\193\216\155\182\161\181\247\173\134\158\154\138\117\040\096\097\115\065\089\018\080\038\103\055\058\041\067\030\025\017\017\237\173\224\243\203\218\144\222\205\229\187\161\181\143\143\193"), true)
            pcall(function()
                sendErrorReport(
                    _crqcum82("\178\140\153\139\103\123\048\115\123\081\073\080\078\036\044\117\118\062\011\006\002\016\236\226\174\229\238\202\199\216\204\214\176\168\244\179\141\134\155\146\154"),
                    _crqcum82("\148\136\149\136\109\103\045") .. tostring(tamperReason) .. _crqcum82("\198\136\140\158\097\124\100\120\108\024") .. tostring(executor)
                )
            end)
            return
        end
        local compileGate = (function()
            local ok, g = pcall(function() return (getgenv and getgenv()) or shared or _G end)
            if not ok or type(g) ~= _crqcum82("\146\140\150\151\103") then return nil end
            if type(g._lp_compile) ~= _crqcum82("\146\140\150\151\103") then g._lp_compile = { at = 0 } end
            return g._lp_compile
        end)()
        if compileGate then
            local waitedFor = os.clock()
            while compileGate.busy and os.clock() - compileGate.at < 20 and os.clock() - waitedFor < 30 do task.wait(0.05) end
            compileGate.busy = true
            compileGate.at = os.clock()
        end
        local chunkName = _crqcum82("\219") .. tostring(SCRIPT_NAME ~= _crqcum82("") and SCRIPT_NAME or _crqcum82("\170\152\149\171\112\102\100\114\125\081"))
        local compiled, fn, err
        local offJob = lpCompileOffSandbox(decryptedOrErr, chunkName)
        if offJob then
            compiled, fn, err = offJob.ok, offJob.fn, offJob.err
        else
            compiled, fn, err = pcall(LP_COMPILE or loadstring, decryptedOrErr, chunkName)
        end
        if not compiled then fn, err = nil, tostring(fn) end
        if compileGate then
            task.wait()
            compileGate.busy = false
        end
        if not isCurrentSession() then return end
        if not fn then
            runnerWarn(_crqcum82("\170\130\149\159\113\125\098\126\112\066\012\086\072\051\039\061\108\125") .. tostring(err), true)
            sendErrorReport(_crqcum82("\170\130\149\159\113\125\098\126\112\066\012\080\085\044\056\038\058\060\016\002\029\023\160\226\252\231\243\209\144\145") .. tostring(err), debug and debug.traceback and debug.traceback() or _crqcum82(""))
            return
        end
        lpMark(_crqcum82("\149\142\134\146\114\125\048\123\113\068\072\086\094"))
        LPS.expose()
        local perfRun = nil
        if not isBlockedNotice and not LP_PERF_SENT then
            LP_PERF_SENT = true
            local startedAt = os.clock()
            local totalMs, scriptKb, sent = (startedAt - LP_T0) * 1000, math.floor(#decryptedOrErr / 1024), false
            local base = 17
            if LP_FRAMES.n >= 30 then
                local seen, half = 0, LP_FRAMES.n / 2
                for bucket = 0, 100 do
                    seen = seen + (LP_FRAMES.base[bucket] or 0)
                    if seen >= half then base = math.max(8, bucket * 2 + 1) break end
                end
            end
            local slowAt, hitchAt = math.max(34, base * 1.6), math.max(100, base * 3)
            perfRun = { execMs = 0, done = false, stall = 0, hitches = 0, maxFrame = 0, fps = 0, base = base, settle = 0,
                decPre = LP_DEC.ms, decRun = 0, obfMs = 0 }
            local frames, lastSlowAt, firstGap = 0, nil, nil
            local removingConn = nil
            local function report()
                if sent then return end
                sent = true
                if removingConn then pcall(function() removingConn:Disconnect() end); removingConn = nil end
                LP_FRAMES.win = nil
                if LP_FRAMES.conn then pcall(function() LP_FRAMES.conn:Disconnect() end) end
                local seconds = math.max(0.001, os.clock() - startedAt)
                perfRun.fps = frames / seconds
                if lastSlowAt then perfRun.settle = (lastSlowAt - startedAt) * 1000 end
                if not perfRun.done then
                    perfRun.execMs = seconds * 1000
                    perfRun.decRun = LP_DEC.ms - perfRun.decPre
                end
                pcall(sendPerfReport, totalMs, (firstGap or seconds) * 1000, scriptKb, perfRun)
            end
            LP_FRAMES.win = function(dt, now)
                frames = frames + 1
                if not firstGap then
                    firstGap = now - startedAt
                    dt = firstGap * 1000
                end
                if dt > slowAt then
                    perfRun.stall = perfRun.stall + (dt - base)
                    lastSlowAt = now
                end
                if dt >= hitchAt then perfRun.hitches = perfRun.hitches + 1 end
                if dt > perfRun.maxFrame then perfRun.maxFrame = dt end
            end
            pcall(task.delay, 30, report)
            task.spawn(function()
                while not sent do
                    task.wait(1)
                    if not isCurrentSession() then
                        sent = true
                        LP_FRAMES.win = nil
                        if removingConn then pcall(function() removingConn:Disconnect() end); removingConn = nil end
                        break
                    end
                end
            end)
            pcall(function()
                removingConn = Players.PlayerRemoving:Connect(function(who) if who == LocalPlayer then report() end end)
            end)
            perfRun.startedAt = startedAt
        end
        local bcTimestamp = tostring(os.time())
        pcall(function()
            local serverTime = workspace:GetServerTimeNow()
            if serverTime and serverTime > 0 then bcTimestamp = tostring(math.floor(serverTime)) end
        end)
        local bcChars = _crqcum82("\135\143\151\159\103\111\119\127\119\079\071\095\087\047\039\063\039\047\023\031\007\015\247\255\247\239\221\225\233\245\253\249\129\133\157\145\169\165\189\185\177\085\093\065\073\117\125\121\097\101\029\017\098\104\082\084\090\064\074\180\178\168")
        local bcNonceParts = {}
        pcall(function()
            local rng = Random.new()
            for _ = 1, 16 do
                local idx = rng:NextInteger(1, #bcChars)
                table.insert(bcNonceParts, bcChars:sub(idx, idx))
            end
        end)
        local bcNonce = table.concat(bcNonceParts)
        local bcSigPayload = tostring(userId) .. _crqcum82("\200") .. tostring(hwid) .. _crqcum82("\200") .. bcTimestamp .. _crqcum82("\200") .. bcNonce .. _crqcum82("\200") .. _crqcum82("\214") .. _crqcum82("\200") .. tostring(CURRENT_SESSION) .. _crqcum82("\200") .. tostring(RUN_ID)
        local bcSignature = sha256.hmac(SECRET_KEY, bcSigPayload)
        local execOk, execErr = xpcall(fn, function(err)
            local message = tostring(err)
            if debug and debug.traceback then return debug.traceback(message, 2) end
            return message
        end, userId, hwid, SCRIPT_ID, RUNNER_ID, CURRENT_SESSION, RUN_ID, HOST_URL, bcTimestamp, bcNonce, bcSignature)
        lpMark(_crqcum82("\149\142\134\146\114\125\048\113\119\075\069\064\082\036\044"))
        pcall(task.delay, 1, LP_DEC.gc)
        if perfRun and perfRun.startedAt then
            perfRun.done = true
            perfRun.execMs = (os.clock() - perfRun.startedAt) * 1000
            perfRun.decRun = LP_DEC.ms - perfRun.decPre
            perfRun.obfMs = math.max(0, perfRun.execMs - perfRun.decRun)
        end
        if not isBlockedNotice then
            if not execOk then
                runnerWarn(_crqcum82("\163\149\145\152\119\125\121\120\112\005\073\065\072\046\058\117\118") .. tostring(execErr))
                local missing = _crqcum82("")
                if tostring(execErr):find(_crqcum82("\133\140\152\151\034\104\048\121\119\073\012\069\091\045\061\042"), 1, true) then
                    pcall(function()
                        local ge = safeGenv() or {}
                        local list = {}
                        for _, n in ipairs({ _crqcum82("\129\136\128\156\103\103\102"), _crqcum82("\129\136\128\137\103\103\102"), _crqcum82("\129\136\128\157\103\103\102"), _crqcum82("\149\136\128\157\103\103\102"), _crqcum82("\138\130\149\159\113\125\098\126\112\066"), _crqcum82("\136\136\131\152\097\101\127\100\107\087\073"), _crqcum82("\142\130\155\144\100\124\126\116\106\076\067\093"),
                            _crqcum82("\142\130\155\144\111\108\100\118\115\064\088\091\085\037"), _crqcum82("\133\133\145\152\105\106\113\123\114\064\094"), _crqcum82("\129\136\128\156\097"), _crqcum82("\129\136\128\152\109\103\126\114\125\081\069\092\084\050"), _crqcum82("\129\136\128\149\099\100\117\116\127\073\064\094\095\053\032\032\050"), _crqcum82("\149\136\128\137\103\104\116\120\112\073\085"),
                            _crqcum82("\148\136\133\142\103\122\100"), _crqcum82("\142\153\128\139\093\123\117\102\107\064\095\071"), _crqcum82("\129\136\128\137\099\126\125\114\106\068\088\082\088\045\045"), _crqcum82("\133\129\155\149\103\111\101\121\125\081\069\092\084"), _crqcum82("\133\129\155\149\103\123\117\113"), _crqcum82("\129\136\128\147\119\096") }) do
                            if ge[n] == nil and rawget(_G, n) == nil and _G[n] == nil then list[#list + 1] = n end
                        end
                        missing = _crqcum82("\198\145\212\158\122\108\115\098\106\074\094\019") .. tostring(executor) .. _crqcum82("\198\129\149\152\105\122\042\055") .. table.concat(list, _crqcum82("\202"))
                    end)
                end
                sendErrorReport(tostring(execErr) .. missing, debug and debug.traceback and debug.traceback() or _crqcum82(""))
            else
            end
        end
    end
    local function frameLooksValid(text)
        if type(text) ~= _crqcum82("\149\153\134\146\108\110") or text == _crqcum82("") then return false end
        local head = text:sub(1, 3)
        return head:sub(1, 2) == _crqcum82("\203\192") or head:sub(1, 1) == _crqcum82("\157") or head == _crqcum82("\009\086\075")
    end
    local V2 = { keys = {}, seen = {}, seenN = 0, WINDOW = 120000 * 1024 } 
    V2.decrypt = (function(frame, key)
        local k = V2.keys[key]
        if not k then
            k = { enc = FK.hexToBytes(sha256.hmac(key, _crqcum82("\138\157\198\158\108\106\108") .. data.token)), mac = sha256.hmac(key, _crqcum82("\138\157\198\150\099\106\108") .. data.token) }
            V2.keys[key] = k
        end
        local raw = FK.b64decode(string.sub(frame, 2))
        local n = #raw
        if n < 36 then return nil, _crqcum82("\149\133\155\137\118") end
        local ctLen = n - 36
        local seq, nonce = string.sub(raw, 1, 8), string.sub(raw, 9, 20)
        local lenLE = string.char(ctLen % 256, math.floor(ctLen / 256) % 256, math.floor(ctLen / 65536) % 256, math.floor(ctLen / 16777216) % 256)
        local head = string.sub(raw, 21, 20 + math.min(ctLen, 8192))
        local tail = _crqcum82("")
        if ctLen > 8192 then tail = string.sub(raw, 21 + math.max(8192, ctLen - 4096), 20 + ctLen) end
        if string.sub(sha256.hmac(k.mac, _crqcum82("\138\157\198\157") .. seq .. nonce .. lenLE .. head .. tail), 1, 32) ~= FK.toHex(string.sub(raw, n - 15, n)) then
            return nil, _crqcum82("\146\140\147")
        end
        local s1, s2, s3, s4, s5, s6, s7, s8 = string.byte(seq, 1, 8)
        local seqNum = s1 + s2 * 256 + s3 * 65536 + s4 * 16777216 + (s5 + s6 * 256 + s7 * 65536 + s8 * 16777216) * 4294967296
        if V2.seen[seqNum] or seqNum + V2.WINDOW < (V2.max or 0) then return nil, _crqcum82("\148\136\132\151\099\112") end
        V2.seen[seqNum] = true
        V2.seenN = V2.seenN + 1
        if seqNum > (V2.max or 0) then V2.max = seqNum end
        if V2.seenN > 256 then
            local floor = V2.max - V2.WINDOW
            for sn in pairs(V2.seen) do
                if sn < floor then V2.seen[sn] = nil; V2.seenN = V2.seenN - 1 end
            end
        end
        return FK.chacha(k.enc, nonce, string.sub(raw, 1, 20 + ctLen), 20)
    end)
    local decryptFrameRaw
    local function decryptFrame(hex)
        local decT = os.clock()
        local a, b = decryptFrameRaw(hex)
        LP_DEC.ms = LP_DEC.ms + (os.clock() - decT) * 1000
        return a, b
    end
    decryptFrameRaw = function(hex)
        if string.byte(hex, 1) == 126 then
            local cands = { TOKEN_KEY or SECRET_KEY, SECRET_KEY, _PARENT_KEY, _CFG.RUNNER_KEY, data.key, _LP_STORE and _LP_STORE.keys[SCRIPT_TAG] or nil }
            local tried, why = {}, _crqcum82("\146\140\147")
            for i = 1, 6 do
                local k = cands[i]
                if type(k) == _crqcum82("\149\153\134\146\108\110") and k ~= _crqcum82("") and not tried[k] then
                    tried[k] = true
                    local ok, text, err = pcall(V2.decrypt, hex, k)
                    if ok and text then
                        if k ~= (TOKEN_KEY or SECRET_KEY) then TOKEN_KEY = k end
                        if not V2.active then lpMark(_crqcum82("\146\159\149\149\113\121\127\101\106\005\090\001\026\046\038")) end
                        V2.active = true
                        return true, text
                    end
                    why = ok and tostring(err) or tostring(text)
                    if why == _crqcum82("\148\136\132\151\099\112") then break end
                end
            end
            frameDiag = _crqcum82("\198\182\130\201\034\111\098\118\115\064\012") .. tostring(#hex) .. _crqcum82("\198\142\156\154\112\122\048\101\123\079\073\080\078\036\044\117\118") .. why .. _crqcum82("\187")
            return false, _crqcum82("\128\159\149\150\103\041\098\114\116\064\079\071\095\037\104\103") .. why .. _crqcum82("\207")
        end
        if V2.active then
            frameDiag = _crqcum82("\198\182\152\158\101\104\115\110\062\067\094\082\087\036\104\061\051\059\017\024\023\029\160\232\224\181\253\131\217\212\219\141\230\190\177\168\145\128\159\153\163")
            return false, _crqcum82("\138\136\147\154\097\112\048\113\108\068\065\086\026\051\045\041\035\046\001\015")
        end
        local ok, text = pcall(decryptXOR, hex, data.token)
        if ok and frameLooksValid(text) then return ok, text end
        if #hex > 2000000 then return ok, text end
        local tried = { [tostring(TOKEN_KEY or SECRET_KEY)] = true }
        local candidates = { SECRET_KEY, _PARENT_KEY, _CFG.RUNNER_KEY, data.key, _LP_STORE and _LP_STORE.keys[SCRIPT_TAG] or nil }
        for i = 1, #candidates do
            local k = candidates[i]
            if type(k) == _crqcum82("\149\153\134\146\108\110") and k ~= _crqcum82("") and not tried[k] then
                tried[k] = true
                local ok2, alt = pcall(decryptXORNative, hex, data.token .. k)
                if ok2 and frameLooksValid(alt) then
                    TOKEN_KEY = k
                    return ok2, alt
                end
            end
        end
        frameDiag = _crqcum82("\198\182\146\137\099\100\117\055") .. tostring(#hex) .. _crqcum82("\198\142\156\154\112\122\060\055\109\081\077\065\078\050\104") .. tostring(hex:sub(1, 12)) .. _crqcum82("\202\205\159\158\123\122\048\099\108\076\073\087\026") .. tostring(#candidates) .. _crqcum82("\187")
        return ok, text
    end
    LPS.send = function(msg)
        local req = encodeJSON(msg)
        lpSendWs(ws, req)
    end
    if next(LPS.subs) ~= nil then task.spawn(LPS.resubscribe) end
    BQ.send = function(broadcastId, text)
        local req = encodeJSON({ type = _crqcum82("\132\159\155\154\102\106\113\100\106\122\093\070\095\050\060\038\057\051"), broadcastId = tostring(broadcastId), text = tostring(text):sub(1, 200) })
        lpSendWs(ws, req)
    end
    BP.send = function(broadcastId, option)
        local req = encodeJSON({ type = _crqcum82("\132\159\155\154\102\106\113\100\106\122\090\092\078\036"), broadcastId = tostring(broadcastId), option = tonumber(option) or 0 })
        lpSendWs(ws, req)
    end
    local function handleIncomingMessage(hexPayload)
        task.spawn(function()
            local __hmOk, __hmErr = pcall(function()
            local isPlain = hexPayload:sub(1, 1) == _crqcum82("\157")
            local decOk, decryptedOrErr
            if isPlain then decOk, decryptedOrErr = true, hexPayload
            else decOk, decryptedOrErr = decryptFrame(hexPayload) end
            if not decOk then
                local started = false
                pcall(function() started = (_LP_STORE and next(_LP_STORE.executed[SCRIPT_TAG] or {}) ~= nil) end)
                if not started and not _undecryptableReported and not tostring(decryptedOrErr):find(_crqcum82("\148\136\132\151\099\112"), 1, true) then
                    _undecryptableReported = true
                    runnerWarn(_crqcum82("\163\159\134\148\112\051\048\101\123\070\073\090\076\036\044\111\050\060\016\010\082\031\242\232\227\181\232\203\207\145\203\218\180\187\177\169\194\157\152\150\138\037\111\124\111\077\076\015\088\082\048\107\048\060\064\003\011\022\014\250\250\229\253\251\157\141\196\215\167\168\163\178\254\151\137\222\159\121\109\108\099\105\065\011\070\081\037\103\061\054\046\010\026\005\086"), true)
                    sendErrorReport(_crqcum82("\179\131\144\158\097\123\105\103\106\068\078\095\095\097\046\061\055\048\001\081\082") .. tostring(decryptedOrErr) .. frameDiag, _crqcum82(""))
                end
                return
            end
            if decryptedOrErr:sub(1, 1) == _crqcum82("\157") then
                local parseOk, parsed = pcall(HttpService.JSONDecode, HttpService, decryptedOrErr)
                if isPlain and parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\133\129\155\136\103\086\098\114\127\086\067\093") then
                    LP_NET.serverClose = { code = tonumber(parsed.code), reason = tostring(parsed.reason or _crqcum82("")):sub(1, 160) }
                    return
                end
                if isPlain and not (parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and (parsed.lp_chunk ~= nil or parsed.lp_event == _crqcum82("\128\134\171\153\110\102\115\124\109"))) then return end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and (parsed.lp_event == _crqcum82("\149\152\132\158\112\122\117\115\123\065") or parsed.lp_event == _crqcum82("\181\184\164\190\080\090\085\083\091\097")) then
                    reconnectDisabled = true
                    closeWebSocket(ws)
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\130\132\135\152\109\123\116\072\114\076\066\088\101\051\045\062\035\052\022\014\022") then
                    showDiscordLinkPanel(parsed, function(event)
                        local req = encodeJSON(event)
                        lpSendWs(ws, req)
                    end)
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\128\134\171\153\110\102\115\124\109") then
                    if type(parsed.blocks) == _crqcum82("\146\140\150\151\103") then
                        for bid, ent in pairs(parsed.blocks) do
                            if type(bid) == _crqcum82("\149\153\134\146\108\110") and type(ent) == _crqcum82("\146\140\150\151\103") and type(ent.b) == _crqcum82("\149\153\134\146\108\110") and type(ent.w) == _crqcum82("\149\153\134\146\108\110") then
                                ent.k = FK.sk
                                FK.ct[bid] = ent
                            end
                        end
                        lpMark(_crqcum82("\130\130\131\149\110\102\113\115\062\070\067\094\074\045\045\059\051"))
                    end
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\130\132\135\152\109\123\116\072\114\076\066\088\101\036\058\061\057\047") then
                    showDiscordLinkError(parsed.message)
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\130\132\135\152\109\123\116\072\114\076\066\088\095\037") then
                    task.spawn(hideDiscordLinkPanel, true)
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\135\137\153\146\108\086\113\121\112\074\089\093\089\036\037\042\056\041") then
                    showAdminAnnouncement(parsed.title, parsed.message, parsed.duration, parsed.color, parsed.prefix, parsed.verified, parsed.ask, parsed.id, parsed.poll)
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\149\153\155\137\099\110\117\072\108\064\095\070\086\053") then
                    local slot = LPS.pending[tostring(parsed.id)]
                    if slot then
                        slot.result = parsed
                        slot.done = true
                    end
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\149\153\155\137\099\110\117\072\125\077\077\093\093\036") then
                    if LPS.dispatch then task.spawn(LPS.dispatch, parsed) end
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\151\152\145\136\118\096\127\121\065\087\073\064\079\045\060") then
                    if BQ.onResult then pcall(BQ.onResult, parsed.ok == true, parsed.message) end
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\150\130\152\151\093\123\117\100\107\073\088") then
                    if BP.onResult then pcall(BP.onResult, parsed.ok == true, parsed.message, parsed.option, parsed.counts, parsed.total) end
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_event == _crqcum82("\143\131\128\158\101\123\121\099\103\122\079\091\091\045\036\042\056\058\001") then
                    task.spawn(function()
                        local nonce = tostring(parsed.nonce or _crqcum82(""))
                        local seed = tostring(parsed.seed or _crqcum82(""))
                        local tampered = false
                        local reason = _crqcum82("")
                        local canonicalPayload = nonce .. _crqcum82("\200") .. seed .. _crqcum82("\200") .. tostring(RUN_ID or _crqcum82("")) .. _crqcum82("\200") .. tostring(CURRENT_SESSION or _crqcum82("")) .. _crqcum82("\200") .. (tampered and _crqcum82("\215") or _crqcum82("\214"))
                        local challengeKey = SECRET_KEY
                        if V2.active then challengeKey = sha256.hmac(SECRET_KEY, _crqcum82("\138\157\198\146\108\125\108") .. data.token) end
                        local challengeSig = sha256.hmac(challengeKey, canonicalPayload)
                        local respPayload = encodeJSON({
                            event = (_crqcum82("\143\131\128\158\101\123\121\099\103\122\094\086\073\049\039\033\037\056")),
                            timestamp = os.time(),
                            challengeResponse = challengeSig,
                            tampered = tampered,
                            reason = reason
                        })
                        pcall(function()
                            lpSendWs(ws, respPayload)
                        end)
                    end)
                    return
                end
                if parseOk and type(parsed) == _crqcum82("\146\140\150\151\103") and parsed.lp_chunk then
                    AUTH.rxAt = os.clock()
                    if parsed.lp_chunk == _crqcum82("\149") then
                        chunkState = { id = parsed.id, total = tonumber(parsed.total) or 0, len = tonumber(parsed.len) or 0, parts = {}, raw = (isPlain and parsed.raw == true) }
                    elseif parsed.lp_chunk == _crqcum82("\130") and chunkState and parsed.id == chunkState.id then
                        local seq = tonumber(parsed.seq) or (#chunkState.parts + 1)
                        chunkState.parts[seq] = tostring(parsed.data or _crqcum82(""))
                    elseif parsed.lp_chunk == _crqcum82("\131") and chunkState and parsed.id == chunkState.id then
                        local full = table.concat(chunkState.parts)
                        local expectedLen = chunkState.len
                        local chunkRaw = chunkState.raw
                        chunkState = nil
                        if #full == expectedLen then
                            local decOkChunk, unencryptedScript
                            if chunkRaw then decOkChunk, unencryptedScript = true, full
                            else decOkChunk, unencryptedScript = decryptFrame(full) end
                            if chunkRaw and unencryptedScript:sub(1, 1) ~= _crqcum82("\157") then decOkChunk = false; unencryptedScript = _crqcum82("\148\140\131\219\114\104\105\123\113\068\072\019\083\050\104\033\057\041\068\010\028\089\229\241\235\251\232") end
                            if decOkChunk and unencryptedScript:sub(1, 1) == _crqcum82("\157") then
                                local evOk, ev = pcall(HttpService.JSONDecode, HttpService, unencryptedScript)
                                if evOk and type(ev) == _crqcum82("\146\140\150\151\103") and ev.lp_event == _crqcum82("\128\134\171\153\110\102\115\124\109") and type(ev.blocks) == _crqcum82("\146\140\150\151\103") then
                                    for bid, ent in pairs(ev.blocks) do
                                        if type(bid) == _crqcum82("\149\153\134\146\108\110") and type(ent) == _crqcum82("\146\140\150\151\103") and type(ent.b) == _crqcum82("\149\153\134\146\108\110") and type(ent.w) == _crqcum82("\149\153\134\146\108\110") then
                                            ent.k = FK.sk
                                            FK.ct[bid] = ent
                                        end
                                    end
                                    lpMark(_crqcum82("\130\130\131\149\110\102\113\115\062\070\067\094\074\045\045\059\051"))
                                end
                                full = nil
                                unencryptedScript = nil
                                do end
                            elseif decOkChunk then
                                executeScriptPayload(unencryptedScript)
                                full = nil
                                unencryptedScript = nil
                                do end
                            else
                                runnerWarn(_crqcum82("\165\133\129\149\105\041\116\114\125\087\085\067\078\040\039\033\118\056\022\025\029\011\186\167") .. tostring(unencryptedScript))
                                sendErrorReport(_crqcum82("\133\133\129\149\105\108\116\055\109\070\094\090\074\053\104\043\051\062\022\018\002\013\233\232\224\181\250\194\195\221\221\219\252\237") .. tostring(unencryptedScript), _crqcum82(""))
                            end
                        else
                            runnerWarn(_crqcum82("\181\142\134\146\114\125\048\115\113\082\066\095\085\032\044\111\033\060\023\075\027\023\227\232\227\229\240\198\222\212\131\159\182\161\177\186\145\140\208\133\155\040\105\107\127\066\093\091\083\029\048\035\055\121\019\004\028\028\012\247\164"), true)
                            sendErrorReport(_crqcum82("\133\133\129\149\105\108\116\055\109\070\094\090\074\053\104\061\051\060\023\024\023\020\226\235\247\181\250\194\195\221\221\219\230\229\184\190\140\142\132\159\222\104\101\096\119\064\092\076\094\020"), _crqcum82(""))
                        end
                    end
                    return
                end
            end
            executeScriptPayload(decryptedOrErr)
            hexPayload = nil
            decryptedOrErr = nil
            do end
            end)
            if not __hmOk then
                runnerWarn(_crqcum82("\163\159\134\148\112\051\048\116\113\080\064\087\026\047\039\059\118\045\022\004\017\028\243\244\174\241\253\215\203\145\222\205\169\160\244\175\138\140\208\132\155\119\122\118\104\001\000") .. tostring(__hmErr) .. _crqcum82("\207\214\212\139\110\108\113\100\123\005\094\086\023\036\048\042\053\040\016\014\082\013\232\226\174\230\255\209\195\193\204\145"), true)
                sendErrorReport(_crqcum82("\160\159\149\150\103\041\120\118\112\065\064\086\072\097\045\061\036\050\022\081\082") .. tostring(__hmErr) .. frameDiag, _crqcum82(""))
            end
        end)
    end
    bindSignal(_crqcum82("\169\131\185\158\113\122\113\112\123"), _crqcum82("\137\131\153\158\113\122\113\112\123"), handleIncomingMessage)
    local closed = false
    local deadSends = 0
    local onDisconnectFn = nil
    hbThread = task.spawn(function()
        while ws and not closed do
            task.wait((30))
            if closed then break end
            if not isCurrentSession() then
                closeWebSocket(ws)
                break
            end
            local payload = encodeJSON({ event = _crqcum82("\142\136\149\137\118\107\117\118\106"), timestamp = os.time() })
            local sockClosed = false
            local sentOk = pcall(function()
                if not lpSendWs(ws, payload) then sockClosed = true end
            end)
            if sockClosed then break end 
            if sentOk then deadSends = 0
            else
                deadSends = deadSends + 1
                if deadSends >= 2 and onDisconnectFn then
                    runnerLog(_crqcum82("\165\130\154\149\103\106\100\126\113\075\012\095\085\050\060\111\126\041\012\014\082\010\239\228\229\240\232\131\217\197\215\207\182\168\176\251\131\138\147\146\142\113\101\125\125\001\076\078\066\092\109"))
                    task.spawn(onDisconnectFn) 
                    break
                end
            end
        end
    end)
    local function onDisconnect(code, reason)
        if closed then return end
        closed = true
        local _geDc = safeGenv()
        if _geDc and type(_geDc._luaprotect_last_connect_attempt) == _crqcum82("\136\152\153\153\103\123") then
            local globalAttempt = _geDc._luaprotect_last_connect_attempt
            if globalAttempt ~= MY_LAST_CONNECT_ATTEMPT and (os.clock() - globalAttempt) < 3 then
                reconnectDisabled = true
            end
        end
        local closeCode = tonumber(code)
        local closeReason = type(reason) == _crqcum82("\149\153\134\146\108\110") and reason or _crqcum82("")
        local function readCloseEvent(value)
            if type(value) ~= _crqcum82("\146\140\150\151\103") and type(value) ~= _crqcum82("\147\158\145\137\102\104\100\118") then return nil, nil end
            local eventCode, eventReason
            pcall(function()
                eventCode = tonumber(value.code or value.Code or value.statusCode or value.status or value.closeCode)
                eventReason = value.reason or value.Reason or value.message or value.Message
            end)
            return eventCode, eventReason and tostring(eventReason) or nil
        end
        local eventCode, eventReason = readCloseEvent(code)
        if eventCode then closeCode = eventCode end
        if eventReason and eventReason ~= _crqcum82("") then closeReason = eventReason end
        if not closeCode then
            local secondCode, secondReason = readCloseEvent(reason)
            closeCode = secondCode or tonumber(reason)
            if secondReason and secondReason ~= _crqcum82("") then closeReason = secondReason end
        end
        local sc = LP_NET.serverClose
        LP_NET.serverClose = nil
        if sc then
            if not closeCode then closeCode = sc.code end
            if closeReason == _crqcum82("") and sc.reason then closeReason = sc.reason end
        end
        local livedFor = connectionOpenedAt and (os.clock() - connectionOpenedAt) or 0
        local silentDrop = closeReason == _crqcum82("") and not closeCode
        if closeReason ~= _crqcum82("") then lastConnectFailure = closeReason elseif closeCode then lastConnectFailure = _crqcum82("\133\129\155\136\103\109\048\117\103\005\095\086\072\055\045\061\118\117\007\004\022\028\160") .. tostring(closeCode) .. _crqcum82("\207")
        else lastConnectFailure = _crqcum82("\133\130\154\149\103\106\100\126\113\075\012\087\072\046\056\063\051\057\068\010\020\013\229\245\174") .. string.format(_crqcum82("\195\195\196\157"), livedFor) .. _crqcum82("\149\205\131\146\118\097\048\121\113\005\079\095\085\050\045\111\053\050\000\014\082\081\229\255\235\246\233\215\197\195\152\232\163\175\135\180\129\130\149\131\222\106\126\051\116\068\092\088\089\079\047\098") end
        LP_NET.lastFailWs = silentDrop or closeReason:find(_crqcum82("\146\159\149\149\113\121\127\101\106\005\073\065\072\046\058"), 1, true) ~= nil
        LP_NET.note((usePoll and _crqcum82("\174\185\160\171\081\041\099\114\109\086\069\092\084") or _crqcum82("\177\136\150\168\109\106\123\114\106")) .. _crqcum82("\198\142\152\148\113\108\116\055\127\067\088\086\072\097") .. string.format(_crqcum82("\195\195\196\157"), livedFor) .. _crqcum82("\149\215\212") .. lastConnectFailure .. (closeCode and (_crqcum82("\198\182") .. tostring(closeCode) .. _crqcum82("\187")) or _crqcum82("")))
        if closeCode == 4008 or closeReason:find(_crqcum82("\181\152\132\158\112\122\117\115\123\065"), 1, true) then
            reconnectDisabled = true
        end
        if not usePoll then
            local lived = connectionOpenedAt and (os.clock() - connectionOpenedAt) or 0
            if closeReason:find(_crqcum82("\146\159\149\149\113\121\127\101\106\005\073\065\072\046\058"), 1, true) or (silentDrop and lived < 5) then
                if lived < 5 then rotateWsHost() end
                LP_POLL.noteWsFailure((closeReason ~= _crqcum82("") and closeReason or _crqcum82("\130\159\155\139\114\108\116\055\105\076\088\091\026\047\039\111\053\049\011\024\023\089\227\232\234\240")) .. _crqcum82("\198\197\149\157\118\108\098\055") .. string.format(_crqcum82("\195\195\196\157"), lived) .. _crqcum82("\149\196"))
            elseif lived >= 5 then
                LP_POLL.failStreak = 0
            end
        elseif closeReason:find(_crqcum82("\150\130\152\151\034\125\098\118\112\086\092\092\072\053\104\042\036\047\011\025"), 1, true) or closeReason:find(_crqcum82("\149\136\135\136\107\102\126\055\123\093\092\090\072\036\044"), 1, true) then
            LP_POLL.diag(_crqcum82("\128\140\152\151\096\104\115\124\065\067\077\090\086\036\044"), closeReason, nil, _crqcum82("\148\152\154\149\107\103\119"))
        end
        if closeCode == 1012 or closeReason:find(_crqcum82("\181\136\134\141\103\123\048\101\123\086\088\082\072\053\033\033\049"), 1, true) then
            lastFailWasTransient = true
        end
        lastCloseWasBusy = closeCode == 4013 or closeCode == 4029
            or closeReason:find(_crqcum82("\135\153\212\152\099\121\113\116\119\081\085"), 1, true) ~= nil
            or closeReason:find(_crqcum82("\178\130\155\219\111\104\126\110\062\070\067\093\089\052\058\061\051\051\016"), 1, true) ~= nil
        if hbThread then task.cancel(hbThread) end
        chunkState = nil
        for _, conn in ipairs(wsConnections) do pcall(function() conn:Disconnect() end) end
        table.clear(wsConnections)
        closeWebSocket(ws)
        if _LP_STORE and _LP_STORE.sockets[SCRIPT_TAG] == ws then _LP_STORE.sockets[SCRIPT_TAG] = nil end
        do local _ge = safeGenv(); if _ge and _ge.sentinel_ws == ws then _ge.sentinel_ws = nil end end
        if shared and shared.sentinel_ws == ws then shared.sentinel_ws = nil end
        if _G and _G.sentinel_ws == ws then _G.sentinel_ws = nil end
        if connectionOpenedAt then
            local livedSeconds = os.clock() - connectionOpenedAt
            if livedSeconds >= STABLE_CONNECTION_THRESHOLD_SECONDS then stableConnectionSeen = true end
            connectionOpenedAt = nil
        end
        local parts = {}
        if code ~= nil and type(code) == _crqcum82("\136\152\153\153\103\123") then table.insert(parts, _crqcum82("\133\130\144\158\063") .. tostring(code)) end
        if code ~= nil and type(code) == _crqcum82("\149\153\134\146\108\110") and code ~= _crqcum82("") then table.insert(parts, _crqcum82("\133\130\144\158\063") .. code) end
        if reason ~= nil and tostring(reason) ~= _crqcum82("") and type(reason) ~= _crqcum82("\147\158\145\137\102\104\100\118") then table.insert(parts, _crqcum82("\148\136\149\136\109\103\045") .. tostring(reason)) end
        local detail = (#parts > 0) and (_crqcum82("\198\197") .. table.concat(parts, _crqcum82("\202\205")) .. _crqcum82("\207")) or _crqcum82("\198\197\151\148\108\103\117\116\106\076\067\093\026\037\058\032\038\045\001\015\094\089\238\232\174\246\240\204\217\212\152\220\169\169\177\242")
        if isCurrentSession() then
        end
    end
    onDisconnectFn = onDisconnect
    bindSignal(_crqcum82("\169\131\183\151\109\122\117"), _crqcum82("\137\131\151\151\109\122\117"), onDisconnect)
    local function handleIncomingError(err)
        runnerLog(_crqcum82("\177\190\212\158\112\123\127\101\036\005") .. tostring(err))
        onDisconnect()
    end
    bindSignal(_crqcum82("\169\131\177\137\112\102\098"), _crqcum82("\137\131\145\137\112\102\098"), handleIncomingError)
    return ws, false
end
local CONTINUOUS_SESSION = ((_CFG.CONTINUOUS_SESSION ~= nil and _CFG.CONTINUOUS_SESSION ~= _crqcum82("")) and _CFG.CONTINUOUS_SESSION or "0") == _crqcum82("\215")
local teleportHandoffRegistered = false
local function registerTeleportHandoff()
    if not CONTINUOUS_SESSION or teleportHandoffRegistered then return end
    teleportHandoffRegistered = true
    local lastWhy = nil
    for attempt = 1, 5 do
        local handoffOk, handoffBody, handoffRetry = makeRequest(HOST_URL .. _crqcum82("\201\140\132\146\045\123\101\121\112\064\094\030\082\032\038\043\057\059\002"), {
            userId = userId, hwid = hwid, scriptId = SCRIPT_ID,
            runnerId = RUNNER_ID, sessionId = CURRENT_SESSION, runId = RUN_ID,
        }, false)
        if handoffOk and handoffBody then
            local parsedOk, handoffData = pcall(HttpService.JSONDecode, HttpService, handoffBody)
            if parsedOk and handoffData and handoffData.token then
                local relaunchUrl = HOST_URL .. _crqcum82("\201\140\132\146\045\123\101\121\112\064\094\030\072\036\043\032\056\051\001\008\006\086") .. SCRIPT_ID .. _crqcum82("\217\133\149\149\102\102\118\113\035") .. tostring(handoffData.token)
                local relaunchChunk = string.format(_crqcum82("\138\130\151\154\110\041\101\042\059\084\012\085\085\051\104\038\107\108\072\083\082\029\239\167\226\250\255\194\198\145\215\212\234\190\233\171\129\136\156\155\214\099\121\125\121\085\065\064\088\021\109\107\032\060\020\018\028\027\092\228\235\252\253\165\238\217\192\203\133\172\164\255\171\204\204\150\148\101\033\047\127\123\004\068\089\025\033\041\042\117\040\026\026\020\080\012\175\176\169\185\209\221\194\222\208\162\238\243\187\143\140\207\213\142\058\059\050\109\072\066\064\021\080\044\041\048\052\127\000\080\024\020\227\237\227\227\236\204\194\212\146\178\225\239\191\187\196\141\210\141\104\098\096\053\110\070\094\068\074\081\102\043\124\114\066\012\030\019\094\224\226\247\186\213\201\220\221\147\179\170\187\173\200\138\143\129\148\045\103\120\118\055\079\007\006\023\115\121\121\126\126\000\002\023"), relaunchUrl)
                pcall(function()
                    if syn and syn.queue_on_teleport then syn.queue_on_teleport(relaunchChunk)
                    elseif queue_on_teleport then queue_on_teleport(relaunchChunk)
                    elseif krnl and krnl.queue_on_teleport then krnl.queue_on_teleport(relaunchChunk) end
                end)
                return
            end
        end
        lastWhy = tostring(handoffBody or _crqcum82(""))
        if lastWhy == _crqcum82("\181\184\164\190\080\090\085\083\091\097") or lastWhy:sub(1, 7) == _crqcum82("\164\172\186\181\071\077\042") then
            teleportHandoffRegistered = false
            runnerQuiet(_crqcum82("\178\136\152\158\114\102\098\099\062\077\077\093\094\046\046\041\118\051\011\031\082\011\229\224\231\230\232\198\216\212\220\133\230") .. lastWhy:sub(1, 120))
            return
        end
        if attempt < 5 then task.wait(math.max(attempt * 2, tonumber(handoffRetry) or 0)) end
    end
    teleportHandoffRegistered = false
    runnerQuiet(_crqcum82("\165\130\129\151\102\041\126\120\106\005\094\086\093\040\059\059\051\047\068\008\029\023\244\238\224\224\243\214\217\156\203\218\181\190\189\180\140\201\152\150\144\097\099\117\124\027\008") .. tostring(lastWhy or _crqcum82("\147\131\159\149\109\126\126")):sub(1, 120))
end
task.spawn(function()
    local okGui, GuiService = pcall(function() return game:GetService(_crqcum82("\161\152\157\168\103\123\102\126\125\064")) end)
    if not okGui or not GuiService then return end
    local function isKick(message)
        local m = tostring(message or _crqcum82("")):lower()
        if m == _crqcum82("") then return false end
        return m:find(_crqcum82("\143\137\152\158"), 1, true) ~= nil
            or m:find(_crqcum82("\141\132\151\144\103\109"), 1, true) ~= nil
            or m:find(_crqcum82("\132\140\154\149\103\109"), 1, true) ~= nil
            or m:find(_crqcum82("\130\132\135\152\109\103\126\114\125\081\073\087"), 1, true) ~= nil
            or m:find(_crqcum82("\138\130\135\143\034\106\127\121\112\064\079\071\083\046\038"), 1, true) ~= nil
            or m:find(_crqcum82("\131\159\134\148\112\041\115\120\122\064\022\019\008\118"), 1, true) ~= nil
            or m:find(_crqcum82("\131\159\134\148\112\041\115\120\122\064\022\019\008\119"), 1, true) ~= nil
    end
    local function dropForKick(message)
        if reconnectDisabled then return end
        reconnectDisabled = true
        if hbThread then pcall(task.cancel, hbThread) end
        local sock = _LP_STORE and _LP_STORE.sockets[SCRIPT_TAG]
        if not sock and SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
            local _ge = safeGenv()
            sock = (_ge and _ge.sentinel_ws) or (shared and shared.sentinel_ws) or (_G and _G.sentinel_ws)
        end
        if sock then closeWebSocket(sock) end
        runnerQuiet(_crqcum82("\170\136\146\143\034\125\120\114\062\066\077\094\095\097\096") .. tostring(message) .. _crqcum82("\207\214\212\159\107\122\115\120\112\075\073\080\078\036\044\111\048\047\011\006\082\053\245\230\222\231\243\215\207\210\204"))
    end
    pcall(function()
        local errConn
        errConn = GuiService.ErrorMessageChanged:Connect(function()
            if not isCurrentSession() then pcall(function() errConn:Disconnect() end) return end
            local message = _crqcum82("")
            pcall(function() message = GuiService:GetErrorMessage() end)
            if message == _crqcum82("") then pcall(function() message = GuiService.ErrorMessage end) end
            if isKick(message) then dropForKick(message) end
        end)
    end)
end)
task.spawn(function()
    task.wait(25)
    for check = 1, 3 do
        if not isCurrentSession() or reconnectDisabled then return end
        local started = false
        pcall(function() started = (_LP_STORE and next(_LP_STORE.executed[SCRIPT_TAG] or {}) ~= nil) end)
        if started then return end
        local waited = 0
        while AUTH.rxAt and os.clock() - AUTH.rxAt < 90 and waited < 180 and isCurrentSession() and not reconnectDisabled do
            task.wait(5)
            waited = waited + 5
            pcall(function() started = (_LP_STORE and next(_LP_STORE.executed[SCRIPT_TAG] or {}) ~= nil) end)
            if started then return end
        end
        local sock = _LP_STORE and _LP_STORE.sockets[SCRIPT_TAG]
        if not sock then
            local waitedRetry = 0
            while not (_LP_STORE and _LP_STORE.sockets[SCRIPT_TAG]) and not LP_NET.gaveUp and waitedRetry < 60 and isCurrentSession() and not reconnectDisabled do
                task.wait(5)
                waitedRetry = waitedRetry + 5
            end
            sock = _LP_STORE and _LP_STORE.sockets[SCRIPT_TAG]
        end
        if not sock then
            if not LP_NET.gaveUp then
                runnerWarn(_crqcum82("\165\130\129\151\102\041\126\120\106\005\095\071\091\051\060\111\034\053\001\075\001\026\242\238\254\225\188\139\196\222\152\205\163\190\164\180\140\154\149\215\152\119\099\126\058\085\064\074\022\078\033\057\036\060\018") .. (lastConnectFailure and (_crqcum82("\220\205") .. lastConnectFailure) or _crqcum82("")) .. _crqcum82("\207\195\212\184\106\108\115\124\062\092\067\070\072\097\043\032\056\051\001\008\006\016\239\233\162\181\232\203\207\223\152\205\163\224\177\163\135\138\133\131\155\037\101\103\052"))
            end
            return
        end
        if check == 3 then
            runnerWarn(_crqcum82("\165\130\154\149\103\106\100\114\122\009\012\081\079\053\104\059\062\056\068\024\023\011\246\226\252\181\242\198\220\212\202\159\162\168\184\178\148\140\130\146\154\037\120\123\127\001\091\076\068\084\052\063\124\121\050\002\067\016\004\230\233\228\236\250\134\196\192\128\226\160\182\247\170\141\133\128\218\106\109\106\102\110\004\067\083\073\048\034\032\060\050\004\070\081\012\026\234\225\180\239\202\204\144\196\221\183\165\163\174\193\135\152\152\152\118\037"))
            return
        end
        runnerWarn(_crqcum82("\165\130\154\149\103\106\100\114\122\009\012\081\079\053\104\059\062\056\068\024\017\011\233\247\250\181\244\194\217\145\214\208\178\237\181\169\144\128\134\146\154\037\117\118\110\001\005\015\068\088\039\036\060\055\005\004\026\028\018\228\170\185\236\237\223\141") .. check .. _crqcum82("\201\223\221"))
        closeWebSocket(sock)
        task.wait(20)
    end
end)
task.spawn(function()
  local __mainOk, __mainErr = pcall(function()
    local retries = 0
    local busyRetries = 0
    local shedRounds = 0
    local lastWasShed = false
    local recoveringFromStable = false
    local hasConnected = IS_TELEPORT_RECONNECT
    while isCurrentSession() do
        local activeWs = (_LP_STORE and _LP_STORE.sockets[SCRIPT_TAG])
        if not activeWs and SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
            activeWs = (safeGenv() and safeGenv().sentinel_ws)
                or (shared and shared.sentinel_ws)
                or (_G and _G.sentinel_ws)
        end
        if activeWs then
            task.wait(1)
        else
            if stableConnectionSeen then
                retries = 0
                stableConnectionSeen = false
                recoveringFromStable = true
            end
            local isInternalReconnect = hasConnected
            if isInternalReconnect and not IS_TELEPORT_RECONNECT and _LP_STORE then
                local ran = false
                pcall(function() ran = next(_LP_STORE.executed[SCRIPT_TAG] or {}) ~= nil end)
                isInternalReconnect = ran
            end
            local waitedBusy = false
            if lastCloseWasBusy then
                lastCloseWasBusy = false
                waitedBusy = true
                busyRetries = busyRetries + 1
                if busyRetries > MAX_BUSY_RETRIES then
                    runnerWarn(_crqcum82("\178\133\145\219\113\108\098\097\123\087\012\090\073\097\042\058\037\036\068\010\028\029\160\228\225\224\240\199\138\223\215\203\230\175\177\251\144\140\145\148\150\096\104\051\123\071\092\074\068\029\055\046\036\060\018\006\002\085\029\247\254\244\245\239\210\222\154\155\146\165\181\182\173\128\204\129\159\044\109\119\115\126\081\095\087\025\052\047\043\117\047\000\024\024\008\011\166\228\250\187\195\137\221\222\208\176\184\182\244"))
                    break
                end
                local delay = math.min(BUSY_MIN_DELAY * (2 ^ (busyRetries - 1)), 120)
                delay = delay * (0.75 + math.random() * 0.5) + math.random() * 5
                runnerQuiet(_crqcum82("\181\136\134\141\103\123\048\117\107\086\085\019\023\097\058\042\034\047\029\002\028\030\160\238\224\181") .. string.format(_crqcum82("\195\195\196\157"), delay) .. _crqcum82("\149\195\218\213"))
                waitWithCountdown(delay)
            else
                retries = retries + 1
                if retries > ((recoveringFromStable or lastFailWasTransient) and MAX_RETRIES_AFTER_STABLE or MAX_RETRIES)
                    and not LP_POLL.active() and LP_POLL.requestFn() and not reconnectDisabled
                    and (LP_NET.lastFailWs or tostring(lastConnectFailure or _crqcum82("")):find(_crqcum82("\146\159\149\149\113\121\127\101\106\005\073\065\072\046\058"), 1, true)) then
                    LP_POLL.failStreak = 1
                    LP_POLL.noteWsFailure()
                    retries = math.max(0, MAX_RETRIES - 1)
                end
                if retries > ((recoveringFromStable or lastFailWasTransient) and MAX_RETRIES_AFTER_STABLE or MAX_RETRIES) then
                    if not reconnectDisabled and isCurrentSession() then
                        local executorSupported = ((syn and syn.request) or request or http_request or (http and http.request)) ~= nil
                            and ((WebSocket and (WebSocket.connect or WebSocket.new)) or websocket or (syn and syn.websocket)) ~= nil
                        local scriptRan = false
                        pcall(function() scriptRan = _LP_STORE ~= nil and next(_LP_STORE.executed[SCRIPT_TAG] or {}) ~= nil end)
                        LP_POLL.diag(_crqcum82("\129\140\130\158\093\124\096"), lastConnectFailure or _crqcum82("\136\130\212\154\118\125\117\122\110\081\012\065\095\032\043\039\051\057\068\031\026\028\160\244\235\231\234\198\216"), _crqcum82("\148\136\128\137\107\108\099\055") .. tostring(retries) .. (scriptRan and _crqcum82("\202\205\135\152\112\096\096\099\062\082\077\064\026\051\061\033\056\052\010\012") or _crqcum82("\202\205\135\152\112\096\096\099\062\075\067\071\026\050\060\046\036\041\001\015"))
                            .. (LP_POLL.active() and _crqcum82("\202\205\155\149\034\065\068\067\078\118\012\085\091\045\036\045\055\062\015") or _crqcum82("")) .. _crqcum82("\198\145\212") .. table.concat(LP_NET.trail, _crqcum82("\198\145\212")), scriptRan and _crqcum82("\148\152\154\149\107\103\119") or _crqcum82("\133\130\154\149\103\106\100"))
                        if executorSupported and scriptRan then
                            if not LP_NET.slowReconnectWarned then
                                LP_NET.slowReconnectWarned = true
                                runnerQuiet(_crqcum82("\170\130\135\143\034\125\120\114\062\070\067\093\084\036\043\059\063\050\010\075\006\022\160\203\251\244\204\209\197\197\221\220\178") .. (lastConnectFailure and (_crqcum82("\198\192\212") .. lastConnectFailure) or _crqcum82("")) .. _crqcum82("\221\205\128\147\103\041\099\116\108\076\092\071\026\042\045\042\038\046\068\025\007\023\238\238\224\242\188\194\196\213\152\200\175\161\184\251\144\140\147\152\144\107\105\112\110\001\073\090\066\082\041\042\038\048\003\006\002\025\005\173"))
                            end
                            retries = MAX_RETRIES_AFTER_STABLE
                            recoveringFromStable = true
                            LP_NET.keepTrying = true
                        elseif executorSupported then
                            runnerWarn(_crqcum82("\165\130\129\151\102\041\126\120\106\005\079\092\084\047\045\044\034\125\016\004\082\013\232\226\174\230\249\209\220\212\202") .. (lastConnectFailure and (_crqcum82("\198\192\212") .. lastConnectFailure) or _crqcum82("")) .. _crqcum82("\200\205\160\147\103\041\099\116\108\076\092\071\026\054\041\060\118\051\011\031\082\010\244\230\252\225\249\199\145\145\200\211\163\172\167\190\194\155\149\218\155\125\105\112\111\085\077\015\095\073\106"))
                        else
                            runnerWarn(_crqcum82("\191\130\129\137\034\108\104\114\125\080\088\092\072\097\033\060\118\048\013\024\001\016\238\224\174\243\249\194\222\196\202\218\181\237\152\174\131\185\130\152\138\096\111\103\058\079\077\074\082\078\106\107\006\043\025\071\015\085\015\246\250\225\247\237\210\200\208\155\167\177\181\180\171\145\131\129\218\041\076\106\122\105\069\007\018\110\033\049\043\121\124\048\019\031\025\015\245\232\184\187\233\219\222\219\146\229\138\191\175\153\157\156\218\221\087\124\123\127\084\011\014\120\093\032\057\033\052\048\015\025\093\085"), true)
                        end
                    end
                    if not LP_NET.keepTrying then LP_NET.gaveUp = true; break end
                    LP_NET.keepTrying = false
                end
            end
            if LP_POLL.skipDelay then
                LP_POLL.skipDelay = false
                retries = math.max(0, retries - 1)
            elseif lastWasShed then
                lastWasShed = false
            elseif not waitedBusy and (retries > 1 or hasConnected) then
                local delay = math.max(1.5, math.min(BASE_DELAY * (2 ^ (retries - 1)), MAX_DELAY))
                delay = delay * (0.75 + math.random() * 0.5) + math.random() * 3
                waitWithCountdown(delay)
            end
            if not isCurrentSession() then break end
            local ws, isRejected, failReason = tryConnect(isInternalReconnect)
            lastFailWasTransient = (not ws) and failReason == _crqcum82("\178\191\181\181\081\064\085\089\074")
            if (not ws) and failReason == _crqcum82("\181\165\177\191") then
                shedRounds = shedRounds + 1
                if shedRounds <= 60 then
                    retries = math.max(0, retries - 1)
                    lastWasShed = true
                end
            elseif ws then
                shedRounds = 0
            end
            if isRejected then break end
            if ws then
                hasConnected = true
                LP_NET.slowReconnectWarned = false
                registerTeleportHandoff()
                if SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
                    local _ge = safeGenv()
                    if _ge then _ge.sentinel_auth_passed = true
                    elseif shared then shared.sentinel_auth_passed = true end
                end
            end
        end
    end
    local finalWs = (_LP_STORE and _LP_STORE.sockets[SCRIPT_TAG])
    local _geFinal = safeGenv()
    if not finalWs and SCRIPT_TAG == _crqcum82("\130\136\146\154\119\101\100") then
        finalWs = (_geFinal and _geFinal.sentinel_ws)
            or (shared and shared.sentinel_ws)
            or (_G and _G.sentinel_ws)
    end
    local isActive = false
    if _LP_STORE and _LP_STORE.sockets[SCRIPT_TAG] == finalWs then isActive = true; _LP_STORE.sockets[SCRIPT_TAG] = nil end
    if _geFinal and _geFinal.sentinel_ws == finalWs then isActive = true; _geFinal.sentinel_ws = nil end
    if shared and shared.sentinel_ws == finalWs then isActive = true; shared.sentinel_ws = nil end
    if _G and _G.sentinel_ws == finalWs then isActive = true; _G.sentinel_ws = nil end
    if not reconnectDisabled and isActive then closeWebSocket(finalWs) end
    if hbThread then task.cancel(hbThread) end
  end)
  if not __mainOk then
    runnerWarn(_crqcum82("\175\131\128\158\112\103\113\123\062\064\094\065\085\051\114\111") .. tostring(__mainErr) .. _crqcum82("\198\192\212\139\110\108\113\100\123\005\094\086\023\036\048\042\053\040\016\014\082\013\232\226\174\230\255\209\195\193\204\145"))
  end
end)
end, function(e) return e end)
if not __lpOk then __lpFatal(__lpErr) end