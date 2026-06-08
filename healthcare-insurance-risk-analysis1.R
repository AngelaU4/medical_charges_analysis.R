################################################################################
#                   TALLER PRÁCTICO RSTUDIO - SEMANA 2                         #
# Nombres: [Inserta aquí los nombres de los integrantes]                       #
# Base de Datos: Gastos Médicos y Seguros de Salud (insurance.csv)             #
################################################################################

# ==============================================================================
# MARCO DE INVESTIGACIÓN
# ==============================================================================
# PREGUNTA PROBLEMA: 
# ¿De qué manera el hábito de fumar y el Índice de Masa Corporal (IMC) inciden 
# exponencialmente en el costo de los gastos médicos individuales de los afiliados?
#
# OBJETIVO GENERAL:
# Analizar el impacto financiero de los factores de riesgo de salud (tabaquismo 
# y obesidad) en los costos de facturación médica mediante la manipulación de 
# datos y programación en RStudio.


# ==============================================================================
# PASO 1: CARGA Y ACTIVACIÓN DE LIBRERÍAS
# ==============================================================================
# Forzamos la instalación limpia de las dependencias necesarias si faltaran.
if(!require(tidyverse)) install.packages("tidyverse", dependencies = TRUE)
library(tidyverse) # Activa dplyr, ggplot2 y readr


# ==============================================================================
# PASO 2: CARGA DE LA BASE DE DATOS
# ==============================================================================
# Importamos la base de datos académica directamente desde su repositorio en la nube.
url_datos <- "https://raw.githubusercontent.com/stedy/Machine-Learning-with-R-datasets/master/insurance.csv"
datos_seguro <- read.csv(url_datos)


# ==============================================================================
# PASO 3: EXPLORACIÓN DE LA BASE DE DATOS
# ==============================================================================
print("--- VOLUMEN Y DIMENSIONES (Número de filas y columnas) ---")
dim(datos_seguro) 

print("--- TIPOS DE VARIABLE Y UNIDADES (Estructura interna) ---")
str(datos_seguro) 

print("--- RESUMEN ESTADÍSTICO (Distribución general) ---")
summary(datos_seguro) 


# ==============================================================================
# PASO 4: LIMPIEZA Y PREPARACIÓN DE VARIABLES
# ==============================================================================
# Aplicamos un filtro de calidad para eliminar registros duplicados o filas vacías.
datos_limpios <- datos_seguro %>%
  distinct() %>%           
  drop_na()                

# Definición de tipos de variables: Convertimos los textos en Categorías (Factores)
datos_limpios$sex <- as.factor(datos_limpios$sex)
datos_limpios$smoker <- as.factor(datos_limpios$smoker)
datos_limpios$region <- as.factor(datos_limpios$region)


# ==============================================================================
# PASO 5: OPERACIONES BÁSICAS Y GRÁFICOS
# ==============================================================================
# Operación matemática avanzada: Agrupar y calcular el promedio exacto de cargos
tabla_gastos <- datos_limpios %>%
  group_by(smoker) %>%
  summarise(Gasto_Promedio = mean(charges))

print("--- RESULTADO MATEMÁTICO: GASTOS MEDIOS ---")
print(tabla_gastos)

# Generación del gráfico estadístico de cajas (Boxplot) para sustentación visual
ggplot(datos_limpios, aes(x = smoker, y = charges, fill = smoker)) +
  geom_boxplot() +
  labs(
    title = "Distribución de Gastos Médicos: Fumadores vs No Fumadores",
    x = "¿El paciente es fumador?", 
    y = "Gastos en Salud Anuales (USD)"
  ) +
  theme_minimal()


# ==============================================================================
# PASO 6: FUNCIONES LÓGICAS Y CICLOS/BUCLES
# ==============================================================================
print("--- SISTEMA AUTOMATIZADO DE ALERTA DE RIESGOS (PRIMEROS 10 PACIENTES) ---")

# Un bucle 'for' que recorre la base de datos de forma automática fila por fila
for (i in 1:10) {
  imc_actual <- datos_limpios$bmi[i]
  edad_actual <- datos_limpios$age[i]
  
  # Condicional lógico (Función lógica anidada)
  if (imc_actual >= 30) {
    estado <- "Obesidad Crítica"
  } else if (imc_actual >= 25 & imc_actual < 30) {
    estado <- "Sobrepeso"
  } else {
    estado <- "Peso Saludable"
  }
  
  # Imprime un reporte personalizado para cada paciente en la consola
  print(paste("Paciente", i, "- Edad:", edad_actual, "| IMC:", imc_actual, "| Estado:", estado))
}