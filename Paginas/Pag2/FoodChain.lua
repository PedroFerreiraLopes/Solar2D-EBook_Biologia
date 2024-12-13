local table = {};

local inspect = require("inspect");

table.createListener = function(foodChains, scale)
    local scale = scale or 1;

    for i=1, #foodChains do
        local offSet = {
            x = 0,
            y = 0
        }
        foodChains[i].widthIndentation = 0;
        for j = 1, #foodChains do
            if(j > i)then
                break;
            elseif(j == i)then
                foodChains[i].widthIndentation = foodChains[i].widthIndentation + (foodChains[j].width/2);
            else
                foodChains[i].widthIndentation = foodChains[i].widthIndentation + foodChains[j].width - (foodChains[j][3].width) * scale;
                print(foodChains[j].numChildren);
            end
        end

        foodChains[i].isOrganized = false;
        local onTouchEvent = function(event)
            local order = i;

            local function organized() foodChains[i].isOrganized = true end;

            if(event.phase == "moved")then
                foodChains[i].x = event.x + offSet.x;
                foodChains[i].y = event.y + offSet.y;


            elseif(event.phase == "began")then
                offSet.x = foodChains[i].x - event.x;
                offSet.y = foodChains[i].y - event.y;

                foodChains[i].isOrganized = false;
                
                local transitionFadeParams = { time = 400 };
                for j = 1, foodChains[i].numChildren do
                    transition.fadeIn(foodChains[i][j], transitionFadeParams);
                end
                if(foodChains[i+1])then
                    local transitionFadeOut = transition.fadeIn(foodChains[i+1][2], transitionFadeParams);
                end
                
                if(foodChains[i-1])then
                    local transitionFadeOut = transition.fadeIn(foodChains[i-1][3], transitionFadeParams);
                end

            elseif(event.phase == "ended" or event.phase == "cancelled")then
                if(
                    (event.x > 80 and event.x < 762 - 10)
                    and
                    (event.y > 10 and event.y < 899)
                )then
                    local transitionMoveParams = {
                        x = (200 + foodChains[i].widthIndentation) * scale,
                        y = display.contentCenterY * scale,
                        time = 600,
                        transition = easing.outExpo,
                        onComplete = organized
                    };
                    local transitionMoveFC = transition.moveTo(foodChains[i], transitionMoveParams);

                    local transitionFadeParams = { time = 400 };
                    if(foodChains[i+1])then
                        if(foodChains[i+1].isOrganized)then
                            local transitionFadeIn = transition.fadeOut(foodChains[i+1][2], transitionFadeParams);
                        end
                    end
                    
                    if(foodChains[i-1])then
                        if(foodChains[i-1].isOrganized)then
                            local transitionFadeIn = transition.fadeOut(foodChains[i-1][3], transitionFadeParams);
                        end
                    end
                end
            end
            
        end

        foodChains[i]:addEventListener("touch", onTouchEvent);
    end
end

return table;