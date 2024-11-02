local table = {};

-- Set scene
table.scene = nil;

table.rectShutter = display.newRect(0, 0, 50, 50);
table.rectShutter.fill = {1,.01};

table.PrtScr = nil;

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

    local shutter = event.target;

    transition.cancel( transition_rectShutter );

    local captureBounds = {
        xMin = shutter.contentBounds.xMin,
        yMin = shutter.contentBounds.yMin,
        xMax = shutter.contentBounds.xMax,
        yMax = shutter.contentBounds.yMax
    }
    
    -- Capture only within these bounds
    table.PrtScr = display.captureBounds(captureBounds)
    table.PrtScr.x, table.PrtScr.y = shutter.x - 70, shutter.y + 340
    table.PrtScr.stroke = {1,0,0};
    table.PrtScr.strokeWidth = 8;
    table.PrtScr.xScale, table.PrtScr.yScale = .4, .4;

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
    
    -- local PrtCtn = display.newContainer(table.scene, shutter.width, shutter.height);
    -- PrtCtn.x, PrtCtn.y = shutter.x, shutter.y;

    -- PrtScr.x, PrtScr.y = PrtScr.x - shutter.x,  PrtScr.y - shutter.y;
    -- PrtCtn:insert( PrtScr, true );
    -- PrtCtn:translate(140, 0);

    -- local pointerMarker = display.newCircle(event.x , event.y, 50 );
    -- pointerMarker.fill = {0,0,0, 0};
    -- pointerMarker.stroke = {1,0,0};
    -- pointerMarker.strokeWidth = 10;
    -- PrtCtn:insert(pointerMarker);

    -- PrtCtn:scale(.3,.3);
    
    table.PrtScr:addEventListener("tap", function (event) 
        display.remove( event.target );
    end);
end

table.rectShutter:addEventListener("tap", snapShotListener);

return table;