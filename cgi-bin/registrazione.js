/*function checkEmpty(valore))  
{  
    if(valore.length == 0) return true;
    return false;
}

function checkEmail(){
    var email = document.getElementById("email");
    if(checkEmpty(email.value)){
        
    }
}*/
/*
function controlloVuoto(){
    var arrivo = document.forms["FormPren"]["dataArrivo"].value;
    if (arrivo == null || arrivo == "") {
        alert("Name must be filled out");
        return true;
    }
    return false;
}

function validazioneForm(){
    if(!controlloVuoto()){
        alert("Nessun errore");
        return true;
    }
    else{
        alert("Errore");
        return false;
    }
}*/
/*
function validateForm() {
    var x = document.forms["FormPren"]["dataArrivo"].value;
    if (x == null || x == "") {
        alert("Name must be filled out");
        return false;
    }
}*/

function controlloData(){
    var data = document.forms["FormPren"]["dataArrivo"].value;
    if (data == null || data == "") {
        return false;
    }
    else{
        /*var re = new RegExp("^(0[1-9]|[12][0-9]|3[01])[/](0[1-9]|1[012])[/]((19|20)\d\d)");*/
        /*if(/^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/.test(data)){*/
         /*if(/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(data)){*/
        var date_regex = /^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/ ;
if(!(date_regex.test(data)))
{    alert("Pattern errato");
            return false;
        }
        else {alert("Data corretta");
             return true;
             }
    }

}

