% -------------------------------------------------------------------------
%
%    function [espectro img] = Grafico_Frecuencial(sgn, fs, mode, mod_gr);
%
%   Parámetros de Entrada :
%
%       snl     : array con las muestras de la señal
%       Fs      : Frecuencia a la que fue sampleada la señal
%       color   : parámetro del plot
%       mod_gr  : 0 -> grafica parte real e imaginaria de la señal
%                 1 -> grafica modulo y fase en dB
%                 2 -> Grafica solo módulo sin crear nueva figura
%       NF      : Opcional:Número de fila. Para asociar el gráfico a uno ya
%                 existente.
%       NC      : Opcional:Número de columna. Para asociar el gráfico a uno 
%                 ya existente.
%       G0      : Opcional:Número de gráfico del plot a partir del cual se
%                 dibuja.
%
%   Parámetros de salida :
% 
%       espectro    : Array de N muestras con la señal
%       img         : Array de N muestras con el eje temporal
%
%   Fecha de creacion   :   08.04.2010
%   Última Modificación :   10.02.2014
%
%   Autor : Federico Roux (froux@favaloro.edu.ar)
%   Laboratorio de uP. Universidad Favaloro 
% -------------------------------------------------------------------------

function [espectro img ] = Grafico_Frecuencial(snl, Fs, color, mod_gr, NF, NC, G0)

%% Definición de parámetros :

margenY = 0.1 ;                                                             % Margen porcentual en el eje y

%% Implementación de la función :

N = length(snl);                                                            % Calculo la longitud de la señal

espectro = fft(snl);                                                        % Hago la fft de la señal

if(mod_gr == 1 || mod_gr == 2)                                              % Grafico mod_gr : Módulo y Fase
    
    modulo  = abs(espectro);                                                % Calculo el módulo de las muestras
    fase    = angle(espectro);                                              % Calculo la fase del espectro de la señal
    
    max_mod = max(modulo);                                                  % Calculo el máximo del módulo para normalizar
    modulo_norm = modulo/max_mod;                                           % Normalizo en función del máximo que me queda igual a uno
    modulo_db = 20*log(modulo_norm);                                        % Convierto todo a dB (el máximo pasa a ser cero)
    
    g1 = modulo_db;                                                         % Guardo el módulo de la señal a graficar
    g2 = fase ;                                                             % Guardo la fase de la señal a graficar
        
    titulo = 'Módulo y Fase del Espectro de la Señal' ;                     % Título general
    tit1 = 'Módulo del espectro de la señal' ;                              % Titulo gráfico modulo
    tit2 = 'Fase del espectro de la señal' ;                                % Título gráfico fase
    ylab1 = '|X(\omega)| [dB]' ;                                            % Etiqueta del eje vertical del primer gráfico
    ylab2 = '\phi[X(\omega)] [rad]' ;                                       % Etiqueta del eje vertical del segundo gráfico
       
elseif (mod_gr == 0 )                                                       % Grafico cartesiano : parte real e imaginaria
    
    preal   = real (espectro) ;                                             % Calculo la parte real del espectro
    pimag   = imag (espectro) ;                                             % Calculo la parte imaginaria del espectro
    
    g1 = preal ;                                                            % Guardo la parte real de la señal a graficar
    g2 = pimag ;                                                            % Guardo la parte imaginaria de la señal a graficar
    
    titulo = 'Parte Real e Imaginaria del Espectro de la Señal' ;           % Titulo general
    tit1 = 'Parte Real del espectro de la señal' ;                          % Título del gráfico de la parte real
    tit2 = 'Parte Imaginaria del espectro de la señal' ;                    % Título del gráfico de la parte imaginaria
    
    ylab1 = 'Real [X(\omega) ]' ;                                           % Etiqueta del eje vertical del primer gráfico
    ylab2 = 'Imag [X(\omega) ]' ;                                           % Etiqueta del eje vertical del segundo gráfico 

end

n = 0 : N - 1 ;                                                             % Eje con número de muestras
n = n * (Fs / N);                                                           % Escalo el eje de frecuencias en Hz
% n = n - N/2 ;                                                             % Muevo el eje al centro

%% Correción de márgenes

[max1 min1 ] = Margenes(g1, margenY ) ;
[max2 min2 ] = Margenes(g2, margenY ) ;


%% Gráfico de las señales :

if(mod_gr == 0 || mod_gr == 1)
    if(nargin < 5)
        img = figure () ;                                                       % Obtengo el handler de la imagen       
        G0 = 1;
        set(gcf, 'Name', titulo) ;
        NF = 2;
        NC = 1;
    end
    % Primer Gráfico :

    subplot (NF, NC, G0) ;
    plot (n, g1, color, 'LineWidth', 2 ) ;               
    grid on ;    
    ylim ([min1 max1 ] ) ;

    xlabel ('f[Hz]' ) ;
    ylabel (ylab1) ;
    title(tit1 ) ;

    % Segundo Gráfico :

    subplot (NF, NC, G0 + 1) ;
    plot (n, g2, color, 'LineWidth', 2 ) ;               
    grid on ;
    ylim ([min2 max2 ] ) ;

    xlabel ('f[Hz]' ) ;
    ylabel (ylab2) ;
    title(tit2 ) ;

    
elseif(mod_gr == 2)

    if(nargin < 5)
        img = figure () ;                                                       % Obtengo el handler de la imagen       
        G0 = 1;
        set(gcf, 'Name', titulo) ;
    end
    img = gcf();
    
    plot (n, g1, color, 'LineWidth', 2 ) ;               
    grid on ;
    % xlim ([fmin fmax ] ) ;
    ylim ([min1 max1 ] ) ;

    xlabel ('f[Hz]' ) ;
    ylabel (ylab1) ;
    title(tit1 ) ;    
    
end

end

%-------------------------------------------------------------------------
%   function [maximo minimo] = Margenes(signal )
%
%   Parámetros de Entrada :
%           sgn                 : señal a calcular los márgenes
%           margen_porcentual   : porcentaje respecto a los máximos
%
%   Parámetros de salida :
%       maximo  : valor máximo del márgen del gráfico
%       minimo  : valor mínimo del márgen del gráfico
%
%   Fecha de creación   : 13-10-2010
%   Última Modificación : 13-10-2010
%
%   Fecha de creacion   :   13.10.2010
%   Última Modificación :   10.02.2014
%
%   Autor : Federico Roux (froux@favaloro.edu.ar)
%   Laboratorio de uP
%   Universidad Favaloro 
%-------------------------------------------------------------------------

function [maximo minimo] = Margenes(sgn, margen_porcentual )

maximo = max(sgn );                                                         % Máximo de la señal a graficar
minimo = min(sgn );                                                         % Mínimo de la señal a graficar

span = maximo - minimo ;                                                    % Rango dinámico de la señal

if(span == 0)
    span = 1 ;                                                              % Fuerzo el span si las señales tienen sus muestras iguales
end

margen = margen_porcentual * abs(span ) ;

maximo = maximo + margen ;
minimo = minimo - margen ;

end