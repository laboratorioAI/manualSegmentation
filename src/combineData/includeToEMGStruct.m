function userData = includeToEMGStruct(userData, groundTruth, xi, xo, nameGesture, kRep)


userData.gestures.(nameGesture).data{kRep, 1}.emgGroundTruth = groundTruth;
userData.gestures.(nameGesture).data{kRep, 1}.emgGroundTruthIndex = [xi xo];

end