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
<#
    .SYNOPSIS
    Este script permite generar un resumen de multas por año y patente

    .DESCRIPTION
    El script recibe por parametro un archivo CSV con los datos de las multas que contiene la patente, el monto y la fecha en la ue se realizo la multa

    .EXAMPLE
    ./ejercicio3.ps1 -Entrada "entrada.csv" -Salida "/home/matiascirojimenez/Escritorio/SISOP2019/powershell"

    .NOTES
    Antes de ejecutar eñ script por consola, pararse en el directorio donde esta ubicado el script con cd "path"
#>

Param
(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({Test-Path $_})]
    [string]$Entrada,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({Test-Path $_})]
    [string]$Salida
)

$multas = Import-Csv -Path $Entrada
$matriz = [ordered]@{}

foreach ($multa in $multas) {
  $anio = $multa.Fecha.Substring($multa.Fecha.Length-4)
  $patente = $multa.Patente

  if(!$matriz[$patente]) { 
      $matriz[$patente] = [ordered]@{} 
    }
  if(!$matriz[$patente][$anio]) { 
      $matriz[$patente][$anio] = 0 
    }
  $matriz[$patente][$anio] += $multa.ValorMulta
}

$lista = @()

foreach ($patente in $matriz.Keys) {
  foreach ($anio in $matriz[$patente].Keys) {
    $valor = $matriz[$patente][$anio]
    $objeto = @{Patente=$patente;Año=$anio;TotalMultas=$valor}
    $lista += $objeto
  }
}

$lista | Select-Object -Property Patente,Año,TotalMultas | Export-Csv -Path $Salida\salida.csv -Force