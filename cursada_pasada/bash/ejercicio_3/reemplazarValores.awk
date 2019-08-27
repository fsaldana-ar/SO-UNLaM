{
    if(NR > 1){#Si es la primer linea la imprimo para guardarlo y no perder la estructura del archivo
        if( NF > 1 )
        {
            printf("%d\t",$1);#imprimo los numeros de los cartones
            for(i=2; i<= NF; i++){
                if(bolilla != $i){#mientras no sea un numero igual a la bolilla lo voy imprimiendo
                    printf("%s\t",$i);
                }else{
                    printf("X\t");
                }            
            }
            printf("\n");
        }
    } else{
        print($0);
    }
}