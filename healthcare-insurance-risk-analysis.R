################################################################################
# ==============================================================================
# PASO 7: TABLA DE FRECUENCIAS COMPLETA Y CONCLUSIONES
# ==============================================================================
print("--- CONSTRUCCIÓN DE LA TABLA DE FRECUENCIAS: TABAQUISMO ---")

# 1. Frecuencia Absoluta (Conteo directo de pacientes)
frec_absoluta <- table(datos_limpios$smoker)
# 2. Frecuencia Relativa (Proporción / Porcentaje en decimales)
frec_relativa <- prop.table(frec_absoluta)
# 3. Frecuencias Acumuladas (Suma progresiva de las anteriores)
frec_abs_acumulada <- cumsum(frec_absoluta)
frec_rel_acumulada <- cumsum(frec_relativa)
# 4. Unimos todo en una sola matriz o tabla estructurada para el informe
tabla_frecuencias <- cbind(
  Frec_Absoluta     = frec_absoluta,
  Frec_Relativa     = round(frec_relativa, 4), 
  Frec_Abs_Acumula  = frec_abs_acumulada,
  Frec_Rel_Acumula  = round(frec_rel_acumulada, 4)
)
# Convertimos a data frame para que se visualice perfecto en la consola
tabla_frecuencias <- as.data.frame(tabla_frecuencias)

print(tabla_frecuencias)

# ==============================================================================
# PASO 8: ESTADÍSTICOS DESCRIPTIVOS AVANZADOS
# ==============================================================================
print("--- CÁLCULO DE ESTADÍSTICOS INTEGRALES DE LOS GASTOS MÉDICOS ---")

# Instalamos y activamos la librería e1071 para estadística de forma si no está
if(!require(e1071)) install.packages("e1071", dependencies = TRUE)
library(e1071)

# 1. TENDENCIA CENTRAL
media_gastos <- mean(datos_limpios$charges)
mediana_gastos <- median(datos_limpios$charges)

# 2. TENDENCIA NO CENTRAL (Cuartiles Q1, Q2, Q3)
cuartiles_gastos <- quantile(datos_limpios$charges, probs = c(0.25, 0.50, 0.75))

# 3. DISPERSIÓN
varianza_gastos <- var(datos_limpios$charges)
desviacion_gastos <- sd(datos_limpios$charges)
rango_intercuartil <- IQR(datos_limpios$charges)

# 4. FORMA (Asimetría)
asimetria_gastos <- skewness(datos_limpios$charges)

# 5. APUNTAMIENTO (Curtosis)
curtosis_gastos <- kurtosis(datos_limpios$charges)

# 6. ASOCIACIÓN (Correlación entre Edad y Gastos)
correlacion_edad_gastos <- cor(datos_limpios$age, datos_limpios$charges)

# --- IMPRESIÓN CONSOLIDADA EN CONSOLA ---
print(paste("Media (Promedio):", round(media_gastos, 2)))
print(paste("Mediana:", round(mediana_gastos, 2)))
print("Cuartiles (Q1, Q2, Q3):")
print(round(cuartiles_gastos, 2))
print(paste("Desviación Estándar:", round(desviacion_gastos, 2)))
print(paste("Coeficiente de Asimetría:", round(asimetria_gastos, 4)))
print(paste("Curtosis:", round(curtosis_gastos, 4)))
print(paste("Correlación Lineal (Edad vs Gastos):", round(correlacion_edad_gastos, 4)))

# ==============================================================================
# PASO 9: REPRESENTACIÓN GRÁFICA AVANZADA Y COMPLETA
# ==============================================================================
print("--- GENERACIÓN DE GRÁFICOS ESTADÍSTICOS PROFESIONALES ---")

# 1. HISTOGRAMA: Para evaluar la distribución de los Gastos Médicos
ggplot(datos_limpios, aes(x = charges)) +
  geom_histogram(bins = 30, fill = "#1f77b4", color = "white", alpha = 0.85) +
  labs(
    title = "Histograma de Distribución: Gastos Médicos Anuales",
    subtitle = "Análisis de frecuencias cuantitativas de la facturación",
    x = "Cargos Médicos Anuales (en USD)",
    y = "Frecuencia Absoluta (Número de Pacientes)"
  ) +
  theme_minimal()

# 2. DIAGRAMA DE BARRAS: Para evaluar el volumen de Pacientes por Región
ggplot(datos_limpios, aes(x = region, fill = region)) +
  geom_bar(color = "black", alpha = 0.8) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Diagrama de Barras: Distribución de Afiliados por Región",
    subtitle = "Comparativa del volumen operativo en las 4 zonas geográficas",
    x = "Región de Residencia",
    y = "Cantidad de Pacientes Asegurados",
    fill = "Zonas:"
  ) +
  theme_minimal()

# 3. BOX-PLOT (DIAGRAMA DE CAJAS): Relación Cruzada de Fumadores e IMC
# Usamos una variable creada internamente para ver el impacto de la obesidad
datos_limpios <- datos_limpios %>%
  mutate(Condicion_IMC = if_else(bmi >= 30, "Obesidad (IMC >= 30)", "Peso Normal/Sobrepeso"))

ggplot(datos_limpios, aes(x = smoker, y = charges, fill = Condicion_IMC)) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16, outlier.size = 1.5) +
  scale_fill_manual(values = c("#d62728", "#2ca02c")) +
  labs(
    title = "Box-Plot Multivariado: Impacto del Tabaquismo y el IMC en los Costos",
    subtitle = "Análisis cruzado de factores de riesgo versus facturación anual",
    x = "¿El paciente es fumador activo?",
    y = "Gastos Médicos Anuales (USD)",
    fill = "Estado Nutricional:"
  ) +
  theme_minimal()
# ==============================================================================
# PASO 10: IDENTIFICACIÓN CLÁSICA DE OUTLIERS (MÉTODO IQR)
# ==============================================================================
print("--- AUDITORÍA MATEMÁTICA DE VALORES ATÍPICOS (OUTLIERS) ---")

# 1. Calculamos los componentes clave del Rango Intercuartílico
q1 <- quantile(datos_limpios$charges, 0.25)
q3 <- quantile(datos_limpios$charges, 0.75)
ric <- IQR(datos_limpios$charges)

# 2. Establecemos el límite superior formal (Umbral de Outliers)
limite_superior <- q3 + (1.5 * ric)

# 3. Filtramos la base de datos para extraer los registros atípicos
outliers_identificados <- datos_limpios %>% 
  filter(charges > limite_superior)

# 4. Contamos cuántos outliers reales existen y qué porcentaje representan
total_outliers <- nrow(outliers_identificados)
porcentaje_outliers <- (total_outliers / nrow(datos_limpios)) * 100

# --- REPORTE DE AUDITORÍA EN CONSOLA ---
print(paste("Umbral matemático de Outlier (USD):", round(limite_superior, 2)))
print(paste("Cantidad total de pacientes atípicos:", total_outliers))
print(paste("Porcentaje que representan del total:", round(porcentaje_outliers, 2), "%"))




