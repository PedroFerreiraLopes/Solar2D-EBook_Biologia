local rectShutter = display.newRect( 
    scene, 
    sprite_runningCat.x, sprite_runningCat.y, 
    sprite_runningCat.width, sprite_runningCat.height );

local resetAlphaListener_rectShutter = function (obj)
    obj.alpha = 0.01;
end;

local function snapShotListener( event )

    transition.cancel( transition_rectShutter );

    local pointerMarker = display.newCircle(event.x , event.y, 50 );
    pointerMarker.fill = {0,0,0, 0};
    pointerMarker.stroke = {1,0,0};
    pointerMarker.strokeWidth = 10;

    local PrtScr = display.captureScreen();
    -- local PrtScr = display.newSnapshot( 1000, 1000 );

    rectShutter:setFillColor(1, 1, 1);
    rectShutter.alpha = 0.01;
    
    rectShutter.alpha = .6;
    local transition_rectShutter = transition.fadeOut( rectShutter, {
        time=300, onComplete= resetAlphaListener_rectShutter, onCancel= resetAlphaListener_rectShutter,
        transition=easing.inSine
    } );
    
    PrtScr.x, PrtScr.y = display.contentCenterX, display.contentCenterY;
    
    local PrtCtn = display.newContainer(PrtScr.width, PrtScr.height);
    PrtCtn.x, PrtCtn.y = display.contentCenterX - 100, display.contentCenterY - 200;
    PrtCtn:insert( PrtScr, true );
    PrtCtn:insert(pointerMarker);
    PrtCtn.width, PrtCtn.height = sprite_runningCat.width, sprite_runningCat.height;
    PrtCtn:scale(.3,.3);
    
    PrtScr:addEventListener("tap", function (event) 
        display.remove( PrtScr );
    end);
end