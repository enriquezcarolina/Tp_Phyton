% -------------------------------------------------------------------------
%   
%   function Grafico_Temporal(snl, Fs, t0, titulo, x_etq, y_etq, color, mod_gr, nombre)
%
%   Parametros de Entrada:
%
%       snl         : Señal a graficar
%       Fs          : Frecuencia de muestreo
%       t0          : Instante inicial de la señal
%       titulo      : Titulo del gráfico hecho
%       x_etq       : Etiqueta del eje x
%       y_etq       : Etiqueta del eje y
%       mod_gr      :   0 -> plot 
%                       1 -> stem
%                       2 -> Línea y puntos negros
%       color       : Parametro para el plot.
%       nombre      : Título de la figura (propiedad 'Name')
%
%   Fecha de creacion :     11.05.2010
%   Última Modificación :   17.02.2014
%
%   Autor : Federico Roux (froux@favaloro.edu.ar)
%   Laboratorio de uP. Universidad Favaloro 
% -------------------------------------------------------------------------

function Grafico_Temporal(snl, Fs, t0, titulo, x_etq, y_etq, color, mod_gr, nombre)

%% Calculo parámetros de la señal:

N = length(snl);                                                            % Cantidad de muestras de la señal

Ts = 1 / Fs ;                                                               % Período de muestreo
k = 0:(N - 1);                                                              % Eje de muestras
t = (k * Ts) + t0;                                                          % Convierto de muestras a unidad de tiempo

xmin = t0;                                                                  % Instante inicial de la señal
xmax = (N - 1)*Ts + t0;                                                     % Instante final de la señal

%% Tipo de gráfico:

if (nargin >= 8)                                                            % Pregunto si recibí todos los parámetros de la señal

    if(mod_gr == 0)                                                         % Modo 0 :        
        plot(t, snl, color, 'LineWidth', 2);                                 % --> Grafico con la función plot
    
    elseif(mod_gr == 1)                                                       % Modo 1 : 
        stem(t, snl, color) ;                                               % --> Grafico con la función stem
    
    elseif(mod_gr == 2)
        plot(t, snl, color, 'LineWidth', 2);                                 % --> Grafico con la función plot
        hold on;
        plot(t, snl, '.k', 'LineWidth', 2);                                 % --> Grafico con la función plot
        hold off;
    end
else
    
    plot(t, snl, color, 'LineWidth', 2) ;                                   % Si no se especifica el modo, por default hace plot.
end

%% Escribo todas las etiquetas del gráfico:

xlabel(x_etq);                                                              % Asigno las etiqueta del eje X
ylabel(y_etq);                                                              % Asigno las etiqueta del eje Y

titulo = sprintf('%s N = %d Fs = %.2f [Hz]', titulo, N, Fs) ;                    % Genero la leyenda a escribir como título
title(titulo);                                                              % Escribo título del gráfico      

if(nargin == 9)  
    set(gcf, 'Name',  nombre, 'NumberTitle', 'off');
end

%% Determino los límites del gráfico

maximo = max(snl);                                                          % Maximo de la señal a graficar
minimo = min(snl);                                                          % Minimo de la señal a graficar

span = maximo - minimo ;                                                    % Rango dinamico de la señal

if(span == 0)                                                               % Si la señal tiene todas las muestras iguales el span es cero y da error
    span = 1 ;                                                              % Fuerzo el span para poder ver correctamente la señal
end

margen_porcentual = 0.1 ;                                                   % Margen del gráfico a mostrar más allá de sus límites
margen = margen_porcentual * abs(span) ;                                    % Genero el margen para sumar a los límites del gráfico

maximo = maximo + margen ;                                                  % Calculo el máximo del gráfico
minimo = minimo - margen ;                                                  % Calculo el mínimo del gráfico    

ylim([minimo maximo]);                                                      % Límites del eje vertical
xlim([xmin xmax]);                                                          % Limites del eje horizontal

grid on;                                                                    % Muestro la grilla sobre el fondo del gráfico

end