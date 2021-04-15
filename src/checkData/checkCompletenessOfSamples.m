function [flagCompleteness, usersWithIncompleteness] = ...
    checkCompletenessOfSamples()

%%
parameters = getParams();
listGestures = parameters.gestures; % list of gestures
%
folders = dir('data');
numFolders = length(folders);

%%
numGestures = parameters.numGestures;
vectCompleteGestures = zeros(1, numGestures);

usersWithIncompleteness = {};
count = 0;

for i = 3:numFolders
    if ~folders(i).isdir
        continue
    end
    
    info = load(['data\' folders(i).name '\userData.mat']) ;
    userData = info.userData;
    try
        for iG = 1:numGestures
            nameGesture = listGestures{iG};
            
            numSamplesPerGesture = ...
                parameters.numSamplesPerGesture.(nameGesture);
            
            % mayor o igual???
            if length(userData.gestures.(nameGesture).data) >=...
                    numSamplesPerGesture
                
                vectCompleteGestures(iG) = 1;
            end
        end
        
        
        % Checks if all the gestures have the righ number of samples
        if sum(vectCompleteGestures) ~= numGestures
            count = count + 1;
            
            % User with incomplete data
            usersWithIncompleteness{count} = folders(i);
        end
    catch
        count = count + 1;
        
        % Indicates that the number of samples is incomplete
        flagCompleteness = -1;
        % User with incomplete data
        usersWithIncompleteness{count} = folders(i);
        return;
    end
    
end
if isempty(usersWithIncompleteness)
    flagCompleteness = 1;
else
    flagCompleteness = 0;
end
end