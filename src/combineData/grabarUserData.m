function grabarUserData(userData, nameUser, versionData)

folderAddress = '.\dataNew\';
userData = rmfield(userData, 'counterGesture');
userData = rmfield(userData, 'counterRepetition');
eval (['userData' versionData ' = userData;']);



if isequal(versionData, 'Train')
    versionAcquisition = 'training';
    
elseif isequal(versionData, 'Test')
    versionAcquisition = 'testing';
end

filepath = [folderAddress nameUser '\' versionAcquisition '\userData.mat'];

save(filepath, ['userData' versionData]);

end

