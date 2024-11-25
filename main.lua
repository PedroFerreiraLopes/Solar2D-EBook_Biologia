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

composer.gotoScene( "Paginas.Capa.Capa", transitionOptions )

-- Your code here