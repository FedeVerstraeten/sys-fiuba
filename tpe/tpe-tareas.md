# TRABAJO PRACTICO ESPECIAL - TAREAS

## Punto 1:
  - **[OK]** Escuchar señal, identificar tiempo de discado.
  - **[OK]** Distinguir tiempo señal y tiempo silencio.
  - **[OK]** Agregar al informe secciones
  - **[?]** ¿Sección temporal señales DTMF corresponde a una señal periódica infinita?
  - **[?]** Identificar frecuencia fundamental.

## Punto 2:
  - **[OK]** ¿Qué debe cumplir la señal para aplicar Serie de Fourier?
  - **[OK]** Señal periódica infinita suma 2 senoide scon **f1=800Hz** y **f2=1200Hz**, hallar coef. Fourier. (Preguntar por qué las "deltas" quedan con una altura de la mitad de cantidad de muestras -> N/2)
  - **[OK]** Generar una sección del item anterior y escucharla.
  - **[OK]** Calcular distribución de coef. para cada una de las 16 combinaciones de DTMF **[f1,f2,f3,f4] X [f1',f2',f3',f4']**.

## Punto 3:
  - Trasformada de Fourier del discado completo.
  - Analiza espectro de los distintos símbolos de la señal `modemDIaling.wav` de manera individual.
  - Comparación de los espectros.
  - **[OK]** ¿Se puede identificar la secuencia a partir de este espectro? **Resp.:** No, ya que con la TF directamente se pierde información de la evolución temporal de la señal, debemos usar la TFCT con una ventana adecuada.
  - Realizar la TFCT y caraterizar. Mostrar espectro con el uso de distintas ventanas (hamming, hanning, kaiser, barlet, haav).

## Punto 4:
  - **[OK]** Calcular frecuencia mínima de muestreo para "trabajar digitalmente" con las señales del discado. Nyquist?

## Punto 5:
  - **[OK]** Señal discreta en `modemDIaling.wav` obtenida con **Fs = 8kHz**. Pasarlo a fracciones de $\pi$ o a $\omega = 2 \pi f$
  - **[OK?]** Generar una tabla para frecuencias de campo discreto (?)

## Punto 6:
  - **[OK?]** Usar `spectrogram` y T.Fourier. Agregar gráficos.
  - **[OK?]** Identificar visualmente e indicar secuencia de dígitos (los simbolos) que corresponden.

## Punto 7:
  - **[OK]** Construir generador (función a desarrollar) de secuencias de discado: 
  - **[OK]** Datos entrada: vector digitos (asociado a frecs. fn y fn'), vector duración digitos, vector duración silencio siguiente.
  - **[OK]** Prototipo: `x = gen_discado(digitos[], tiempo_tono[], tiempo_silencio[])`
  - La señal DTMF generada usarla de test para analizar y decodificar.

## Punto 8:
  - **[OK]** Construir decodificador: señal DTMF a dígitos ('0','1', ... , 'C','D')
  - **[OK]** Usando ejmplo Entrada: myFileDTMF.wav
  - **[OK]** Salida: impresion por pantalla
  - Salida archivo txt los caracteres decodif
  *Tip:* Elevar señal al cuadrado, ventanear con un comparador ( x(t)^2 > umbral == '1' ), calcular DFT, buscar en tabla.

## Punto 9:
  - Decodificar por banco de filtros pasabanda centrado en frecuencias de codificacion DTMF. 
  - (Revisar pasos tentativos en enunciado).

## Punto 10:
  - Transformada Z: diagrama polos y ceros para cada filtro.
  - Graficar fase de respuesta en frecuencia.

## Punto 11 [Opcional]:
  - Agregar a la señal de marcado ruido y pasar por los filtros.
  - Ruido aleatorio: blanco (random vector), voces superpuestas, etc.
  - Testear la inmunidad de los filtros al ruido.