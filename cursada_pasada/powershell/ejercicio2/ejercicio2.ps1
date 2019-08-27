########### ENCABEZADO ###########

#

#   Nombre del script: ejercicio2.ps1

#   Trabajo práctico: N°2
#   Ejercicio: N°2
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
Este es un script que cuenta archivos duplicados

.DESCRIPTION
Este script cuenta archivos duplicados en un directorio recursivamente entendiendo por ellos a los que tienen mismo nombre y peso

.EXAMPLE
./ejercicio2.ps1 -path /home 

#>

Param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({Test-Path $_})]
    [string]$path
)

$existe = Test-Path $path
if ($existe -eq $true){
    $lista = Get-ChildItem $path -File -Recurse
    $files = @{}
    $duplicados = @{}
    foreach ($item in $lista){
        if ($files.ContainsKey($item.Name)){
            if (!$duplicados.ContainsKey($item.Name)){
                $duplicados.add($item.Name, $item.Length)        
            }
        }
        else
        {
            $files.add($item.Name, $item.Length)
        }
    }
    foreach($dup in $duplicados.keys)
    {
        Write-Host "$($dup)"
    }
} else {
    Write-Error "El path no existe"
}