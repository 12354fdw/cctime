local dir = "time/"

local sun = paintutils.loadImage(dir.."sun.nfp")
local moon = paintutils.loadImage(dir.."moon.nfp")

local w,h = term.getSize()

local sky = window.create(term.current(),0,0,w+1,h+1)
local ground = window.create(term.current(),0,h*0.8,w+1,h*0.4)
ground.setBackgroundColor(colors.green)

while true do
    local nTime = os.time()
    local nDay = os.day()
    local time = textutils.formatTime(nTime,false)..", Day "..nDay
    local time_ = textutils.formatTime(nTime,true)
    local first = tonumber(string.match(time_,"([^:]+)"))
    local night = first >= 18 or first <= 6
    if night then
        sky.setBackgroundColor(colors.black)
        sky.clear()
        paintutils.drawImage(moon,w*0.6,1)
        term.setBackgroundColor(colors.black)
    else
        sky.setBackgroundColor(colors.blue)
        sky.clear()
        paintutils.drawImage(sun,w*0.6,1)
        term.setBackgroundColor(colors.blue)
    end

    ground.clear()
    term.setCursorPos(1,1)
    print(time)
    sleep(1)
end