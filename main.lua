-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require("composer");

local transitionOptions = {

    effect = "fromBottom",
    time = 800,
    -- params = {
    --     sampleVar1 = "my sample variable",
    --     sampleVar2 = "another sample variable"
    -- }
}

composer.gotoScene( "Paginas.Pag1.Pag1", transitionOptions )

-- Your code here