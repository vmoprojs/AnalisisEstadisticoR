-   [Procedimientos Gráficos](#procedimientos-graficos)
    -   [Funciones Gráficas](#funciones-graficas)
        -   [Funciones gráficas de alto
            nivel](#funciones-graficas-de-alto-nivel)
        -   [Funciones gráficas de bajo
            nivel](#funciones-graficas-de-bajo-nivel)
-   [Práctica](#practica)

<!--
La revisión metodológica aquí vertida se basa en [@Wang_2012].
-->
Procedimientos Gráficos
=======================

-   Una de las grandes potencialidades en R es la calidad gráfica. Su
    potencialidad es del mismo nivel e incluso superior al de muchos
    software comerciales.

-   Resultaría un curso exclusivo de graficación en R para poder dar a
    conocer todas las posibilidades de graficación en la herramienta.
    Para ilustrar algunas posibilidades:

<!-- -->

    demo(graphics)

Funciones Gráficas
------------------

-   El resultado de una función gráfica no puede ser asignado a un
    objeto sino que es enviado a un dispositivo gráfico. Un dispositivo
    gráfico es una ventana gráfica o un archivo.

-   Existen dos tipos de funciones gráficas:
    -   Funciones de *gráficas de alto nivel*: Crean una nueva gráfica
    -   Funciones de *gráficas de bajo nive*l: agregan elementos a una
        gráfica existente
-   Las gráficas se producen con respecto a *parámetros gráficos* que
    están definidos por defecto y pueden ser modificados con la función
    `par`.

### Funciones gráficas de alto nivel

<table>
<thead>
<tr class="header">
<th align="center">Función</th>
<th align="center">Descripción</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><code>plot(x)</code></td>
<td align="center">graficar los valores de x (en el eje y) ordenados en el eje x</td>
</tr>
<tr class="even">
<td align="center"><code>plot(x,y)</code></td>
<td align="center">gráfico bivariado de x (en el eje x) y y (en el eje y)</td>
</tr>
<tr class="odd">
<td align="center"><code>pie(x)</code></td>
<td align="center">gráfico circular tipo <em>pie</em></td>
</tr>
<tr class="even">
<td align="center"><code>boxplot(x)</code></td>
<td align="center">Gráfico de caja y bigotes</td>
</tr>
<tr class="odd">
<td align="center"><code>hist(x)</code></td>
<td align="center">histograma de las frecuencias de x</td>
</tr>
<tr class="even">
<td align="center"><code>barplot(x)</code></td>
<td align="center">histograma de los valores de x</td>
</tr>
</tbody>
</table>

-   Las opciones de cada unas de las funciones se pueden ver en la ayuda
    de R.
-   Las principales son:

<table style="width:57%;">
<colgroup>
<col width="5%" />
<col width="51%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Opción</th>
<th align="center">Descripción</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><code>add=FALSE</code></td>
<td align="center">si es TRUE superpone el gráfico en el ya existente (si existe)</td>
</tr>
<tr class="even">
<td align="center"><code>axes=TRUE</code></td>
<td align="center">si es FALSE no dibuja los ejes ni la caja del gráfico</td>
</tr>
<tr class="odd">
<td align="center"><code>type=&quot;p&quot;</code></td>
<td align="center">especifica el tipo de gráfico; <code>&quot;p&quot;</code>: puntos, <code>&quot;l&quot;</code>: líneas, <code>&quot;h&quot;</code>: líneas verticales, <code>&quot;s&quot;</code>: escaleras, los datos se representan como la parte superior de las líneas verticales, entre otros</td>
</tr>
<tr class="even">
<td align="center"><code>xlim=</code>, <code>ylim=</code></td>
<td align="center">especifica los límites inferiores y superiores de los ejes; por ejemplo con <code>xlim=c(1, 10)</code> o <code>xlim=range(x)</code></td>
</tr>
<tr class="odd">
<td align="center"><code>main=</code></td>
<td align="center">Título principal; debe ser de tipo caracter</td>
</tr>
<tr class="even">
<td align="center"><code>sub=</code></td>
<td align="center">sub-título (escrito en una letra más pequeña)</td>
</tr>
</tbody>
</table>

#### La función `plot(x)`

    x <- seq(10,20,1)
    plot(x)

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-2-1.png)

#### La función `plot(x,y)`

    y <- seq(30,40,1)
    plot(x,y)

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-3-1.png)

#### Boxplot

-   También se le llama gráfico de caja y bigotes, refleja gráficamente
    el resumen de estadísticas principales (Min,Q1,Mediana,Q3,Max,
    Outlayers). Importa los datos `Mundo.csv` y...

<!-- -->

    boxplot(PNB_PC)
    boxplot(log(PNB_PC))

-   Exácto! Es muy probable que hayas obtenido un error (**¿Por qué?**).
    Hay dos formas de solucionarlo. Una de las formas sería:

<!-- -->

    boxplot(datos$PNB_PC)

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-6-1.png)

-   Mmmm, algo anda mal, la variable no se puede apreciar muy bien.
    Tratemos visualizarla haciendo una transformación logarítmica:

<!-- -->

    boxplot(log(datos$PNB_PC))

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-7-1.png)

En general, si al aplicar el boxplot sobre una variable se tiene
problemas para visualizarla, se debe usar el lograritmo de la variable
para una mejor lectura de la variable.

-   Otra forma de solucionar el problema anterior es usando el comando
    `attach`. Esta función es utilizada para poder *ingresar* a las
    variables de un `data frame` sin el operador `$`. Así

<!-- -->

    attach(datos)

-   Realicemos varios `boxplot` a la vez.

<!-- -->

    boxplot(log(PNB_PC)~REGION, col=rainbow(5))

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-9-1.png)

-   Agreguemos etiquetas:

<!-- -->

    fregion <- factor(REGION,labels=c("Africa","America","Asia","Europa","Oceania"))
    boxplot(log(PNB_PC)~fregion, col=rainbow(5))

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-10-1.png)

#### Pie

-   Realiza un gráfico de *PIE* de los datos (tiene sentido cuando son
    datos de suma 100)

<!-- -->

    z.pie <- c(20,40,10,30)
    pie(z.pie)

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-11-1.png)

-   Con etiquetas

<!-- -->

    names(z.pie) <- c("Soltero", "Casado","Viudo",  "Divorciado")
    pie(z.pie)

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-12-1.png)

-   Con colores elegidos (más opciones de colores puedes encontrarlos
    [aquí](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf))

<!-- -->

    pie(z.pie, col = c("purple", "violetred1",  "green3","cornsilk"))

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-13-1.png)

-   Juguemos un poco con las opciones:
    -   Realizar un `plot` de *x* e *y* (ya creados) con las siguientes
        opciones:
    -   Título: Gráficas en R
    -   Subtítulo: Centro de Estudios Fiscales
    -   Etiquetas en ejes: `"Eje X"`, `"Eje Y"` Respectivamente
    -   Gráfico tipo escalera
    -   Color Azul

### Funciones gráficas de bajo nivel

<table style="width:53%;">
<colgroup>
<col width="5%" />
<col width="47%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Función</th>
<th align="center">Descripción</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><code>points(x, y)</code></td>
<td align="center">Agrega puntos</td>
</tr>
<tr class="even">
<td align="center"><code>lines(x,y)</code></td>
<td align="center">Mismo que points pero con líneas</td>
</tr>
<tr class="odd">
<td align="center"><code>segments(x0, y0, x1, y1)</code></td>
<td align="center">dibuja una línea desde el punto (<span class="math inline"><em>x</em><sub>0</sub></span>,<span class="math inline"><em>y</em><sub>0</sub></span>) hasta el punto (<span class="math inline"><em>x</em><sub>1</sub></span>,<span class="math inline"><em>y</em><sub>1</sub></span>)</td>
</tr>
<tr class="even">
<td align="center"><code>abline(a,b)</code></td>
<td align="center">dibuja una línea con pendiente b e intercepto a</td>
</tr>
</tbody>
</table>

#### Curve

Sirve para graficar funciones, el formato es

> `curve(expr, from, to, add=FALSE,...)`

Por ejemplo:

    curve(x^3-3*x,-2,2)  

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-14-1.png)

**Micro práctica**

-   Realiza una gráfica del conjunto de datos `women` (`women` es una
    base de datos *precargada* en `R`, se accede a ella con
    `data(women)`). Coloque `"Altura"` como etiqueta en el eje x y
    `"Peso"` en el *y*. Como título ponga
    `"Valores promedio de altura y peso"`, subtitulo:
    "`Mujeres de 30 a 39 años"`. El gráfico debe lucir así:

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-15-1.png)

-   Haga una gráfica de la función *c**o**s*(3*x*) de 0 a 3, de color
    azul. Superponga la gráfica de *s**i**n*(2*x*) de color rojo. La
    gráfica debe lucir así:

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-16-1.png)

-   Cerremos esta primera parte gráfica con un ejemplo en 3D:

<!-- -->

    library(rgl)
    r <- 1
    a <- runif(1000,0,2*pi)
    u <- runif(1000,-r,r)

    x <- cos(a)*sqrt(1-u^2)
    y <- sin(a)*sqrt(1-u^2)
    z <- u
    plot3d(x,y,z,col="blue")

-   Hasta el momento hemos cubierto formas básicas de hacer gráficos.
    Existen opciones más avanzas como lattice, ggplot2 y ggvis. Hagamos
    un breve paseo por `ggplot` y luego hacemos una práctica:

#### `ggplot2`

Un gráfico básico (usando lo aprendido hasta ahora)

    # Obtenemos los datos
    library(ggplot2)
    data(diamonds)

    # basic plotting
    plot(diamonds$carat, diamonds$price, col = diamonds$color,
        pch = as.numeric(diamonds$cut))

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-18-1.png)

Usando `ggplot`:

    ggplot(diamonds, aes(carat, price, col = color, shape = cut)) +
        geom_point()

![](%5BP1-4%5D_Procedimientos_Gráficos_files/figure-markdown_strict/unnamed-chunk-19-1.png)

Práctica
========

-   Abra los datos de R `cars`. Es una buena práctica el conocer los
    nuestros datos. Mira la ayuda de `cars`.

-   Ejecuta `head(cars)`. Para tener una mejor idea de nuestros datos,
    podemos usar funciones como: `dim()`, `names()`, `head()`, `tail()`
    y `summary()`.

-   Hagamos un gráfico básico `plot(cars)`
    -   `R` nota que el data frame tiene sólo dos columnas, por lo que
        asume que deseas graficar una columna vs la otra.
-   Además, ya que no se proporcionan etiquetas para los ejes, `R`
    utiliza los nombres de las columnas.

-   Ahora, ejecuta `plot(x = cars$speed, y = cars$dist)`. ¿Notas alguna
    diferencia con el gráfico anterior?

-   Ten en cuenta que hay otras maneras de usar el comando `plot`, esto
    es, utilizando el interfaz de `"fórmula"`. Por ejemplo, tenemos
    gráfico similar al anterior con `plot(dist ~ speed, cars)`. Sin
    embargo, vamos a usar más tarde en la práctica antes de utilizar la
    interfaz de fórmula.

-   Hagamos un gráfico de cars con `dist` en el eje *x* y `speed` en el
    eje *y*.

-   En el gráfico anterior, agrega la etiqueta `"Speed"` en el eje *x*.

-   En el gráfico anterior, agrega la etiqueta `"Stopping Distance"` en
    el eje *y*.

-   Ahora, agrega el título `"My Plot"`.

-   Agrega el subtítulo `"My Plot Subtitle"`.

-   Agrega la opción `col=2`

-   Limita los ejes usando la opción `xlim = c(10,15)`

-   Podemos cambiar la forma de los puntos, trata con la opción
    `pch = 2`.

-   Carga los datos `mtcars`. Usa `boxplot()` con la fórmula =
    `mpg ~ cyl` y `data = mtcars`.

-   Finalmente, realiza un histograma de `mtcars$mpg` con la función
    `hist`.
