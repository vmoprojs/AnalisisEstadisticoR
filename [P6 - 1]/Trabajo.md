-   [1. Ejercicio (\[1\] Introducción)](#ejercicio-1-introduccion)
-   [2. Ejercicio (\[4\] NonLinearLS)](#ejercicio-4-nonlinearls)
-   [3. Ejercicio (\[6\] GAM & \[7\] MARS & \[10\]
    RegBayes)](#ejercicio-6-gam-7-mars-10-regbayes)
-   [4. Ejercicio: Bootstrap](#ejercicio-bootstrap)

1. Ejercicio (\[1\] Introducción)
---------------------------------

1.  Teniendo en cuenta los datos de Maggie Simpson, responde las
    siguientes preguntas:

<!-- -->

1.  ¿Cuál fue su puntuación media?

2.  ¿Cuáles fueron el primer y tercer cuartil de sus puntuaciones?

3.  De acuerdo con la prueba de rango con signo de Wilcoxon de una
    muestra, ¿son sus puntajes significativamente diferentes de un
    puntaje neutral de 3?

4.  ¿Es útil el resultado del intervalo de confianza de la prueba para
    responder la pregunta anterior?

5.  En general, ¿cómo resumiría sus resultados? Asegúrese de abordar la
    implicación práctica de sus puntuaciones en comparación con una
    puntuación neutral de 3.

6.  ¿Estos resultados reflejan lo que usted esperaría de ver el gráfico
    de barras?

<!-- -->

    Input =("
      Speaker          Rater  Likert
     'Maggie Simpson'   1         3
     'Maggie Simpson'   2         4
     'Maggie Simpson'   3         5
     'Maggie Simpson'   4         4
     'Maggie Simpson'   5         4
     'Maggie Simpson'   6         4
     'Maggie Simpson'   7         4
     'Maggie Simpson'   8         3
     'Maggie Simpson'   9         2
     'Maggie Simpson'  10         5     
    ")

    datos <- read.table(textConnection(Input),header=TRUE)

1.  Brian Griffin quiere evaluar el nivel de educación de los
    estudiantes en su curso de escritura creativa para adultos. Quiere
    saber el nivel de educación medio de su clase, y si el nivel de
    educación de su clase es diferente del nivel de licenciatura típico.

Brian usó la siguiente tabla para codificar sus datos.

<table>
<thead>
<tr class="header">
<th>Instructor</th>
<th>Student</th>
<th>Education</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Brian Griffin</td>
<td>a</td>
<td>3</td>
</tr>
<tr class="even">
<td>Brian Griffin</td>
<td>b</td>
<td>2</td>
</tr>
<tr class="odd">
<td>Brian Griffin</td>
<td>c</td>
<td>3</td>
</tr>
<tr class="even">
<td>Brian Griffin</td>
<td>d</td>
<td>3</td>
</tr>
<tr class="odd">
<td>Brian Griffin</td>
<td>e</td>
<td>3</td>
</tr>
<tr class="even">
<td>Brian Griffin</td>
<td>f</td>
<td>3</td>
</tr>
<tr class="odd">
<td>Brian Griffin</td>
<td>g</td>
<td>4</td>
</tr>
<tr class="even">
<td>Brian Griffin</td>
<td>h</td>
<td>5</td>
</tr>
<tr class="odd">
<td>Brian Griffin</td>
<td>i</td>
<td>3</td>
</tr>
<tr class="even">
<td>Brian Griffin</td>
<td>j</td>
<td>4</td>
</tr>
<tr class="odd">
<td>Brian Griffin</td>
<td>k</td>
<td>3</td>
</tr>
<tr class="even">
<td>Brian Griffin</td>
<td>l</td>
<td>2</td>
</tr>
</tbody>
</table>

Para cada uno de los siguientes, responda la pregunta y muestre el
resultado de los análisis que usó para responder la pregunta.

1.  ¿Cuál era el nivel medio de educación? (¡Asegúrese de informar el
    nivel de educación, no solo el código numérico!)

2.  ¿Cuáles fueron el primer y tercer cuartil para el nivel educativo?

3.  De acuerdo con la prueba de Wilcoxon de una muestra, ¿son los
    niveles de educación significativamente diferentes de los niveles de
    un bachiller típico?

4.  ¿Es útil el resultado del intervalo de confianza de la prueba para
    responder la pregunta anterior?

5.  En general, ¿cómo resumiría los resultados? Asegúrese de abordar las
    implicaciones prácticas.

6.  Grafica los datos de Brian tal que te ayude a visualizar los datos.

7.  ¿Los resultados reflejan lo que usted esperaría de mirar el gráfico?

2. Ejercicio (\[4\] NonLinearLS)
--------------------------------

Considere la siguiente ecuación:

$$
Y = \\frac{\\epsilon}{1+e^{\\beta\_1X\_1+\\beta\_2X\_2}}
$$

*l**o**g*(*Y*)= − *l**o**g*(1 + *e*<sup>*β*<sub>1</sub>*X*<sub>1</sub> + *β*<sub>2</sub>*X*<sub>2</sub></sup>)+*l**o**g*(*ϵ*)

La segunda ecuación es la versión transformada que usaremos para la
estimación.

-   Usando como semilla =1, simule 100 valores de *X*<sub>1</sub> y
    *X*<sub>2</sub> con distribución uniforme entre 0 y 1.
-   Usando el modelo propuesto, simule valores de *Y* donde *a* = 0.8 y
    *b* = 0.5.
-   El ruido tiene distribución normal con media cero y varianza 1.

Aplicando estimación de mínimos cuadrados no lineales paraestimar el
modelo con los datos simulados. Debe obtener los siguientes resultados:

    ## 
    ## Formula: log(Y) ~ -log(1 + exp(a * X1 + b * X2))
    ## 
    ## Parameters:
    ##   Estimate Std. Error t value Pr(>|t|)   
    ## a   0.8470     0.2697   3.141  0.00223 **
    ## b   0.5962     0.2718   2.193  0.03065 * 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.6517 on 98 degrees of freedom
    ## 
    ## Number of iterations to convergence: 3 
    ## Achieved convergence tolerance: 2.299e-06

3. Ejercicio (\[6\] GAM & \[7\] MARS & \[10\] RegBayes)
-------------------------------------------------------

Usando los datos (`dataRegExp.dta`) que se encuentran en DataLectures,
debes estimar el modelo:

*l**y*2 = *f**e**m**a**l**e* + *a**g**e* + *a**g**e*2 + *e**y**e**a**r**s* + *e*<sub>*p*</sub>*o**s* + *w**h**i**t**e* + *b**l**a**c**k* + *c**a**s**a**d**o* + *p**u**b**l**i**c*

Donde

ly2: logaritmo del ingreso female: 1 si es mujer age: edad age2: edad al
cuadrado eyears: años de educación e\_pos: 1 si tiene postgrado white:
blanco black: indígena, negro o mulato casado: si está casado (hombre o
mujer) public: si trabaja en el sector público.

Para la estimación recuerda filtrar los datos para asalariados
(`datos$pe28 >=6500 & datos$pe28 <= 9900`).

El modelo de regresión lineal múltiple, debe arrojar los siguientes
resultados:

    ## 
    ## Call:
    ## lm(formula = ly2 ~ female + age + age2 + eyears + e_pos + white + 
    ##     black + casado + public, data = datos)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -1.9132 -0.3295 -0.0404  0.3086  2.2487 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  2.414e-01  9.270e-02   2.605 0.009244 ** 
    ## female      -8.205e-02  1.983e-02  -4.138 3.61e-05 ***
    ## age          2.052e-02  4.670e-03   4.393 1.16e-05 ***
    ## age2        -1.095e-04  5.447e-05  -2.010 0.044501 *  
    ## eyears       6.779e-02  2.518e-03  26.920  < 2e-16 ***
    ## e_pos        2.937e-01  5.546e-02   5.297 1.27e-07 ***
    ## white        1.188e-01  3.269e-02   3.632 0.000286 ***
    ## black       -1.088e-01  5.154e-02  -2.110 0.034925 *  
    ## casado       1.299e-01  2.026e-02   6.411 1.69e-10 ***
    ## public       1.740e-01  2.046e-02   8.508  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.4977 on 2802 degrees of freedom
    ## Multiple R-squared:  0.373,  Adjusted R-squared:  0.371 
    ## F-statistic: 185.2 on 9 and 2802 DF,  p-value: < 2.2e-16

1.  Replique la estimación del modelo de regresión lineal múltiple.
    Interprete los resultados de cada coeficiente.

2.  Estime un modelo GAM con grados de libertad 4 y 5 (Por ejemplo,
    `s(age,df = 4)`). Interprete el resultado del coeficiente con
    suavizamiento.

3.  Ahora, ¿es el modelo planteado el mejor posible?

-   Usa la estimación MARS para obtener el *mejor* modelo usando este
    enfoque, escribe el modelo de resultado.
-   ¿Qué variables quedaron fuera?
-   Analiza la gráfica de resultados (usando `plotmo`).

1.  Contrastemos los resultados del ejercico anterior. Usando regresión
    bayesiana, ¿cuál es el mejor modelo? (asume una apriori `BIC` para
    los parámetros y una auniforme para la selección del modelo)

-   Usa la estimación `bas.lm` para obtener el *mejor* modelo usando
    este enfoque, escribe el modelo de resultado.
-   ¿Qué variables quedaron fuera? (comaprado con la regresión lineal
    múltiple)

4. Ejercicio: Bootstrap
-----------------------

Usaremos la base de datos `iris` que tiene características de plantas.
Usaremos el algoritmo `kmeans` para generar tres grupos de la siguiente
manera:

    library(datasets)
    head(iris)

<script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Sepal.Length"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["Sepal.Width"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["Petal.Length"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["Petal.Width"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["Species"],"name":[5],"type":["fctr"],"align":["left"]}],"data":[{"1":"5.1","2":"3.5","3":"1.4","4":"0.2","5":"setosa","_rn_":"1"},{"1":"4.9","2":"3.0","3":"1.4","4":"0.2","5":"setosa","_rn_":"2"},{"1":"4.7","2":"3.2","3":"1.3","4":"0.2","5":"setosa","_rn_":"3"},{"1":"4.6","2":"3.1","3":"1.5","4":"0.2","5":"setosa","_rn_":"4"},{"1":"5.0","2":"3.6","3":"1.4","4":"0.2","5":"setosa","_rn_":"5"},{"1":"5.4","2":"3.9","3":"1.7","4":"0.4","5":"setosa","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>

    set.seed(20)
    irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)
    irisCluster

    ## K-means clustering with 3 clusters of sizes 50, 52, 48
    ## 
    ## Cluster means:
    ##   Petal.Length Petal.Width
    ## 1     1.462000    0.246000
    ## 2     4.269231    1.342308
    ## 3     5.595833    2.037500
    ## 
    ## Clustering vector:
    ##   [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
    ##  [36] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
    ##  [71] 2 2 2 2 2 2 2 3 2 2 2 2 2 3 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3
    ## [106] 3 2 3 3 3 3 3 3 3 3 3 3 3 3 2 3 3 3 3 3 3 2 3 3 3 3 3 3 3 3 3 3 3 2 3
    ## [141] 3 3 3 3 3 3 3 3 3 3
    ## 
    ## Within cluster sum of squares by cluster:
    ## [1]  2.02200 13.05769 16.29167
    ##  (between_SS / total_SS =  94.3 %)
    ## 
    ## Available components:
    ## 
    ## [1] "cluster"      "centers"      "totss"        "withinss"    
    ## [5] "tot.withinss" "betweenss"    "size"         "iter"        
    ## [9] "ifault"

Como puedes ver, los promedios de cada grupo generado es:

    irisCluster$centers

    ##   Petal.Length Petal.Width
    ## 1     1.462000    0.246000
    ## 2     4.269231    1.342308
    ## 3     5.595833    2.037500

Usa bootstrap para obtener ls distribución de probabilidad de los
centroides. La configuración es: el tamño de la muestra en cada
iteración es 500. Además, fija 1000 muestras bootstrap. Debes obtener
resultados como los siguientes:

![](Trabajo_files/figure-markdown_strict/unnamed-chunk-11-1.png)

interpreta los resultados obtenidos, ¿puedes confiar en la primera
estimación? (la de `irisCluster$centers`)
