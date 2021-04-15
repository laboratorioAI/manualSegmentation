function groundTruth = toGroundTruth(rawEMG, iStart, iEnd)

tam = size(rawEMG, 1);
groundTruth = zeros(1, tam);

groundTruth(iStart:iEnd) = true;

end

