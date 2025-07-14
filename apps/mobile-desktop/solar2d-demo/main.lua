local composer = require("composer")
local widget = require("widget")
local json = require("json")

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local background = display.newRect(centerX, centerY, display.actualContentWidth, display.actualContentHeight)
background:setFillColor(0.2, 0.3, 0.5)

local titleText = display.newText({
    text = "Lua Solar2D Demo App",
    x = centerX,
    y = 100,
    font = native.systemFontBold,
    fontSize = 28
})
titleText:setFillColor(1, 1, 1)

local subtitleText = display.newText({
    text = "Cross-platform app built with Solar2D",
    x = centerX,
    y = 140,
    font = native.systemFont,
    fontSize = 16
})
subtitleText:setFillColor(0.8, 0.8, 0.8)

local scoreText = display.newText({
    text = "Score: 0",
    x = centerX,
    y = 200,
    font = native.systemFont,
    fontSize = 20
})
scoreText:setFillColor(1, 1, 1)

local currentScore = 0

local function updateScore(points)
    currentScore = currentScore + points
    scoreText.text = "Score: " .. currentScore
end

local function createButton(text, x, y, onTap)
    local button = widget.newButton({
        label = text,
        x = x,
        y = y,
        width = 200,
        height = 50,
        fontSize = 18,
        fillColor = { default = {0.2, 0.7, 0.9}, over = {0.1, 0.6, 0.8} },
        labelColor = { default = {1, 1, 1}, over = {0.9, 0.9, 0.9} },
        onRelease = onTap
    })
    return button
end

local function onTapButton()
    updateScore(10)
    
    local tapAnimation = display.newCircle(centerX, centerY + 50, 5)
    tapAnimation:setFillColor(1, 1, 0)
    
    local function removeAnimation()
        display.remove(tapAnimation)
    end
    
    transition.to(tapAnimation, {
        time = 500,
        alpha = 0,
        xScale = 3,
        yScale = 3,
        onComplete = removeAnimation
    })
end

local function onResetScore()
    currentScore = 0
    scoreText.text = "Score: 0"
    
    local resetText = display.newText({
        text = "Reset!",
        x = centerX,
        y = centerY + 100,
        font = native.systemFontBold,
        fontSize = 24
    })
    resetText:setFillColor(1, 0.2, 0.2)
    
    local function removeResetText()
        display.remove(resetText)
    end
    
    transition.to(resetText, {
        time = 1000,
        alpha = 0,
        y = centerY + 50,
        onComplete = removeResetText
    })
end

local function onShowInfo()
    local alert = native.showAlert("App Info", 
        "This is a demo Solar2D application built with Lua.\n\n" ..
        "Features:\n" ..
        "• Cross-platform compatibility\n" ..
        "• Native UI widgets\n" ..
        "• Animations and transitions\n" ..
        "• Touch/click interactions\n" ..
        "• JSON data handling",
        {"OK"})
end

local tapButton = createButton("Tap for Points", centerX, centerY, onTapButton)
local resetButton = createButton("Reset Score", centerX - 110, centerY + 80, onResetScore)
local infoButton = createButton("App Info", centerX + 110, centerY + 80, onShowInfo)

local physics = require("physics")
physics.start()
physics.setGravity(0, 9.8)

local function createBouncyBall()
    local ball = display.newCircle(math.random(50, display.actualContentWidth - 50), 50, 15)
    ball:setFillColor(math.random(), math.random(), math.random())
    physics.addBody(ball, "dynamic", { radius = 15, bounce = 0.8 })
    
    local function removeBall()
        if ball and ball.removeSelf then
            physics.removeBody(ball)
            display.remove(ball)
        end
    end
    
    timer.performWithDelay(5000, removeBall)
    
    return ball
end

local function onCreateBall()
    createBouncyBall()
    updateScore(5)
end

local ballButton = createButton("Drop Ball", centerX, centerY + 160, onCreateBall)

local ground = display.newRect(centerX, display.actualContentHeight - 10, display.actualContentWidth, 20)
ground:setFillColor(0.5, 0.3, 0.1)
physics.addBody(ground, "static")

local instructions = display.newText({
    text = "Tap buttons to interact • Watch balls bounce with physics",
    x = centerX,
    y = display.actualContentHeight - 40,
    font = native.systemFont,
    fontSize = 14
})
instructions:setFillColor(0.7, 0.7, 0.7)

local deviceInfo = {
    platform = system.getInfo("platform"),
    model = system.getInfo("model"),
    version = system.getInfo("version")
}

print("Solar2D Demo App Started")
print("Platform: " .. deviceInfo.platform)
print("Model: " .. deviceInfo.model)
print("Version: " .. deviceInfo.version)

local function saveGameData()
    local gameData = {
        highScore = currentScore,
        lastPlayed = os.date("%Y-%m-%d %H:%M:%S"),
        platform = deviceInfo.platform
    }
    
    local path = system.pathForFile("gamedata.json", system.DocumentsDirectory)
    local file = io.open(path, "w")
    
    if file then
        file:write(json.encode(gameData))
        file:close()
        print("Game data saved")
    end
end

local function loadGameData()
    local path = system.pathForFile("gamedata.json", system.DocumentsDirectory)
    local file = io.open(path, "r")
    
    if file then
        local contents = file:read("*a")
        file:close()
        
        local gameData = json.decode(contents)
        if gameData and gameData.highScore then
            print("Previous high score: " .. gameData.highScore)
            return gameData
        end
    end
    
    return nil
end

loadGameData()

local function onSystemEvent(event)
    if event.type == "applicationExit" or event.type == "applicationSuspend" then
        saveGameData()
    end
end

Runtime:addEventListener("system", onSystemEvent)