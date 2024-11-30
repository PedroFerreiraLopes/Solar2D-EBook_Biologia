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

    local placeholder = display.newImage(sceneGroup, "assets/Icon.png");
    placeholder:scale(5,5);
    placeholder.x, placeholder.y = display.contentCenterX, display.contentCenterY;

    local background = display.newImage( backgroundGroup, "assets/Pag1/background.png");
    background.anchorX, background.anchorY = 0, 0;

    local lion_sprite, lion_sequence = lion.createSprite();
    local giraffe_sprite, giraffe_sequence = giraffe.createSprite();

    backgroundGroup:insert(lion_sprite);
    backgroundGroup:insert(giraffe_sprite);

    -- lion.sprite:setFrame(4);
    lion_sprite:play();
    lion_sprite.x, lion_sprite.y = lion_sprite.width, lion_sprite.height;
    giraffe_sprite:play();
    giraffe_sprite.x, giraffe_sprite.y = 550, 650;
    -- giraffe.sprite.alpha = 0;

    local foregroundGroup = display.newGroup();
    sceneGroup:insert( foregroundGroup );

    local prevButton, nextButton = botoes.createNavButtons();
    foregroundGroup:insert( prevButton );
    foregroundGroup:insert( nextButton );

    botoes.changeNavListener(prevButton, composer, "Paginas.Pag1.TextPage");
    botoes.changeNavListener(nextButton, composer, "Paginas.Pag2.TextPage");

    local rectShutter, captureTable = snapShot.createElements(backgroundGroup, foregroundGroup);

    local soundButtonGroup, soundOn, soundOff = botoes.createSoundButton();
    botoes.setSound({soundButtonGroup, soundOn, soundOff}, "audios/Pag1.mp3");
    foregroundGroup:insert( soundButtonGroup );

    local instructionBox = display.newImage( foregroundGroup, "assets/Pag1/IntructionBox.png");
    instructionBox.anchorX, instructionBox.anchorY = 0, 0;
    instructionBox.x, instructionBox.y = 102, 894;
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