local composer = require( "composer" );
local CONST = require("BookConstants");

local snapShot = require("Paginas.Pag1.SnapShot");

local giraffe = require("Animals.Giraffe.Giraffe");

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
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local placeholder = display.newImage(sceneGroup, "assets/Icon.png");
    placeholder:scale(5,5);
    placeholder.x, placeholder.y = display.contentCenterX, display.contentCenterY;

    sceneGroup:insert(giraffe.sprite);

    giraffe.sprite:play();
    giraffe.sprite.x, giraffe.sprite.y = CONST.pokedex.x, CONST.pokedex.y;

    local pokedex = display.newImage(sceneGroup, "assets/Pokedex/Pokedex.png")
    pokedex.xScale, pokedex.yScale = CONST.pokedex.xScale, CONST.pokedex.yScale;
    pokedex.x, pokedex.y = CONST.pokedex.x, CONST.pokedex.y;

    local bottom_screen_text = display.newImage( sceneGroup, "assets/Pag1/bottom_screen_text.png");
    bottom_screen_text.x = pokedex.x - (562 - pokedex.x)/2;
    bottom_screen_text.y = pokedex.y + pokedex.y/2 - 40;
    local bottom_screen_division = display.newLine( 
        sceneGroup, 562, 715, 
        562, 715 + 263);
    bottom_screen_division:setStrokeColor( 0, 0, 0, 1 )
    bottom_screen_division.strokeWidth = 2.5
 
    sceneGroup:insert(snapShot.rectShutter);
    snapShot.x, snapShot.y, snapShot.scene = pokedex.x + 50, pokedex.y + 50, sceneGroup;
    snapShot.rectShutter.x, snapShot.rectShutter.y = pokedex.x, pokedex.y - 178;
    snapShot.rectShutter.width, snapShot.rectShutter.height = 334, 260;
    -- snapShot.rectShutter.alpha = 1;
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