function resetContadores()
% data = load('.\matFiles\contadores.mat');
kUser  = 1;
kGesture = 1;
kRep = 1;
flags.Stop = false;

save('.\matFiles\contadores.mat','kUser','kGesture','kRep','flags');

mainFile = '.\matFiles\indicesTodos.mat';
if isfile(mainFile)
    delete(mainFile);
end
end