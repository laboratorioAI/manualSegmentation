function [nameUser, totalUsers] = k2name(kUser)

vectorUser = findingUsuarios();
totalUsers = length(vectorUser);
nameUser = vectorUser{kUser};

end
