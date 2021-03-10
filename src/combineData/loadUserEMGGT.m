function userData = loadUserEMGGT(nameUser, versionData, gender)

folderAddress = '.\massiveCollection\';

if isequal(versionData,'Train')
    versionAcquisition = 'training';
    
elseif isequal(versionData,'Test')
    versionAcquisition = 'testing';
end


filepath = [folderAddress 'training\' gender '\' nameUser '\' versionAcquisition '\userData.mat'];
userData = load(filepath);

userData = userData.(['userData' versionData]);


end