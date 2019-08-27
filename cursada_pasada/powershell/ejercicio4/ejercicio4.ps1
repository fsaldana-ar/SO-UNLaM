########### ENCABEZADO ###########

#

#   Nombre del script: ejercicio4.ps1

#   Trabajo práctico: N°2
#   Ejercicio: N°4
#   Integrantes:

#       Matias Ángel Jimenénez Vitale   34.799.834

#       Maximiliano Federico Manso      37.792.709

#       Germán Alejandro                34.412.028

#       Jonathan Aranguri               40.672.991

#       Fernando Ezequiel Saldaña       38.346.178

#   Correspondiente a: Entrega

#

#################################

#

#################################
<#
.SYNOPSIS
Se crear un archivo .ZIP que contiene todos los archivos que en su contenido se encuentre el la cadena ingresada

.DESCRIPTION
El script consiste en pasarle un path que contenga archivos, donde se va a buscar en el contenido de cada archivo una cadena especificada y este armara un archivo ZIP con el nombre 
y en la path que se le haya pasado

.EXAMPLE
.\ejercicio4.ps1 ".\ejercicio4\PruebaArchivos" ".\archivos.zip" "Manso
Siendo el primer parametro el path donde se encuentra los archivo para buscar, el segundo path donde se guardara el archivo .ZIP y el tercero la cadena que se buscara en cada archivo


.NOTES#>

Param(
[Parameter (Mandatory = $true, HelpMessage="Ingrese path del contenedor de archivos")][ValidateScript ({Test-Path $_})][string] $pathEntrada,
[Parameter (Mandatory = $true, HelpMessage="Ingrese path del con el nombre del archivo ZIP")][string] $pathSalidaNomArchivo,
[Parameter (Mandatory = $true, HelpMessage="Ingrese la cadena a buscar")][string] $cadena
)

$pathSalida = $pathSalidaNomArchivo.Replace("\$($pathSalidaNomArchivo.Split('\')[-1])","")
if( !(Test-Path $pathSalida))
{
    Write-Error "El path para almacenar el archivo ZIP no es valido" 
    exit
} 

if (!$pathSalidaNomArchivo.Split('\')[-1].Split(".")[-1].Contains("zip") -and !$pathSalidaNomArchivo.Split('\')[-1].Split(".")[-1].Contains("ZIP"))
{
    Write-Error "el nombre del archivo ingresado no es valido"
    exit 
}


#Coloco esto porque sino me genera un error de permiso en los archivo donde no puede acceder el powershell
$ErrorActionPreference = "SilentlyContinue"


$archivos = Get-ChildItem $pathEntrada | Where-Object{Get-Content $_.FullName | Select-String $cadena}

if("$archivos".Equals("") ){
    
    Write-Host "No se encontro ningun archivo con la cadena solicitada"
}
else
{
    $archivos|Compress-Archive -DestinationPath $pathSalidaNomArchivo -Update
}

  