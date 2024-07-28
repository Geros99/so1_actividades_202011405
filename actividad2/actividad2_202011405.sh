#!/bin/bash


# PEDIR EL NOMBRE DE USUARIO DE GITHUB
echo "Ingrese su nombre de usuario de GitHub:"
#LEER EL NOMBRE DE USUARIO
read USUARIO

# SI LA VARIABLE USUARIO ESTA VACIA SE MUESTRA UN MENSAJE DE ERROR
if [ -z "$USUARIO" ]; then
    echo "Error: Debe ingresar un nombre de usuario de GitHub valido."
    exit 1
fi

# CONSULTA A LA API DE GITHUB
RESPUESTA=$(curl -s "https://api.github.com/users/$USUARIO")

# AQUI SE EXTRAEN LOS DATOS QUE LA API RETORNA
IDENTIFICADOR=$(echo "$RESPUESTA" | grep '"id"' | awk -F ': ' '{print $2}' | tr -d ',')
FECHA_CREACION=$(echo "$RESPUESTA" | grep '"created_at"' | awk -F ': ' '{print $2}' | tr -d '",')

# VERIFICAR SI LA INFORMACION DEL USUARIO SE PUDO OBTENER
if [ -z "$IDENTIFICADOR" ]; then
    echo "Error: No se pudo obtener información del usuario $USUARIO."
    exit 1
fi

# CONFIGURACION DEL MENSAJE DE SALIDA
MENSAJE="Hola $USUARIO. User ID: $IDENTIFICADOR. Cuenta fue creada el: $FECHA_CREACION."
echo "$MENSAJE"

# CREACION DEL ARCHIVO LOG CON LA FECHA ACTUAL
FECHA=$(date +%Y-%m-%d)
DIRECTORIO="/tmp/$FECHA"
mkdir -p "$DIRECTORIO"
ARCHIVO_LOG="$DIRECTORIO/saludos.log"

# AGREGAR EL MENSAJE AL ARCHIVO LOG
echo "$MENSAJE" >> "$ARCHIVO_LOG"


#CREACION DEL CRONJOB
#crontab -e -> elegir nano y lueg ingresar la siguiente ruta:
# */5 * * * * /home/gerson/Escritorio/SOPES1_2S2024/actividad2_202011405.sh
# */5 * * * * -> ejecuta cada 5 minutos
#  Guardar y salir