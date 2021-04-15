% Este script añade los campos de iStart, iEnd y groundTruth determinados
% por la Segmentación Manual en el archivo
% “./manualSegmentation/indicesTodos.mat”; para ello se debe copiar las
% carpetas de “./data/” en “./newData/”. Este script sobreescribe los
% archivos de la carpeta “./newData/” incluyendo la nueva información:
% iStart,
% iEnd,
% groundTruth
% a la estructura userData!

cc
addpath(genpath(pwd))

%%
vectorUser = findingUsuarios();
defaultClass = 6;

archivo = load('.\manualSegmentation\indicesTodos.mat');
indices = archivo.indices;

for kUser = 1:size(vectorUser,1)
    
    nameUser = vectorUser{kUser};
    
    userDataTrain = loadUserEMG(nameUser, 'Train');
    
    %% training
    for kRep = 1:25
        
        for kGesture = 1:5
            trueClass = kGesture;
            nameGesture = k2gesture(kGesture);
            
            %
            vectorIndex = indices.(nameUser).(nameGesture);
            
            xi = vectorIndex(kRep, 1);
            xo = vectorIndex(kRep, 2);
            
            rawEMG = loadRepetition(nameUser, nameGesture, kRep);
            
            groundTruth = toGroundTruth(rawEMG, xi, xo);
            userDataTrain = includeToEMGStruct(userDataTrain, groundTruth, xi, xo, nameGesture, kRep);
            
        end
    end
    
    grabarUserData(userDataTrain, nameUser, 'Train');
    
    
    %% testing
    userDataTest = loadUserEMG(nameUser, 'Test');
    
    for kRep = 26:50
        
        for kGesture = 1:5
            
            trueClass = kGesture;
            nameGesture = k2gesture(kGesture);
            
            %
            vectorIndex = indices.(nameUser).(nameGesture);
            
            xi = vectorIndex(kRep, 1);
            xo = vectorIndex(kRep, 2);
            
            rawEMG = loadRepetition(nameUser, nameGesture, kRep);
            
            groundTruth = toGroundTruth(rawEMG, xi, xo);
            
            userDataTest = includeToEMGStruct(userDataTest, groundTruth, xi, xo, nameGesture, kRep - 25);
        end
    end
    
    grabarUserData(userDataTest, nameUser, 'Test');
    
    
    
end

beep

