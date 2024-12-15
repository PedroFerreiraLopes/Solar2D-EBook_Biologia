local giraffe = {};

giraffe.createSprite = function()
    local sheetOptions_walking =
    {
        width = 303,
        height = 380,
        numFrames = 2
    };

    local sheet_walking = graphics.newImageSheet( "assets/Animals/Giraffe/walkingGiraffe.png", sheetOptions_walking );

    local sheetOptions_lurking =
    {
        width = 747/ 3,
        height = 380,
        numFrames = 3
    };

    local sheet_lurking = graphics.newImageSheet( "assets/Animals/Giraffe/lurkingGiraffe.png", sheetOptions_lurking );

    local sheetOptions_running =
    {
        width = 708/2,
        height = 380,
        numFrames = 2
    };

    local sheet_running = graphics.newImageSheet( "assets/Animals/Giraffe/runningGiraffe.png", sheetOptions_running );

    local frame_time = 500;

    -- Giraffe sequences table
    local sequences = {
        {
            name = "walk",
            sheet = sheet_walking,
            start = 1,
            count = 2,
            time = frame_time * 2,
            loopCount = 0,
            loopDirection = "forward"
        },
        {
            name = "lurk",
            sheet = sheet_lurking,
            frames = {1, 2, 2, 1, 2, 3, 2},
            time = frame_time * 7,
            loopCount = 0,
            loopDirection = "forward"
        },
        {
            name = "run",
            sheet = sheet_running,
            start = 1,
            count = 2,
            time = frame_time * 2,
            loopCount = 0,
            loopDirection = "forward"
        },
    };

    local sprite = display.newSprite( sheet_walking, sequences );
    sprite.anchorY = 1;
    sprite.anchorX = .5;

    return sprite, sequences;
end

giraffe.setOutlineBody = function(sprite, physics, inspect)
    local inspect = inspect or false;
    local physics = physics or false;
    -- print( sprite.x );
    -- print( sprite.y );
    -- print( sprite.xScale );
    -- print( sprite.yScale );

    local jifaBottom = display.newImage("assets/Animals/Giraffe/jifaBottom.png");
    jifaBottom.anchorY = 1;
    jifaBottom.xScale, jifaBottom.yScale = -sprite.xScale, sprite.yScale;
    jifaBottom.x, jifaBottom.y = sprite.x + sprite.width/4, sprite.y;
    jifaBottom.isVisible = false;
    local jifaTop = display.newImage("assets/Animals/Giraffe/jifaTop.png");
    jifaTop.anchorY = 1;
    jifaTop.xScale, jifaTop.yScale = -sprite.xScale, sprite.yScale;
    jifaTop.x, jifaTop.y = sprite.x - sprite.width/4, sprite.y;
    jifaTop.isVisible = false;


    local jifaBottomOutline = graphics.newOutline( 3, "assets/Animals/Giraffe/jifaBottom.png");
    jifaBottomOutline.anchorY = 1;
    jifaBottomOutline.x, jifaBottomOutline.y = jifaBottom.x, jifaBottom.y;
    jifaBottomOutline.xScale, jifaBottomOutline.yScale = jifaBottom.xScale, jifaBottom.yScale;
    local jifaTopOutline = graphics.newOutline( 1, "assets/Animals/Giraffe/jifaTop.png");
    jifaTopOutline.anchorY = 1;
    jifaTopOutline.x, jifaTopOutline.y = jifaTop.x, jifaTop.y;
    jifaTopOutline.xScale, jifaTopOutline.yScale = jifaTop.xScale, jifaTop.yScale;

    local jifaMask = display.newImage("assets/Animals/Giraffe/jifaMask.png");
    jifaMask.anchorY = 1;
    jifaMask.xScale, jifaMask.yScale = -sprite.xScale, sprite.yScale;
    jifaMask.x, jifaMask.y = sprite.x, sprite.y;
    jifaMask.isVisible = false;

    local jifaMaskOutline = graphics.newOutline( 5, "assets/Animals/Giraffe/jifaMask.png");
    jifaMaskOutline.anchorY = 1;
    jifaMaskOutline.x, jifaMaskOutline.y = sprite.x, sprite.y;
    jifaMaskOutline.xScale, jifaMaskOutline.yScale = sprite.xScale, sprite.yScale;

    if(inspect)then
        print( inspect(jifaBottom) );
        print( "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" )
        print( inspect(jifaBottomOutline) );
    end

    local physicsGroup = display.newGroup();
    physicsGroup:insert(jifaBottom);
    physicsGroup:insert(jifaTop);

    local outlineParams = {
        friction = 0,
        bounce = 1
    }

    if (physics) then
        physics.addBody( jifaTop, "static", {outline=jifaTopOutline});
        physics.addBody( jifaBottom, "static", {outline=jifaBottomOutline});
        -- physics.addBody( jifaMask, "static", {outline=jifaMaskOutline});
        local particleSystem = physics.newParticleSystem(
            {
                filename = "assets/Pag4/blob.png",
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
                x = sprite.x - 28,
                y = sprite.y - sprite.height/2 - 25,
                radius = 20,
                color = { 1, 0, 0, 1 },
                strength = 1,
                stride = .5,
                -- radius = 150,
                lifetime = 0
            }
        ); 
        particleSystem:createGroup(
            {
                flags = {"tensile"},
                -- groupFlags = {"solid"},
                x = sprite.x + 30,
                y = sprite.y - sprite.height/2 + 25,
                radius = 25,
                -- angle = 45,
                color = { 1, 0, 0, 1 },
                strength = 1,
                stride = .5,
                -- radius = 150,
                lifetime = 0
            }
        ); 
        timer.performWithDelay( 200, function (params)
            particleSystem:applyLinearImpulse(math.random(200, 300), math.random(300, 400),
                sprite.x, sprite.y
            );
        end, 1 )
        return particleSystem;
    end
    -- physicsGroup:translate(20, 20);
    return false;
end

return giraffe;