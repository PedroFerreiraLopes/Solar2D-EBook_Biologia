local composer = require( "composer" )
local CONST = require("BookConstants");
 
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

    local interactionEnabler = false
    local interactionCounter = 1;
    
    local imgPath = "assets/Pag5/";

    local topTextPath = {
        imgPath .. "Top_TextBox1.png",
        imgPath .. "Top_TextBox2.png"
    };

    local topTextSequence = {1, 2, 2, 1};

    local latTextPath = {
        imgPath .. "Lat_TextBox1.png",
        imgPath .. "Lat_TextBox2.png",
        imgPath .. "Lat_TextBox3.png",
    }

    local latTextSequence = {0, 1, 2, 3};

    local riverImagePath = {
        imgPath .. "River1.png",
        imgPath .. "River2.png",
        imgPath .. "River3.png",
        imgPath .. "River4.png",
    }

    local riverImageSequence = {1, 2, 3, 4};

    local changeTableVisibility = function (iterator, sequence, table)
        if(sequence[iterator] > 0)then
            if(iterator > 1)then
                if(sequence[iterator-1] > 0)then
                    table[sequence[iterator-1]].isVisible = false; 
                    print( "dissapeared iteration before" );
                end            
            end
            print( "In sequence" );
            print( sequence[iterator] );
            table[sequence[iterator]].isVisible = true;
        end
    end
 
 
    local sceneGroup = self.view;
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
    local pokedex = display.newImage(sceneGroup, "assets/Pokedex/Pokedex.png");
    pokedex.xScale, pokedex.yScale = CONST.pokedex.xScale, CONST.pokedex.yScale;
    pokedex.x, pokedex.y = CONST.pokedex.x, CONST.pokedex.y;

    local topText = {}
    for i = 1,#topTextPath do
        topText[i] = display.newImage( sceneGroup, topTextPath[i], display.contentCenterX, 19);
        topText[i].anchorY = 0;
        topText[i].isVisible = false
    end

    local latText = {}
    for i = 1,#latTextPath do
        latText[i] = display.newImage( sceneGroup, latTextPath[i], 31, 215);
        latText[i].anchorX, latText[i].anchorY = 0, 0;
        latText[i].isVisible = false;
    end

    local riverImageGroup = display.newGroup();
    sceneGroup:insert( riverImageGroup);

    local riverImage = {}
    for i = 1,#riverImagePath do
        riverImage[i] = display.newImage( riverImageGroup, riverImagePath[i], pokedex.x, CONST.pokedex.yBottomScreen);
        riverImage[i].isVisible = false;
    end

    changeTableVisibility(interactionCounter, topTextSequence, topText);
    changeTableVisibility(interactionCounter, latTextSequence, latText);
    changeTableVisibility(interactionCounter, riverImageSequence, riverImage);

    local interactionTimer = timer.performWithDelay( 
        2000, 
        function () interactionEnabler = true end, 
        1 
    )

    riverImageGroup:addEventListener("tap", function (event) 

        if(interactionEnabler and interactionCounter < 4)then
            interactionCounter = interactionCounter + 1;

            changeTableVisibility(interactionCounter, topTextSequence, topText);
            changeTableVisibility(interactionCounter, latTextSequence, latText);
            changeTableVisibility(interactionCounter, riverImageSequence, riverImage);

            interactionEnabler = false;
            interactionTimer = timer.performWithDelay( 
                2000, 
                function () interactionEnabler = true end, 
                1 
            )
        else
            return true; 
        end
    end);
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

    -- SET MULTI-TAPS DELAY
    system.setTapDelay( 0 );
 
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