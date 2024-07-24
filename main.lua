local dir = "time/"

peripheral.find("monitor",term.redirect)
local weatherDec = peripheral.find("environmentDetector")

local sun = paintutils.loadImage(dir.."sun.nfp")
local moon = paintutils.loadImage(dir.."moon.nfp")

-- weather guis
local clear = dir.."weather/clear.nfp"
local rainy = dir.."weather/rainy.nfp"
local thunder = dir.."weather/thunder.nfp"

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
    local night = first >= 19 or first < 7
    local dusk = first >= 17 or first >= 5 and first < 7
    if night then
        sky.setBackgroundColor(colors.black)
        sky.clear()
        paintutils.drawImage(moon,w*0.6,1)
        term.setBackgroundColor(colors.black)
    elseif dusk then
        sky.setBackgroundColor(colors.orange)
        sky.clear()
        paintutils.drawImage(sun,w*0.6,1)
        term.setBackgroundColor(colors.orange)
    else
        sky.setBackgroundColor(colors.blue)
        sky.clear()
        paintutils.drawImage(sun,w*0.6,1)
        term.setBackgroundColor(colors.blue)
    end

    ground.clear()
    term.setCursorPos(1,1)
    print(time)

    if weatherDec then
        if weatherDec.isSunny() then
            paintutils.drawImage(clear,1,3)
            term.setCursorPos(4,3)
            print("Sunny")
        end
        if weatherDec.isRaining() then
            paintutils.drawImage(rainy,1,3)
            term.setCursorPos(4,3)
            print("Rainy")
        end
        if weatherDec.isThunder() then
            paintutils.drawImage(thunder,1,3)
            term.setCursorPos(4,3)
            print("Thunderstorm")
        end
    end

    sleep(1)
end
