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

    <title>Bed and Breakfast Navona</title>
    <meta name=\"title\" content=\"Bed and Breakfast Navona\"/>
    <meta name=\"description\" content=\"Sito del Bed and Breakfast Navona - Roma\" />
    <meta name=\"keywords\" content=\"bed and breakfast, bed, breakfast, Roma, Navona\" />
    <meta name=\"language\" content=\"italian it\" />
    <meta name=\"author\" content=\"Alba Matteo, Andrighetto Cristian, Zoso Leonardo\" />
    <link href=\"../style.css\" rel=\"stylesheet\" type=\"text/css\" />


    </head>
    <body>
    <div id=\"wrapper\">
    <div id=\"header\">
        <img src=\"../img/Logo-bn.png\" alt=\"logo B&amp;B\" id=\"logo\"/>
    <!--<h1>Bed and Breakfast Navona - Roma</h1>-->
    </div>

    <div id=\"menu\">
        <ul>
            <li><a href=\"../index.html\"><span lang=\"en\">Home</span></a></li>

            <li><a href=\"../chisiamo.html\">Chi siamo</a></li>

            <li><a href=\"../galleria.html\">Galleria</a></li>

            <li><a href=\"../servizi.html\">Servizi</a></li>

            <li><a href=\"../tariffe.html\">Tariffe</a></li>

            <li id=\"currentLink\"><a href=\"../cgi-bin/prenotazioni.pl\">Prenotazioni</a></li>

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
    
    <script type=\"text/javascript\" src=\"registrazione.js\"></script>
	<form id=\"FormPren\" action=\"disponibilita.pl\" method=\"post\">
		<fieldset>
			<!--<legend>Prenotazione</legend>-->
            <div class=\"dati\">
            <div id=\"sinistra\">
			<p><label for=\"dataArrivo\">Data Arrivo </label></p>";
            if($valori{'erarrivo'} ne undef){ print "
            <span class=\"error\">$valori{'erarrivo'}</span>";}
            print "
			<p><input type=\"text\" name=\"dataArrivo\" id=\"dataArrivo\" maxlength=\"10\" value=\"$valori{'arrivo'}\" onblur=\"controlloData()\"/></p>
            <p><label for=\"dataPartenza\">Data Partenza </label></p>";
            if($valori{'erpartenza'} ne undef){ print "
            <span class=\"error\">$valori{'erpartenza'}</span>";}
            print "
            <p><input type=\"text\" name=\"dataPartenza\" id=\"dataPartenza\" maxlength=\"10\" value=\"$valori{'partenza'}\" onblur=\"controlloData()\"/></p>
            </div>
            
            <div id=\"destra\">
            <p><label for=\"singole\">Singole </label></p>";
            if($valori{'ersingole'} ne undef){ print "
            <span class=\"error\">$valori{'ersingole'}</span>";}
            print "
            <p><input type=\"text\" name=\"singole\" id=\"singole\" maxlength=\"1\" value=\"$valori{'singole'}\" /></p>
            
            <p><label for=\"doppie\">Doppie </label></p>";
            if($valori{'erdoppie'} ne undef){ print "
            <span class=\"error\">$valori{'erdoppie'}</span>";}
            print "            
            <p><input type=\"text\" name=\"doppie\" id=\"doppie\" maxlength=\"1\" value=\"$valori{'doppie'}\" /></p>
            
			<p><label for=\"adulti\">Adulti </label></p>";
            if($valori{'eradulti'} ne undef){ print "
            <span class=\"error\">$valori{'eradulti'}</span>";}
            print "
			<p><input type=\"text\" name=\"adulti\" id=\"adulti\" maxlength=\"1\" value=\"$valori{'adulti'}\" /></p>
            </div>
            </div>
            <div id=\"elenco\">
            <p><input type=\"checkbox\" name=\"parcheggio\" value=\"true\" $valori{'parcheggio'}/> Voglio usufruire del parcheggio coperto convenzionato (".Tariffe::getPrezzoParcheggio()."&euro;/giorno).</p>
            <p><input type=\"checkbox\" name=\"pulizia\" value=\"true\" $valori{'pulizia'}/> Pulizia giornaliera della camera (".Tariffe::getPrezzoPulizie()."&euro;/giorno).</p>
            <p><input type=\"checkbox\" name=\"navettaaereo\" value=\"true\" $valori{'navaereo'}/> Servizio navetta Fiumicino - Hotel : ".Tariffe::getPrezzoNavettaAeroporto()."&euro;</p>
            <p><input type=\"checkbox\" name=\"navettatreno\" value=\"true\" $valori{'navtreno'}/> Servizio navetta Stazione Termini - Hotel : ".Tariffe::getPrezzoNavettaTreno()."&euro;</p>
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
print "<h2>La tua prenotazione</h2>";
#print "<div id=\"centrale\">";
print "<p>Numero prenotazione: $numeroprenotazione</p>";
print "<div id=\"richiesta\">";
print "<p>Data Arrivo: $arrivo</p>";
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
#print "<h2>La tua prenotazione</h2>";
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
  print "Servizi";
my ($parcheggio,$pulizia,$navettaaereo, $navettatreno)=@_;
  print "<div id = \"dettagli\">";
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
          $prdoppie = $prdoppia*$doppie;
          if($doppie == 1){
          print "<p>$doppie camera doppia &nbsp; &euro; $prdoppia x $doppie = &euro; $prdoppie.</p>";
          }
          else{
            print "<p>$doppie camere doppie &nbsp; &euro; $prdoppia x $doppie = &euro; $prdoppie.</p>";
          }
          }
      if($singole > 0){
          my $prsingola = Tariffe::getPrezzoCamera('SINGOLA');
		  $prsingole = Tariffe::getPrezzoCamera('SINGOLA')*$singole;
          if($singole == 1){
          print "<p>$singole camera singola &nbsp; $prsingola x $singole = &euro; $prsingole.</p>";
          }
          else{
          print "<p>$singole camere singole &nbsp; $prsingola x $singole = &euro; $prsingole.</p>";
          }
          }
      if($parcheggio eq "true"){
          my $prpark = Tariffe::getPrezzoParcheggio();
		  $prparcheggio = $prpark*$diff;
        print "<p>Parcheggio coperto = &euro; $prpark x $diff giorni = &euro; $prparcheggio</p>";
      }
      if($pulizia eq "true"){
          my $prpul = Tariffe::getPrezzoPulizie();
		  $prpulizia = $prpul*$diff;
        print "<p>Pulizia quotidiana = &euro; $prpul x $diff giorni = &euro; $prpulizia</p>";
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
print "<div class=\"dati\">";
print "<h2>Inserisci i dati</h2>";
print "<p>Compila i seguenti campi per procedere con la prenotazione. Tutti i campi sono obbligatori.</p>";
print "<form method=\"post\" action=\"prenotazione.pl\">
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
                <span class=\"errore\">$valori{'ernome'}</span>"};
                print"
                <p><input type=\"text\" name=\"nome\" id=\"nome\" value=\"$valori{'nome'}\"/></p>
                <p><label for=\"cognome\">Cognome </label></p>";
                if($valori{'ercognome'} ne undef){print "
                <span class=\"errore\">$valori{'ercognome'}</span>"};
                print "
                <p><input type=\"text\" name=\"cognome\" id=\"cognome\" value=\"$valori{'cognome'}\"/></p>
                <p><label for=\"dataNascita\">Data di Nascita (gg/mm/aaaa) </label></p>";
                if($valori{'ernascita'} ne undef){print "
                <span class=\"errore\">$valori{'ernascita'}</span>"};
                print "
                <p><input type=\"text\" name=\"dataNascita\" id=\"dataNascita\" maxlength=\"10\" value=\"$valori{'nascita'}\"/></p>
                <p><label for=\"citta\">Citt&agrave; </label></p>";
                if($valori{'ercitta'} ne undef){print "
                <span class=\"errore\">$valori{'ercitta'}</span>"};
                print "
                <p><input type=\"text\" name=\"citta\" id=\"citta\" value=\"$valori{'citta'}\"/></p>
            </div>
            <div id=\"destra\">
                <p><label for=\"email\">E-mail </label></p>";
                if($valori{'eremail'} ne undef){print "
                <span class=\"errore\">$valori{'eremail'}</span>"};
                print "
                <p><input type=\"text\" name=\"email\" id=\"email\" value=\"$valori{'email'}\"/></p>
                <p><label for=\"cemail\">Conferma E-mail </label></p>";
                if($valori{'ercemail'} ne undef){print "
                <span class=\"errore\">$valori{'ercemail'}</span>"};
                print "
                <p><input type=\"text\" name=\"cemail\" id=\"cemail\"/></p>
                <p><label for=\"telefono\">Numero di cellulare </label></p>";
                if($valori{'ertel'} ne undef){print "
                <span class=\"errore\">$valori{'ertel'}</span>"};
                print "
                <p><input type=\"text\" name=\"telefono\" id=\"telefono\" value=\"$valori{'telefono'}\" maxlength=\"13\"/></p>
            </div>
            </fieldset>
        <p>Dati di pagamento</p>
        <fieldset>
            <p><label for=\"pagamento\">Metodo di pagamento </label></p>";
            if($valori{'ermet'} ne undef){print "
            <span class=\"errore\">$valori{'ermet'}</span>"};
            print "
            <p><select name=\"pagamento\" id=\"pagamento\">
                <option value=\"Visa\" $valori{'Vpag'}>Visa</option>
                <option value=\"Mastercard\" $valori{'Mpag'}>Mastercard</option>
                <option value=\"American Express\" $valori{'Apag'}>American Express</option>
            </select></p>
            <p><label for=\"numerocarta\">Numero carta </label></p>";
            if($valori{'ernumcarta'} ne undef){print "
            <span class=\"errore\">$valori{'ernumcarta'}</span>"};
            if($valori{'ercifre'} ne undef){print "
            <span class=\"errore\">$valori{'ercifre'}</span>"};
            print"
			<p><input type=\"text\" name=\"numerocarta\" id=\"numerocarta\" maxlength=\"16\"/></p>
            <p><label for=\"cvc\">CVC </label></p>";
            if($valori{'ercvc'} ne undef){
            print "<span class=\"errore\">$valori{'ercvc'}</span>"};
            print "
            <p><input type=\"text\" name=\"cvc\" id=\"cvc\" maxlength=\"3\"/></p>
            <p><label for=\"intcarta\">Nome e Cognome dell'intestatario della carta</label></p>";
            if($valori{'erintcarta'} ne undef){
            print "<span class=\"errore\">$valori{'erintcarta'}</span>"};
            print "
            <p><input type=\"text\" name=\"intcarta\" id=\"intcarta\" value=\"$valori{'intcarta'}\"/></p>
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

    <div id=\"right\">
        <h3> Contatti </h3>
		<p>Via delle Pertiche, 11
    	    04323 Latina
            Roma (RM)</p>

        <p>Telefono 0093412534</p>
        <p>Email bbmichele\@gmail.com</p>
    </div>

</div>
</div>
</body>
</html>";
}
