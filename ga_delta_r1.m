clc  %Limpiamos command window
clear  %Limpiamos workspace
%todas las unidades se consideran en metros para todo el algoritmo y
%funciones dependientes
nvars=4;  %NÃºmero de variables de diseÃ±o (tamaÃ±o del vector de diseÃ±o)
% x es el vector de variables de diseÃ±o 
A=[]; %Matriz de restricciones lineales de desigualdad
b=[]; %Vector de restricciones lineales de desigualdad
Aeq=[]; %Matriz de restricciones lineales de igualdad
beq=[]; %Vector de restricciones lineales de igualdad
lb=[0.2,0.07,0.1, 0.2]; %Vector de variables de diseño minimas [r_basefija,r_basemovil,length_superior,length_inferior]
ub=[0.3, 0.1, 0.19, 0.31]; %Vector de varibales de diseÃ±o maximas
nonlcon=[];%@res_nonl;  %FunciÃ³n de resrticciones nolineales
% lb=[-inf, -inf, -inf, -inf, -inf];
% ub=[inf, inf, inf, inf, inf];
options=optimoptions('ga','MaxGenerations',20,'PopulationSize',50,'PlotFcn',@gaplotbestf);   %FunciÃ³n de opciones del algoritmo
[x,fval,exitflag,output,population,scores]=ga(@fun_objetivodelta,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options);  %sintaxis del toolbox de optimizaciÃ³n
% x es el vector soluciÃ³n del problema
% fval es el valor de la funciÃ³n objetivo con el vector soluciÃ³n
% exitflag es una bandera que indica la convergencia del algoritmo
% Exit Flag	Meaning
% 1	
% Without nonlinear constraints â€” Average cumulative change in value of the fitness function over MaxStallGenerations generations is less than FunctionTolerance, and the constraint violation is less than ConstraintTolerance.
% 
% With nonlinear constraints â€” Magnitude of the complementarity measure (see Complementarity Measure) is less than sqrt(ConstraintTolerance), the subproblem is solved using a tolerance less than FunctionTolerance, and the constraint violation is less than ConstraintTolerance.
% 
% 3	
% Value of the fitness function did not change in MaxStallGenerations generations and the constraint violation is less than ConstraintTolerance.
% 
% 4	
% Magnitude of step smaller than machine precision and the constraint violation is less than ConstraintTolerance.
% 
% 5	
% Minimum fitness limit FitnessLimit reached and the constraint violation is less than ConstraintTolerance.
% 
% 0	
% Maximum number of generations MaxGenerations exceeded.
% 
% -1	
% Optimization terminated by an output function or plot function.
% 
% -2	
% No feasible point found.
% 
% -4	
% Stall time limit MaxStallTime exceeded.
% 
% -5	
% Time limit MaxTime exceeded.
% output ...estructura con informaciÃ³n del algoritmo 
% population es la poblaciÃ³n de individuos en cada generacion
% scores es un indicador de la violacion de restricciones   

%  Valor exacto:   -0.9098  -0.1795
%      N=10,  Gmax=300   
%     -0.8779   -0.2431    Corrida 1
%     -0.9374   -0.1242    Corrida 2
%     -0.9330   -0.1330    Corrida 3
%     -0.9227   -0.1538    Corrida 4
%     -0.9238   -0.1514    Corrida 5
%     SoluciÃ³n PROMEDIO
%      N=50,  Gmax=300
%     -0.9064   -0.1863    Corrida 1
%     -0.9096   -0.1797    Corrida 2
%     -0.9161   -0.1668    Corrida 3
%     -0.9061   -0.1868    Corrida 4
%     -0.9101   -0.1789    Corrida 5
%     SoluciÃ³n PROMEDIO
%      N=50,  Gmax=300
%     -0.9092   -0.1805   Corrida 1

%numero de puntos N=[10,50,100]
%generaciones = [10,50,100]
%individuos  = [10,50,100]
%27 soluciones para caso no restringido
%si alguna variable no cambia mucho, quizá no posee demasiada influencia y
%se puede fijar, se reducen las var de diseño
%manipulabilidad, elipsoide de manipulabilidad, en terms del jacobiano
%al maximizarlo el robot no entra en configuraciones
%singulares-->1restriccion
%tabla de excel con parámetros en solidworks

%referencias de los vectores, en mi libreta
%Simulaciones con espacio de trabajo 3 (dimensiones adecuadas)
%Simulación 1, N=10 GENE=10 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.3000    0.0700    0.1900    0.3100]; fval=-0.0029
%Simulación 2, N=10, GENE=50 INDIV=50
%x=[0.3000    0.0700    0.1000    0.3100]; fval=-0.0029
%Simulación 3, N=10 GENE=100 INDIV=100
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2000    0.0939    0.1900    0.3100]; fval=-0.0029
%Simulación 4: N=50 GENE=10 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.0700    0.1000    0.3100]; fval=-0.0029
%Simulación 5: N=50 GENE=50 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.1000    0.1900    0.2000]; fval=-0.0029
%Simulación 6: N=50 GENE=100 INDIV=100
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.3000    0.0700    0.1000    0.3100]; fval=-0.0029
%Simulación 7: N=100; GENE=10 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2755    0.0737    0.1843    0.3047]; fval=-0.0029
%Simulación 8: N=100 GENE=50 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.1000    0.1122    0.3100]; fval=-0.0029
%Simulación 9 N=100 GENE=100 INDIV=100
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.3000    0.0700    0.1900    0.3100]; fval=-0.0029
%Simulación 10 N=10 GENE=10 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2244    0.0933    0.1853    0.3090]; fval=-0.0029
%Simulación 11 N=10 GENE=10 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.3000    0.0700    0.1000    0.3100]; fval=-0.0029
%Simulación 12 N=10 GENE=50 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.1000    0.1900    0.2000]; fval=-0.0029
%Simulación 13 N=10 GENE=50 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.1000    0.1900    0.2000]; fval=-0.0029
%Simulación 14 N=10 GENE=100 INDIV=10
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2000    0.0700    0.1000    0.3100]; fval=-0.0029
%Simulación 15 N=10 GENE=100 INDIV=50
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2497    0.0700    0.1900    0.3100]; fval=-0.0029
%Simulación 16 N=50 GENE=10 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.3000    0.1000    0.1000    0.3100]; fval=-0.0029
%Simulación 17 N=50 GENE=10 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2822    0.0787    0.1789    0.2689]; fval=-0.0029
%Simulación 18 N=100 GENE=10 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2401    0.0775    0.1489    0.2861]; fval=-0.0029
%Simulación 19 N=100 GENE=10 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.0700    0.1900    0.3100]; fval=-0.0029
%Simulación 20 N=100 GENE=50 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2011    0.0983    0.1277    0.2095]; fval=-0.0029
%Simulación 21 N=100 GENE=50 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.0700    0.1900    0.2000]; fval=-0.0029
%Simulación 22 N=50 GENE=50 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.0700    0.1900    0.2738]; fval=-0.0029
%Simulación 23 N=50 GENE=50 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2268    0.0783    0.1783    0.2087]; fval=-0.0029
%Simulación 24 N=50 GENE=100 INDIV=10
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2000    0.0700    0.1900    0.3100]; fval=-0.0029
%Simulación 25 N=50 GENE=100 INDIV=50
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2986    0.0964    0.1003    0.3082]; fval=-0.0029
%Simulación 26 N=100 GENE=100 INDIV=10
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2000    0.0700    0.1900    0.2000]; fval=-0.0029
%Simulación 27 N=100 GENE=100 INDIV=50
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2000    0.0700    0.1900    0.2000]; fval=-0.0029















%referencias de los vectores, en mi libreta
%Simulaciones con espacio de trabajo 2 (dimensiones adecuadas)
%Simulación 1, N=10 GENE=10 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x= [0.2158    0.0940    0.1353    0.2764]; fval=-0.0067
%Simulación 2, N=10, GENE=50 INDIV=50
%x=[0.2125    0.0806    0.1886    0.2734]; fval=-0.0067
%Simulación 3, N=10 GENE=100 INDIV=100
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2000    0.1000    0.1000    0.3100]; fval=-0.0067
%Simulación 4: N=50 GENE=10 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2074    0.0885    0.1809    0.2788]; fval=-0.0067
%Simulación 5: N=50 GENE=50 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2285    0.0894    0.1731    0.2895]; fval=-0.0067
%Simulación 6: N=50 GENE=100 INDIV=100
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2139    0.0917    0.1775    0.3053]; fval=-0.0067
%Simulación 7: N=100; GENE=10 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.1000    0.1000    0.3100]; fval=-0.0067
%Simulación 8: N=100 GENE=50 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2132    0.0990    0.1871    0.2956]; fval=-0.0067
%Simulación 9 N=100 GENE=100 INDIV=100
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2494    0.0873    0.1815    0.3030]; fval=-0.0067
%Simulación 10 N=10 GENE=10 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2192    0.0751    0.1536    0.2979]; fval=-0.0067
%Simulación 11 N=10 GENE=10 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2665    0.0852    0.1771    0.2965]; fval=0.0067
%Simulación 12 N=10 GENE=50 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2161    0.0923    0.1255    0.3003]; fval=-0.0067
%Simulación 13 N=10 GENE=50 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2229    0.0957    0.1817    0.2829]; fval=-0.0067
%Simulación 14 N=10 GENE=100 INDIV=10
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2162    0.0861    0.1550    0.2777]; fval=-0.0067
%Simulación 15 N=10 GENE=100 INDIV=50
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2067    0.0944    0.1316    0.3085]; fval=-0.0067
%Simulación 16 N=50 GENE=10 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2347    0.0861    0.1615    0.3026]; fval=-0.0067
%Simulación 17 N=50 GENE=10 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2000    0.1000    0.1000    0.3100]; fval=-0.0067
%Simulación 18 N=100 GENE=10 INDIV=50
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2071    0.0914    0.1558    0.2833]; fval=-0.0067
%Simulación 19 N=100 GENE=10 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2332    0.0860    0.1691    0.3052]; fval=-0.0067
%Simulación 20 N=100 GENE=50 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2319    0.0998    0.1379    0.3057]; fval=-0.0067
%Simulación 21 N=100 GENE=50 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2098    0.0795    0.1442    0.2994]; fval=-0.0067
%Simulación 22 N=50 GENE=50 INDIV=10
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2091    0.0742    0.1734    0.2861]; fval=-0.0067
%Simulación 23 N=50 GENE=50 INDIV=100
%Optimization terminated: maximum number of generations exceeded.
%x=[0.2386    0.0962    0.1640    0.3059]; fval=-0.0067
%Simulación 24 N=50 GENE=100 INDIV=10
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2000    0.0753    0.1551    0.3020]; fval=-0.0067
%Simulación 25 N=50 GENE=100 INDIV=50
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2512    0.0894    0.1885    0.2980]; fval=-0.0067
%Simulación 26 N=100 GENE=100 INDIV=10
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2012    0.0757    0.1840    0.2772]; fval=-0.0067
%Simulación 27 N=100 GENE=100 INDIV=50
%Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%x=[0.2123    0.0918    0.1445    0.3063]; fval=-0.0067









%Simulaciones r1 con espacio de trabajo 1 (muy grande)
%Dimensiones propuestas de espacio de trabajo 1*0.75*0.8, centro de volumen
%en (0,0,-0.6)
%Simulación 1, N=10 GENE=10 INDIV=10
%0.2632    0.0988    0.1764    0.2051 corrida 1 fval, ver imagen
%0.2398    0.0798    0.1859    0.2942 corrida 2 fval=-0.0600
%0.2227    0.0882    0.1306    0.2876 corrida 3 fval= -0.1200
%0.2033    0.0973    0.1721    0.3100 corrida 4 fval=-0.1800
%0.2540    0.0770    0.1625    0.2675 corrida 5 fval= -0.0600
%Solución promedio: 
%Simulación 2, N=10, GENE=50 INDIV=50 ; en todas Optimization terminated: maximum number of generations exceeded.
%0.2090    0.0945    0.1882    0.3090 corrida 1 fval=-0.2400
%0.2177    0.0929    0.1804    0.3057 corrida 2 fval=-0.2400
%0.2001    0.0931    0.1860    0.3021 corrida 3 fval=-0.1800
%0.2389    0.0970    0.1868    0.3064 corrida 4 fval=-0.3000
%0.2030    0.0940    0.1820    0.3092 corrida 5 fval=-0.2400
%Solución promedio:
%Simulación 3, N=10 GENE=100 INDIV=100
%0.2082    0.0931    0.1872    0.3066 corrida 1 fval=-0.2400 Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%0.2014    0.0980    0.1900    0.3100 corrida 2 fval=-0.2400 Optimization terminated: average change in the fitness value less than options.FunctionTolerance. 
%0.2029    0.0976    0.1812    0.3077 corrida 3 fval=-0.2400 Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%0.2241    0.0916    0.1840    0.3088 corrida 4 fval=-0.1800 Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%0.2088    0.0953    0.1881    0.3071 corrida 5 fval=-0.2400 Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%Solución promedio:
%Simulación 4: N=50 GENE=10 INDIV=10
%0.2043    0.1000    0.1169    0.2692 corrida 1 fval=-0.0720 Optimization terminated: maximum number of generations exceeded.
%0.2125    0.0728    0.1896    0.2965 corrida 2 fval=-0.0840 maximum number of generations exceeded.
%0.2158    0.0988    0.1590    0.2906 corrida 3 fval=-0.1080 maximum number of generations exceeded.
%0.2398    0.1000    0.1665    0.2650 corrida 4 fval=-0.0720 maximum number of generations exceeded.
%0.2000    0.1000    0.1900    0.3100 corrida 5 fval=-0.1080 maximum number of generations exceeded.
%Solución promedio:
%Simulación 5: N=50 GENE=50 INDIV=50
%0.2027    0.0966    0.1793    0.3092 corrida 1 fval=-0.1560 maximum number of generations exceeded.
%0.2031    0.0949    0.1729    0.3036 corrida 2 fval=-0.1440 maximum number of generations exceeded.
%0.2010    0.0984    0.1898    0.3100 corrida 3 fval=-0.1440 maximum number of generations exceeded.
%0.2000    0.0952    0.1846    0.3080 corrida 4 fval=-0.1320 maximum number of generations exceeded.
%0.2139    0.0980    0.1900    0.3048 corrida 5 fval=-0.1440 aximum number of generations exceeded.
%Solución promedio:
%Simulación 6: N=50 GENE=100 INDIV=100
%0.2046    0.0961    0.1895    0.3100 fval=-0.1440 Optimization terminated: average change in the fitness value less than options.FunctionTolerance.
%Simulación 7: N=100; GENE=10 INDIV=10
%0.2338    0.0832    0.1817    0.2854 fval=-0.0540 maximum number of generations exceeded.
%Simulación 8: N=100 GENE=50 INDIV=50
%0.2017    0.0898    0.1748    0.2971 fval=-0.0840 maximum number of generations exceeded.
%Simulación 9 N=100 GENE=100 INDIV=100
%0.2202    0.0946    0.1767    0.3090 fval=-0.1140 Optimization terminated: average change in the fitness value less than options.FunctionTolerance.