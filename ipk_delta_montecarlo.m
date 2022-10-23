%Cinemática inversa de robot delta
function ci=ipk_delta_montecarlo(xdesired,Jdesign)
%Xvalidos=zeros(3,1);%tendremos 3 coordenadas cartesianas
%PUNTO DESEADO
x=xdesired(1);
y=xdesired(2);
z=xdesired(3);

%Parametros de diseño en centímetros
%Bases
    r1=Jdesign(1); %Radio del primer triangulo //Radio de Base fija
    r2=Jdesign(2);  %Radio del segundo triangulo //Radio de Base Móvil
%//////////////////////////////////////////////////////
%Eslabones    
    %sujetos a Teta1 de a==>A
    L11=Jdesign(3); %Longitud de pierna superior
    L12=Jdesign(4); %Longitud de pierna inferior
    
    err=0.1; %Precision
%/////////////////////////////////////////////////////
    %sujetos a Teta2 de b==>B
    L21=L11;
    L22=L12;
    %sujetos a Teta3 de c==>C
    L31=L11;
    L32=L12;
%Definimos la base fija en el espacio
a=[r1*cos(pi/6) -r1*sin(pi/6) 0];
b=[0 r1 0];
c=[-r1*cos(pi/6) -r1*sin(pi/6) 0];
%%Graficamos Base fija
% plot3([a(1);b(1)],[a(2);b(2)],[a(3);b(3)],'r')
% plot3([b(1);c(1)],[b(2);c(2)],[b(3);c(3)],'r')
% plot3([c(1);a(1)],[c(2);a(2)],[c(3);a(3)],'r')

%%Definimos base móvil
    %Iniciada en el Origen
    A=[r2*cos(pi/6) -r2*sin(pi/6) 0];
    B=[0 r2 0];
    C=[-r2*cos(pi/6) -r2*sin(pi/6) 0];
    %La colocamos en el punto deseado;
    H1=[1 0 0 A(1);0 1 0 A(2);0 0 1 A(3);0 0 0 1];
    H2=[1 0 0 B(1);0 1 0 B(2);0 0 1 B(3);0 0 0 1];
    H3=[1 0 0 C(1);0 1 0 C(2);0 0 1 C(3);0 0 0 1];
    H1=H1*[1 0 0 x;0 1 0 y;0 0 1 z;0 0 0 1];
    H2=H2*[1 0 0 x;0 1 0 y;0 0 1 z;0 0 0 1];
    H3=H3*[1 0 0 x;0 1 0 y;0 0 1 z;0 0 0 1];
    %Plataforma Transportada al objetivo 
    %(centro de la plataforma es el objetivo)
    A=[H1(1,4) H1(2,4) H1(3,4)];
    B=[H2(1,4) H2(2,4) H2(3,4)];
    C=[H3(1,4) H3(2,4) H3(3,4)];
    
    %dibujamos la plataforma secundaria
%     plot3([A(1);B(1)],[A(2);B(2)],[A(3);B(3)],'b')
%     plot3([B(1);C(1)],[B(2);C(2)],[B(3);C(3)],'b')
%     plot3([C(1);A(1)],[C(2);A(2)],[C(3);A(3)],'b')
    
    %Dibujamos los centros como referencia
%     plot3([0;x],[0;y],[0;z],'g')

i=0;%contador para saber si punto es alcanzable    
%MOVIMIENTOS DE TETA2
   for (alfa2=-pi/2:0.001:pi/2)
    teta2=alfa2;
    %deplazamiento del origen a B
    h1=[1 0 0 b(1);0 1 0 b(2);0 0 1 b(3);0 0 0 1];
    h11=h1*[1 0 0 0;0 cos(teta2) -sin(teta2) 0;0 sin(teta2) cos(teta2) 0;0 0 0 1];
    h111=h11*[1 0 0 0;0 1 0 L11;0 0 1 0;0 0 0 1];
    pb=[h111(1,4) h111(2,4) h111(3,4)];
    dist2=((pb(1)-B(1))^2+(pb(2)-B(2))^2+(pb(3)-B(3))^2)^.5;
    if(dist2>L12-err)&&(dist2<L12+err)
        teta2=alfa2*180/pi;
%         plot3([b(1);pb(1)],[b(2);pb(2)],[b(3);pb(3)],'m')
%         plot3([pb(1);B(1)],[pb(2);B(2)],[pb(3);B(3)],'m')
%         ;fprintf('aquí es theta 2:')
%         ;teta2
        i=i+1;
        break;
    end
   end
    
%MOVIMIENTOS DE TETA3
 for (alfa3=-pi/2:0.001:pi/2)
    teta3=-1*alfa3+pi; %conversión para la referencia que establecimos
    %rotacion de 120 grados y despues deplazamiento del origen a B
    h2=[1 0 0 c(1);0 1 0 c(2);0 0 1 c(3);0 0 0 1]*[cos(2*pi/6) sin(2*pi/6) 0 0;-sin(2*pi/6) cos(2*pi/6) 0 0;0 0 1 0;0 0 0 1];
    h22=h2*[1 0 0 0;0 cos(teta3) -sin(teta3) 0;0 sin(teta3) cos(teta3) 0;0 0 0 1];
    h222=h22*[1 0 0 0;0 1 0 L11;0 0 1 0;0 0 0 1];
    pc=[h222(1,4) h222(2,4) h222(3,4)];
    dist3=((pc(1)-C(1))^2+(pc(2)-C(2))^2+(pc(3)-C(3))^2)^.5;
    if(dist3>L12-err)&&(dist3<L12+err)
        teta3=alfa3;
        teta3=teta3*180/pi;
%         plot3([c(1);pc(1)],[c(2);pc(2)],[c(3);pc(3)],'m')
%         plot3([pc(1);C(1)],[pc(2);C(2)],[pc(3);C(3)],'m')
%         ;fprintf('aquí es theta 3:')
%         ;teta3
        i=i+1;
        break;
    
 end
 end
%MOVIMIENTOS DE TETA1
 for (alfa1=-pi/2:0.001:pi/2)
    teta1=-1*alfa1+pi;
    %desplazamiento y despues rotacion en za
    h3=[1 0 0 a(1);0 1 0 a(2);0 0 1 a(3);0 0 0 1]*[cos(-2*pi/6) sin(-2*pi/6) 0 0;-sin(-2*pi/6) cos(-2*pi/6) 0 0;0 0 1 0;0 0 0 1];
    h33=h3*[1 0 0 0;0 cos(teta1) -sin(teta1) 0;0 sin(teta1) cos(teta1) 0;0 0 0 1];
    h333=h33*[1 0 0 0;0 1 0 L11;0 0 1 0;0 0 0 1];
    pa=[h333(1,4) h333(2,4) h333(3,4)];
    dist1=((pa(1)-A(1))^2+(pa(2)-A(2))^2+(pa(3)-A(3))^2)^.5;
    if(dist1>L12-err)&&(dist1<L12+err)
        teta1=alfa1;
        teta1=teta1*180/pi;
%         plot3([a(1);pa(1)],[a(2);pa(2)],[a(3);pa(3)],'m')
%         plot3([pa(1);A(1)],[pa(2);A(2)],[pa(3);A(3)],'m') 
%         ;fprintf('aquí es theta 1:')
%         ;teta1
        i=i+1;
        break;
    
    end
 end
%Terminamos de dibujar el Robot Delta
distancia=((a(1)+b(1))^2+(a(2)+b(2))^2+(a(3)+b(3))^2)^.5;
Q=b+[c(1)-a(1) c(2)-a(2) c(3)-a(3)];
P=b-[c(1)-a(1) c(2)-a(2) c(3)-a(3)];
R=a+[c(1)-b(1) c(2)-b(2) c(3)-b(3)];

% plot3([Q(1);P(1)],[Q(2);P(2)],[Q(3);P(3)],'r')
% plot3([P(1);R(1)],[P(2);R(2)],[P(3);R(3)],'r')
% plot3([Q(1);R(1)],[Q(2);R(2)],[Q(3);R(3)],'r')

q=[teta1;teta2;teta3];
%disp("expresados en °");
%disp("para llegar a:");
X=[x;y;z];

% if (i==3)
%     ci=1;
%     fprintf('punto dentro de espacio alcanzable')
%     Xvalidos(1)=x;
%     Xvalidos(2)=y;
%     Xvalidos(3)=z;
% end
% if (i<3)
%     ci=0;
%     fprintf('punto fuera de espacio alcanzable')
% end
% %
if (i==3)
    ci=1;
end
if (i<3)
    ci=0;
end