function controlloData(campo){
            var data = document.getElementById(campo).value;

    if (data == null || data == "") {
            if(!document.getElementById(campo+"errore")){
                var errore = document.createElement('div');
                errore.id = campo+'errore';
                var testoerrore = document.createTextNode("Campo obbligatorio");
                errore.appendChild(testoerrore);
                var id = document.getElementById(campo);
	           id.parentElement.insertBefore(errore, id);
                return false;
                }
            else   {document.getElementById(campo+"errore").innerHTML = "Campo obbligatorio";
                   return false;
                   }
                
        }
    else {
            var date_regex = /^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/ ;
            if(!(date_regex.test(data))){
                if(!document.getElementById(campo+"errore")){
                    var errore = document.createElement('div');
                    errore.id = campo+'errore';
                    var testoerrore = document.createTextNode("Inserire la data con il formato gg/mm/aaaa");
                    errore.appendChild(testoerrore);
                    var id = document.getElementById(campo);
                    id.parentElement.insertBefore(errore, id);
                    return false;
                    }
                else  { document.getElementById(campo+"errore").innerHTML = "Inserire la data con il formato gg/mm/aaaa";
                    return false;
                      }
                    
                }
            else{
                if(document.getElementById(campo+"errore")){
                    var rimuovere = document.getElementById(campo+"errore");
                    rimuovere.parentNode.removeChild(rimuovere);
                    
                }
            }
        }
    
    var arr = document.getElementById("dataArrivo").value;
    var part = document.getElementById("dataPartenza").value;
    if (arr && part){
        var parti_arr = arr.split("/");
        var parti_part = part.split("/");
        var giorno_arr = parti_arr[0];
        var mese_arr= parti_arr[1];
        var anno_arr = parti_arr[2]; 
        
        var giorno_part = parti_part[0];
        var mese_part= parti_part[1];
        var anno_part = parti_part[2];
        
        var d1 = Date.parse(anno_arr+"-"+mese_arr+"-"+giorno_arr);
        var d2 = Date.parse(anno_part+"-"+mese_part+"-"+giorno_part);
        
        if (d1 > d2){
            if(!document.getElementById("confrontoerrore")){
                var errore = document.createElement('div');
                errore.id = 'confrontoerrore';
                var testoerrore = document.createTextNode("La data di partenza deve essere successiva a quella di arrivo");
                errore.appendChild(testoerrore);
                var id = document.getElementById("dataPartenza");
	           id.parentElement.insertBefore(errore, id);
                return false;
                }
            else   {document.getElementById("confrontoerrore").innerHTML = "La data di partenza deve essere successiva a quella di arrivo";
                   return false;
                   }
        }
        else {
                if(document.getElementById("confrontoerrore")){
                    var rimuovere = document.getElementById("confrontoerrore");
                    rimuovere.parentNode.removeChild(rimuovere);
                     return true;
                }
            }
    }
    return true;
}
