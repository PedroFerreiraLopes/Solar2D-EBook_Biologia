local composer = require( "composer" );

local scene = composer.newScene();
 
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

    local CONST = require("BookConstants");

    local snapShot = require("Paginas.Pag1.SnapShot");

    local lion = require("Animals.Lion.Lion");
    local giraffe = require("Animals.Giraffe.Giraffe");

    local inspect = require("inspect");

    local botoes = require("Botoes");

    local backgroundGroup = display.newGroup();
    sceneGroup:insert( backgroundGroup );
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local background = display.newImage( backgroundGroup, "assets/Pag1/background.png");
    background.anchorX, background.anchorY = 0, 0;

    local lion_sprite, lion_sequence = lion.createSprite();
    local giraffe_sprite, giraffe_sequence = giraffe.createSprite();

    backgroundGroup:insert(giraffe_sprite);
    backgroundGroup:insert(lion_sprite);

    -- lion.sprite:setFrame(4);
    -- giraffe.sprite.alpha = 0;

    local tree = display.newImage(backgroundGroup, "assets/Pag1/tree.png");
    tree.anchorX, tree.anchorY = 0, 1;
    tree.x, tree.y = 0, display.contentCenterY + 350;
    tree.alpha = .65;

    local foregroundGroup = display.newGroup();
    sceneGroup:insert( foregroundGroup );

    local prevButton, nextButton = botoes.createNavButtons();
    foregroundGroup:insert( prevButton );
    foregroundGroup:insert( nextButton );

    botoes.changeNavListener(prevButton, composer, "Paginas.Pag1.TextPage");
    botoes.changeNavListener(nextButton, composer, "Paginas.Pag2.TextPage");

    local rectShutter, captureTable = snapShot.createElements(backgroundGroup, foregroundGroup);
    rectShutter.interactionCounter = 0;

    local soundButtonGroup, soundOn, soundOff = botoes.createSoundButton();
    botoes.setSound({soundButtonGroup, soundOn, soundOff}, "audios/Pag1.mp3");
    foregroundGroup:insert( soundButtonGroup );

    local instructionBox = display.newImage( foregroundGroup, "assets/Pag1/IntructionBox.png");
    instructionBox.anchorX, instructionBox.anchorY = 0, 0;
    instructionBox.x, instructionBox.y = 102, 894;

    local resetActors = function()
        lion_sprite:setSequence("run");
        lion_sprite:play();
        lion_sprite.x, lion_sprite.y = -lion_sprite.width, 820;
        lion_sprite.xScale, lion_sprite.yScale = .5, .5;
        lion_sprite.isVisible = false;
        giraffe_sprite:play();
        giraffe_sprite.x, giraffe_sprite.y = 900, 800;
        giraffe_sprite.xScale = -1;
        giraffe_sprite.rotation = 0;
        giraffe_sprite.isVisible = false;
    end

    local giraffeToTree;
    local lionRun;
    local lionJumpX;
    local lionJumpY1;
    local lionJumpY2;
    local giraffeTumble;
    local lionCarryGiraffe;

    giraffeToTree = function()
        resetActors();
        giraffe_sprite.isVisible = true;
        local transitionParams = {
            x = tree.x + tree.width - 80,
            delay = 1000,
            time = 1500,
            transition = easing.outSine,
        }
        local transition = transition.to( giraffe_sprite, transitionParams );

        timer.performWithDelay( 
            transitionParams.time + transitionParams.delay - 500, 
            function() 
                rectShutter.interactionCounter = 1;
            end 
        );

        timer.performWithDelay( 
            transitionParams.time + transitionParams.delay + 2000, 
            function() 
                lionRun()
            end 
        )
    end

    lionRun = function()
        lion_sprite.isVisible = true;
        local transitionParams = {
            x = giraffe_sprite.x - (giraffe_sprite.width + 80),
            delay = 1000,
            time = 1500,
            transition = easing.inSine,
            onComplete = lionJumpX,
        }
        local transition = transition.to( lion_sprite, transitionParams );
    end

    lionJumpX = function()
        lionJumpY1();
        local transitionParams = {
            x = giraffe_sprite.x + 80,
            time = 600,
            transition = easing.linear,
            onComplete = nil,
        }
        local transition = transition.to( lion_sprite, transitionParams );
    end

    lionJumpY1 = function()
        rectShutter.interactionCounter = 2;
        local transitionParams = {
            y = 820 - 150,
            time = 300,
            transition = easing.outCubic,
            onComplete = lionJumpY2,
        }
        local transition = transition.to( lion_sprite, transitionParams );
    end

    lionJumpY2 = function()
        giraffeTumble();
        local transitionParams = {
            y = 820,
            time = 300,
            transition = easing.inCubic
        }
        local transition = transition.to( lion_sprite, transitionParams );
    end

    giraffeTumble = function()
        giraffe_sprite:pause();
        lion_sprite:pause();
        local transitionParams = {
            rotation = 90,
            time = 2000,
            transition = easing.outBounce,
            onComplete = lionCarryGiraffe,
        }
        local transition = transition.to( giraffe_sprite, transitionParams );
    end        

    local carryCounter = 10;
    lionCarryGiraffe = function()
        if(carryCounter <= 0)then
            rectShutter.interactionCounter = 0;

            carryCounter = 10;
            giraffeToTree();
        else
            carryCounter = carryCounter - 1;

            lion_sprite:setSequence("carry");
            lion_sprite:play();
            local transitionParams = {
                x = - 80,
                time = 1000,
                transition = easing.outBack,
            }
            local transitionGiraffe = transition.moveBy( giraffe_sprite, transitionParams );
            local transitionLion = transition.moveBy( lion_sprite, transitionParams );

            timer.performWithDelay( 
                1000, 
                function() 
                    return lionCarryGiraffe() 
                end 
            );
        end
    end        

    giraffeToTree();
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        composer.removeHidden();
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        transition.cancel();
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        audio.stop( 1 );
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