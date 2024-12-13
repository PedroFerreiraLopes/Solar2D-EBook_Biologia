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
    local snapShot = require("Paginas.Pag1.SnapShot");
    local foodChain = require("Paginas.Pag2.FoodChain");
    local inspect = require("inspect");
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local backgroundGroup = display.newGroup();
    sceneGroup:insert( backgroundGroup );

    local background = display.newImage( backgroundGroup, "assets/Pag1/background.png");
    background.anchorX, background.anchorY = 0, 0;

    -- BUTTONS AREA
    local foregroundGroup = display.newGroup();
    sceneGroup:insert( foregroundGroup );

    local photos = {};
    if(event.params)then
        if(event.params.photos)then
            photos = event.params.photos or {};
        end
    else
        shutter, photos = snapShot.createElements(backgroundGroup, foregroundGroup);
        shutter:removeSelf();
        shutter = nil;
    end

    for i=1, #photos do
        photos[i].polaroidGroup.xScale, photos[i].polaroidGroup.yScale = photos[i].finalScale, photos[i].finalScale;
        photos[i].polaroidGroup.x, photos[i].polaroidGroup.y = photos[i].finalX, photos[i].finalY;
        photos[i].polaroidGroup.isVisible = true;
        backgroundGroup:insert(photos[i].polaroidGroup);

        foregroundGroup:insert(photos[i].foodChain);
        photos[i].foodChain.xScale, photos[i].foodChain.yScale = photos[i].finalScale, photos[i].finalScale;
        photos[i].foodChain.x, photos[i].foodChain.y = photos[i].finalX, photos[i].finalY;
    end

    local prevButton, nextButton = botoes.createNavButtons();

    botoes.changeNavListener(prevButton, composer, "Paginas.Pag2.TextPage");
    botoes.changeNavListener(nextButton, composer, "Paginas.Pag3.TextPage");

    foregroundGroup:insert( prevButton );
    foregroundGroup:insert( nextButton );

    -- This is a TABLE, containing (1) Group, (2) SoundOn obj and (3) SoundOff obj
    local soundButtonGroup, soundOn, soundOff = botoes.createSoundButton();
    botoes.setSound({soundButtonGroup, soundOn, soundOff}, "audios/Pag2.mp3");
    foregroundGroup:insert( soundButtonGroup );

    local instructionBox = display.newImage( foregroundGroup, "assets/Pag2/instructionBox.png");
    instructionBox.anchorX, instructionBox.anchorY = 0, 0;
    instructionBox.x, instructionBox.y = 102, 894;

    foodChain.createListener(
        {
            photos[1].foodChain,
            photos[2].foodChain
        },
        photos[1].finalScale
    );
 
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