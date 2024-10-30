local table = {};

-- Set scene + position + scale on page
table.scene = nil;

table.rectShutter = display.newRect(0, 0, 50, 50);
table.rectShutter.fill = {1,.01};

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
    local PrtScr = display.captureBounds(captureBounds)
    PrtScr.x, PrtScr.y = shutter.x, shutter.y + 400
    PrtScr.stroke = {1,0,0};
    PrtScr.strokeWidth = 8;
    PrtScr:scale(.3, .3);

    if table.scene then
        table.scene:insert(PrtScr)
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
    
    PrtScr:addEventListener("tap", function (event) 
        display.remove( PrtScr );
    end);
end

table.rectShutter:addEventListener("tap", snapShotListener);

return table;