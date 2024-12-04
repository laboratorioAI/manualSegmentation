% script para ejecutar la segmentaci�n Manual. Los �ndices de la
% segmentaci�n manual son grabados en el archivo
% �./matFiles/indicesTodos.mat�.
% La rutina de Segmentaci�n Manual itera sobre los usuarios que se
% encuentren en la carpeta �./data/�. Por lo tanto, al modificar el
% contenido de esta carpeta, se cambia los usuarios para la segmentaci�n.
%
% Sin embargo, al hacer esto, es necesario tambi�n reiniciar los contadores
% para no tener conflicto con la nueva ejecuci�n.    
% El archivo �./matFiles/contadores.mat� contiene los contadores del
% usuario, del gesto y de la repetici�n. 
% Para reiniciar el procedimiento de segmentaci�n, ANTERIORMENTE se deb�a
% reiniciar los contadores externamente (establecer los valores en 1 y
% sobrescribir �./matFiles/contadores.mat�). AHORA, la interfaz realiza el 

% Marco E. Benalc�zar, Ph.D.
% Escuela Polit�cnica Nacional
% marco.benalcazar@epn.edu.ec

clearvars;
close all;
clc;

global numUsersToSegment;
%% libs
addpath(genpath('configs'));
addpath(genpath('src'));
addpath(genpath('images'));
addpath(genpath('matFiles'));

folders = dir('data');

numUsersToSegment = length(folders) - 3; % el current dir, el up dir, el readme

%seleccionarUsuario();
seleccionarUsuario_App();
