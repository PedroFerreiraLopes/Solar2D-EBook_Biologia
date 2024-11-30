local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )

    local sceneGroup = self.view

    local inspect = require("inspect");

    local physics = require("physics");
    physics.start();
    physics.setGravity( 0, 0 );
    -- physics.setDrawMode( "hybrid" );

    local lion = require("Animals.Lion.Lion");
    local giraffe = require("Animals.Giraffe.Giraffe");

    local botoes = require("Botoes");

    local invertBackgroundGroup = display.newGroup();
    sceneGroup:insert( invertBackgroundGroup );

    local invertBackground = display.newImage( invertBackgroundGroup, "assets/Pag1/background.png");
    invertBackground.anchorX, invertBackground.anchorY = 0, 0;
    invertBackground.fill.effect = "filter.hue";
    invertBackground.fill.effect.angle = 450;

    local invertGiraffe_sprite, invertGiraffe_sequence = giraffe.createSprite();
    local invertLion_sprite, invertLion_sequence = lion.createSprite();

    invertBackgroundGroup:insert(invertLion_sprite);
    invertBackgroundGroup:insert(invertGiraffe_sprite);

    invertLion_sprite.x, invertLion_sprite.y = 300, 840;
    invertLion_sprite.xScale, invertLion_sprite.yScale = .5, .5;
    invertLion_sprite.fill.effect = "filter.hue";
    invertLion_sprite.fill.effect.angle = 535;
    local invertLion_particles = lion.setOutlineBody(invertLion_sprite, physics);
    invertBackgroundGroup:insert(invertLion_particles);
    
    invertGiraffe_sprite.x, invertGiraffe_sprite.y = 550, 650;
    invertGiraffe_sprite.xScale = -1;
    invertGiraffe_sprite.fill.effect = "filter.hue";
    invertGiraffe_sprite.fill.effect.angle = 500;
    local invertGiraffe_particles = giraffe.setOutlineBody(invertGiraffe_sprite, physics);
    -- print( inspect(invertGiraffe_particles) );
    invertBackgroundGroup:insert(invertGiraffe_particles);

    local backgroundGroup = display.newGroup();
    sceneGroup:insert( backgroundGroup );

    local background = display.newImage( backgroundGroup, "assets/Pag1/background.png");
    background.anchorX, background.anchorY = 0, 0;

    local giraffe_sprite, giraffe_sequence = giraffe.createSprite();
    local lion_sprite, lion_sequence = lion.createSprite();

    backgroundGroup:insert(lion_sprite);
    backgroundGroup:insert(giraffe_sprite);

    -- lion_sprite:play(); 
    -- lion_sprite:setFrame(4); 
    lion_sprite.x, lion_sprite.y = 300, 840;
    lion_sprite.xScale, lion_sprite.yScale = .5, .5;
    -- giraffe_sprite:play();
    giraffe_sprite.x, giraffe_sprite.y = 550, 650;
    giraffe_sprite.xScale = -1;

    -- backgroundGroup.isVisible = false;

    -- local circleMask = graphics.newMask("assets/Pag4/maskingCircle.png");
    -- backgroundGroup:setMask(circleMask)

    -- backgroundGroup.maskX = display.contentCenterX
    -- backgroundGroup.maskY = display.contentCenterY
    -- backgroundGroup.maskScaleX = 1
    -- backgroundGroup.maskScaleY = 1

    local backgroundMask = graphics.newMask("assets/Pag4/backgroundMask.png");
    -- backgroundGroup:setMask(backgroundMask)

    local transitionToEffectParams = {
        time = 500,
        onStart = function()
            backgroundGroup:setMask(backgroundMask);
            backgroundGroup.maskX = display.contentCenterX;
            backgroundGroup.maskY = display.contentCenterY;
            backgroundGroup.maskScaleX = 1;
            backgroundGroup.maskScaleY = 1;
        end,
        maskScaleX = 15,
        maskScaleY = 15,
        onComplete = function()
            backgroundGroup.isVisible = false;
            backgroundGroup:setMask(nil);
        end,
    }

    local transitionOffEffectParams = {
        time = 500,
        onStart = function()
            backgroundGroup:setMask(backgroundMask);
            backgroundGroup.maskX = display.contentCenterX;
            backgroundGroup.maskY = display.contentCenterY;
            backgroundGroup.maskScaleX = 15;
            backgroundGroup.maskScaleY = 15;

            backgroundGroup.isVisible = true;
        end,
        maskScaleX = 1,
        maskScaleY = 1,
        onComplete = function()
            backgroundGroup:setMask(nil);
        end,
    }

    timer.performWithDelay( 1500, 
        function()
            transition.to( backgroundGroup, transitionToEffectParams )
        end
    );

    timer.performWithDelay( 4000, 
        function()
            transition.to( backgroundGroup, transitionOffEffectParams )
        end
    );

    local touches = {};

    local function calculateDistance(point1, point2)
        local dx = point2.x - point1.x;
        local dy = point2.y - point1.y;
        return math.sqrt(dx * dx + dy * dy);
    end

    local onPinchEvent = function(event)
        local phase = event.phase;
        local id = event.id;

        if(event.y < 121 or event.y > 899)then
            return true;
        end

        if (phase == "began") then
            touches[id] = {x = event.x, y = event.y};
    
            if (touches[1] and touches[2]) then
                touches.initialDistance = calculateDistance(touches[1], touches[2]);
                touches.initialScale = interactiveGroup.xScale;
            end

        elseif(phase == "moved" and touches[1] and touches[2]) then
            touches[id] = {x = event.x, y = event.y};

            local currentDistance = calculateDistance(touches[1], touches[2]);

            if(backgroundGroup.isVisible)then
                transition.to( backgroundGroup, transitionToEffectParams )
            elseif(not backgroundGroup.isVisible) then
                transition.to( backgroundGroup, transitionOffEffectParams )
            end   
        end 
    end

    sceneGroup:addEventListener("touch", onPinchEvent );

    local foregroundGroup = display.newGroup();
    sceneGroup:insert( foregroundGroup );

    local prevButton, nextButton = botoes.createNavButtons();
    foregroundGroup:insert( prevButton );
    foregroundGroup:insert( nextButton );

    botoes.changeNavListener(prevButton, composer, "Paginas.Pag4.TextPage2");
    botoes.changeNavListener(nextButton, composer, "Paginas.Pag5.TextPage");

    local soundButtonGroup, soundOn, soundOff = botoes.createSoundButton();
    -- botoes.setSound({soundButtonGroup, soundOn, soundOff}, "audios/TEST.mp3");
    foregroundGroup:insert( soundButtonGroup );
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene