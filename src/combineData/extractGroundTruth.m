function GTgroup = extractGroundTruth()

gestureVector = {'waveIn','waveOut','fist','fingersSpread','doubleTap','relax'};


%%
for kGender = 1:2
    if kGender == 1
        genero = 'men';
    else
        genero = 'women';
    end
    
    load(genero); % aquí está el vectorUser!
    
    for kUser = 1:numel(vectorUser)
        nameUser = vectorUser{kUser};
        
        %
        for kVersion = 1:2
            if kVersion == 1
                versionData = 'Train';
            else
                versionData = 'Test';
            end
            
            userData = loadUserEMGGT(nameUser, versionData, genero);
            
            for kGesture = 1:5
                nameGesture = gestureVector{kGesture};
                
                for kRep = 1:25
                    kGT = userData.gestures.(nameGesture).data{kRep, 1}.emgGroundTruth;
                    GTgroup.(genero).(nameUser).(versionData).(nameGesture){kRep} = kGT;
                    
                end
            end
        end
    end
end

