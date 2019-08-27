function header(){
    printf FORMAT_HEADER, "Nombre", "CUIT", "IMP GANANCIAS", "IMP IVA", "MONOTRIBUTO", "INTEGRANTE SOC", "EMPLEADOR", "ACTIVIDAD MONOTRIBUTO"
    printf FORMAT_HEADER, "------------------------------", "-----------", "--------------", "---------------------", "------------", "--------------", "------------", "---------------------"
    # print "Nombre                         CUIT         IMP GANANCIAS  IMP IVA	         MONOTRIBUTO  INTEGRANTE SOC EMPLEADOR    ACTIVIDAD MONOTRIBUTO"
    # print "------------------------------ ------------ -------------- --------------------- ------------ -------------- ------------ ---------------------" 
}

function cod_to_desc_text(cod){
    if (cod == "NI" || cod == "N") return "No Inscripto"
    if (cod == "AC" || cod == "S") return "Activo"
    if (cod == "EX") return "Exento"
    if (cod == "NA") return "No alcanzado"
    if (cod == "XN") return "Exento no alcanzado"
    if (cod == "AN") return "Activo no alcanzado"
    if (cod == "NC") return "No corresponde"
    return cod
}

function print_header_and_inc_count(){
    if (COUNT == 0) {
        header()
    }
    COUNT++;
}

function output_dni(){
    printf FORMAT_HEADER, $4, $1$2$3, cod_to_desc_text($5), cod_to_desc_text($6), cod_to_desc_text($7), cod_to_desc_text($8), cod_to_desc_text($9), cod_to_desc_text($10), cod_to_desc_text($11)
}

function output_name_and_cuit(){
    printf FORMAT_HEADER, $2, $1, cod_to_desc_text($3), cod_to_desc_text($4), cod_to_desc_text($5), cod_to_desc_text($6), cod_to_desc_text($7), cod_to_desc_text($8), cod_to_desc_text($9)
}

#Comparo si el nombre contiene al valor y lo muestro
function compare_by_name(){
    if ($2 ~ VAL)
        {
            print_header_and_inc_count()
            output_name_and_cuit()
        }
}

#Comparo si el dni es igual al valor y lo muestro
function compare_by_dni(){
    if ($2 == VAL)
        {
            print_header_and_inc_count()
            output_dni()
        }
}

#Comparo si el cuit es igual al valor y lo muestro
function compare_by_cuit(){
    if ($1 == VAL)
        {
            print_header_and_inc_count()
            output_name_and_cuit()
        }
}

#Especifico el FIELDWIDTHS si es por dni o por cuit/nombre
function fieldwidths_by_op(){
    if (OP == "d") {       
        FIELDWIDTHS = "2 8 1 30 2 2 2 1 1 2";   
    } else {
        FIELDWIDTHS = "11 30 2 2 2 1 1 2";
    }
}
BEGIN {
    fieldwidths_by_op()
    COUNT = 0;
    FORMAT_HEADER = "%-30s %-11s %-14s %-21s %-12s %-14s %-12s %-21s\n"
}

#Cuerpo
{
    if (OP == "d")
        compare_by_dni()
    if (OP == "c")
        compare_by_cuit()
    if (OP == "n")
        compare_by_name()     
}
END {
    if (COUNT != 0)
        print "Cantidad de contribuyentes filtrados: "COUNT
}

