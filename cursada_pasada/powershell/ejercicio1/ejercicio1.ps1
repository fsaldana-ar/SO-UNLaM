########### ENCABEZADO ###########

#

#   Nombre del script: ejercicio1.ps1

#   Trabajo práctico: N°2
#   Ejercicio: N°1
#   Integrantes:

#       Matias Ángel Jimenénez Vitale   34.799.834

#       Maximiliano Federico Manso      37.792.709

#       Germán Alejandro                34.412.028

#       Jonathan Aranguri               40.672.991

#       Fernando Ezequiel Saldaña       38.346.178

#   Correspondiente a: Entrega

#

#################################
Param($pathsalida)
$existe = Test-Path $pathsalida
if ($existe -eq $true){
    $lista = Get-ChildItem -File
    foreach ($item in $lista){
        Write-Host "$($item.Name) $($item.Length)"
    }
} else {
    Write-Error "El path no existe"
}

<#
a) El objetivo del script es listar todos los nombres de archivos y su peso del directorio actual donde se esta ejecutando el script.
Tambiien valida que se reciba por parametro un PATH valido sino se informa error.

b) Agregariamos la sig. validacion:
    1- Que el parametro $pathsalida sea requerido
    2- Que el parametro $pathsalida sea distinto de null o empty
    3- Que el parametro $pathsalida sea un directorio valido mediane el cmdlet Test-Path
    4- Que el parametro $pathsalida sea un string

    Param
    (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-Path $_ -PathType ‘Container’})]
        [string] $pathsalida
    )
    
c) Para devolver una salida similar podriamos usar el cmdlet Select-Object pasando con pipeline el resultado del cmdlet Get-ChildItem
Ejemplo:
    Get-ChildItem -File | Select-Object Name, Length
#>