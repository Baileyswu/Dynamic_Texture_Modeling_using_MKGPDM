function kern = mk_kernExpandParam(kern,hyperpara)

init_para = 1;
for i = 1:length(kern.comp)
    fhandle = str2func([kern.comp{i}.type 'KernExpandParam']);  
	kern.comp{i} = fhandle(kern.comp{i}, hyperpara(init_para:init_para+kern.comp{i}.nParams-1)); % �������ṹ�������볬����
    init_para = init_para + kern.comp{i}.nParams;
end


end