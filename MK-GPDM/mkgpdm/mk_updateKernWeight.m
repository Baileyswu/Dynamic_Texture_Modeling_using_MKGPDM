function kern = mk_updateKernWeight(kern,weight)

% ���º˺�����Ȩ��

num_kerns = length(kern.comp);

for i = 1:num_kerns    
    kern.weight(i) = weight(i);
end

end