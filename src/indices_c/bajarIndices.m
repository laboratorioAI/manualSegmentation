function [kUser, kGesture, kRep] = bajarIndices(kUser, kGesture, kRep)
%
parameters = getParams();

%% 
[~, numGestures] = k2gesture(kGesture);

%
if kRep > 1
    % in some higher repetition
    kRep = kRep - 1;
else
    % the first repetition
    
    if kGesture > 1
        % in some later gesture
        kGesture = kGesture - 1;
        
        % getting the num of reps of previous gesture
        previousGesture = k2gesture(kGesture);        
        numReps = parameters.numSamplesPerGesture.(previousGesture);
        
        %
        kRep = numReps;
    else
         % first gesture, first rep
        if kUser > 1
            % some second user
            kUser = kUser - 1;
            kGesture = numGestures;
            
            lastGesture = k2gesture(kGesture);
            numRepsLastGesture = parameters.numSamplesPerGesture.(lastGesture);
            
            %
            kRep = numRepsLastGesture;
        else
            % first user, first rep, first gesture
            disp('Error trying to reduce index!');
        end
    end
end
end