function indices = grabarIndices(kUser, kGesture, kRep, xi, xo)
global flags
nameUser = k2name(kUser);
nameGesture = k2gesture(kGesture);

try
   data = load('.\matFiles\indicesTodos.mat');
   indices = data.indices;
catch
    
end

indices.(nameUser).(nameGesture)(kRep,:) = [xi xo];

save('.\matFiles\indicesTodos.mat','indices');
save('.\matFiles\contadores.mat','kUser', 'kGesture', 'kRep','flags');
end

