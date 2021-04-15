function [flagCompleteness, usersWithIncompleteness] = checkCompletenessOfPictures()

folders = dir('data');
numFolders = length(folders);
validFormatsOfPictures = {'tiff', 'tif', 'jpeg', 'jpg', 'png'};
numPicFormats = length(validFormatsOfPictures);
flagUser = false(1, numFolders - 2);
countUsers = 0;
usersWithIncompleteness = {};
for i = 3:numFolders
    if ~folders(i).isdir
        flagUser(i - 2) = true;
        continue
    end
    count = 0;
    flagUser(i - 2) = false;
    while count < numPicFormats
        count = count + 1;
        files = ls(['data\', folders(i).name, '\*.', validFormatsOfPictures{count}]);
        if ~isempty(files)
            flagUser(i - 2) = true;
            break;
        end
    end
    if ~flagUser(i - 2)
        countUsers = countUsers + 1;
        usersWithIncompleteness{countUsers} = folders(i);
    end
end

if sum(flagUser) == (numFolders - 2)
    flagCompleteness = 1;
else
    flagCompleteness = 0;
end
return