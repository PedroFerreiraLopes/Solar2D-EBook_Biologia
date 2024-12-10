local transition = function (element, finalX, finalY, time, delay)
    local time = time or 1000;
    local delay = delay or 500;

    positionParams = {
        x = finalX,
        y = finalY,
        time = time,
        delay = delay,
        transition = easing.inBack
    }
    local positionTransition = transition.moveTo(element,positionParams);

    scaleParams = {
        xScale = .4,
        yScale = .4,
        time = time - 200,
        delay = delay + 200,
        transition = easing.inExpo
    }
    local scaleTransition = transition.to(element,scaleParams);

    return time+delay;
end

return transition;