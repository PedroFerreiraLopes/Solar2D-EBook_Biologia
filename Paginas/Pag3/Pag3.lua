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
    transition.cancel();
 
    local sceneGroup = self.view

    local botoes = require("Botoes");
    local inspect = require("inspect");

    local food_web = require("Paginas.Pag3.FoodWeb");
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local backgroundGroup = display.newGroup();
    sceneGroup:insert( backgroundGroup );

    local background = display.newImage( backgroundGroup, "assets/Pag1/background.png");
    background.anchorX, background.anchorY = 0, 0;

    -- BUTTONS AREA
    local foregroundGroup = display.newGroup();
    sceneGroup:insert( foregroundGroup );

    local prevButton, nextButton = botoes.createNavButtons();

    botoes.changeNavListener(prevButton, composer, "Paginas.Pag3.TextPage");
    botoes.changeNavListener(nextButton, composer, "Paginas.Pag4.TextPage");

    foregroundGroup:insert( prevButton );
    foregroundGroup:insert( nextButton );

    -- This is a TABLE, containing (1) Group, (2) SoundOn obj and (3) SoundOff obj
    local soundButtonGroup, soundOn, soundOff = botoes.createSoundButton();
    botoes.setSound({soundButtonGroup, soundOn, soundOff}, "audios/Pag3.mp3");
    foregroundGroup:insert( soundButtonGroup );

    local instructionBox = display.newImage( foregroundGroup, "assets/Pag3/instructionBox.png");
    instructionBox.anchorX, instructionBox.anchorY = 0, 0;
    instructionBox.x, instructionBox.y = 102, 894;

    -- local fc_1 = display.newGroup();

    -- local grass = display.newImage(fc_1, "assets/Grass.png" );
    -- local giraffe = display.newImage(fc_1, "assets/Animals/Giraffe/jifaMask.png" );
    -- local lion = display.newImage(fc_1, "assets/Animals/Lion/lionMask.png" );

    -- for i = 1, fc_1.numChildren do
    --     food_web.reduc_sprite(fc_1[i], 100);
    -- end

    local group_1 = food_web.createFoodWeb(backgroundGroup);
 
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