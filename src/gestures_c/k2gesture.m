function [nameGesture, totalGestures] = k2gesture(kGesture)

parameters = getParams();

kGestureVector = parameters.gestures;
nameGesture = kGestureVector{kGesture};
totalGestures = length(kGestureVector);
end