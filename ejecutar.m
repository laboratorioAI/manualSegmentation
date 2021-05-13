% script para ejecutar la segmentación Manual. Los índices de la
% segmentación manual son grabados en el archivo
% “./matFiles/indicesTodos.mat”.
% La rutina de Segmentación Manual itera sobre los usuarios que se
% encuentren en la carpeta “./data/”. Por lo tanto, al modificar el
% contenido de esta carpeta, se cambia los usuarios para la segmentación.
%
% Sin embargo, al hacer esto, es necesario también reiniciar los contadores
% para no tener conflicto con la nueva ejecución.    
% El archivo “./matFiles/contadores.mat” contiene los contadores del
% usuario, del gesto y de la repetición. 
% Para reiniciar el procedimiento de segmentación, ANTERIORMENTE se debía
% reiniciar los contadores externamente (establecer los valores en 1 y
% sobrescribir “./matFiles/contadores.mat”). AHORA, la interfaz realiza el 

% Marco E. Benalcázar, Ph.D.
% Escuela Politécnica Nacional
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

seleccionarUsuario();

