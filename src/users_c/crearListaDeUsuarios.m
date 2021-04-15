function [encabezado, listaDeUsuarios, numUsers] =...
    crearListaDeUsuarios()
encabezado = 'SELECT YOUR NAME:';
[num,txt,raw] = xlsread('Investigadores y Ayudantes.xlsx');
numUsers = size(txt,1) - 1;
for userNum = 1:numUsers
    listaDeUsuarios(userNum).name = txt{userNum + 1,1};
    listaDeUsuarios(userNum).email = txt{userNum + 1,2};
    listaDeUsuarios(userNum).cellphone = txt{userNum + 1,3};
    listaDeUsuarios(userNum).university = txt{userNum + 1,4};
end
return