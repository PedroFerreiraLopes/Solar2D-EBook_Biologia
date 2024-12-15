local inspect = require("inspect");

local table = {};

table.reduc_sprite = function(sprite, target_width)
    local ratio_width = sprite.width / target_width;
    sprite.width = target_width;
    sprite.height = sprite.height / ratio_width;

    sprite:scale(.5, .5);
end

local reduce_sprite = function(sprite, target_width)
    local ratio_width = sprite.width / target_width;
    sprite.width = target_width;
    sprite.height = sprite.height / ratio_width;

    sprite:scale(.5, .5);
end

local createArrow = function(group, x, y, scale)
    local scale = scale or 1;

    local arrow = display.newImage( group, "assets/Arrow.png", x, y );
    arrow.xScale, arrow.yScale = scale, scale;
    return arrow;
end

local createFoodChain = function(group, y, beings)
    local group_FC = display.newGroup();
    group:insert(group_FC);

    local length_group;

    for i = 1, #beings do
        -- reduce_sprite(beings[i], 100);
        length_group = length_group + 110;
        group_FC:insert(beings[i]);
        if(beings[i+1])then
            createArrow(group_FC, group_FC.x + length_group, group_FC.y);
            length_group = length_group + 110;
        end
    end

    group_FC.y = y;
    group_FC.x = display.contentCenterX;
    -- group_FC.anchorX, group_FC.anchorY = .5, .5; --TESTING

    return group_FC;
end

table.createFoodWeb = function(backgroundGroup)

    local fc_1 = display.newGroup();
    fc_1:insert(display.newImage( "assets/Grass.png" ));
    fc_1:insert(display.newImage( "assets/Animals/Giraffe/jifaMask.png" ));
    fc_1:insert(display.newImage( "assets/Animals/Lion/lionMask.png" ));

    local length_fc_1 = 0;

    for i = 1, fc_1.numChildren do
        reduce_sprite(fc_1[i], 200);
        fc_1[i].x = 20 + length_fc_1;
        length_fc_1 = length_fc_1 + 110;
        -- group_FC:insert(fc_1[i]);
        if(fc_1[i+1])then
            print( inspect(fc_1[i+1]) );
            local arrow = createArrow(fc_1, 30 + length_fc_1, 500);
            reduce_sprite(arrow, 150);
            length_fc_1 = length_fc_1 + 110;
        end
    end

    local group_1 = createFoodChain(backgroundGroup, 500, fc_1);

    return group_1;
end

return table;