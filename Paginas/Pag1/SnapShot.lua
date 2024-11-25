local table = {};

-- Set scene
table.scene = nil;

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

local resetAlphaListener_rectShutter = function (obj)
    obj.alpha = 0.01;
end;

local snapShotListener = function ( event )

    if(event.y < 121 or event.y > 899)then
        return true;
    end

    local shutter = event.target;
    -- Hide PrtScr, to perfect image capture
    table.PrtScr.alpha = 0;

    transition.cancel( transition_rectShutter );

    -- Capture only within these bounds
    local captureBounds = {
        xMin = 127,
        yMin = 305,
        xMax = 127+504,
        yMax = 305+493
    }
    
    table.PrtScr = display.captureBounds(captureBounds)
    table.PrtScr.anchorX, table.PrtScr.anchorY = 0, 0;
    table.PrtScr.x, table.PrtScr.y = 187, 269;
    table.PrtScr.stroke = {1,0,0};
    -- table.PrtScr.strokeWidth = 1;
    table.PrtScr.xScale, table.PrtScr.yScale = .8, .8;
    -- table.PrtScr.alpha = 1;

    if table.scene then
        table.scene:insert(table.PrtScr)
    end

    shutter:setFillColor(1, 1, 1);

    shutter.alpha = 0.01;
    shutter.alpha = .6;
    local transition_rectShutter = transition.fadeOut( shutter, {
        time=300, onComplete= resetAlphaListener_rectShutter, onCancel= resetAlphaListener_rectShutter,
        transition=easing.inSine
    } );
    
    -- table.PrtScr:addEventListener("tap", function (event) 
    --     display.remove( event.target );
    -- end);
end

table.rectShutter:addEventListener("tap", snapShotListener);

return table;