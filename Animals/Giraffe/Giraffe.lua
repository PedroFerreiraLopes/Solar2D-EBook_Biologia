local giraffe = {};

local sheetOptions_walking =
{
    width = 303,
    height = 380,
    numFrames = 2
};

local sheet_walking = graphics.newImageSheet( "assets/Animals/Giraffe/walkingGiraffe.png", sheetOptions_walking );

local sheetOptions_lurking =
{
    width = 747/ 3,
    height = 380,
    numFrames = 3
};

local sheet_lurking = graphics.newImageSheet( "assets/Animals/Giraffe/lurkingGiraffe.png", sheetOptions_lurking );

local sheetOptions_running =
{
    width = 708/2,
    height = 380,
    numFrames = 2
};

local sheet_running = graphics.newImageSheet( "assets/Animals/Giraffe/runningGiraffe.png", sheetOptions_running );

local frame_time = 500;

-- Giraffe sequences table
giraffe.sequences = {
    {
        name = "walk",
        sheet = sheet_walking,
        start = 1,
        count = 2,
        time = frame_time * 2,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "lurk",
        sheet = sheet_lurking,
        frames = {1, 2, 2, 1, 2, 3, 2},
        time = frame_time * 7,
        loopCount = 0,
        loopDirection = "forward"
    },
    {
        name = "run",
        sheet = sheet_running,
        start = 1,
        count = 2,
        time = frame_time * 2,
        loopCount = 0,
        loopDirection = "forward"
    },
};

giraffe.sprite = display.newSprite( sheet_walking, giraffe.sequences );
giraffe.sprite.anchorY = 1;
giraffe.sprite.anchorX = .5;

return giraffe;