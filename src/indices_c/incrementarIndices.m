function [kUser, kGesture, kRep] = incrementarIndices(kUser, kGesture, kRep)
global flags numUsersToSegment
%%
parameters = getParams();

[nameGesture, numGestures] = k2gesture(kGesture);
numReps = parameters.numSamplesPerGesture.(nameGesture);


%%
if kRep < numReps
    kRep = kRep + 1;
else
    % the last rep of the gesture
    
    if kGesture < numGestures
        % not the last gesture
        kGesture = kGesture + 1;
        kRep = 1;
    else
        % the last gesture
        if kUser < numUsersToSegment
            % not the last user
            kGesture = 1;
            kRep = 1;
            kUser = kUser + 1;
        else
            % the end
            flags.Stop = true;
        end
    end
end

% if kGesture ~= 1
%     if kRep < 50
%         kRep = kRep + 1;
%     else
%         if kGesture < 6
%             kGesture = kGesture + 1;
%             kRep = 1;
%         else
%             if kUser < numUsersToSegment
%                 kGesture = 1;
%                 kRep = 1;
%                 kUser = kUser + 1;
%             else
%                 flags.Stop = true;
%             end
%         end
%     end
% else
%     
%     if kRep < 5
%         kRep = kRep + 1;
%     else
%         if kGesture < 6
%             kGesture = kGesture + 1;
%             kRep = 1;
%         else
%             if kUser < numUsersToSegment
%                 kGesture = 1;
%                 kRep = 1;
%                 kUser = kUser + 1;
%             else
%                 flags.Stop = true;
%             end
%         end
%     end
% end
end
