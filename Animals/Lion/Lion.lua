local lion = {};

lion.createSprite = function ()
    local sheetOptions_running =
    {
        frames = 
        {
            {
                x = 3,
                y = 0,
                width = 474,
                height = 345
            },
            {
                x = 477,
                y = 0,
                width = 480,
                height = 345
            },
            {
                x = 957,
                y = 0,
                width = 435,
                height = 345
            },
            {
                x = 1392,
                y = 0,
                width = 1867-1392,
                height = 345
            },
        }
    };

    local sheet_running = graphics.newImageSheet( "assets/Animals/Lion/runningLion.png", sheetOptions_running );

    local frame_time = 700;

    -- Lion sequences table
    local sequences = {
        {
            name = "run",
            sheet = sheet_running,
            start = 1,
            count = 4,
            time = frame_time,
            loopCount = 0,
            loopDirection = "forward"
        },
        {
            name = "carry",
            sheet = sheet_running,
            frames = {4, 3, 2, 2, 1, 1, 1, 1},
            time = frame_time * 2,
            loopCount = 0,
            loopDirection = "forward"
        },
    };

    local sprite = display.newSprite( sheet_running, sequences );
    sprite.anchorY = 1;
    sprite.anchorX = .5;

    return sprite, sequences;
end

lion.scaleOutline = function(outline, scaleFactor)
    local scaledOutline = {}
    for i = 1, #outline, 2 do
        local x, y = outline[i], outline[i + 1]
        table.insert(scaledOutline, x * scaleFactor);
        table.insert(scaledOutline, y * scaleFactor);
    end
    return scaledOutline;
end

lion.setOutlineBody = function(sprite, physics, inspect)
    local inspect = inspect or false;
    local physics = physics or false;

    local lionBottom = display.newImage("assets/Animals/Lion/lionBottom.png");
    lionBottom.anchorY = 1;
    lionBottom.xScale, lionBottom.yScale = sprite.xScale, sprite.yScale;
    lionBottom.x, lionBottom.y = sprite.x - sprite.width/9, sprite.y;
    lionBottom.isVisible = false;
    local lionTop = display.newImage("assets/Animals/Lion/lionTop.png");
    lionTop.anchorY = 1;
    lionTop.xScale, lionTop.yScale = sprite.xScale, sprite.yScale;
    lionTop.x, lionTop.y = sprite.x + sprite.width/7 - 2, sprite.y;
    lionTop.isVisible = false;

    local lionBottomOutline = graphics.newOutline( 3, "assets/Animals/Lion/lionBottom.png");
    lionBottomOutline.anchorY = 1;
    lionBottomOutline.x, lionBottomOutline.y = lionBottom.x, lionBottom.y;
    -- lionBottomOutline = lion.scaleOutline(lionBottomOutline, .52);
    -- lionBottomOutline.xScale, lionBottomOutline.yScale = lionBottom.xScale, lionBottom.yScale;
    local lionTopOutline = graphics.newOutline( 7, "assets/Animals/Lion/lionTop.png");
    lionTopOutline.anchorY = 1;
    -- lionTopOutline = lion.scaleOutline(lionTopOutline, .52);
    lionTopOutline.x, lionTopOutline.y = lionTop.x, lionTop.y;
    -- lionTopOutline.xScale, lionTopOutline.yScale = lionTop.xScale, lionTop.yScale;

    local lionMask = display.newImage("assets/Animals/Lion/lionMask.png");
    lionMask.anchorY = 1;
    lionMask.xScale, lionMask.yScale = -sprite.xScale, sprite.yScale;
    lionMask.x, lionMask.y = sprite.x, sprite.y;
    lionMask.isVisible = false;

    local lionMaskOutline = graphics.newOutline( 5, "assets/Animals/Giraffe/jifaMask.png");
    lionMaskOutline.anchorY = 1;
    lionMaskOutline.x, lionMaskOutline.y = sprite.x, sprite.y;
    lionMaskOutline.xScale, lionMaskOutline.yScale = sprite.xScale, sprite.yScale;

    if(inspect)then
        print( inspect(lionBottom) );
        print( "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" )
        print( inspect(lionBottomOutline) );
    end

    local physicsGroup = display.newGroup();
    physicsGroup:insert(lionBottom);
    physicsGroup:insert(lionTop);

    local outlineParams = {
        friction = 0,
        bounce = 1
    }
    

    if (physics) then
        physics.addBody( lionTop, "static", {outline=lionTopOutline});
        physics.addBody( lionBottom, "static", {outline=lionBottomOutline});
        -- physics.addBody( lionMask, "static", {outline=lionMaskOutline});
        local particleSystem = physics.newParticleSystem(
            {
                filename = "assets/Icon.png",
                imageRadius = 5.5,
                radius = 1,
                gravityScale = 0.001,
                strictContactCheck = true,
                dampingStrength = 10
            }
        );
        particleSystem:createGroup(
            {
                flags = {"tensile"},
                -- groupFlags = {"solid"},
                x = sprite.x + 45,
                y = sprite.y - (sprite.height / 4),
                radius = 17,
                -- halfWidth = 42,
                -- halfheight = 17,
                color = { 1, 0, 0, 1 },
                strength = 1,
                stride = .15,
                -- radius = 150,
                lifetime = 0,
            }
        ); 
        timer.performWithDelay( 200, function (params)
            particleSystem:applyLinearImpulse(math.random(200, 300), math.random(300, 400), 
                particleSystem.x, particleSystem.y
            );
        end, 1 )
        return particleSystem;
    end

    return false;
end

return lion;