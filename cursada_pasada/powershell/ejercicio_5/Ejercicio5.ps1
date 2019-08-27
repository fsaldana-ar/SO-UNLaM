########### ENCABEZADO ###########

#

#   Nombre del script: ejercicio5.ps1

#   Trabajo práctico: N°2
#   Ejercicio: N°5
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
    Cada una determinada cantidad de tiempo realiza una de las siguientes acciones:
	- Informar la cantidad de procesos que se encuentran corriendo en ese momento.
	- Indicar la cantidad de archivos que contiene un directorio.

    .DESCRIPTION
    Se informa la cantidad de archivos que se encuentran en la direción que se recibe por parámetro, o se informa
    la cantidad de procesos que se encuetran corriendo en ese momento; segun se reciba por parametro, cada cierto
    intervalo de tiempo. 
    Para detener el proceso, ejecutar la siguiente linea:
    Unregister-Event TimerEvent

    .PARAMETER procesos
    Indica que se mostrará la cantidad de procesos corriendo al momento de ejecutar el script.

    .PARAMETER archivos
    Indica que se mostrará la cantidad de archivos que contiene un directorio.

    .PARAMETER directorio
    Indica el directorio a evaluar. Solo se puede utilizar si se pasa el parámetro Archivos.

    .EXAMPLE
        .\Ejercicio5.ps1 -archivos -directorio "C:\"
	    .\Ejercicio5.ps1 -procesos
#>

[CmdletBinding()]
Param(
	[Parameter(Mandatory=$True,
    ParameterSetName="Procesos")]
    [switch]$Procesos,

    [Parameter(Mandatory=$True,ParameterSetName="Archivos")]
    [switch]$Archivos,

    [Parameter(Mandatory=$True,ParameterSetName="Archivos")]
	[ValidateScript({Test-Path $_})] 
    [string]$Directorio

)

# Creo un Timer, y le asigno el intervalo ingresado por parámetro

$timer=New-Object -Type Timers.Timer
$timer.Interval=1000
$timer.Enabled='True'


# Verifico que no exista el evento TimerEvent. En caso de que ya exista, lo borro

$existe_evento=Get-EventSubscriber | Select-String -pattern "TimerEvent"

if($existe_evento) 
{
    Unregister-Event TimerEvent
}

# Registro un nuevo evento, asociado al Timer, y comienzo a monitorear los archivos en busca de errores

Register-ObjectEvent -InputObject $timer -EventName elapsed –SourceIdentifier  TimerEvent  -Action {

    # Creo una variable para contar

    $contador= 0

    #Verifico que acción hay que realizar


    if($Procesos)
    {

        # Uso una variable para guardar los procesos

        $lista_procesos = get-process

        foreach($proceso in $lista_procesos)
        {
                $contador++
        }

    }
    else
    {
  
        if($Archivos){
            # Uso una variable para guardar los archivos

            $lista_archivos= Get-ChildItem $Directorio -File

            # Cuento cada archivo

            foreach($archivo in $lista_archivos)
            {
                $contador++
            }

            Write-Host "$($contador)"

        }

    }
    
}

# Inicio el Timer

$timer.start()
