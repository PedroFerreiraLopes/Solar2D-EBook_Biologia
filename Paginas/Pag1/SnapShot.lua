local inspect = require("inspect");
local PolaroidTransition = require("Paginas.Pag1.PolaroidTransition");

local table = {};

table.createElements = function (backGroup, frontGroup)
    local rectShutter = display.newRect(backGroup, 
        0, 0, 
        display.contentWidth, display.contentHeight
    );
    rectShutter.anchorX, rectShutter.anchorY = 0, 0;
    rectShutter.fill = {1,.01};   
    
    local capture1 = {};
    local capture2 = {};
    local captureTable = {capture1, capture2};

    for i=1, #captureTable do

        captureTable[i].polaroidGroup = display.newGroup();
        captureTable[i].polaroidPaper = display.newImage("assets/Pag1/SnapShot/PolaroidPaper.png");
        captureTable[i].foodChain = {};
        captureTable[i].print = {};

        frontGroup:insert(captureTable[i].polaroidGroup);
        inspect(captureTable[i]);
        captureTable[i].polaroidPaper.anchorX = 0;
        captureTable[i].polaroidPaper.anchorY = 0;
        captureTable[i].polaroidPaper.x = 173;
        captureTable[i].polaroidPaper.y = 247;
        captureTable[i].polaroidGroup:insert(captureTable[i].polaroidPaper);
        captureTable[i].polaroidGroup.isVisible = false;
        
        captureTable[i].finalX = -2 - 173 + (captureTable[i].polaroidPaper.width * .2);
        captureTable[i].finalY = 40 - 247 + ((i-1) *280) + (captureTable[i].polaroidPaper.height * .2);
        captureTable[i].transitionSignal = false;
    end

    local resetAlphaListener_rectShutter = function (obj)
        obj.alpha = 0.01;
    end;
    
    local snapShotListener = function ( event )
    
        if(event.y < 121 or event.y > 899)then
            return true;
        end
    
        local shutter = event.target;
        -- Hide PrtScr, to perfect image capture
        -- local PrtScr = {};
        -- PrtScr.alpha = 0;
    
        if(transition_rectShutter)then
            transition.cancel( transition_rectShutter );
        end
    
        -- Capture only within these bounds
        local captureBounds = {
            xMin = 127,
            yMin = 305,
            xMax = 127+504,
            yMax = 305+493
        }

        -- PrtScr = display.captureBounds(captureBounds)
        -- PrtScr.anchorX, PrtScr.anchorY = 0, 0;
        -- PrtScr.x, PrtScr.y = 187, 269;
        -- PrtScr.stroke = {1,0,0};
        -- PrtScr.xScale, PrtScr.yScale = .8, .8;

        for i=1, #captureTable do 
            if(next(captureTable[i].print) == nil)then
                captureTable[i].print = display.captureBounds(captureBounds);
                captureTable[i].print.anchorX, captureTable[i].print.anchorY = 0, 0;
                captureTable[i].print.x, captureTable[i].print.y = 187, 269;
                captureTable[i].print.xScale = .81;
                captureTable[i].print.yScale = .81;
                captureTable[i].polaroidGroup:insert(captureTable[i].print);
                print(  );
                captureTable[i].polaroidGroup.isVisible = true;
                PolaroidTransition(
                    captureTable[i].polaroidGroup, captureTable[i].finalX,
                    captureTable[i].finalY)
                break;
            end
        end
    
        shutter:setFillColor(1, 1, 1);
    
        shutter.alpha = 0.01;
        shutter.alpha = .6;
        local transition_rectShutter = transition.fadeOut( shutter, {
            time=600, onComplete= resetAlphaListener_rectShutter, onCancel= resetAlphaListener_rectShutter,
            transition=easing.inSine
        } );

        -- TEST ETSTESTETS
        -- for i=1, #captureTable do 
        --     captureTable[i].polaroidGroup.x = captureTable[i].polaroidGroup.x + 40*i;
        -- end
    end
    
    rectShutter:addEventListener("tap", snapShotListener);

    return rectShutter, captureTable;
end

table.rectShutter = display.newRect(0, 0, display.contentWidth, display.contentHeight);
table.rectShutter.anchorX, table.rectShutter.anchorY = 0, 0;
table.rectShutter.fill = {1,.01};

table.PrtScr = {};

-- AT WORK ----------------------------------------------------

-- Initialize the animal table
table.animals = {}

-- Function to add a new animal with identifier
local function addAnimal(sprite, id)
    sprite.id = id
    table.insert(table.animals, sprite)
end

-- In `snapShotListener`, after capturing `PrtScr`:
for _, animal in ipairs(table.animals) do
    local bounds = animal.contentBounds
    if bounds.xMax >= captureBounds.xMin and bounds.xMin <= captureBounds.xMax and
       bounds.yMax >= captureBounds.yMin and bounds.yMin <= captureBounds.yMax then
        print("Captured animal: " .. animal.id)
    end
end

-- AT WORK ---------------------------------------------------



return table;