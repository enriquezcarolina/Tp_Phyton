
import numpy as np
import matplotlib.pyplot as plp
import pandas as pd
Fs=500
Ts=1/Fs
S1=pd.read_csv("./presion_TP1.csv")
L=len(S1)
print("L:{0}".format(L))

k=np.arange(0,L) # el cero se cuenta, por eso no lo hago hasta 0-1
t=k*Ts #creo el eje 

plp.subplot(3,1,1)
plp.plot(t,S1)
plp.grid()
plp.xlabel("t[s]")


rf= Fs/(L-1) # Resolucion en frec (en timepo 1/Fs es la resolucion)
F=k*rf #array de freq
#grafico en frecuencia 
Pf=abs(np.fft.rfft(S1));
plp.subplot(3,1,2)
plp.plot(t,Pf)
plp.grid()
plp.xlabel("w")
# Este ADC es de 12 Bits 

# La señal S1 del punto anterior es una señal de tensión entregada por un sensor de presión
#diferencial, en unidades de Volts. El sensor entrega una señal en el rango +/­ 1 Volt. Se quiere
#muestrear la señal entregada por el sensor al ADC del LPC1769, alimentado con una tensión de3.3V.

# Realice un diagrama en bloques del acondicionamiento del sensor (sin tener en cuent el filtro) y calcule los valores de cada bloque.
# sensor entrega rango de +-1V señal minima que puede medir es de 0V 
#G=(3.3-0.1)/(1-(-1)) # Ganancia del bloque amplificador

# Genere una nueva señal S2 en la que modifique la amplitud y el offset de la señal del punto anterior según los valores calculados.

Vmax_sensor=1
Vmin_sensor=-1
Vmax_ADC=3.3
Vmin_ADC=0

G=(Vmax_ADC-Vmin_ADC)/(Vmax_sensor-Vmin_sensor)
Offset=(Vmax_ADC-Vmin_ADC)/2

S2=S1*G+Offset #señal escalada despues de pasar por el amplificador 
plp.subplot(3,1,3)
plp.plot(t,S2) 

plp.grid()
plp.show()
#cambia la amplitud a un rango que puedo usar en el ADC 

# En la hoja de datos del sensor aparece la siguiente información

#si alimento con 5V tengo 330mmhg el sensor va a arrojar 7.5 en lugar de 5V pongo 3.3

#si alimento con 3.3V

Resolucion_3V= 3.3*7.5/5

print(Resolucion_3V)

#simular cuantificacion
#graficar en tiempo y freq y comparar con grafico de S2
############## D1 ADC 8 Bits ###################
N1=8
D1_min=0
D1_max=2**N1-1

S2_max=Vmax_ADC
S2_min=Vmin_ADC

D1=round(S2*((D1_max-D1_min))/(S2_max-S2_min))

plp.subplot(2,1,1)
plp.plot(t,D1)
plp.grid()
plp.title("D1")

plp.subplot(2,1,2)
plp.plot(t,S2)
plp.grid()
plp.title("S2")
plp.show()

D1F=np.fft.rfft(D1)
plp.subplot(2,1,1)
plp.plot(t,D1F)
plp.grid()
plp.title("D1 En frecuencia")

plp.subplot(2,1,2)
plp.plot(t,np.fft.rfft(S2))
plp.grid()
plp.title("S2")
plp.show()


############## D2 ADC 12 Bits ###################
N2=12
D2_min=0
D2_max=2**N2-1

S2_max=Vmax_ADC
S2_min=Vmin_ADC

D2=round(S2*((D2_max-D2_min))/(S2_max-S2_min))

plp.subplot(2,1,1)
plp.plot(t,D2)
plp.grid()
plp.title("D2")

plp.subplot(2,1,2)
plp.plot(t,S2)
plp.grid()
plp.title("S2")
plp.show()

plp.subplot(2,1,1)
plp.plot(t,np.fft.rfft(D2))
plp.grid()
plp.title("D2 frecuencia")

D2F=np.fft.rfft(S2)
plp.subplot(2,1,2)
plp.plot(t,D2F)
plp.grid()
plp.title("S2")
plp.show()
############## D3 ADC 24 Bits ###################

N3=24
D3_min=0
D3_max=2**N1-1

S2_max=Vmax_ADC
S2_min=Vmin_ADC

D3=round(S2*((D3_max-D3_min))/(S2_max-S2_min))

plp.subplot(2,1,1)
plp.plot(t,D3)
plp.grid()
plp.title("D3")

plp.subplot(2,1,2)
plp.plot(t,S2)
plp.grid()
plp.title("S2")
plp.show()

D3F=np.fft.rfft(D3)
plp.subplot(2,1,1)
plp.plot(t,D3F)
plp.grid()
plp.title("D3 frec")

plp.subplot(2,1,2)
plp.plot(t,np.fft.rfft(S2))
plp.grid()
plp.title("S2")
plp.show()

###### E1 E2 E3 ######
D1_float=S2*((D1_max-D1_min))/(S2_max-S2_min) 


E1=D1_float-S2

plp.subplot(2,1,1)
plp.plot(t,E1)
plp.title("E1")

plp.subplot(2,1,2)
plp.plot(t,D1)
plp.title("D1")
plp.show()

D2_float=S2*((D2_max-D2_min))/(S2_max-S2_min) 


E2=D2_float-S2

plp.subplot(2,1,1)
plp.plot(t,E2)
plp.title("E2")

plp.subplot(2,1,2)
plp.plot(t,D2)
plp.title("D2")
plp.show()

D3_float=S2*((D3_max-D3_min))/(S2_max-S2_min) 


E3=D3_float-S2

plp.subplot(2,1,1)
plp.plot(t,E3)
plp.title("E3")

plp.subplot(2,1,2)
plp.plot(t,D3)
plp.title("D3")
plp.show()