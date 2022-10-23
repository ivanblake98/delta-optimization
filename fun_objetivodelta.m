 function wspace=fun_objetivodelta(Jdesign)
%MÉTODO DE MONTECARLO PARA GENERAR PUNTOS ALEATORIOS QUE SE ENCUENTREN
%DENTRO DEL ESPACIO DE TRABAJO DESEADO PROPUESTO
% #volumen propuesto:
% #volumen ---> lado1 x lado2 x alturaz (x*y*z)
% #suponiendo que el centro de la caja es  (0, 0, -0.275) (x,y,z) y esta orientada en Z
% #entonces todos los puntos dentro deL espacio de trabajo deseado deberían satisfacer las siguientes restricciones
% # - (lado1 / 2) < X < (lado1 / 2)
% # - (lado2 / 2) < Y < (lado2 / 2)
% # -0.275 - (alturaz / 2)  < Z < -0.275 + (alturaz / 2)
alturaz=0.15; %definimos el alto del espacio de trabajo [0.15m]
lado1=0.15; %definimos el lado X [0.15m]
lado2=0.13; %definimos el lado Y [0.13m]
N = 100; %# cantidad de puntos aleatorios a generar
cnt = 0; %# puntos dentro del espacio de trabajo, inicializa en 0
%generamos N puntos aleatorios y comprobamos si cada uno está dentro
%del espacio de trabajo deseado con el algoritmo de Cinemática inversa
for(k=1:1:N)
%generamos puntos aleatorios (x,y,z) dentro del espacio de trabajo deseado
%     x=randi([-(lado1/2),(lado1/2)]);
%     y=randi([-(lado2/2),(lado2/2)]);
%     z=randi([-0.275 - (alturaz / 2) , -0.275 +(alturaz / 2)]);
    x = py.numpy.random.uniform(-(lado1/2),(lado1/2));    
    y = py.numpy.random.uniform(-(lado2/2),(lado2/2));
    z = py.numpy.random.uniform(-0.275 - (alturaz / 2) , -0.275 +(alturaz / 2));
    xdesired = [x,y,z];%creamos el vector de coordenadas deseadas (aleatorio)
    if(ipk_delta_montecarlo(xdesired,Jdesign)==1)%si el punto está dentro del espacio alcanzable entonces entra
            cnt = cnt + 1  %el punto es válido; incrementamos cn
    end
end
wspace=-(cnt/N)*(lado1*lado2*alturaz); %Wspace=(#totalpuntosalcanzables/#totaldepuntosaleatoriosgenerados)*(lado1*lado2*alturaz) [m^3]
%multiplicamos la función objetivo por -1 porque se desea maximizar el
%espacio de trabajo

 
