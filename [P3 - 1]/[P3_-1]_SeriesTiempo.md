-   [Introducción](#introduccion)
-   [[Rezagos y operadores en
    diferencia](http://www.economia.unam.mx/biblioteca/redeco/Pdf/Rezagos%20y%20Operadores%20de%20Diferencia.pdf)](#rezagos-y-operadores-en-diferencia)
    -   [Operadores de rezagos](#operadores-de-rezagos)
-   [Descomposición de una serie de
    tiempo](#descomposicion-de-una-serie-de-tiempo)
    -   [Ejemplo](#ejemplo-1)
    -   [Descomposición: ¿aditiva o
        multiplicativa?](#descomposicion-aditiva-o-multiplicativa)
    -   [Ejemplo:](#ejemplo-2)
    -   [Detrend:](#detrend)
    -   [Suavizamiento: Holt-Winters](#suavizamiento-holt-winters)
-   [Modelos de series de tiempo](#modelos-de-series-de-tiempo)
    -   [Ruido blanco](#ruido-blanco)
    -   [Serie estacionaria (en
        covarianza)](#serie-estacionaria-en-covarianza)
-   [Procesos ARMA(p,q)](#procesos-armapq)
-   [El modelo Autorregresivo AR(p)](#el-modelo-autorregresivo-arp)
    -   [Simulación:](#simulacion)
    -   [Prueba de Ljung-Box](#prueba-de-ljung-box)
-   [Proceso de Medias Móviles (MA)](#proceso-de-medias-moviles-ma)
-   [Proceso ARMA](#proceso-arma)
-   [Buscando el *mejor* modelo](#buscando-el-mejor-modelo)
    -   [Ejemplo 1](#ejemplo-1-1)
    -   [Ejemplo 2](#ejemplo-2-1)
    -   [Test de Dickey Fuller](#test-de-dickey-fuller)
-   [Cointegración](#cointegracion)
    -   [Estacionariedad](#estacionariedad)
    -   [Regresión espúrea](#regresion-espurea)
    -   [Estacionariedad](#estacionariedad-1)
    -   [Ejemplo 2](#ejemplo-2-2)
-   [Introducción a los modelos de vectores autorregresivos:
    VAR](#introduccion-a-los-modelos-de-vectores-autorregresivos-var)
    -   [Ejemplo](#ejemplo-7)
-   [Referencias](#referencias)

<script type="text/x-mathjax-config">
    MathJax.Hub.Config({ TeX: { equationNumbers: {autoNumber: "all"} } });
  </script>

------------------------------------------------------------------------

Introducción
============

Una serie de tiempo es una sucesión de variables aleatorias ordenadas de
acuerdo a una unidad de tiempo, *Y*<sub>1</sub>, …, *Y*<sub>*T*</sub>.

¿Por qué usar series de tiempo?

-   Pronósticos
-   Entender el mecanismo de generación de datos (no visible al inicio
    de una investigación)

[Rezagos y operadores en diferencia](http://www.economia.unam.mx/biblioteca/redeco/Pdf/Rezagos%20y%20Operadores%20de%20Diferencia.pdf)
======================================================================================================================================

Operadores de rezagos
---------------------

Definción:

*Δ**Y*<sub>*t* − *i*</sub> = *Y*<sub>*t*</sub> − *Y*<sub>*t* − *i*</sub>

Ejemplos:

*Δ**Y*<sub>*t*</sub> = *Y*<sub>*t*</sub> − *Y*<sub>*t* − 1</sub>

Caso general:

*L*<sup>*j*</sup>*Y*<sub>*t*</sub> = *Y*<sub>*t* − *j*</sub>

Ejemplos:

*L*<sup>1</sup>*Y*<sub>*t*</sub> = *L**Y*<sub>*t*</sub> = *Y*<sub>*t* − 1</sub>
*L*<sup>2</sup>*Y*<sub>*t*</sub> = *Y*<sub>*t* − 2</sub>

*L*<sup>−2</sup>*Y*<sub>*t*</sub> = *Y*<sub>*t* + 2</sub>

*L*<sup>*i*</sup>*L*<sup>*j*</sup> = *L*<sup>*i* + *j*</sup> = *Y*<sub>*t* − (*i* + *j*)</sub>
 \# Manipulando `ts` en \`R

-   Abrir `IPCEcuador.csv`
-   Se puede ver una inflación variable

<!-- -->

    uu <- "https://raw.githubusercontent.com/vmoprojs/DataLectures/master/IPCEcuador.csv"
    datos <- read.csv(url(uu),header=T,dec=".",sep=",")
    IPC <- ts(datos$IPC,start=c(2005,1),freq=12)
    plot(IPC)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-1-1.png)

La serie tiene tendencia creciente. Tratemos de quitar esa tendencia:

    plot(diff(IPC)) # Se puede ver una inlfacion estable
    abline(h=0)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-2-1.png)

Se ha estabilizado, pero podemos hacerlo aún más con el logartimo de la
diferencia:

    plot(diff(log(IPC))) #Tasa de variacion del IPC

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-3-1.png)

La serie no tiene tendecia y es estable. Ahora, si deseo trabajar con un
subconjunto de datos, puedo...

    # Solo quiero trabajar con los datos de agosto 2008
    IPC2 <- window(IPC,start=c(2008,8),freq=1)
    plot(IPC2)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-4-1.png)

    # IPC de todos los diciembres
    IPC.dic <- window(IPC,start=c(2005,12),freq=T)
    plot(IPC.dic)
    points(IPC.dic)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-4-2.png)

Si tengo mensuales y necsito trabajar con el IPC anual:

    aggregate(IPC)

    ## Time Series:
    ## Start = 2005 
    ## End = 2012 
    ## Frequency = 1 
    ## [1] 1213.09 1241.75 1262.13 1349.24 1399.26 1435.96 1491.87 1542.53

A continuación algunas transformaciones frecuentes y su
[interpretación](https://www.ucm.es/data/cont/docs/518-2013-10-25-Tema_6_EctrGrado.pdf):

<table>
<colgroup>
<col width="43%" />
<col width="56%" />
</colgroup>
<thead>
<tr class="header">
<th>Transformación</th>
<th>Interpretación</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><span class="math inline"><em>z</em><sub><em>t</em></sub> = ∇<em>y</em><sub><em>t</em></sub> = <em>y</em><sub><em>t</em></sub> − <em>y</em><sub><em>t</em> − 1</sub></span></td>
<td>Cambio en <span class="math inline"><em>y</em><sub><em>t</em></sub></span>. Es un indicador de crecimiento absoluto.</td>
</tr>
<tr class="even">
<td><span class="math inline">$z_t=ln(y_t)-ln(y_{t-1})\approx \frac{y_t-y_{t-1}}{y_{t-1}}$</span></td>
<td>Es la tasa logarítmica de variación de una variable. Es un indicador de crecimiento relativo. Si se multiplica por 100 es la tasa de crecimiento porcentual de la variable</td>
</tr>
<tr class="odd">
<td><span class="math inline"><em>z</em><sub><em>t</em></sub> = ∇[<em>l</em><em>n</em>(<em>y</em><sub><em>t</em></sub>)−<em>l</em><em>n</em>(<em>y</em><sub><em>t</em> − 1</sub>)]</span></td>
<td>Es el cambio en la tasa logarítmica de variación de una variable. Es un indicador de la aceleración de la tasa de crecimiento relativo de una variable.</td>
</tr>
</tbody>
</table>

### Ejemplo

Veamos un gráfico más interesante usando un conjunto de datos anterior,
vamos a:

-   Abrir la base `estadísticas Turismo.csv`
-   Agregar de manera mensual
-   Convertir a `ts` y graficar

<!-- -->

    uu <- "https://raw.githubusercontent.com/vmoprojs/DataLectures/master/estadisticas%20Turismo.csv"
    datos<-read.csv(url(uu),header=T,dec=".",sep=";")
    attach(datos)

    # Visitas a Areas Naturales Protegidas

    # Sumar por mes y año

    mensual<-aggregate(TOTALMENSUAL,by=list(mesnum,Year),FUN="sum") # Los datos sin mes es el total de ese anio

    TOTALmensual<-ts(mensual[,3],start=c(2006,1),freq=12)
    plot(TOTALmensual)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-6-1.png)

Se ve una tendencia creciente y también una cierta estacionalidad.
Veamos la misma serie en gráficos más atractivos:

    library(latticeExtra)
    library(RColorBrewer)
    library(lattice)
    xyplot(TOTALmensual)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-7-1.png)

    asTheEconomist(xyplot(TOTALmensual,
                          main="TOTAL VISITAS MENUSALES \n AREAS PROTEGIDAS")
                   ,xlab="Year_mes",ylab="Visitantes")

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-7-2.png)

Descomposición de una serie de tiempo
=====================================

Componentes

-   Tendencia-ciclo: representa los cambios de largo plazo en el nivel
    de la serie de tiempo
-   Estacionalidad: Caracteriza fluctuaciones periódicas de longitud
    constante causadas por factores tales como temperatura, estación del
    año, periodo vacacional, políticas, etc.

*Y*<sub>*t*</sub> = *f*(*S*<sub>*t*</sub>, *T*<sub>*t*</sub>, *E*<sub>*t*</sub>)
 donde *Y*<sub>*t*</sub> es la serie observada, *S*<sub>*t*</sub> es el
componente estacional, *T*<sub>*t*</sub> es la tendencia y
*E*<sub>*t*</sub> es el término de error.

La forma de *f* en la ecuación anterior determina tipos de
[descomposiciones](https://seriesdetiempo.files.wordpress.com/2012/08/descomposicic3b3n-de-series-de-tiempo-base-cap-3-makridakis-et-al-fe-ago-2012.pdf):

<table>
<thead>
<tr class="header">
<th>Descomposición</th>
<th>Expresión</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Aditiva</td>
<td><span class="math inline"><em>Y</em><sub><em>t</em></sub> = <em>S</em><sub><em>t</em></sub> + <em>T</em><sub><em>t</em></sub> + <em>E</em><sub><em>t</em></sub></span></td>
</tr>
<tr class="even">
<td>Multiplicativa</td>
<td><span class="math inline"><em>Y</em><sub><em>t</em></sub> = <em>S</em><sub><em>t</em></sub> * <em>T</em><sub><em>t</em></sub> * <em>E</em><sub><em>t</em></sub></span></td>
</tr>
<tr class="odd">
<td>Transformación logaritmica</td>
<td><span class="math inline"><em>l</em><em>o</em><em>g</em>(<em>Y</em><sub><em>t</em></sub>)=<em>l</em><em>o</em><em>g</em>(<em>S</em><sub><em>t</em></sub>)+<em>l</em><em>o</em><em>g</em>(<em>T</em><sub><em>t</em></sub>)+<em>l</em><em>o</em><em>g</em>(<em>E</em><sub><em>t</em></sub>)</span></td>
</tr>
<tr class="even">
<td>Ajuste estacional</td>
<td><span class="math inline"><em>Y</em><sub><em>t</em></sub> − <em>S</em><sub><em>t</em></sub> = <em>T</em><sub><em>t</em></sub> + <em>E</em><sub><em>t</em></sub></span></td>
</tr>
</tbody>
</table>

### Ejemplo

    visitas.descompuesta<-decompose(TOTALmensual, type="additive")
    plot(visitas.descompuesta)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-8-1.png)

Dentro de `visitas.decompuesta` tenemos los siguientes elementos:

-   `$x` = serie original
-   `$seasonal` = componente estacional de los datos EJ: en marzo hay un
    decremento de 2502 (para cada dato)
-   `$trend` = tendencia
-   `$random` = visitas no explicadas por la tendencia o la
    estacionalidad
-   `$figure` = estacionalidad (mismo que `seasonal` pero sin
    repetición)

### Descomposición: ¿aditiva o multiplicativa?

Visualmenete:

-   Aditivo:
    -   las fluctuaciones estacionales lucen aproximadamente constantes
        en tamaño con el tiempo y
    -   no parecen depender del nivel de la serie temporal,
    -   y las fluctuaciones aleatorias también parecen ser más o menos
        constantes en tamaño a lo largo del tiempo
-   Multiplicativo
    -   Si el efecto estacional tiende a aumentar a medida que aumenta
        la tendencia
    -   la varianza de la serie original y la tendencia aumentan con el
        tiempo

Forma alternativa de elegir: ver cuál es la que tiene un componente
aleatorio menor.

### Ejemplo:

Los datos en el archivo `wine.dat` son ventas mensuales de vino
australiano por categoría, en miles de litros, desde enero de 1980 hasta
julio de 1995. Las categorías son blanco fortificado (`fortw`), blanco
seco (`dryw`), blanco dulce (`sweetw`), rojo (`red`), rosa (`rose`) y
espumoso (`spark`).

    direccion<- "https://raw.githubusercontent.com/dallascard/Introductory_Time_Series_with_R_datasets/master/wine.dat"
    wine<-read.csv(direccion,header=T,sep="")
    attach(wine)
    head(wine)

    ##   winet fortw dryw sweetw  red rose spark
    ## 1     1  2585 1954     85  464  112  1686
    ## 2     2  3368 2302     89  675  118  1591
    ## 3     3  3210 3054    109  703  129  2304
    ## 4     4  3111 2414     95  887   99  1712
    ## 5     5  3756 2226     91 1139  116  1471
    ## 6     6  4216 2725     95 1077  168  1377

    dulce <- ts(sweetw,start=c(1980,12), freq=12)
    plot(dulce)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-9-1.png)

Tratemos la serie como un caso aditivo:

En funcion del grafico de la variable, se decide el "type" de la
descomposicion La estacionalidad tiene valores negativos porque se
plantea respecto de la tendencia

    dulce.descompuesta<-decompose(dulce, type="additive") 
    plot(dulce.descompuesta)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-10-1.png)

    a<-dulce.descompuesta$trend[27] # La tendencia era de 130 en mayo del 82
    b<-dulce.descompuesta$seasonal[27] # El componente de la estacionalidad era este
    c<-dulce.descompuesta$random[27]  # Es el componente aleatorio

    a+b+c # La sumatoria de la descomposicion de la serie da el valor real, si es aditiva

    ## [1] 127

Veamos el caso multiplicativo:

    # Multiplicativa
    dulce.descompuesta1<-decompose(dulce, type="multiplicative")
    plot(dulce.descompuesta1)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-11-1.png)

    a<-dulce.descompuesta1$trend[27] # La tendencia era de 130 en mayo del 82
    b<-dulce.descompuesta1$seasonal[27] # El componente de la estacionalidad era este
    c<-dulce.descompuesta1$random[27]  # Es el componente aleatorio

    a*b*c # La sumatoria de la descomposicion de la serie da el valor real, si es aditiva

    ## [1] 127

Veamos la forma alternativa de elección:

    u1<-var(dulce.descompuesta$random,na.rm=T)
    u2<-var(dulce.descompuesta1$random,na.rm=T)
    cbind(u1,u2)

    ##            u1         u2
    ## [1,] 1970.235 0.02247602

Se escoge la multiplicativa en este caso.

### Detrend:

Las series se ofrecen generalmente sin tendencia ni estacionalidad.
Veamos la serie sin tendencia:

    dulce.detrended <- dulce-dulce.descompuesta$trend
    plot(dulce.detrended)
    abline(h=0)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-14-1.png)

Parece ser que hay un cambio en la varianza desde el 85.

Si descomponemos multiplicativamente en vez de restar se debe dividir.

    plot(dulce-dulce.descompuesta$trend)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-15-1.png)

    plot(dulce/dulce.descompuesta1$trend)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-15-2.png)

Existen formas de descomponer más sofisticadas, por ejemplo, usando la
función `stl`.

    dulce.stl<-stl(dulce,s.window="per")
    plot(dulce.stl)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-16-1.png)

En este caso el calculo de la tendencia cambia, se calcula con formas no
paramétricas. La barra del final es la desviacion estándar.

Suavizamiento: Holt-Winters
---------------------------

El método se resume en las fórmulas siguientes:

El método de Holt-Winters generaliza el método de suavizamiento
exponencial.

### Ejemplo

Veamos un modelo más sencillo:

    dulce.se <- HoltWinters(dulce,beta=0,gamma=0)
    plot(dulce.se) 

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-17-1.png)

Es un suavizamiento HW sin tendencia y sin componente estacional. La
serie roja son los datos con suavizamiento exponencial y la negra son
los observados. `R` buscó el alpha que le pareció apropiado.

Usemos un alpha deliberado:

    dulce.se1 <- HoltWinters(dulce,alpha=0.8,beta=0,gamma=0)
    plot(dulce.se1)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-18-1.png)

¿Qué pasó con los errores?

    dulce.se$SSE # Suma de los residuos al cuadrado (de un paso)

    ## [1] 963408.2

    dulce.se1$SSE # Suma de los residuos al cuadrado (de un paso)

    ## [1] 1132577

Es decir, el criterio para la busqueda de los parámetros es la
minimización del SSE.

### Ejemplo

Total mensual de pasajeros (en miles) de líneas aéreas internacionales,
de 1949 a 1960.

    data(AirPassengers)
    str(AirPassengers)

    ##  Time-Series [1:144] from 1949 to 1961: 112 118 132 129 121 135 148 148 136 119 ...

    plot(AirPassengers)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-20-1.png)

Se aprecia tendencia y variabilidad. Podemos usar HW para predicción:

    ap.hw<- HoltWinters(AirPassengers,seasonal="mult")
    plot(ap.hw)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-21-1.png)

    ap.prediccion <- predict(ap.hw,n.ahead=48)
    ts.plot(AirPassengers,ap.prediccion,lty=1:2,
    col=c("blue","red"))

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-21-2.png)

Modelos de series de tiempo
===========================

Ruido blanco
------------

Una serie (*ϵ*<sub>*t*</sub>, *t* ∈ ℤ) se dice que es Ruido Blanco si
cumple

-   *E*(*ϵ*<sub>*t*</sub>)=0 (media cero)
-   *V**a**r*(*ϵ*<sub>*t*</sub>)=*σ*<sup>2</sup> (varianza constante)
-   ∀*k* ≠ 0, *C**o**v*(*ϵ*<sub>*t*</sub>, *ϵ*<sub>*t* + *k*</sub>)=0
    (Incorrelación)

Si además cumple que *ϵ*<sub>*t*</sub> ∼ *N*(0, *σ*<sup>2</sup>) se dice
que *ϵ*<sub>*t*</sub> es Ruido Blanco Gaussiano (RBG).

    n   <-200
    mu  <- 0
    sdt <- 3
    w <- rnorm(n,mu,sdt)

¿Cómo se si algo tiene ruido blanco? : Analizo la función de
autocorrelación muestral.

$$
\\hat\\rho\_k = \\frac{\\hat\\gamma\_k}{\\hat\\gamma\_0}
$$
 donde
$$
\\hat\\gamma\_k = \\frac{\\sum(Y\_t-\\bar{Y})(Y\_{t-k}-\\bar{Y})}{n}
$$
$$
\\hat\\gamma\_0 = \\frac{\\sum(Y\_t-\\bar{Y})^2}{n}
$$

Se asume que $\\hat\\rho\_k \\sim N(0,1/n)$. Es decir:

$$
\\hat\\rho\_k = \\frac{\\sum\_{t=k+1}^{T}(Y\_t-\\bar{Y})(Y\_{t-k}-\\bar{Y})}{\\sum\_{t=1}^{T}(Y\_t-\\bar{Y})^2}
$$

    acf(w)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-23-1.png)

Si se sale de las franjas, si hay correlación y no hay ruido blanco

Serie estacionaria (en covarianza)
----------------------------------

Una serie (*Y*<sub>*t*</sub>, *t* ∈ *Z*) se dice estacionaria en
covarianza o simplemente estacionaria si cumple dos condiciones:

1.  *E*(*Y*<sub>*t*</sub>)=*μ*
2.  *C**o**v*(*Y*<sub>*t*<sub>1</sub></sub>, *Y*<sub>*t*<sub>2</sub></sub>)=*R*(*t*<sub>2</sub> − *t*<sub>1</sub>)
    con *R* función par (*f*(−*x*)=*f*(*x*))

Es decir, la covarianza entre *Y*<sub>*t*<sub>1</sub></sub> y
*Y*<sub>*t*<sub>2</sub></sub> depende únicamente de la distancia entre
los tiempo *t*<sub>2</sub> y *t*<sub>1</sub>,
|*t*<sub>2</sub> − *t*<sub>1</sub>|.

Procesos ARMA(p,q)
==================

En los modelos de descomposición
*Y*<sub>*t*</sub> = *T*<sub>*t*</sub> + *S*<sub>*t*</sub> + *ϵ*<sub>*t*</sub>,
*t* = 1, 2, … se estima $\\hat\\epsilon\_t$ y se determina si es o no
ruido blanco mediante, por ejemplo, las pruebas LjungBox y DurbinWatson.

En caso de encontrar que $\\hat\\epsilon\_t$ no es ruido blanco, el
siguiente paso es modelar esta componente mediante tres posibles
modelos:

1.  Medias Móviles de orden *q*, *M**A*(*q*).
2.  Autorregresivos de orden *q*, *A**R*(*p*).
3.  Medias Móviles Autorregresivos, *A**R**M**A*(*p*, *q*).

El modelo Autorregresivo AR(p)
==============================

Se dice que *Y*<sub>*n*</sub>, *n* ∈ ℤ sigue un proceso *A**R*(*p*) de
media cero si

*Y*<sub>*t*</sub> = *ϕ*<sub>1</sub>*Y*<sub>*t* − 1</sub> + *ϕ*<sub>2</sub>*Y*<sub>*t* − 2</sub> + ⋯ + *ϕ*<sub>*p*</sub>*Y*<sub>*t* − *p*</sub> + *ϵ*<sub>*t*</sub>

donde *ϵ*<sub>*t*</sub> ∼ *R**B*(0, *σ*<sup>2</sup>) y *p* = 1, 2, ….
Usando el operador de rezago *L* se puede escribir como:

*ϕ*<sub>*p*</sub>(*L*)(*Y*<sub>*n*</sub>)=*ϵ*<sub>*n*</sub>

con
*ϕ*<sub>*p*</sub>(*z*)=1 − *ϕ*<sub>1</sub>*z* − *ϕ*<sub>2</sub>*z*<sup>2</sup> − ⋯ − *ϕ*<sub>*p*</sub>*z*<sup>*p*</sup>,el
polinomio autorregresivo.

**Condición Suficiente para que un *A**R*(*p*) sea Estacionario en
Covarianza**

La condición suficiente para que *Y*<sub>*t*</sub> ∼ *A**R*(*p*) sea
estacionario en covarianza es que las *p* raíces de la ecuación
*ϕ*<sub>*p*</sub>(*z*)=0, *z*<sub>*i*</sub>, *i* = 1, 2, …, *p* cumplan

|*z*<sub>*i*</sub>|&gt;1.

En palabras, la condición $\\ref{eq2}$ se describe como *para que un
proceso autorregresivo de orden *p* sea estacionario en covarianza, es
suficiente que las raíces del polinomio autorregresivo estén por fuera
del círculo unitario*

Si el proceso *Y*<sub>*t*</sub> es estacionario en covarianza se cumple
que su media es constante, *Y*<sub>*t*</sub> = *μ*

**Propiedades**

1.  *E*(*Y*<sub>*t*</sub>)=0
2.  $\\sum\_{j=1}^{p}\\phi\_j&lt;1$

<!-- Proceso estocástico autoregresivo de primer orden -->
<!-- \begin{eqnarray} -->
<!-- (Y_{t}-\delta) = \alpha_{1}(Y_{t-1}-\delta)+u_{t} \nonumber -->
<!-- \end{eqnarray} -->
<!-- Donde $\delta$ es la media de $Y$ y $u_{i}$ es un ruido blanco no correlacionado. -->
Trabajaremos con datos de *M*1
([WCURRNS](https://fred.stlouisfed.org/series/WCURRNS) dinero en
circuación fuera de los Estados Unidos) semanales de los Estados Unidos
desde enero de 1975.

    uu <- "https://raw.githubusercontent.com/vmoprojs/DataLectures/master/WCURRNS.csv"
    datos <- read.csv(url(uu),header=T,sep=";")
    names(datos)

    ## [1] "DATE"  "VALUE"

    attach(datos)
    value.ts <- ts(VALUE, start=c(1975,1),freq=54)
    ts.plot(value.ts)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-24-1.png)

Estacionariedad: La serie es estacionaria si la varianza no cambia

    acf(value.ts)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-25-1.png)

Esta es la marca de una serie que NO es estacionaria, dado que la
autocorrelación decrece muy lentamente.

    plot(stl(value.ts,s.window="per"))  

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-26-1.png)

Una forma de trabajar con una serie esacionaria es quitarle el *trend*

    valuetrend<- value.ts- stl(value.ts,s.window="per")$time.series[,2]
    plot(valuetrend)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-27-1.png)

*Reminder* es lo que queda sin tendencia ni estacionalidad

    valuereminder<-
    stl(value.ts,s.window="per")$time.series[,3]

Veamos cómo quedo la serie:

    acf(valuereminder)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-29-1.png)

Se puede decir que la hicimos una serie estacionaria

Otra forma de hacer estacionaria una serie es trabajar con las
diferencias

    acf(diff(value.ts))

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-30-1.png)

Nos indica que hay una estructura en la serie que no es ruido blanco
pero SI estacionaria (cae de 1 a "casi"" cero)

### Simulación:

El siguiente paso es modelar esta estructura. Un modelo para ello es un
modelo autorregresivo. Simular un *A**R*(1).

    y <- arima.sim(list(ar=c(0.99),sd=1),n=200)
    plot(y)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-31-1.png)

    acf(y)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-31-2.png)

¿Cuáles son los parámetros del `arima.sim`? Hemos simulado
*Y*<sub>*t*</sub> = *ϕ*<sub>0</sub> + *ϕ*<sub>1</sub>*Y*<sub>*t* − 1</sub> = *ϕ*<sub>0</sub> + 0.99*Y*<sub>*t* − 1</sub>.

Simulemos el modelo:
*Y*<sub>*t*</sub> = 0.5*Y*<sub>*t* − 1</sub> − 0.7*Y*<sub>*t* − 2</sub> + 0.6*Y*<sub>*t* − 3</sub>

    ar3 <- arima.sim(n=200,list(ar=c(0.5,-0.7,0.6)),sd=5) 
    ar3.ts = ts(ar3)
    plot(ar3.ts)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-32-1.png)

    acf(ar3)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-32-2.png)

Las autocorrelaciones decaen exponencialemente a cero

**Autocorrelaciones parciales**: nos ayunda a determinar el orden del
modelo.

La autocorrelación parcial es la correlación entre *Y*<sub>*t*</sub> y
*Y*<sub>*t* − *k*</sub> después de eliminar el efecto de las *Y*
intermedias.

**Definición** Suponga que (*Y*<sub>*t*</sub>, *t* ∈ *Z*) es
estacionaria. La pacf muestral es una función de *k*,

1.  $\\hat{\\alpha}(1)=\\hat\\rho(1)$
2.  $\\hat{\\alpha}(2)$: se regresa *Y*<sub>*t*</sub> sobre
    *Y*<sub>*t* − 1</sub> y *Y*<sub>*t* − 2</sub> tal que
    *Y*<sub>*t*</sub> = *ϕ*<sub>21</sub>*Y*<sub>*t* − 1</sub> + *ϕ*<sub>22</sub>*Y*<sub>*t* − 2</sub> + *ϵ*<sub>*t*</sub>
    entonces $\\hat{\\alpha}(2)=\\phi\_{22}$
3.  $\\hat{\\alpha}(k)$: se regresa *Y*<sub>*t*</sub> sobre
    *Y*<sub>*t* − 1</sub>…*Y*<sub>*t* − *k*</sub> tal que
    *Y*<sub>*t*</sub> = *ϕ*<sub>*k*1</sub>*Y*<sub>*t* − 1</sub> + … + *ϕ*<sub>*k**k*</sub>*Y*<sub>*t* − 2</sub> + *ϵ*<sub>*t*</sub>
    entonces $\\hat{\\alpha}(k)=\\phi\_{kk}$

En los datos de series de tiempo, una gran proporción de la correlación
entre *Y*<sub>*t*</sub> y *Y*<sub>*t* − *k*</sub> puede deberse a sus
correlaciones con los rezagos intermedios
*Y*<sub>1</sub>, *Y*<sub>2</sub>, …, *Y*<sub>*t* − *k* + 1</sub>. La
correlación parcial elimina la influencia de estas variables
intermedias.

    pacf(ar3) 

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-33-1.png)

    ar(ar3)$aic

    ##          0          1          2          3          4          5 
    ## 160.714149 161.441530  75.238078   2.034397   1.526842   1.367533 
    ##          6          7          8          9         10         11 
    ##   1.953525   1.466039   3.429412   5.424623   6.329208   0.000000 
    ##         12         13         14         15         16         17 
    ##   1.258117   1.727323   3.009122   4.971836   6.873873   8.790469 
    ##         18         19         20         21         22         23 
    ##  10.783535  12.754019   9.050400  11.041620  12.579505  14.203012

La tercera autocorrelación es la que esta fuera de las bandas, esto
indica que el modelo es un AR(3)

#### Ejemplo

Datos: precio de huevos desde 1901

    uu <- "https://raw.githubusercontent.com/vmoprojs/DataLectures/master/PrecioHuevos.csv"
    datos <- read.csv(url(uu),header=T,sep=";")
    ts.precio <- ts(datos$precio,start=1901)
    plot(ts.precio)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-34-1.png)

Veamos las autocorrelaciones:

    par(mfrow=c(2,1))
    acf(ts.precio)
    pacf(ts.precio)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-35-1.png)

    par(mfrow=c(1,1))

Las auto si decaen, no lo hacen tan rápido. No se puede decir si es
estacionario o no.

Evaluemos un modelo:

    modelo1 <- arima(ts.precio, order=c(1,0,0))
    print(modelo1)

    ## 
    ## Call:
    ## arima(x = ts.precio, order = c(1, 0, 0))
    ## 
    ## Coefficients:
    ##          ar1  intercept
    ##       0.9517   195.5066
    ## s.e.  0.0310    48.1190
    ## 
    ## sigma^2 estimated as 712.3:  log likelihood = -443.28,  aic = 892.56

    modelo1$var.coef

    ##                     ar1    intercept
    ## ar1        0.0009588394   -0.1532017
    ## intercept -0.1532017342 2315.4371739

¿Qué nos recomienda `R`?

    ar.precio <- ar(ts.precio)
    ar.precio

    ## 
    ## Call:
    ## ar(x = ts.precio)
    ## 
    ## Coefficients:
    ##      1  
    ## 0.9237  
    ## 
    ## Order selected 1  sigma^2 estimated as  975.9

Analicemos los residuos

    residuos = ar.precio$resid
    # Los residuos debe estar sin ninguna estructura
    par(mfrow = c(2,1))
    plot(residuos)
    abline(h=0,col="red")
    abline(v=1970,col="blue")
    acf(residuos,na.action=na.pass)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-38-1.png)

### Prueba de Ljung-Box

La prueba de Ljung-Box se puede definir de la siguiente manera.

*H*<sub>0</sub>: Los datos se distribuyen de forma independiente (es
decir, las correlaciones en la población de la que se toma la muestra
son 0, de modo que cualquier correlación observada en los datos es el
resultado de la aleatoriedad del proceso de muestreo).

*H*<sub>*a*</sub>: Los datos no se distribuyen de forma independiente.

La estadística de prueba es:

$$
Q=n\\left(n+2\\right)\\sum \_{k=1}^{h}{\\frac {{\\hat {\\rho }}\_{k}^{2}}{n-k}}
$$

donde n es el tamaño de la muestra, $\\hat\\rho\_{k}$ es la
autocorrelación de la muestra en el retraso k y h es el número de
retardos que se están probando. Por nivel de significación *α*, la
región crítica para el rechazo de la hipótesis de aleatoriedad es
*Q* &gt; *χ*<sub>1 − *α*, *h*</sub><sup>2</sup>

donde *χ*<sub>1 − *α*, *h*</sub><sup>2</sup> es la *α*-cuantil de la
distribución chi-cuadrado con *m* grados de libertad.

La prueba de Ljung-Box se utiliza comúnmente en autorregresivo integrado
de media móvil de modelado (ARIMA). Tenga en cuenta que se aplica a los
residuos de un modelo ARIMA equipada, no en la serie original, y en
tales aplicaciones, la hipótesis de hecho objeto del ensayo es que los
residuos del modelo ARIMA no tienen autocorrelación. Al probar los
residuales de un modelo ARIMA estimado, los grados de libertad deben ser
ajustados para reflejar la estimación de parámetros. Por ejemplo, para
un modelo *A**R**I**M**A*(*p*, 0, *q*), los grados de libertad se debe
establecer en *h* − *p* − *q*.

    Box.test(residuos,lag=20,type="Ljung")

    ## 
    ##  Box-Ljung test
    ## 
    ## data:  residuos
    ## X-squared = 20.526, df = 20, p-value = 0.4255

*H**o*: Ruido Blanco ¿Es ruido blanco?

Probemos un segundo modelo

    modelo2 <- arima(ts.precio, order=c(2,0,0))
    print(modelo2)

    ## 
    ## Call:
    ## arima(x = ts.precio, order = c(2, 0, 0))
    ## 
    ## Coefficients:
    ##          ar1     ar2  intercept
    ##       0.8456  0.1134   193.5287
    ## s.e.  0.1026  0.1046    53.9009
    ## 
    ## sigma^2 estimated as 703:  log likelihood = -442.7,  aic = 893.4

Comparemos los resultados:

    ar2.precio <- ar(ts.precio,FALSE,2)
    ar2.precio$aic

    ##          0          1          2 
    ## 178.338243   0.000000   1.869475

    modelo2$aic

    ## [1] 893.401

    modelo1$aic

    ## [1] 892.563

Se escoge el modelo de menor AIC.

Proceso de Medias Móviles (MA)
==============================

Recordemos el polinomio de rezagos:

*B*<sub>*p*</sub>(*L*) = *β*<sub>0</sub> + *β*<sub>1</sub>*L* + *β*<sub>2</sub>*L*<sup>2</sup> + ⋯ + +*β*<sub>*p*</sub>*L*<sup>*p*</sup>

combinados con una serie de tiempo:

*B*<sub>*p*</sub>(*L*)(*Y*<sub>*t*</sub>)=(*β*<sub>0</sub> + *β*<sub>1</sub>*L* + *β*<sub>2</sub>*L*<sup>2</sup> + ⋯ + +*β*<sub>*p*</sub>*L*<sup>*p*</sup>)(*Y*<sub>*t*</sub>)

$$
B\_p{(L)}(Y\_t) =\\sum\_{j=0}^{p}\\beta\_jL^jY\_t
$$
$$
B\_p{(L)}(Y\_t) =\\sum\_{j=0}^{p}\\beta\_jL^jY\_t
$$

**Definición**

Se dice que una serie *Y*<sub>*t*</sub> sigue un proceso *M**A*(*q*),
*q* = 1, 2, … de media móvil de orden *q*, si se cumple que

*Y*<sub>*t*</sub> = *ϵ*<sub>*t*</sub> + *θ*<sub>1</sub>*ϵ*<sub>*t* − 1</sub> + ⋯ + *θ*<sub>*q*</sub>*ϵ*<sub>*t* − *q*</sub>
 para constantes *θ*<sub>1</sub>, …, *θ*<sub>*p*</sub> y
*ϵ*<sub>*t*</sub> ∼ *N*(0, *σ*<sup>2</sup>). La expresión con el
operador *L* es, si se define el polinomio.

*θ*<sub>*p*</sub>(*L*)=1 + *θ*<sub>1</sub>*L* + ⋯ + *θ*<sub>*q*</sub>*L*<sup>*q*</sup>

entonces la ecuación queda
*Y*<sub>*t*</sub> = *θ*<sub>*q*</sub>(*L*)(*ϵ*<sub>*t*</sub>)

**Propiedades**

1.  *E*(*Y*<sub>*t*</sub>)=0
2.  *V**a**r*(*Y*<sub>*t*</sub>)=(1 + *θ*<sub>1</sub><sup>2</sup> + ⋯ + *θ*<sub>*q*</sub><sup>2</sup>)*σ*<sup>2</sup>

luego *V**a**r*(*Y*<sub>*t*</sub>)&gt;*V**a**r*(*ϵ*<sub>*t*</sub>), en
general. 3.
*C**o**v*(*Y*<sub>*t*</sub>, *Y*<sub>*t* + *k*</sub>)=*R*(*k*), donde

$$
R(K) = \\sigma^2\\sum\_{j=0}^{q-k}\\theta\_j\\theta\_{j+k}\\label{cov}
$$

donde *θ*<sub>0</sub> = 1 y *k* &lt; *q* + 1. *R*(*K*)=0 si
*k* ≥ *q* + 1.

1.  Un *M**A*(*q*) siempre es un proceso estacionario con ACF,
    $p(k)=\\frac{R(k)}{R(0)}$

La ecuación $\\eqref{cov}$ se puede interpretar como una indicación de
que un *M**A*(*q*) es un proceso d´ebilmente correlacionado, ya que su
autocovarianza es cero a partir de un valor. Por esta razón se puede ver
los procesos *M**A*(*q*) como alternativas al Ruido Blanco completamente
incorrelacionado.

**Ejemplo**

Sea *Y*<sub>*t*</sub> ∼ *M**A*(2) dado por:

*y*<sub>*t*</sub> = *ϵ*<sub>*t*</sub> + *θ*<sub>1</sub>*ϵ*<sub>*t* − 1</sub> + *θ*<sub>2</sub>*ϵ*<sub>*t* − 2</sub>
 donde *ϵ*<sub>*t*</sub> ∼ *N*(0, 9), con
*θ*<sub>1</sub> = −0.4,*θ*<sub>2</sub> = 0.4.

De acuerdo con $\\eqref{cov}$, si la fac muestral de una serie Yt
termina abruptamente puede tratarse de un *M**A*(*q*).

Simulemos un modelo:

    simulcion.ma <- arima.sim(200,model=list(ma=c(0.8)))
    plot(simulcion.ma)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-42-1.png)

    acf(simulcion.ma)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-42-2.png)

    pacf(simulcion.ma)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-42-3.png)

-   Las *p* primeras autocorrelaciones van a ser diferentes de cero
-   La autocorrelación parcial decae exponencialmente

Veamos otro ejemplo

    simulcion.ma1 <- arima.sim(200, model =list(ma=c(2.1,-0.9,4.7)))
    plot(simulcion.ma1)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-43-1.png)

    acf(simulcion.ma1)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-43-2.png)

    pacf(simulcion.ma1)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-43-3.png)

Proceso ARMA
============

**Definición**

Un proceso *Y**t* ∼ *A**R**M**A*(*p*, *q*) se define mediante

*ϕ*<sub>*p*</sub>(*L*)(*Y*<sub>*t*</sub>)=*θ*<sub>*q*</sub>(*L*)*ϵ*<sub>*t*</sub>
 donde *ϵ*<sub>*t*</sub> ∼ *R**B*(0, *σ*<sup>2</sup>) y
$\\phi\_p(z)=1-\\sum\_{j=1}^{p}\\phi\_jz^j$,
$\\theta\_q(z)=1+\\sum\_{j=1}^q\\theta\_jz^j$ son los polinomios
autorregresivo y de media móvil respectivamente.

se asume que las raíces de las ecuaciones *ϕ*<sub>*p*</sub>(*z*)=0 y
*θ*<sub>*q*</sub>(*z*)=0 están fuera del círculo unitario. Además se
asume que estos polinomios no tienen raíces en común. Si se cumplen
estas condiciones el proceso *Y**t* ∼ *A**R**M**A*(*p*, *q*) es
estacionario e identificable.

Simulemos el proceso:

    simulcion.ma2 <- arima.sim(1000, model=list(order=c(1,0,1),ar=c(-0.1),ma=c(0.1)))
    plot(simulcion.ma2)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-44-1.png)

    acf(simulcion.ma2)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-44-2.png)

    pacf(simulcion.ma2)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-44-3.png)

Buscando el *mejor* modelo
==========================

### Ejemplo 1

Datos: Serie de tiempo (1952-1988) del ingreso nacional real en China
por sector (año base: 1952)

    library(AER)
    data(ChinaIncome)
    str(ChinaIncome)

    ##  Time-Series [1:37, 1:5] from 1952 to 1988: 100 102 103 112 116 ...
    ##  - attr(*, "dimnames")=List of 2
    ##   ..$ : NULL
    ##   ..$ : chr [1:5] "agriculture" "commerce" "construction" "industry" ...

    transporte <- ChinaIncome[,"transport"]
    ts.plot(transporte)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-45-1.png)

Parece no ser estacionario. Hacemos una transformación para tratar de
confirmar la estacionariedad.

    ltrans <- log(transporte)
    ts.plot(ltrans)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-46-1.png)

Notamos que persiste el porblema, sigue sin ser estacionario. Probemos
con la diferencia:

    dltrans <- diff(ltrans)
    ts.plot(dltrans)
    abline(h=0)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-47-1.png)

Asumamos estacionariedad (después haremos una prueba específica para
verificar estacionariedad) y busquemos el mejor modelo.

Usaremos el `acf` y el `pacf` para evaluar si es MA o AR.

    acf(dltrans)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-48-1.png)

    pacf(dltrans)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-48-2.png)

Ajustando según la gráfica, tendríamos un proceso *M**A*(2)

¿Qué recomienda `R`?

    ar(dltrans)$aic

    ##         0         1         2         3         4         5         6 
    ##  8.140754  5.473906  1.951624  0.000000  1.990078  3.975236  5.400529 
    ##         7         8         9        10        11        12        13 
    ##  6.622877  6.428684  8.083145  9.975465 10.326488 12.291432 14.227677 
    ##        14        15 
    ## 16.183322 17.644775

Según esta recomendación, estamos ante un proceso *A**R*(3).

    modelo1 <- arima(dltrans,order = c(3,0,0))
    modelo1$aic

    ## [1] -32.75694

Ajustemos el *M**A*(2) y comparemos:

    modelo2 <- arima(dltrans,order = c(0,0,2))
    modelo2$aic

    ## [1] -28.01574

Recuerda: Un menor AIC es mejor. ¿Con qué modelo te quedas?

Ajustemos un *M**A*(3):

    modelo3 <- arima(dltrans,order = c(0,0,3))
    print(modelo3)

    ## 
    ## Call:
    ## arima(x = dltrans, order = c(0, 0, 3))
    ## 
    ## Coefficients:
    ##          ma1      ma2      ma3  intercept
    ##       0.1763  -0.4596  -0.7167     0.0621
    ## s.e.  0.1883   0.1640   0.1925     0.0053
    ## 
    ## sigma^2 estimated as 0.01625:  log likelihood = 21.26,  aic = -32.53

    modelo3$aic

    ## [1] -32.52547

Este modelo es mejor que el *M**A*(2), pero peor que *A**R*(3).

Probemos algunas combinaciones

    # Ajustando un ARMA(1,1)
    modelo4 <- arima(dltrans,order = c(1,0,1))
    modelo4$aic

    ## [1] -27.49033

    # Ajustando un ARMA(2,1)
    modelo5 <- arima(dltrans,order = c(2,0,1))
    modelo5$aic

    ## [1] -32.45195

    # Ajustando un ARMA(1,2)
    modelo6 <- arima(dltrans,order = c(1,0,2))
    modelo6$aic

    ## [1] -29.86264

Nos quedamos con el *A**R*(3). Revisemos los residuos:

    AR3Resid <- (modelo1$resid)
    ts.plot(AR3Resid)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-54-1.png)

    acf(AR3Resid)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-54-2.png)

    pacf(AR3Resid)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-54-3.png)
No hay autocorrelación, No hay autocorrelación parcial.

Veamos si se trata de un ruido blanco

    Box.test(AR3Resid)

    ## 
    ##  Box-Pierce test
    ## 
    ## data:  AR3Resid
    ## X-squared = 0.00015103, df = 1, p-value = 0.9902

¿Es ruido blanco?

Realicemos una proyección a 5 años

    pred5 <- predict(modelo1, n.ahead=5,se=T)
    pred5se <- pred5$se

intervalos de confianza:

    ic = pred5$pred + cbind(-2*pred5$se,2*pred5$se)
    ts.plot(dltrans,pred5$pred,ic,
    col=c("black","blue","red","red"))

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-57-1.png)

Los intervalos son grandes, podría ser por la cantidad de datos

### Ejemplo 2

Datos: Índice de desempleo trimestal en Canada desde el 62

    uu <- "https://raw.githubusercontent.com/vmoprojs/DataLectures/master/CAEMP.DAT"
    datos <- read.csv(url(uu),sep=",",header=T)
    emp.ts <- ts(datos,st=1962,fr=4)
    plot(emp.ts)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-58-1.png)

Veamos sus autocorrelaciones y AIC:

    acf(emp.ts)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-59-1.png)

    pacf(emp.ts)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-59-2.png)

    ar(emp.ts)$aic

    ##          0          1          2          3          4          5 
    ## 347.493734   8.048336   0.000000   1.386627   2.471906   4.195572 
    ##          6          7          8          9         10         11 
    ##   6.015058   7.925583   9.390454  10.273560  10.989316  12.924608 
    ##         12         13         14         15         16         17 
    ##  14.892737  16.870041  18.803523  20.117383  22.114279  23.215372 
    ##         18         19         20         21 
    ##  25.038216  26.186319  28.019605  29.975609

Decae linealmente el ACF, esto es señal de que no es un proceso AR

Comparemos modelos:

    mode1 <- arima(emp.ts,order=c(2,0,0))
    mode2 <- arima(emp.ts,order=c(0,0,4))
    Box.test(mode1$resid,t="Ljung",lag=20)

    ## 
    ##  Box-Ljung test
    ## 
    ## data:  mode1$resid
    ## X-squared = 16.546, df = 20, p-value = 0.6822

    Box.test(mode2$resid,t="Ljung",lag=20)

    ## 
    ##  Box-Ljung test
    ## 
    ## data:  mode2$resid
    ## X-squared = 113.23, df = 20, p-value = 4.996e-15

mode1 es ruido, pero mode2 no lo es. Analicemos los resíduos:

    ts.plot(mode1$resid)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-61-1.png)

    ts.plot(mode2$resid)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-61-2.png)

    tsdiag(mode1)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-61-3.png)

Probemos un modelo ARMA

    arma.21 <- arima(emp.ts,order=c(2,0,1))
    arma.21$aic

    ## [1] 494.8726

    arma.21

    ## 
    ## Call:
    ## arima(x = emp.ts, order = c(2, 0, 1))
    ## 
    ## Coefficients:
    ##          ar1      ar2      ma1  intercept
    ##       1.5745  -0.5987  -0.1612    97.9320
    ## s.e.  0.1534   0.1522   0.1922     4.0145
    ## 
    ## sigma^2 estimated as 2.011:  log likelihood = -242.44,  aic = 494.87

    tsdiag(arma.21)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-62-1.png)

    arma.21$coef

    ##        ar1        ar2        ma1  intercept 
    ##  1.5744680 -0.5986826 -0.1612365 97.9320375

    arma.21$var.coef

    ##                   ar1         ar2         ma1   intercept
    ## ar1        0.02353470 -0.02327060 -0.02640964  0.09975805
    ## ar2       -0.02327060  0.02316479  0.02602775 -0.11240983
    ## ma1       -0.02640964  0.02602775  0.03693592 -0.10423546
    ## intercept  0.09975805 -0.11240983 -0.10423546 16.11644493

    polyroot(c(1,-1.57,0.59)) # Estacionario (Las raíces son |x|>1)

    ## [1] 1.056032+0i 1.604985-0i

    polyroot(c(1,-0.16)) # Invertible

    ## [1] 6.25+0i

    # Si se cumplen ambas, el proceso ARMA es estacionario. 

**Condición de invertibilidad del Proceso *M**A*(*q*)**

Dado un proceso *M**A*(*q*),
*Y*<sub>*t*</sub> = *θ**q*(*L*)(*ϵ*<sub>*t*</sub>) donde
*θ*<sub>*q*</sub>(*L*)=1 + *θ*<sub>1</sub>*L* + *θ*<sub>2</sub>*L*<sup>2</sup> + ⋯ + *θ*<sub>*q*</sub>*L*<sup>*q*</sup>,
entonces considerando el polinomio en
*z* ∈ ℂ, *θ*<sub>*q*</sub>(*z*)=1 + *θ*<sub>1</sub>*z* + ⋯ + *θ*<sub>*q*</sub>*z*<sup>*q*</sup>
y sus *q* raíces
(*z*<sub>1</sub>, *z*<sub>2</sub>, …, *z*<sub>*q*</sub>)∈ℂ, es decir,
valores *z* ∈ ℂ tales que *θ*<sub>*q*</sub>(*z*)=0, se dice que el
proceso *Y*<sub>*t*</sub> es invertible si se cumple

|*z*<sub>*j*</sub>|&gt;1,  ∀*j* = 1, …, *q*
 o también, si *θ*<sub>*q*</sub>(*z*)≠0, ∀*z*, |*z*|≤1. Note que
$\\eqref{eq1}$ es equivalente a

$$
\\frac{1}{z\_j}&lt;1, \\quad \\forall j = 1,\\ldots,q
$$

es decir, los inversos de las raíces deben caer dentro del círculo
unitario complejo.

Test de Dickey Fuller
---------------------

> La Prueba de Dickey-Fuller busca determinar la existencia o no de
> raíces unitarias en una serie de tiempo. La hipótesis nula de esta
> prueba es que existe una raíz unitaria en la serie.

    library(tseries)
    adf.test(emp.ts)

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  emp.ts
    ## Dickey-Fuller = -2.6391, Lag order = 5, p-value = 0.3106
    ## alternative hypothesis: stationary

    adf.test(diff(emp.ts))

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  diff(emp.ts)
    ## Dickey-Fuller = -4.0972, Lag order = 5, p-value = 0.01
    ## alternative hypothesis: stationary

### Ejemplo 3

Datos: 14 series macroeconómicas:

-   indice de precios del consumidor (`cpi`),
-   producción industrial (`ip`),
-   PNB Nominal (`gnp.nom`),
-   Velocidad (`vel`),
-   Empleo (`emp`),
-   Tasa de interés (`int.rate`),
-   Sueldos nominales (`nom.wages`),
-   Deflactor del PIB (`gnp.def`),
-   Stock de dinero (`money.stock`),
-   PNB real (`gnp.real`),
-   Precios de stock (`stock.prices`),
-   PNB per cápita (`gnp.capita`),
-   Salario real (`real.wages`), y
-   Desempleo (`unemp`).

Tienen diferentes longitudes pero todas terminan en 1988. Trabajaremos
con `cpi`

    data(NelPlo)
    plot(cpi)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-65-1.png)
La serie parece no ser estacionaria ni lineal.

Veamos las raíces unitarias:

    adf.test(cpi)

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  cpi
    ## Dickey-Fuller = -1.6131, Lag order = 5, p-value = 0.7374
    ## alternative hypothesis: stationary

¿Es estacionaria?

Probemos con las diferencias

    dife <- diff(cpi)
    plot(dife)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-67-1.png)

    adf.test(dife)

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  dife
    ## Dickey-Fuller = -4.4814, Lag order = 5, p-value = 0.01
    ## alternative hypothesis: stationary

La serie en diferencias si es estacionaria. Veamos qué modelo sugiere R:

    ar(dife)

    ## 
    ## Call:
    ## ar(x = dife)
    ## 
    ## Coefficients:
    ##       1        2        3  
    ##  0.8067  -0.3494   0.1412  
    ## 
    ## Order selected 3  sigma^2 estimated as  0.001875

Hasta mi última revisión, no existe una función `ma` como `ar`, pero:

    #### Busquemos el mejor MA #####
    N=10
    AICMA=matrix(0,ncol=1,nrow=N)
    for (i in 1:N){
    AICMA[i] = arima(diff(cpi),order=c(0,0,i))$aic
    }
    which.min(AICMA)

    ## [1] 3

    AICMA

    ##            [,1]
    ##  [1,] -432.7692
    ##  [2,] -435.4208
    ##  [3,] -436.1922
    ##  [4,] -434.4117
    ##  [5,] -432.4410
    ##  [6,] -432.1389
    ##  [7,] -432.3631
    ##  [8,] -430.4594
    ##  [9,] -428.4612
    ## [10,] -429.8065

Se sugiere un *M**A*(3).

Evaluemos el modelo MA con una diferencia:

    mode1 <- arima(cpi,order=c(0,1,3))
    mode1

    ## 
    ## Call:
    ## arima(x = cpi, order = c(0, 1, 3))
    ## 
    ## Coefficients:
    ##          ma1     ma2     ma3
    ##       0.8782  0.3754  0.1898
    ## s.e.  0.0876  0.1172  0.0890
    ## 
    ## sigma^2 estimated as 0.00185:  log likelihood = 220.67,  aic = -433.34

    tsdiag(mode1)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-70-1.png)

Cointegración
=============

Esta sección fue tomada de Colonescu (2016).

-   Una serie de tiempo no es estacionaria si su distribución, en
    particular su media, varianza o covarianza en el tiempo cambian con
    el tiempo.

-   Las series temporales no estacionarias no se pueden usar en los
    modelos de regresión porque pueden crear una regresión espuria, una
    relación falsa debido, por ejemplo, a una tendencia común en
    variables que de otro modo no estarían relacionadas.

-   Dos o más series no estacionarias aún pueden ser parte de un modelo
    de regresión si están cointegradas, es decir, están en una relación
    estacionaria de algún tipo.

<!-- ## Regresión Espúrea -->
<!-- Ecuaciones de la forma $\ref{eq12}$ -->
<!-- $$ -->
<!-- y_t = \beta_1x_{t,1}+\beta_2x_{t,2}+\cdots+\beta_Kx_{t,K}+\epsilon_t\label{eq12} -->
<!-- $$ -->
<!-- para $t = 1,\ldots,T$, son la base de la predicción macroeconómica y de modelos de simulación. $y_t$ es una variable *endógena*, el vector fila $\mathbf{x'_t} = (x_{t,1},x_{t,2},\ldots,x_{t,K})$ son las variables *exógenas* y $e_t$ es un ruido blanco.  -->
<!-- Se asume que las variables utilizadas en el análisis son estacionarias. -->
<!-- ## El concepto de cointegración y modelo de corrección de errores -->
<!-- ## Sistemas de variables cointegradas -->
Estacionariedad
---------------

Hasta ahora hemos realizado procedimientos para averiguar si una serie
es estacionaria. Recordemos, por ejemplo, el proceso *A**R*(1):

*y*<sub>*t*</sub> = *ϕ**y*<sub>*t* − 1</sub> + *ϵ*<sub>*t*</sub>

Este proceso es **estacionario** si |*ϕ*|&lt;1; cuando *ϕ* = 1 el
proceso se llama **caminata aleatoria**.

El siguiente código genera procesos *A**R*(1):

-   con y sin constante
-   con y sin tendencia
-   *ϕ* menor que 1.

La ecuación genérica para la simulación es:

*y*<sub>*t*</sub> = *α* − *λ**t* + *ϕ**y*<sub>*t* − 1</sub> + *ϵ*<sub>*t*</sub>

    N <- 500
    a <- 1
    l <- 0.01
    rho <- 0.7

    set.seed(246810)
    v <- ts(rnorm(N,0,1))

    par(mfrow = c(3,2))

    y <- ts(rep(0,N))
    for (t in 2:N){
      y[t]<- rho*y[t-1]+v[t]
    }
    plot(y,type='l', ylab="rho*y[t-1]+v[t]",main= "Sin tendencia")
    abline(h=0)

    y <- ts(rep(0,N))
    for (t in 2:N){
      y[t]<- a+rho*y[t-1]+v[t]
    }
    plot(y,type='l', ylab="a+rho*y[t-1]+v[t]", main= "Con constante")
    abline(h=0)

    y <- ts(rep(0,N))
    for (t in 2:N){
      y[t]<- a+l*time(y)[t]+rho*y[t-1]+v[t]
    }
    plot(y,type='l', ylab="a+l*time(y)[t]+rho*y[t-1]+v[t]", main = "Con tendencia y constante")
    abline(h=0)

    y <- ts(rep(0,N))
    for (t in 2:N){
      y[t]<- y[t-1]+v[t]
    }
    plot(y,type='l', ylab="y[t-1]+v[t]", main = "Caminata aleatoria")
    abline(h=0)

    a <- 0.1
    y <- ts(rep(0,N))
    for (t in 2:N){
      y[t]<- a+y[t-1]+v[t]
    }
    plot(y,type='l', ylab="a+y[t-1]+v[t]", main = "Caminata aleatoria con constante")
    abline(h=0)

    y <- ts(rep(0,N))
    for (t in 2:N){
      y[t]<- a+l*time(y)[t]+y[t-1]+v[t]
    }
    plot(y,type='l', ylab="a+l*time(y)[t]+y[t-1]+v[t]", main = "Caminata aleatoria con constante y tendencia")
    abline(h=0)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-71-1.png)

Regresión espúrea
-----------------

La no estacionariedad puede conducir a una regresión espuria, una
aparente relación entre variables que, en realidad, no están
relacionadas. La siguiente secuencia de código genera dos procesos de
paseo aleatorio independientes, *y* y *x*, hacemos la regresión
*y*<sub>*t*</sub> = *β*<sub>*o*</sub> + *β*<sub>1</sub>*x*<sub>*t*</sub>.

Veamos las series y su gráfica de dispersión:

    T <- 1000
    set.seed(1357)
    y <- ts(rep(0,T))
    vy <- ts(rnorm(T))
    for (t in 2:T){
      y[t] <- y[t-1]+vy[t]
    }

    set.seed(4365)
    x <- ts(rep(0,T))
    vx <- ts(rnorm(T))
    for (t in 2:T){
      x[t] <- x[t-1]+vx[t]
    }
    y <- ts(y[300:1000])
    x <- ts(x[300:1000])

    par(mfrow = c(1,2))
    ts.plot(y,x, ylab="y & x")
    plot(x, y, type="p", col="grey")

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-72-1.png)

    spurious.ols <- lm(y~x)
    summary(spurious.ols)

    ## 
    ## Call:
    ## lm(formula = y ~ x)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -12.554  -5.973  -2.453   4.508  24.678 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -20.38711    1.61958 -12.588  < 2e-16 ***
    ## x            -0.28188    0.04331  -6.508 1.45e-10 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 7.954 on 699 degrees of freedom
    ## Multiple R-squared:  0.05713,    Adjusted R-squared:  0.05578 
    ## F-statistic: 42.35 on 1 and 699 DF,  p-value: 1.454e-10

El resumen muestra una fuerte correlación entre las dos variables,
aunque se han generado de forma independiente. (Sin embargo, no es
necesario que ninguno de los dos procesos generados aleatoriamente
genere una regresión espuria).

Estacionariedad
---------------

Ya hemos trabajado con la prueba de Dickey-Fuller para determinar si una
serie es estacionaria. Recuerda que la *H*<sub>*o*</sub> de esta prueba
es *no estacionariedad*. Es decir, **si rechazamos la hipótesis nula, la
serie es estacionaria**.

Un concepto que está estrechamente relacionado con la estacionalidad es
el **orden de integración**, que es *cuántas veces necesitamos
diferenciar una serie hasta que se vuelva estacionaria*.

Una serie es *I*(0), es decir, integrada de orden 0 si ya es
estacionaria (es estacionaria en niveles, no en diferencias); una serie
es *I*(1) si es no estacionara en niveles, pero estacionaria en sus
primeras diferencias.

### Ejemplo

Serie trimestral (1984:1 - 2009:4) de los Estados Unidos de las
siguientes variables:

-   `gdp` producto interno bruto
-   `inf` inflacion anual
-   `f` tasa de los fondos federales
-   `b` tasa a tres años

<!-- -->

    dir <- "~/Documents/Consultorias&Cursos/DataLectures"
    load(file = paste(dir,"/usa.rda",sep = ""))
    usa.ts <- ts(usa, start=c(1984,1), end=c(2009,4),
                   frequency=4)

Analicemos las tasas: f y b

    plot.ts(usa.ts[,c("f","b")], main = "Tasa federal y tasa a 3 meses")

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-75-1.png)

Veamos la estacionariedad de las series:

    adf.test(usa.ts[,"f"], k=10)

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  usa.ts[, "f"]
    ## Dickey-Fuller = -3.3726, Lag order = 10, p-value = 0.06283
    ## alternative hypothesis: stationary

    adf.test(usa.ts[,"b"], k=10)

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  usa.ts[, "b"]
    ## Dickey-Fuller = -2.9838, Lag order = 10, p-value = 0.1687
    ## alternative hypothesis: stationary

Las series no son estacionarias. Analicemos sus diferencias

    adf.test(diff(usa.ts[,"f"]), k=10)

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  diff(usa.ts[, "f"])
    ## Dickey-Fuller = -3.5291, Lag order = 10, p-value = 0.04291
    ## alternative hypothesis: stationary

    adf.test(diff(usa.ts[,"b"]), k=10)

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  diff(usa.ts[, "b"])
    ## Dickey-Fuller = -3.7181, Lag order = 10, p-value = 0.02601
    ## alternative hypothesis: stationary

Las series en diferencias son estacionarias.

### Prueba de Phillips-Perron

<!-- La hipótesis nula determina si una serie de tiempo es integrada de orden $1$. Se realiza la prueba de DF de la hipótesis nula $\phi=1$ en $\Delta y_{t}=(\phi -1)y_{t-1}+u_{t}$. -->
La hipótesis nula es que la serie tiene una raíz unitaria.

    # Tets de Phillips Perron
    pp.test(usa.ts[,"f"])

    ## 
    ##  Phillips-Perron Unit Root Test
    ## 
    ## data:  usa.ts[, "f"]
    ## Dickey-Fuller Z(alpha) = -13.21, Truncation lag parameter = 4,
    ## p-value = 0.3498
    ## alternative hypothesis: stationary

    pp.test(usa.ts[,"b"])

    ## 
    ##  Phillips-Perron Unit Root Test
    ## 
    ## data:  usa.ts[, "b"]
    ## Dickey-Fuller Z(alpha) = -16.361, Truncation lag parameter = 4,
    ## p-value = 0.1667
    ## alternative hypothesis: stationary

### Prueba de Cointegración: Phillips-Ouliaris

Peter C. B. Phillips y Sam Ouliaris (1990) muestran que las pruebas de
raíz unitaria basadas en residuos aplicadas a los residuos de
cointegración estimados no tienen las distribuciones habituales de
Dickey-Fuller bajo la **hipótesis nula de no cointegración**.

Debido al fenómeno de regresión espuria bajo la hipótesis nula, la
distribución de estas pruebas tiene distribuciones asintóticas que
dependen de

1.  el número de términos de tendencias deterministas y
2.  el número de variables con las que se prueba la cointegración.

Estas distribuciones se conocen como distribuciones de
Phillips-Ouliaris.

    bfx <- as.matrix(cbind(usa.ts[,"f"],usa.ts[,"b"]))
    po.test(bfx)

    ## 
    ##  Phillips-Ouliaris Cointegration Test
    ## 
    ## data:  bfx
    ## Phillips-Ouliaris demeaned = -19.877, Truncation lag parameter =
    ## 1, p-value = 0.05763

Las series no son cointegradas

    fff <- fitted(lm(usa.ts[,"f"]~usa.ts[,"b"]))
    pp.test(fff)

    ## 
    ##  Phillips-Perron Unit Root Test
    ## 
    ## data:  fff
    ## Dickey-Fuller Z(alpha) = -16.361, Truncation lag parameter = 4,
    ## p-value = 0.1667
    ## alternative hypothesis: stationary

    adf.test(fff, k = 10)

    ## 
    ##  Augmented Dickey-Fuller Test
    ## 
    ## data:  fff
    ## Dickey-Fuller = -2.9838, Lag order = 10, p-value = 0.1687
    ## alternative hypothesis: stationary

> Una relación entre las variables *I*(1) cointegradas es una relación a
> largo plazo, mientras que una relación entre las variables *I*(0) es a
> corto plazo.

Ejemplo 2
---------

Datos: tasas de cambio mensuales de Estados Unidos, Inglaterra y Nueva
Zelanda desde 2004.

    uu <- "https://raw.githubusercontent.com/vmoprojs/DataLectures/master/us_rates.txt"
    datos <- read.csv(url(uu),sep="",header=T)
    usa.ts <- ts(usa, start=c(1984,1), end=c(2009,4),
                   frequency=4)

    # Tasas de cambio, datos mensuales
    uk.ts <- ts(datos$UK,st=2004,fr=12)
    eu.ts <- ts(datos$EU,st=2004,fr=12)

Revisemos si las series son estacionarias:

    # Tets de Phillips Perron
    pp.test(uk.ts)

    ## 
    ##  Phillips-Perron Unit Root Test
    ## 
    ## data:  uk.ts
    ## Dickey-Fuller Z(alpha) = -10.554, Truncation lag parameter = 7,
    ## p-value = 0.521
    ## alternative hypothesis: stationary

    pp.test(eu.ts)

    ## 
    ##  Phillips-Perron Unit Root Test
    ## 
    ## data:  eu.ts
    ## Dickey-Fuller Z(alpha) = -6.812, Truncation lag parameter = 7,
    ## p-value = 0.7297
    ## alternative hypothesis: stationary

Tienen raíces unitarias

Objetivo: Se piensa que la libra esterlina y el euro tienen alguna
relación

    #Test de Phillips Ollearis
    po.test(cbind(uk.ts,eu.ts))

    ## 
    ##  Phillips-Ouliaris Cointegration Test
    ## 
    ## data:  cbind(uk.ts, eu.ts)
    ## Phillips-Ouliaris demeaned = -21.662, Truncation lag parameter =
    ## 10, p-value = 0.04118

La *H**o*: NO COINTEGRADAS.

Si son cointegradas, es decir que hay una tendencia a largo plazo.

Veamos la relación:

    reg <- lm(uk.ts~eu.ts)
    summary(reg)

    ## 
    ## Call:
    ## lm(formula = uk.ts ~ eu.ts)
    ## 
    ## Residuals:
    ##        Min         1Q     Median         3Q        Max 
    ## -0.0216256 -0.0068351  0.0004963  0.0061439  0.0284938 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) 0.074372   0.004983   14.92   <2e-16 ***
    ## eu.ts       0.587004   0.006344   92.53   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.008377 on 1001 degrees of freedom
    ## Multiple R-squared:  0.8953, Adjusted R-squared:  0.8952 
    ## F-statistic:  8561 on 1 and 1001 DF,  p-value: < 2.2e-16

Analicemos los resíduos:

    residuos = resid(reg)
    plot(resid(reg),t="l")

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-86-1.png)

Presentan una estructura, debemos modelizarlos.

    arma11 <- arima(residuos,order=c(1,0,1))
    arma11

    ## 
    ## Call:
    ## arima(x = residuos, order = c(1, 0, 1))
    ## 
    ## Coefficients:
    ##          ar1     ma1  intercept
    ##       0.9797  0.1013     0.0015
    ## s.e.  0.0072  0.0331     0.0029
    ## 
    ## sigma^2 estimated as 3.031e-06:  log likelihood = 4947.45,  aic = -9886.9

    tsdiag(arma11)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-87-1.png)

Encontramos un modelo en los errores que si es estacionario, la relación
a largo plazo entonces es el coeficiente de la regresión: 0.58.

Introducción a los modelos de vectores autorregresivos: VAR
===========================================================

Un modelo VAR simple puede ser escrito como:

*y*<sub>1*t*</sub> = *a*<sub>10</sub> + *a*<sub>11</sub>*y*<sub>*t* − 1</sub> + *a*<sub>12</sub>*y*<sub>2*t* − 1</sub> + *ϵ*<sub>1*t*</sub>
*y*<sub>2*t*</sub> = *a*<sub>10</sub> + *a*<sub>21</sub>*y*<sub>*t* − 1</sub> + *a*<sub>22</sub>*y*<sub>2*t* − 1</sub> + *ϵ*<sub>2*t*</sub>

o, en forma matricial

$$
\\begin{bmatrix}y\_{1,t}\\\\y\_{2,t}\\end{bmatrix}={\\begin{bmatrix}a\_{1,0}\\\\a\_{2,0}\\end{bmatrix}}+{\\begin{bmatrix}a\_{1,1}&a\_{1,2}\\\\a\_{2,1}&a\_{2,2}\\end{bmatrix}}{\\begin{bmatrix}y\_{1,t-1}\\\\y\_{2,t-1}\\end{bmatrix}}+{\\begin{bmatrix}e\_{1,t}\\\\e\_{2,t}\\end{bmatrix}}
$$

donde los términos de error satisfacen

*E*(*e*<sub>1*t*</sub>)=*E*(*e*<sub>2*t*</sub>)=0, ∀*t*
*E*(*e*<sub>1*t*</sub>*e*<sub>1*s*</sub>)=*E*(*e*<sub>2*t*</sub>*e*<sub>2*s*</sub>)=*E*(*e*<sub>1*t*</sub>*e*<sub>2*s*</sub>)=0, ∀*t* ≠ *s*

$$
Var\\left(\\begin{matrix}e\_{1,t}\\\\e\_{2,t}\\end{matrix}\\right) = \\left(\\begin{matrix}\\sigma\_{1}^2\\\\\\sigma\_{12}\\end{matrix}\\begin{matrix}\\sigma\_{12}\\\\\\sigma\_{2}^2\\end{matrix}\\right) = \\Sigma, \\forall t
$$

o, de forma más compacta:

*y*<sub>*t*</sub> = *A*<sub>0</sub> + *A*<sub>1</sub>*y*<sub>*t*</sub> + *ϵ*<sub>*t*</sub>

donde $y\_t = \\begin{bmatrix}y\_{1,t}\\\\y\_{2,t}\\end{bmatrix}$,
$A\_1 = {\\begin{bmatrix}a\_{1,1}&a\_{1,2}\\\\a\_{2,1}&a\_{2,2}\\end{bmatrix}}$
y $\\epsilon\_t = \\begin{bmatrix}e\_{1,t}\\\\e\_{2,t}\\end{bmatrix}$

Básicamnete, que *todo depende de todo*. Notemos que cada fila puede ser
escrita como una ecuación separada:

Mirando un poco más cerca a las ecuaciones individuales, notarás que no
aparecen valores contemporáneos (en el tiempo *t*) en el lado derecho
(ld) del modelo VAR.

### Ejemplo

Empecemos simulando un proceso VAR (2)

    set.seed(123) # Misma semilla para tener los mismos resultados

    # Generamos muestra
    t <- 200 # tamaño de la serie
    k <- 2 # Número de variables endogenas
    p <- 2 # numero de rezagos

    # Generamos matriz de coeficientes
    A.1 <- matrix(c(-.3, .6, -.4, .5), k) # Matriz de coeficientes del rezago 1
    A.2 <- matrix(c(-.1, -.2, .1, .05), k) # Matriz de coeficientes del rezago 2
    A <- cbind(A.1, A.2) # Forma compuesta

    # Genramos las series
    series <- matrix(0, k, t + 2*p) # Inicio serie con ceros
    for (i in (p + 1):(t + 2*p)){ # Genramos los errores e ~ N(0,0.5)
      series[, i] <- A.1%*%series[, i-1] + A.2%*%series[, i-2] + rnorm(k, 0, .5)
    }

    series <- ts(t(series[, -(1:p)])) # Convertimos a formato ts
    names <- c("V1", "V2") # Renombrar variables
    plot.ts(series) # Graficos de la serie

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-88-1.png)

#### Estimación

La función relevante es `VAR` y su uso es directo. Solo tienes que
cargar el paquete y especificar los datos (`y`), el orden (`p`) y el
tipo del modelo. El tipo de opción determina si se debe incluir un
término de intercepción, una tendencia o ambos en el modelo. Como los
datos artificiales que hemos generado no contienen términos
determinísticos, elegimos no tomarlo en cuenta en la estimación al
establecer `type = "none"`.

    library(vars) # Cargamos el paquete
    var.1 <- VAR(series, 2, type = "none") # Estimamos el modelo

#### Comparación

Un problema central en el análisis de `VAR` es encontrar el número de
rezagos que produce los mejores resultados. La comparación de modelos
generalmente se basa en criterios de información como el `AIC`, `BIC` o
`HQ`. Por lo general, el `AIC` es preferible a otros criterios, debido a
sus características favorables de pronóstico de muestras pequeñas. El
`BIC` y `HQ`, sin embargo, funcionan bien en muestras grandes y tienen
la ventaja de ser un estimador consistente, es decir, converge a los
valores verdaderos.

El parámetro clave es `lag.max = 5` en el código siguiente:

    var.aic <- VAR(series, type = "none", lag.max = 5, ic = "AIC")

Veamos los resultados:

    summary(var.aic)

    ## 
    ## VAR Estimation Results:
    ## ========================= 
    ## Endogenous variables: Series.1, Series.2 
    ## Deterministic variables: none 
    ## Sample size: 200 
    ## Log Likelihood: -266.065 
    ## Roots of the characteristic polynomial:
    ## 0.6611 0.6611 0.4473 0.03778
    ## Call:
    ## VAR(y = series, type = "none", lag.max = 5, ic = "AIC")
    ## 
    ## 
    ## Estimation results for equation Series.1: 
    ## ========================================= 
    ## Series.1 = Series.1.l1 + Series.2.l1 + Series.1.l2 + Series.2.l2 
    ## 
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## Series.1.l1 -0.19750    0.06894  -2.865  0.00463 ** 
    ## Series.2.l1 -0.32015    0.06601  -4.850 2.51e-06 ***
    ## Series.1.l2 -0.23210    0.07586  -3.060  0.00252 ** 
    ## Series.2.l2  0.04687    0.06478   0.724  0.47018    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## 
    ## Residual standard error: 0.4638 on 196 degrees of freedom
    ## Multiple R-Squared: 0.2791,  Adjusted R-squared: 0.2644 
    ## F-statistic: 18.97 on 4 and 196 DF,  p-value: 3.351e-13 
    ## 
    ## 
    ## Estimation results for equation Series.2: 
    ## ========================================= 
    ## Series.2 = Series.1.l1 + Series.2.l1 + Series.1.l2 + Series.2.l2 
    ## 
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## Series.1.l1  0.67381    0.07314   9.213  < 2e-16 ***
    ## Series.2.l1  0.34136    0.07004   4.874 2.25e-06 ***
    ## Series.1.l2 -0.18430    0.08048  -2.290   0.0231 *  
    ## Series.2.l2  0.06903    0.06873   1.004   0.3164    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## 
    ## Residual standard error: 0.4921 on 196 degrees of freedom
    ## Multiple R-Squared: 0.3574,  Adjusted R-squared: 0.3443 
    ## F-statistic: 27.26 on 4 and 196 DF,  p-value: < 2.2e-16 
    ## 
    ## 
    ## 
    ## Covariance matrix of residuals:
    ##          Series.1 Series.2
    ## Series.1  0.21417 -0.03116
    ## Series.2 -0.03116  0.24154
    ## 
    ## Correlation matrix of residuals:
    ##          Series.1 Series.2
    ## Series.1    1.000   -0.137
    ## Series.2   -0.137    1.000

#### Impulso respuesta

    ir.1 <- irf(var.1, impulse = "Series.1", response = "Series.2", n.ahead = 20, ortho = FALSE)
    plot(ir.1)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-92-1.png)

La opción `orto` es importante, porque dice algo sobre las relaciones
contemporáneas entre las variables. En nuestro ejemplo, ya sabemos que
tales relaciones no existen, porque la matriz verdadera de
varianza-covarianza, o simplemente matriz de covarianza, es diagonal con
ceros en los elementos fuera de la diagonal.

Sin embargo, dado que los datos de series temporales limitadas con 200
observaciones restringen la precisión de las estimaciones de los
parámetros, la matriz de covarianza tiene valores positivos en sus
elementos fuera de la diagonal, lo que implica efectos contemporáneos
distintos de cero de un choque. Para descartar esto establezco
`ortho = FALSE`. El resultado de esto es que la respuesta al impulso
comienza en cero en el período 0. También puedes probar la alternativa y
establecer `ortho = TRUE`, lo que da como resultado un gráfico que
comienza bajo cero. No quiero entrar en más detalles aquí, pero basta
decir que el problema de los llamados errores ortogonales es uno de los
problemas centrales en el análisis de VAR y definitivamente deberías
leer más al respecto, si tienes la intención de configurar tus propios
modelos VAR.

A veces es importante obtener el efecto a largo plazo. Para esto se
calcula el gráfico de la función impulso-respuesta acumulada:

    ir.2 <- irf(var.1,impulse="Series.1",response="Series.2",n.ahead = 20,ortho = FALSE,
    cumulative = TRUE)
    plot(ir.2)

![](%5BP3_-1%5D_SeriesTiempo_files/figure-markdown_strict/unnamed-chunk-93-1.png)

Vemos que, pese a variaciones negaivas en algunos períodos, en el largo
plazo el efecto es positivo.

Referencias
===========

Colonescu, Constantin. 2016. “Principles of Econometrics with R.”
