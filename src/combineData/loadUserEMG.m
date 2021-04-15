function userData = loadUserEMG(nameUser, versionData)

folderAddress = '.\data\';

if isequal(versionData,'Train')
    versionAcquisition = 'training';
    
elseif isequal(versionData,'Test')
    versionAcquisition = 'testing';
end


filepath = [folderAddress nameUser '\' versionAcquisition '\userData.mat'];
userData = load(filepath);

userData = userData.(['userData' versionData]);

end
