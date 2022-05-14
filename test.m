% Este script permite probar el funcionamiento del sistema sobre una serie de casos de prueba

gas = readfis('Gasometria.fis');

val =  [[7.30, 68, 28]
        [7.35, 72, 38]
        [7.10, 70, 24]
        [7.61, 22, 25]
        [7.60, 31, 25]
        [7.00, 23, 12]
        [7.39, 27, 19]
        [7.50, 40, 34]
        [7.57, 37, 30]
        [6.90, 68, 13]
        [7.57, 22, 17]
        [7.39, 44, 26]
        [7.55, 25, 22]
        [7.17, 48, 36]
        [7.34, 24, 20]
        [7.64, 25, 19]
        [7.45, 50, 30]
        [7.60, 53, 38]
        [7.50, 19, 22]
        [7.39, 59, 35]
        
        [7.50, 30, 23]
        [7.30, 50, 25]
        [7.32, 26, 20]
        [7.18, 20, 10]
        [7.05, 77, 17]
        
        [7.58, 60, 57]
        [7.60, 54, 54]
        [7.48, 53, 40]
        [7.46, 49, 35]
        
        [7.37, 47, 23]];
    
pre = ["Acidosis respiratoria moderada"
       "Acidosis respiratoria severa parcialmente compensada por alcalosis metabólica"
       "Acidosis respiratoria severa"
       "Alcalosis respiratoria severa"
       "Alcalosis respiratoria moderada"
       "Acidosis metabólica"
       "Acidosis metabólica"
       "Alcalosis metabólica"
       "Alcalosis metabólica"
       "Acidosis respiratoria y metabólica"
       "Alcalosis respiratoria parcialmente compensada por acidosis metabólica"
       "Normal"
       "Alcalosis respiratoria"
       "Acidosis respiratoria parcialmente compensada por alcalosis metabólica"
       "Acidosis metabólica parcialmente compensada por alcalosis respiratoria"
       "Alcalosis respiratoria parcialmente compensada por acidosis metabólica"
       "Alcalosis metabólica totalmente compensada por acidosis respiratoria"
       "Alcalosis metabólica parcialmente compensada por acidosis respiratoria"
       "Alcalosis respiratoria"
       "Acidosis respiratoria totalmente compensada por alcalosis metabólica"
       "Alcalosis respiratoria"
       "Acidosis respiratoria"
       "Acidosis metabólica parcialmente compensada por alcalosis respiratoria"
       "Acidosis metabólica parcialmente compensada por alcalosis respiratoria"
       "Acidosis respiratoria y metabólica"
       "Alcalosis metabólica parcialmente compensada por acidosis respiratoria"
       "Alcalosis metabólica parcialmente compensada por acidosis respiratoria"
       "Alcalosis metabólica totalmente compensada por acidosis respiratoria"
       "Alcalosis metabólica totalmente compensada por acidosis respiratoria"
       "Normal"];
    
for i = 1:size(val, 1)
    disp("-------------------------------------------------------------")
    result = evalfis(gas, val(i, :));
    disp("Caso " + i + ": " + pre(i))
    disp("    " + num2str(val(i, :)))
    disp(result);
    
    for j = 1:size(gas.Outputs, 2)
        max_mf = 0; max_mf_val = 0.0;
        for k = 1:size(gas.Outputs(j).MembershipFunctions, 2)
            mf_val = evalmf(gas.Outputs(j).MembershipFunctions(k), result(j));
            if mf_val > max_mf_val
                max_mf_val = mf_val;
                max_mf = k;
            end
        end
        
        disp(gas.Outputs(j).Name + ": " + ...
        gas.Outputs(j).MembershipFunctions(max_mf).Name + " (" + result(j) + ")")
    end
end