function kern = mk_creatkern(X,kernType)

% Ӧ���ǿ���ֱ��ʹ�ø��Ϻ˵Ľṹ���������ڻ�������

% kernType = {'rbf','lin','poly'};

num_kern = length(kernType);

kern = cell(num_kern,1);

for i=1:num_kern
    creat_kern = kernCreate(X,kernType);    
    kern{i} = creat_kern;
end


end