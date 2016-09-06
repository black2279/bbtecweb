#!/usr/bin/perl

use DateTime;
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use Tariffe;
package Std;

use Exporter qw(import);
our @EXPORT = qw(HtmlCode);
sub HtmlCode{
  print "Content-type: text/html\n\n";

        print"
    <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
    <html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"it\" lang=\"it\">


    <head>
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />
	<meta http-equiv=\"Content-Script-Type\" content=\"text/javascript\" />

    <title>Bed and Breakfast Navona</title>
    <meta name=\"title\" content=\"Bed and Breakfast Navona\"/>
    <meta name=\"description\" content=\"Sito del Bed and Breakfast Navona - Roma\" />
    <meta name=\"keywords\" content=\"bed and breakfast, bed, breakfast, Roma, Navona\" />
    <meta name=\"language\" content=\"italian it\" />
    <meta name=\"author\" content=\"Alba Matteo, Andrighetto Cristian, Zoso Leonardo\" />
    <link href=\"../style.css\" rel=\"stylesheet\" type=\"text/css\" />
	<link rel=\"shortcut icon\" href=\"../img/favicon.ico\" />
	<script type=\"text/javascript\" src=\"../Javascript/menu-mobile.js\" ></script>

	</head>

	<body onload=\"menuMobile()\">
    <div id=\"wrapper\">
    <div id=\"header\">
        <img src=\"../img/Logo-bn.png\" alt=\"logo B&amp;B\" id=\"logo\"/>
    <!--<h1>Bed and Breakfast Navona - Roma</h1>-->
    </div>
"
}
sub MenuPren{
print"
    <div id=\"menu\">
        <ul>
            <li><a href=\"../index.html\"><span lang=\"en\">Home</span></a></li>

            <li><a href=\"../chisiamo.html\">Chi siamo</a></li>

            <li><a href=\"../galleria.html\">Galleria</a></li>

            <li><a href=\"../servizi.html\">Servizi</a></li>

            <li><a href=\"../cgi-bin/prezzi.pl\">Tariffe</a></li>

            <li><a href=\"#\">Prenotazioni</a></li>

            <li><a href=\"../contatti.html\">Contatti</a></li>
        </ul>
    </div>
"}
sub Menu{
print"
    <div id=\"menu\">
        <ul>
            <li><a href=\"../index.html\"><span lang=\"en\">Home</span></a></li>

            <li><a href=\"../chisiamo.html\">Chi siamo</a></li>

            <li><a href=\"../galleria.html\">Galleria</a></li>

            <li><a href=\"../servizi.html\">Servizi</a></li>

            <li><a href=\"../cgi-bin/prezzi.pl\">Tariffe</a></li>

            <li><a href=\"../cgi-bin/prenotazioni.pl\">Prenotazioni</a></li>

            <li><a href=\"../contatti.html\">Contatti</a></li>
        </ul>
    </div>
"}
sub MenuPrezzi{
print"
    <div id=\"menu\">
        <ul>
            <li><a href=\"../index.html\"><span lang=\"en\">Home</span></a></li>

            <li><a href=\"../chisiamo.html\">Chi siamo</a></li>

            <li><a href=\"../galleria.html\">Galleria</a></li>

            <li><a href=\"../servizi.html\">Servizi</a></li>

            <li><a href=\"#\">Tariffe</a></li>

            <li><a href=\"../cgi-bin/Prenotazioni.pl\">Prenotazioni</a></li>

            <li><a href=\"../contatti.html\">Contatti</a></li>
        </ul>
    </div>
"}

sub Breadcrumb{
my @percorso = @_;
print "<div id=\"breadcrumb\">
Ti trovi qui: <a href=\"../index.html\"><span lang=\"en\">Home</span></a> &gt;&gt; $percorso[0]
</div>
<div id=\"content\">
";
}

sub FormPren{
my %valori= @_;
print "<div id=\"centrale\">
    <h1>Prenotazioni</h1>
    
    <script type=\"text/javascript\" src=\"registrazione.js\"> window.onload = disattivaerrori();</script>
	<form class=\"FormPren\" action=\"disponibilita.pl\" method=\"post\">
		<fieldset>
			<!--<legend>Prenotazione</legend>-->
            <div class=\"dati\">
            <div id=\"sinistra\">
			<p><label for=\"dataArrivo\">Data Arrivo </label></p>";
            if($valori{'erarrivo'} ne undef){ print "
            <p><span class=\"error\">$valori{'erarrivo'}</span></p>";}
            print "
			<p><input type=\"text\" name=\"dataArrivo\" id=\"dataArrivo\" maxlength=\"10\" value=\"$valori{'arrivo'}\" onblur=\"controlloData('dataArrivo')\"/></p>
            <p><label for=\"dataPartenza\">Data Partenza </label></p>";
            if($valori{'erpartenza'} ne undef){ print "
            <p><span class=\"error\">$valori{'erpartenza'}</span></p>";}
            print "
            <p><input type=\"text\" name=\"dataPartenza\" id=\"dataPartenza\" maxlength=\"10\" value=\"$valori{'partenza'}\" onblur=\"controlloData('dataPartenza')\"/></p>
            </div>
            
            <div id=\"destra\">
            <p><label for=\"singole\">Singole </label></p>";
            if($valori{'ersingole'} ne undef){ print "
            <p><span class=\"error\">$valori{'ersingole'}</span></p>";}
            print "
            <p><input type=\"text\" name=\"singole\" id=\"singole\" maxlength=\"1\" value=\"$valori{'singole'}\" onblur=\"controlloNumeri('singole')\"/></p>
            
            <p><label for=\"doppie\">Doppie </label></p>";
            if($valori{'erdoppie'} ne undef){ print "
            <p><span class=\"error\">$valori{'erdoppie'}</span></p>";}
            print "            
            <p><input type=\"text\" name=\"doppie\" id=\"doppie\" maxlength=\"1\" value=\"$valori{'doppie'}\" onblur=\"controlloNumeri('doppie')\"/></p>
            
			<p><label for=\"adulti\">Adulti </label></p>";
            if($valori{'eradulti'} ne undef){ print "
            <p><span class=\"error\">$valori{'eradulti'}</span></p>";}
            print "
			<p><input type=\"text\" name=\"adulti\" id=\"adulti\" maxlength=\"1\" value=\"$valori{'adulti'}\" onblur=\"controlloNumeri('adulti')\"/></p>
            </div>
            </div>
            <div id=\"elenco\">
            <p>
			<input type=\"checkbox\" name=\"parcheggio\" id=\"parcheggio\" value=\"true\" $valori{'parcheggio'}/> 
			<label for=\"parcheggio\">Voglio usufruire del parcheggio coperto convenzionato (".Tariffe::getPrezzoParcheggio()."&euro;/giorno).</label></p>
            <p>
			<input type=\"checkbox\" name=\"pulizia\" id=\"pulizia\" value=\"true\" $valori{'pulizia'}/> 
			<label for=\"pulizia\" >Pulizia giornaliera della camera (".Tariffe::getPrezzoPulizie()."&euro;/giorno).</label></p>
            <p>
			<input type=\"checkbox\" name=\"navettaaereo\" id=\"navettaaereo\" value=\"true\" $valori{'navaereo'}/> 
			<label for=\"navettaaereo\" >Servizio navetta Fiumicino - Hotel : ".Tariffe::getPrezzoNavettaAeroporto()."&euro;</label></p>
            <p>
			<input type=\"checkbox\" name=\"navettatreno\" id=\"navettatreno\" value=\"true\" $valori{'navtreno'}/>	
			<label for=\"navettatreno\" >Servizio navetta Stazione Termini - Hotel : ".Tariffe::getPrezzoNavettaTreno()."&euro;</label></p>
            </div>
            <!--<input type=\"reset\" value=\"Reset\" />&nbsp;--><input type=\"submit\" id=\"prenota\" value=\"Prenota\" />

		</fieldset>

	</form>
	<form method=\"post\" action=\"ricerca_prenotazioni.pl\">
		<fieldset>
			<!--<legend>Ricerca Prenotazione</legend>-->
			<p><label for=\"numeroPrenotazione\">Numero Prenotazione</label></p>";
            if($valori{'erpren'} ne undef){ print "
            <span class=\"error\">$valori{'erpren'}</span>";}
            print "
			<p><input type=\"text\" name=\"numeroPrenotazione\" id=\"numeroPrenotazione\" value=\"$valori{'npren'}\"/></p>

			<!--<input type=\"reset\" value=\"Reset\" />&nbsp;--><input type=\"submit\" id=\"ricerca\" value=\"Ricerca\" />


		</fieldset>
	</form>
</div>";

}

sub PrintPren{
my($arrivo,$partenza,$adulti,$singole,$doppie,$prezzo,$numeroprenotazione,$parcheggio,$pulizia,$navaereo,$navtreno)=@_;
print "<h1>La tua prenotazione</h1>";
#print "<div id=\"centrale\">";
print "<p>Numero prenotazione: $numeroprenotazione</p>";
print "<div id=\"richiesta\">";
print "<p>Data Arrivo $arrivo</p>";
print "<p>Data Partenza $partenza</p>";
print "<p>Ospiti $adulti</p>";
print "<p>La tua prenotazione comprende:</p>";
if($singole->textContent != 0){
$singole = $singole->textContent;
print "<p>Camere singole: $singole</p>";
}
if($doppie->textContent  != 0){
$doppie = $doppie->textContent;
print "<p>Camere doppie: $doppie</p>";
}
if($parcheggio->textContent eq "true" || $pulizia->textContent eq "true" || $navaereo->textContent eq "true" || $navtreno->textContent eq "true"){
print"<p>La tua prenotazione comprende anche i seguenti servizi</p>";
 if($parcheggio->textContent eq "true"){
   print "<p>- Parcheggio</p>";
   }
   if($pulizia->textContent eq "true"){
   print "<p>- Pulizia Quotidiana</p>";
   }
   if($navaereo->textContent eq "true"){
   print "<p>- Navetta dall'Aeroporto</p>";
   }
   if($navtreno->textContent eq "true"){
   print "<p>- Navetta dalla Stazione</p>";
   }
}
print "<p>Totale: &euro; $prezzo</p>";
#print "</div>";
print "</div>";
}

sub Disp{
my($dataarrivo,$datapartenza,$adulti,$doppie,$singole,$exdoppie,$exsingole)=@_;
#print "<h1>La tua prenotazione</h1>";
print "<div id=\"richiesta\">";
print "<p>Data Arrivo $dataarrivo</p>";
print "<p>Data Partenza $datapartenza</p>";
print "<p>Adulti $adulti</p>";
if($singole) { print "<p>Singole $singole</p>";}
if($doppie) {print "<p>Doppie $doppie</p>";}


my $exdoppie="";
my $exsingole="";
if($doppie != 0){
    if($doppie == 1){
    $exdoppie="$doppie camera doppia";
    }
    else{
    $exdoppie="$doppie camere doppie";
    }
    if($singole != 0){
      print " e ";
    }
    }
if($singole != 0){
    if($    singole == 1){
    $exsingole="$singole camera singola";
    }
    else{
    $exsingole="$singole camere singole";
    }
    }

print "<p>La tua prenotazione comprende: $exdoppie $exsingole.</p>";
print "</div>"
#print "Totale &euro;: ".$prezzo->textContent."\n";
#print "</div>";
}

sub Servizi{
  
my ($parcheggio,$pulizia,$navettaaereo, $navettatreno)=@_;
  print "<div id = \"dettagli\">";
  print "<strong>Servizi</strong>";
  print "<p>Hai richiesto anche: </p>";
   if($parcheggio eq "true"){
   print "<p>- Parcheggio</p>";
   }
   if($pulizia eq "true"){
   print "<p>- Pulizia Quotidiana</p>";
   }
   if($navettaaereo eq "true"){
   print "<p>- Navetta dall'Aeroporto</p>";
   }
   if($navettatreno eq "true"){
   print "<p>- Navetta dalla Stazione</p>";
   }
   print "</div>";
}
sub Prezzi{
  print "<div id = \"dettprezzi\">";
    my($dataarrivo,$datapartenza,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo,$navettatreno,$diff)=@_;
          my $prdoppie = "0";
          my $prsingole = "0";
          my $prparcheggio = "0";
          my $prpulizia = "0";
          my $prnavettaaereo = "0";
          my $prnavettatreno = "0";
    print "<h2>Dettaglio costi</h2>";
      if($doppie > 0){
		  my $prdoppia = Tariffe::getPrezzoCamera('DOPPIA');
          $prdoppie = $prdoppia*$doppie*$diff;
          if($doppie == 1){
          print "<p>$doppie camera doppia = &euro; $prdoppia x $doppie doppia x $diff giorni = &euro; $prdoppie</p>";
          }
          else{
            print "<p>$doppie camere doppie = &euro; $prdoppia x $doppie doppie x $diff giorni= &euro; $prdoppie</p>";
          }
          }
      if($singole > 0){
          my $prsingola = Tariffe::getPrezzoCamera('SINGOLA');
		  $prsingole = Tariffe::getPrezzoCamera('SINGOLA')*$singole*$diff;
          if($singole == 1){
          print "<p>$singole camera singola = &euro; $prsingola x $singole singola x $diff giorni = &euro; $prsingole</p>";
          }
          else{
          print "<p>$singole camere singole = &euro; $prsingola x $singole singole x $diff giorni = &euro; $prsingole</p>";
          }
          }
        my $camere = $singole+$doppie;
      if($parcheggio eq "true"){
          my $prpark = Tariffe::getPrezzoParcheggio();
		  $prparcheggio = $prpark*$diff;
        print "<p>Parcheggio coperto = &euro; $prpark x $diff giorni x $camere camere = &euro; $prparcheggio</p>";
      }
      if($pulizia eq "true"){
          my $prpul = Tariffe::getPrezzoPulizie()*$diff*($singole+$doppie);
		  $prpulizia = $prpul*$diff;
        print "<p>Pulizia quotidiana = &euro; $prpul x $diff giorni x $camere camere = &euro; $prpulizia</p>";
      }
      if($navettaaereo eq "true"){
          $prnavettaaereo = Tariffe::getPrezzoNavettaAeroporto();
        print "<p>Navetta B&amp;B Navona - Aeroporto Fiumicino = &euro; $prnavettaaereo</p>";
      }

      if($navettatreno eq "true"){
          $prnavettatreno = Tariffe::getPrezzoNavettaTreno();
        print "<p>Navetta B&amp;B Navona - Stazione Termini = &euro; $prnavettatreno</p>";
      }
      my $totale = $prdoppie + $prsingole + $prparcheggio + $prpulizia + $prnavettaaereo + $prnavettatreno;
      print "<p>Totale &euro; $totale</p>";
	  print "</div>";
      return $totale;
    }

sub DiffData{
  my ($dataarrivo,$datapartenza)=@_;
  $dataarrivo =~ m!^(0[1-9]|[12][0-9]|3[01])[/](0[1-9]|1[012])[/]((19|20)\d\d)$!;
  my $dt1 = DateTime->new(
      year       => $3,
      month      => $2,
      day        => $1,
      hour       => 00,
      minute     => 00,
      second     => 00,
      nanosecond => 000000000,
      time_zone  => 'Europe/Rome',
  );
  $datapartenza =~ m!^(0[1-9]|[12][0-9]|3[01])[/](0[1-9]|1[012])[/]((19|20)\d\d)$!;
  my $dt2 = DateTime->new(
      year       => $3,
      month      => $2,
      day        => $1,
      hour       => 00,
      minute     => 00,
      second     => 00,
      nanosecond => 000000000,
      time_zone  => 'Europe/Rome',
  );
  my $duration = $dt1->delta_days($dt2);
  return $duration->days;
}

sub Dati{
my($dataarrivo,$datapartenza,$adulti,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo, $navettatreno,$totale,%valori)=@_;
print "<div class=\"FormPren\">";
print "<h2>Inserisci i dati</h2>";
print "<p>Compila i seguenti campi per procedere con la prenotazione. Tutti i campi sono obbligatori.</p>
        <script type=\"text/javascript\" src=\"registrazione.js\"></script>
        <form class=\"dati\" method=\"post\" action=\"prenotazione.pl\">
        <p><input type=\"text\" name=\"dataarrivo\" class=\"nascosto\" value=\"$dataarrivo\" readonly=\"readonly\"/></p>
        
		<p><input type=\"text\" name=\"datapartenza\" class=\"nascosto\" value=\"$datapartenza\" readonly=\"readonly\"/></p>
        
        <p><input type=\"text\" name=\"singole\" class=\"nascosto\" value=\"$singole\" readonly=\"readonly\"/></p>
        
		<p><input type=\"text\" name=\"doppie\" class=\"nascosto\" value=\"$doppie\" readonly=\"readonly\"/></p>
        
		<p><input type=\"text\" name=\"adulti\" class=\"nascosto\" value=\"$adulti\" readonly=\"readonly\"/></p>
        
		<p><input type=\"text\" name=\"doppie\" class=\"nascosto\" value=\"$doppie\" readonly=\"readonly\"/></p>
        
		<p><input type=\"text\" name=\"singole\" class=\"nascosto\" value=\"$singole\" readonly=\"readonly\"/></p>

		<p><input type=\"text\" name=\"parcheggio\" class=\"nascosto\" value=\"$parcheggio\" readonly=\"readonly\"/></p>
        
        <p><input type=\"text\" name=\"pulizia\" class=\"nascosto\" value=\"$pulizia\" readonly=\"readonly\"/></p>
        
		<p><input type=\"text\" name=\"navettaaereo\" class=\"nascosto\" value=\"$navettaaereo\" readonly=\"readonly\"/></p>
		<p><input type=\"text\" name=\"navettatreno\" class=\"nascosto\" value=\"$navettatreno\" readonly=\"readonly\"/></p>
		<p><input type=\"text\" name=\"totale\" class=\"nascosto\" value=\"$totale\"/></p>
		<p>Dati anagrafici</p>
        <fieldset>
            <div id=\"sinistra\">
                <p><label for=\"nome\">Nome </label></p>";
                if($valori{'ernome'} ne undef){print "
                <p><span class=\"error\">$valori{'ernome'}</span></p>"};
                print"
                <p><input type=\"text\" name=\"nome\" id=\"nome\" value=\"$valori{'nome'}\" onblur=\"controlloStringa('nome')\"/></p>
                <p><label for=\"cognome\">Cognome </label></p>";
                if($valori{'ercognome'} ne undef){print "
                <p><span class=\"error\">$valori{'ercognome'}</span></p>"};
                print "
                <p><input type=\"text\" name=\"cognome\" id=\"cognome\" value=\"$valori{'cognome'}\"  onblur=\"controlloStringa('cognome')\"/></p>
                <p><label for=\"dataNascita\">Data di Nascita (gg/mm/aaaa) </label></p>";
                if($valori{'ernascita'} ne undef){print "
                <p><span class=\"error\">$valori{'ernascita'}</span></p>"};
                print "
                <p><input type=\"text\" name=\"dataNascita\" id=\"dataNascita\" maxlength=\"10\" value=\"$valori{'nascita'}\" onblur=\"controlloData('dataNascita')\"/></p>
                <p><label for=\"citta\">Citt&agrave; </label></p>";
                if($valori{'ercitta'} ne undef){print "
                <p><span class=\"error\">$valori{'ercitta'}</span></p>"};
                print "
                <p><input type=\"text\" name=\"citta\" id=\"citta\" value=\"$valori{'citta'}\" onblur=\"controlloStringa('citta')\"/></p>
            </div>
            <div id=\"destra\">
                <p><label for=\"email\">E-mail </label></p>";
                if($valori{'eremail'} ne undef){print "
                <p><span class=\"error\">$valori{'eremail'}</span></p>"};
                print "
                <p><input type=\"text\" name=\"email\" id=\"email\" value=\"$valori{'email'}\" onblur=\"controlloEmail('email')\"/></p>
                <p><label for=\"cemail\">Conferma E-mail </label></p>";
                if($valori{'ercemail'} ne undef){print "
                <p><span class=\"error\">$valori{'ercemail'}</span></p>"};
                print "
                <p><input type=\"text\" name=\"cemail\" id=\"cemail\" onblur=\"controlloEmail('cemail')\" /></p>
                <p><label for=\"telefono\">Numero di cellulare </label></p>";
                if($valori{'ertel'} ne undef){print "
                <p><span class=\"error\">$valori{'ertel'}</span></p>"};
                print "
                <p><input type=\"text\" name=\"telefono\" id=\"telefono\" value=\"$valori{'telefono'}\" maxlength=\"10\"/></p>
            </div>
            </fieldset>
        <p>Dati di pagamento</p>
        <fieldset>
            <p><label for=\"pagamento\">Metodo di pagamento </label></p>";
            if($valori{'ermet'} ne undef){print "
            <p><span class=\"error\">$valori{'ermet'}</span></p>"};
            print "
            <p><select name=\"pagamento\" id=\"pagamento\">
                <option value=\"Visa\" $valori{'Vpag'}>Visa</option>
                <option value=\"Mastercard\" $valori{'Mpag'}>Mastercard</option>
                <option value=\"American Express\" $valori{'Apag'}>American Express</option>
            </select></p>
            <p><label for=\"numerocarta\">Numero carta </label></p>";
            if($valori{'ernumcarta'} ne undef){print "
            <p><span class=\"error\">$valori{'ernumcarta'}</span></p>"};
            if($valori{'ercifre'} ne undef){print "
            <p><span class=\"error\">$valori{'ercifre'}</span></p>"};
            print"
			<p><input type=\"text\" name=\"numerocarta\" id=\"numerocarta\" maxlength=\"16\" onblur=\"controlloCarta('numerocarta','pagamento')\"/></p>
            <p><label for=\"cvc\">CVC </label></p>";
            if($valori{'ercvc'} ne undef){
            print "<p><span class=\"error\">$valori{'ercvc'}</span></p>"};
            print "
            <p><input type=\"text\" name=\"cvc\" id=\"cvc\" maxlength=\"3\" onblur=\"controlloNumeri('cvc')\"/></p>
            <p><label for=\"intcarta\">Nome e Cognome dell'intestatario della carta</label></p>";
            if($valori{'erintcarta'} ne undef){
            print "<p><span class=\"error\">$valori{'erintcarta'}</span></p>"};
            print "
            <p><input type=\"text\" name=\"intcarta\" id=\"intcarta\" value=\"$valori{'intcarta'}\" onblur=\"controlloStringa('intcarta')\"/></p>
        </fieldset>
        <p><input type=\"submit\" id=\"prenota\" value=\"Prenota\"/></p>
        </form>
        </div>";
            
}

sub EndHtml{
print "</div>
    <div id=\"footer\">
    <div id=\"left\">
    <p>Tutti i diritti riservati</p>
	<img class=\"imgValidCode\" src=\"../img/XMLvalido.png\" alt=\"XHTML valido\"/>
	<img class=\"imgValidCode\" src=\"../img/CSSvalido.gif\" alt=\"CSS valido\"/>
    </div>

	<div id=\"reserved\">
    <a href=\"login.pl\">Area riservata</a>
    </div>
	
    <div id=\"right\">
        <strong>Contatti</strong>
		<p>Vicolo del Fico, 15
         00100
            Roma (RM)</p>

        <p>Telefono 0093412534</p>
        <p>Email bbmichele\@gmail.com</p>
    </div>

</div>
</div>
</body>
</html>";
}

sub Tariffe{
print "<div id=\"title\">
	<h1>
    Tariffe
  	</h1>
</div>

<div id=\"content\">

	<p>
    	Nel prezzo del nostro <span lang=\"en\">Bed and Breakfast</span> sono compresi la prima colazione,
        la pulizia delle camere ed un asciugacapelli.
    </p>
    <p>
		Inoltre a richiesta &egrave; possibile utilizzare gratuitamente <span lang=\"en\">Wi-Fi</span>, frigorifero e aria condizionata.
    </p>

    <p>
    	I prezzi a notte per le camere sono:
    </p>
    	<ul>
        	<li>Camera singola: ".Tariffe::getPrezzoCamera('SINGOLA')." &euro;</li>
            <li>Camera doppia: ".Tariffe::getPrezzoCamera('DOPPIA')." &euro;</li>
        </ul>
	<p> Sono disponibili servizi aggiuntivi:</p>
        <ul>
            <li>Parcheggio: ".Tariffe::getPrezzoParcheggio()." &euro; al giorno.</li>
            <li>Pulizia: ".Tariffe::getPrezzoPulizie()." &euro; al giorno.</li>
            <li>Navetta per Aeroporto: ".Tariffe::getPrezzoNavettaAeroporto()." &euro;.</li>
            <li>Navetta per Stazione: ".Tariffe::getPrezzoNavettaTreno()." &euro;.</li>
        </ul>
</div>"
}
