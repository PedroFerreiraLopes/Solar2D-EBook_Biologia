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
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local backgroundGroup = display.newGroup();
    sceneGroup:insert( backgroundGroup );

    local background = display.newImage( backgroundGroup, "assets/Ambient/textBackground.png");
    background.anchorX, background.anchorY = 0, 0;

    local text = display.newImage( backgroundGroup, "assets/Pag4/text2.png");
    text.anchorX, text.anchorY = 0, 0;
    text.x, text.y = 30, 130;
    -- BUTTONS AREA
    local foregroundGroup = display.newGroup();
    sceneGroup:insert( foregroundGroup );

    local prevButton, nextButton = botoes.createNavButtons();

    local prevTopSlide = {
        effect = "slideDown",
        time = 500,
    }

    botoes.changeNavListener(prevButton, composer, "Paginas.Pag4.TextPage", prevTopSlide);
    botoes.changeNavListener(nextButton, composer, "Paginas.Pag4.Pag4");

    foregroundGroup:insert( prevButton );
    foregroundGroup:insert( nextButton );

    -- This is a TABLE, containing (1) Group, (2) SoundOn obj and (3) SoundOff obj
    local soundButtonGroup, soundOn, soundOff = botoes.createSoundButton();
    botoes.setSound({soundButtonGroup, soundOn, soundOff}, "audios/Pag4Text2.mp3");
    foregroundGroup:insert( soundButtonGroup );

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