local botoes = {};

botoes.createNavButtons = function()
    local prevButton = display.newImage( "assets/Buttons/Navigation/prev.png" );
    prevButton.anchorX, prevButton.anchorY = 0, 0;
    prevButton.x, prevButton.y = 30, 899;
    prevButton._gotoOptions = {
        effect = "fromLeft",
        time = 500,
    }

    local nextButton = display.newImage( "assets/Buttons/Navigation/next.png" );
    nextButton.anchorX, nextButton.anchorY = 0, 0;
    nextButton.x, nextButton.y = 668, 899;
    nextButton._gotoOptions = {
        effect = "slideLeft",
        time = 500,
    }

    return prevButton, nextButton;
end

botoes.changeNavListener = function (button, composerPack, scenePath, options)
    local buttonEvent = function ()
        composerPack.gotoScene(scenePath, options)
    end
    options = options or button._gotoOptions;
    button:addEventListener("tap", buttonEvent)
end

botoes.createSoundButton = function ()
    local soundGroup = display.newGroup();
    soundGroup.x, soundGroup.y = 668, 30;

    local soundOn = display.newImage( "assets/Buttons/AudioButtons/on.png" );
    soundOn.anchorX, soundOn.anchorY = 0, 0;
    soundGroup:insert( soundOn );

    local soundOff = display.newImage( "assets/Buttons/AudioButtons/off.png" );
    soundOff.anchorX, soundOff.anchorY = 0, 0;
    soundOff.isVisible = false;
    soundGroup:insert( soundOff );

    return soundGroup, soundOn, soundOff;
end

botoes.soundVisibilitySwitch = function (soundOn, soundOff)
    soundOff.isVisible = not soundOff.isVisible;
    soundOn.isVisible = not soundOn.isVisible; 
end

botoes.setSound = function(button, soundPath)
    local soundTrack = audio.loadStream( soundPath );

    local soundOn, soundOff = button[2], button[3];
    
    local soundEnd = function (event)
        if(event.completed)then
            botoes.soundVisibilitySwitch(soundOn, soundOff);
        end
    end
    
    local soundOptions =
    {
        channel = 1,
        loops = 0,
        fadein = 50,
        onComplete = soundEnd
    };
    
    local soundEvent = function ()
        botoes.soundVisibilitySwitch(soundOn, soundOff);
    
        if(soundOff.isVisible)then
            audio.stop( 1 );
            audio.rewind( soundTrack );
        else
            audio.play( soundTrack, soundOptions );
        end
    end

    button[1]:addEventListener("tap", soundEvent);

    audio.setVolume( 0.5, { channel=1 } )
    timer.performWithDelay( 1000, function ()
        audio.play( soundTrack, soundOptions );
        audio.fade( { channel=1, time=500, volume=1 } )
    end)
end

-- if(botoes.soundGroup._haveListener)then
--     botoes.soundGroup:removeEventListener("tap", soundEvent);
-- end

-- botoes.soundGroup:addEventListener("tap", soundEvent);

return botoes;