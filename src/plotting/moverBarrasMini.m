function moverBarrasMini(handles, xString, xn)
% xn es el punto donde va la barra
% conversionFactor es el cociente de emgLength y quatLenght, se crea en
% plotEmgAxes
global conversionFactor
if isequal(xString,'xo') % el orden de los children se definió en initPlots
    kChildren = 1;
elseif isequal(xString,'xi')
    kChildren = 2;
else
    error('Error in moverBarrasMini')
end

%
ax = handles.axes1;
for cidx = 1:8
    idxSTR = num2str(cidx);
    cmd = ['ax = handles.axes' idxSTR ';'];
    eval(cmd);
    
    ax.Children(kChildren).XData = [xn xn];
end


%% quats
handles.axesQuats.Children(kChildren).XData = xn* conversionFactor *[1 1];
handles.axesQwyxz.Children(kChildren).XData = xn* conversionFactor *[1 1];

% axis = {'W', 'X', 'Y', 'Z'};
% for i = 1:3
%     axesName = sprintf('axesQ%s', axis{i});
%     handles.(axesName).Children(i).XData =  xn* conversionFactor *[1 1];
% end

end