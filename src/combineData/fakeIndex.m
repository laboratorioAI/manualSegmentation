% fake values
cc
%%
indices.XavierReinoso = cell(5,1);

for kGesture = 1:5
    
    nameGesture = k2gesture(kGesture);
    indices.XavierReinoso.(nameGesture) = nan(50, 2);
    
    for kRep = 1:50
        xo = randi([100 850]);        
        xi = randi([1 xo - 1]);
        indices.XavierReinoso.(nameGesture)(kRep,:) = [xi xo];
    end
    
end


%%
save('.\manualSegmentation\indicesTodos.mat', 'indices');
