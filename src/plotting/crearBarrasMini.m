function crearBarrasMini(handles, xi, xo)
% crea las barras en los ejes secundarios

%% emg
parameters = getParams();
ax = handles.axes1;
for cidx = 1:8
    idxSTR = num2str(cidx);
    cmd = ['ax = handles.axes' idxSTR ';'];
    eval(cmd);
    
    line([xi xi], parameters.yLims, ...
        'Parent',ax,'LineWidth',1,'Color', parameters.leftLineColor);
    
    line([xo xo], parameters.yLims ...
        ,'Parent',ax,'LineWidth',1,'Color',parameters.rightLineColor);
end

%% quat main
global conversionFactor

xiQ = conversionFactor *xi;
xoQ = conversionFactor *xo;
go = line([xiQ xiQ], [-1 1],...
    'Parent',handles.axesQwyxz,'LineWidth',1, ...
    'Color',parameters.leftLineColor);
go.Annotation.LegendInformation.IconDisplayStyle = 'off';

go2 = line([xoQ xoQ], [-1 1]...
    ,'Parent',handles.axesQwyxz,'LineWidth',1,'Color', ...
    parameters.rightLineColor);
go2.Annotation.LegendInformation.IconDisplayStyle = 'off';
end
