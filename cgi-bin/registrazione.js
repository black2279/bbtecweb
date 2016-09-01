function eDefinito(el){
    var elemento = document.getElementById(el).value;
    if(elemento == null || elemento == ""){
			var errore = document.createElement('div');
                errore.id = el+'errore';
                errore.className = 'error';
				errore.innerHTML = "Campo obbligatorio";
				
            if(!document.getElementById(el+"errore")){
                var id = document.getElementById(el);
	           id.parentElement.insertBefore(errore, id);
                return false;
                }
            else   {
					var id = document.getElementById(el+"errore");
					id.parentNode.replaceChild(errore,id);
                   return false;
                   }
    }
    else{
        return true;
    }
}

function controlloData(campo){
	if(document.getElementById("confrontoerrore")){
       var rimuovere = document.getElementById("confrontoerrore");
       rimuovere.parentNode.removeChild(rimuovere);
    }
    if (eDefinito(campo)){
			var data = document.getElementById(campo).value;
            var date_regex = /^(0[1-9]|1\d|2\d|3[01])\/(0[1-9]|1[0-2])\/(19|20)\d{2}$/ ;
            if(!(date_regex.test(data))){
				var errore = document.createElement('div');
                    errore.id = campo+'errore';
					errore.className = 'error';
					errore.innerHTML = "Inserire la data con il formato gg/mm/aaaa";
					
                if(!document.getElementById(campo+"errore")){
                    var id = document.getElementById(campo);
                    id.parentElement.insertBefore(errore, id);
                    return false;
                    }
                else  { 
					var id = document.getElementById(campo+"errore");
					id.parentNode.replaceChild(errore,id);
                    return false;
                    }
                    
                }
            else{
                
                var parti_input = data.split("/");
                var giorno_input = parti_input[0];
                var mese_input= parti_input[1];
                var anno_input = parti_input[2];
				var data_input = new Date(anno_input, mese_input-1, giorno_input);
                var oggi = new Date();
                if(campo != 'dataNascita'){
                if(data_input < oggi){
					var errore = document.createElement('div');
                    errore.id = campo+'errore';
					errore.className = 'error';
					errore.innerHTML = "La data deve essere successiva alla data odierna";
					
                    if(!document.getElementById(campo+"errore")){
                    var id = document.getElementById(campo);
                    id.parentElement.insertBefore(errore, id);
                    return false;
                    }
                    else  { 
						var id = document.getElementById(campo+"errore");
						id.parentNode.replaceChild(errore,id);
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
                    var errore = document.createElement('div');
                    errore.id = campo+'errore';
					errore.className = 'error';
					errore.innerHTML = "La data di nascita non &egrave; valida";
					
					if(!document.getElementById(campo+"errore")){
                    var id = document.getElementById(campo);
                    id.parentElement.insertBefore(errore, id);
                    return false;
                    }
                    else  { 
						var id = document.getElementById(campo+"errore");
						id.parentNode.replaceChild(errore,id);
						return false;
                    }
                    }else{
					var eighteen = new Date(data_input).setFullYear(data_input.getFullYear()+18)-data_input;
                if(oggi - data_input < eighteen ){
					var errore = document.createElement('div');
                    errore.id = campo+'errore';
					errore.className = 'error';
					errore.innerHTML = "&Egrave; necessario avere pi&ugrave; di 18 anni";
                    
					if(!document.getElementById(campo+"errore")){
                    var id = document.getElementById(campo);
                    id.parentElement.insertBefore(errore, id);
                    return false;
                    }
                    else  { 
						var id = document.getElementById(campo+"errore");
						id.parentNode.replaceChild(errore,id);
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
        
		var d1 = new Date(anno_arr, mese_arr-1, giorno_arr);
		var d2 = new Date(anno_part, mese_part-1, giorno_part);
        
        if (d1 >= d2){
			var errore = document.createElement('div');
                errore.id = 'confrontoerrore';
				errore.className = 'error';
                if(d1>d2){
                errore.innerHTML = "La data di partenza deve essere successiva a quella di arrivo";
                }
                else{ 
                errore.innerHTML = "La data di partenza e quella di arrivo non possono coincidere";
                }
            if(!document.getElementById("confrontoerrore")){
                var id = document.getElementById("dataPartenza");
				id.parentElement.insertBefore(errore, id);
                return false;
                }
            else   {
					var id = document.getElementById("confrontoerrore");
					id.parentNode.replaceChild(errore,id);
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
	}else 
	return false;
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
			var errore = document.createElement('div');
            errore.id = str+'errore';
            errore.className = 'error';
			errore.innerHTML = "Non sono consentiti caratteri numerici";
			if(!document.getElementById(str+"errore")){
               var id = document.getElementById(str);
	           id.parentElement.insertBefore(errore, id);
               return false;
            }
            else {
				var id = document.getElementById(str+"errore");
				id.parentNode.replaceChild(errore,id);
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
        var controllo = numero.match(/^[0-9]*$/);
        if(controllo == null){
			var errore = document.createElement('div');
            errore.id = num+'errore';
            errore.className = 'error';
			errore.innerHTML = "Il campo pu&ograve; contenere solo cifre";
			if(!document.getElementById(num+"errore")){
                var id = document.getElementById(num);
				id.parentElement.insertBefore(errore, id);
                return false;
                }
                else {
				var id = document.getElementById(num+"errore");
				id.parentNode.replaceChild(errore,id);
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
        var controllo = numero.match(/^[0-9]*$/);
        if(controllo == null){
		var errore = document.createElement('div');
        errore.id = num+'errore';
        errore.className = 'error';
		errore.innerHTML = "Il campo pu&ograve; contenere solo cifre";
            if(!document.getElementById(num+"errore")){
                var id = document.getElementById(num);
				id.parentElement.insertBefore(errore, id);
                return false;
                }
                else {
				var id = document.getElementById(num+"errore");
				id.parentNode.replaceChild(errore,id);
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
			var error = document.createElement('div');
                error.id = em+'errore';
                error.className = 'error';
				error.innerHTML = "Inserire un indirizzo email valido";
            if(!document.getElementById(em+"errore")){
                var id = document.getElementById(em);
	           id.parentElement.insertBefore(error, id);
                return false;
                }
                else {
				var id = document.getElementById(em+"errore");
				id.parentNode.replaceChild(error,id);
                return false;
                }
           }
        else {
                if(document.getElementById(em+"errore")){
                    var rimuovere = document.getElementById(em+"errore");
                    rimuovere.parentNode.removeChild(rimuovere);
                }
            }
        var em1 = document.getElementById('email').value;
        var em2 = document.getElementById('cemail').value;
        if(em1 && em2){
            if (em1 != em2){
                if(!document.getElementById("confrontoemail")){
                var error = document.createElement('div');
                error.id = 'confrontoemail';
                error.className = 'error';
                var testoerrore = document.createTextNode("Le email non coincidono");
                error.appendChild(testoerrore);
                var id = document.getElementById("email");
				id.parentElement.insertBefore(error, id);
				}
                return false;
			}else{
                if(document.getElementById("confrontoemail")){
                    var rimuovere = document.getElementById("confrontoemail");
                    rimuovere.parentNode.removeChild(rimuovere);
                }
				return true;
			}
        }
	}else{
		return false;
	}
}