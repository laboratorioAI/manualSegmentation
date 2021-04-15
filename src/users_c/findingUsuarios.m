function vectorUser = findingUsuarios()
usuariosList = dir('.\data');
%%
usuariosNum = size(usuariosList,1);

%%
vectorUser = {};
iU = 0;
for kUser = 3:usuariosNum
    if ~usuariosList(kUser).isdir
        continue
    end
    iU = iU + 1;
  vectorUser{iU} = usuariosList(kUser).name;
end

end
