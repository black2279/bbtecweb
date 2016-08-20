function eDefinito(el){
    var elemento = document.getElementById(el).value;
    if(elemento == null || elemento == ""){
            if(!document.getElementById(el+"errore")){
                var errore = document.createElement('div');
                errore.id = el+'errore';
                errore.setAttribute('class', 'error');
                var testoerrore = document.createTextNode("Campo obbligatorio");
                errore.appendChild(testoerrore);
                var id = document.getElementById(el);
	           id.parentElement.insertBefore(errore, id);
                return false;
                }
            else   {document.getElementById(el+"errore").innerHTML = "Campo obbligatorio";
                   return false;
                   }
    }
    else{
        return true;
    }
}

function controlloData(campo){
            var data = document.getElementById(campo).value;

    if (data == null || data == "") {
            if(document.getElementById("confrontoerrore")){
                    var rimuovere = document.getElementById("confrontoerrore");
                    rimuovere.parentNode.removeChild(rimuovere);
            }
            if(!document.getElementById(campo+"errore")){
                var errore = document.createElement('div');
                errore.id = campo+'errore';
                errore.setAttribute('class', 'error');
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
            var date_regex = /^(0[1-9]|1\d|2\d|3[01])\/(0[1-9]|1[0-2])\/(19|20)\d{2}$/ ;
            if(!(date_regex.test(data))){
                if(document.getElementById("confrontoerrore")){
                    var rimuovere = document.getElementById("confrontoerrore");
                    rimuovere.parentNode.removeChild(rimuovere);
            }
                if(!document.getElementById(campo+"errore")){
                    var errore = document.createElement('div');
                    errore.id = campo+'errore';
                errore.setAttribute('class', 'error');
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
                
                var parti_input = data.split("/");
                var giorno_input = parti_input[0];
                var mese_input= parti_input[1];
                var anno_input = parti_input[2];
                var data_input = Date.parse(anno_input+"-"+mese_input+"-"+giorno_input);
                var oggi = new Date();
                if(campo != 'dataNascita'){
                if(data_input < oggi){
                    if(!document.getElementById(campo+"errore")){
                    var errore = document.createElement('div');
                    errore.id = campo+'errore';
                errore.setAttribute('class', 'error');
                    var testoerrore = document.createTextNode("La data deve essere successiva alla data odierna");
                    errore.appendChild(testoerrore);
                    var id = document.getElementById(campo);
                    id.parentElement.insertBefore(errore, id);
                    return false;
                    }
                    else  { document.getElementById(campo+"errore").innerHTML = "La data deve essere successiva alla data odierna";
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
                else{
                    if(data_input >= oggi){
                        if(!document.getElementById(campo+"errore")){
                    var errore = document.createElement('div');
                    errore.id = campo+'errore';
                errore.setAttribute('class', 'error');
                    var testoerrore = document.createTextNode("La data di nascita non è valida");
                    errore.appendChild(testoerrore);
                    var id = document.getElementById(campo);
                    id.parentElement.insertBefore(errore, id);
                    return false;
                    }
                    else  { document.getElementById(campo+"errore").innerHTML = "La data di nascita non è valida";
                    return false;
                      }
                    }else{
                if(oggi - data_input < 567600000000){
                    if(!document.getElementById(campo+"errore")){
                     var errore = document.createElement('div');
                    errore.id = campo+'errore';
                errore.setAttribute('class', 'error');
                    var testoerrore = document.createTextNode("&Egrave; necessario avere pi&ugrave; di 18 anni");
                    errore.appendChild(testoerrore);
                    var id = document.getElementById(campo);
                    id.parentElement.insertBefore(errore, id);
                    return false;
                    }
                    else  { document.getElementById(campo+"errore").innerHTML = "&Egrave; necessario avere pi&ugrave; di 18 anni";
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
        }
    }
    }
    if(campo != 'dataNascita'){
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
        
        if (d1 >= d2){
            if(!document.getElementById("confrontoerrore")){
                var errore = document.createElement('div');
                errore.id = 'confrontoerrore';
                if(d1>d2){
                var testoerrore = document.createTextNode("La data di partenza deve essere successiva a quella di arrivo");
                }
                else{
                    
                var testoerrore = document.createTextNode("La data di partenza e quella di arrivo non possono coincidere");
                }
                errore.appendChild(testoerrore);
                var id = document.getElementById("dataPartenza");
	           id.parentElement.insertBefore(errore, id);
                return false;
                }
            else   {
                 if(d1>d2){
                     document.getElementById("confrontoerrore").innerHTML = "La data di partenza deve essere successiva a quella di arrivo";
                 }
                else{
                    document.getElementById("confrontoerrore").innerHTML = "La data di partenza e quella di arrivo non possono coincidere";
                }
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
}

function disattivaerrori(){
    //var myElements = document.querySelectorAll(".error");
    var nascondere = document.getElementById("erarrivo");
    nascondere.style.display=none;
/*for (var i = 0; i < myElements.length; i++) {
    myElements[i].style["display"] = none;
}*/
}

function controlloStringa(str){
    if(eDefinito(str))
    {
        var stringa = document.getElementById(str).value;
        var controllo = stringa.match(/\d/g);
        if(controllo != null){
           if(!document.getElementById(str+"errore")){
                var errore = document.createElement('div');
                errore.id = str+'errore';
                errore.setAttribute('class', 'error');
                var testoerrore = document.createTextNode("Non sono consentiti caratteri numerici");
                errore.appendChild(testoerrore);
                var id = document.getElementById(str);
	           id.parentElement.insertBefore(errore, id);
                return false;
                }
                else   {document.getElementById(str+"errore").innerHTML = "Non sono consentiti caratteri numerici";
                   return false;
                   }
           
           }
        else {
                if(document.getElementById(str+"errore")){
                    var rimuovere = document.getElementById(str+"errore");
                    rimuovere.parentNode.removeChild(rimuovere);
                     return true;
                }
            }
    }
}

function controlloNumeri(num){
     if(eDefinito(num))
    {
        var numero = document.getElementById(num).value;
        var controllo = numero.match(/\d/g);
        if(controllo == null){
           if(!document.getElementById(num+"errore")){
                var errore = document.createElement('div');
                errore.id = str+'errore';
                errore.setAttribute('class', 'error');
                var testoerrore = document.createTextNode("Il campo pu&ograve; contenere solo cifre");
                errore.appendChild(testoerrore);
                var id = document.getElementById(num);
	           id.parentElement.insertBefore(errore, id);
                return false;
                }
                else   {document.getElementById(num+"errore").innerHTML = "Il campo pu&ograve; contenere solo cifre";
                   return false;
                   }
           
           }
        else {
                if(document.getElementById(num+"errore")){
                    var rimuovere = document.getElementById(num+"errore");
                    rimuovere.parentNode.removeChild(rimuovere);
                     return true;
                }
            }
    }
}

function controlloCarta(num,tip){
    if(eDefinito(num)){
        var numero = document.getElementById(num).value;
        var controllo = numero.match(/\D/g);
        if(controllo == null){
            if(!document.getElementById(num+"errore")){
                var errore = document.createElement('div');
                errore.id = str+'errore';
                errore.setAttribute('class', 'error');
                var testoerrore = document.createTextNode("Il campo pu&ograve; contenere solo cifre");
                errore.appendChild(testoerrore);
                var id = document.getElementById(num);
	           id.parentElement.insertBefore(errore, id);
                return false;
                }
                else   {document.getElementById(num+"errore").innerHTML = "Il campo pu&ograve; contenere solo cifre";
                   return false;
                   }
           
           }
        else {
            //var metodo = numero.match() //controllare se tipo pagamento è giusto
                if(document.getElementById(num+"errore")){
                    var rimuovere = document.getElementById(num+"errore");
                    rimuovere.parentNode.removeChild(rimuovere);
                    return true;
                }
            }
        }
}

function controlloEmail(em){
    if(eDefinito(em))
        {
        var email = document.getElementById(em).value;
        var controllo = email.match(/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{1,63}/);
            if(controllo == null){
            if(!document.getElementById(em+"errore")){
                var error = document.createElement('div');
                error.id = email+'errore';
                error.setAttribute('class', 'error');
                var testoerrore = document.createTextNode("Inserire un indirizzo email valido");
                error.appendChild(testoerrore);
                var id = document.getElementById(em);
	           id.parentElement.insertBefore(error, id);
                return false;
                }
                else   {document.getElementById(em+"errore").innerHTML = "Inserire un indirizzo email valido";
                   return false;
                   }
           
           }
        else {
                if(document.getElementById(em+"errore")){
                    var rimuovere = document.getElementById(em+"errore");
                    rimuovere.parentNode.removeChild(rimuovere);
                    return true;
                }
            }
        var em1 = document.getElementById('email').value;
        var em2 = document.getElementById('cemail').value;
        if(em1 && em2){
            if (em1 != em2){
                if(!document.getElementById("confrontoemail")){
                var error = document.createElement('div');
                error.id = 'confrontoemail';
                error.setAttribute('class', 'error');
                var testoerrore = document.createTextNode("Le email non coincidono");
                error.appendChild(testoerrore);
                var id = document.getElementById("email");
	           id.parentElement.insertBefore(error, id);
                return false;
                }
                }
        }
        }
}