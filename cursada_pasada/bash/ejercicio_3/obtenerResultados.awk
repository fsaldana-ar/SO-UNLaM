BEGIN{
    linea1=1;
    linea2=1;
    linea3=1;
    i=0;
}
{
    if(NR > 1){
        for(i=2;i<=6;i++){
            
            if($i != "X"){
                linea1 = 0;
            }
        }

        for(i=7;i<=11;i++){
            if($i != "X"){
                linea2 = 0;
            }
        }

        for(i=12;i<=16;i++){
            if($i != "X"){
                linea3 = 0;
            }
        }
    
        if (linea3 == 1){
            printf("l%s ",$1);
        }

        if (linea2 == 1){
            printf("l%s ",$1);
        }
        if (linea1 == 1){
            printf("l%s ",$1);
        }
        if (linea1 == 1 && linea2 == 1 && linea3 == 1){ # Hace bingo
            printf("b%s ",$1);
        }

     }

    linea1=1;
    linea2=1;
    linea3=1;
    
}