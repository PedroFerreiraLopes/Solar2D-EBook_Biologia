local lion = {};

local sheetOptions_running =
{
    frames = 
    {
        {
            x = 3,
            y = 0,
            width = 474,
            height = 345
        },
        {
            x = 477,
            y = 0,
            width = 480,
            height = 345
        },
        {
            x = 957,
            y = 0,
            width = 435,
            height = 345
        },
        {
            x = 1392,
            y = 0,
            width = 1867-1392,
            height = 345
        },
    }
};

local sheet_running = graphics.newImageSheet( "assets/Animals/Lion/runningLion.png", sheetOptions_running );

local frame_time = 700;

-- Lion sequences table
lion.sequences = {
    {
        name = "run",
        sheet = sheet_running,
        start = 1,
        count = 4,
        time = frame_time,
        loopCount = 0,
        loopDirection = "forward"
    },
};

lion.sprite = display.newSprite( sheet_running, lion.sequences );
lion.sprite.anchorY = 1;
lion.sprite.anchorX = .5;

return lion;