function kern = mk_initKernWeight(kern)

% ���������������kern�ṹ������Ӷ�ÿ���˺�����Ȩ�أ������Ȩ�ؼ�����Ӧ����1

weight = (1/length(kern.comp)) * ones(length(kern.comp),1);

kern.weight = weight;

end



