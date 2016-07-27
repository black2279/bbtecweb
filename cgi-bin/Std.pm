#!/usr/bin/perl
use DateTime;
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
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
Ti trovi qui :<a href=\"../index.html\"><span lang=\"en\">Home</span></a> &gt;&gt; ".$percorso[0]."
</div>
<div id=\"content\">
";
}

sub FormPren{
my %valori= @_;
print "<div id=\"content\">
<h1>Prenotazioni</h1>

	<form method=\"post\" action=\"disponibilita.pl\">
		<fieldset>
			<!--<legend>Prenotazione</legend>-->
            <p>
			<label for=\"dataArrivo\">Data Arrivo </label>
			<input type=\"text\" name=\"dataArrivo\" id=\"dataArrivo\" maxlength=\"10\" placeholder=\"gg/mm/aaaa\" value=".$valori{'arrivo'}.">
            <label for=\"dataPartenza\">Data Partenza </label>
            <input type=\"text\" name=\"dataPartenza\" id=\"dataPartenza\" maxlength=\"10\" placeholder=\"gg/mm/aaaa\" value=".$valori{'partenza'}.">
            </p>
            <label for=\"numeroCamere\">Numero Camere </label>
            <input type=\"text\" name=\"numeroCamere\" id=\"numeroCamere\" maxlength=\"1\" value=".$valori{'numerocamere'}.">
            <label for=\"adulti\">Adulti </label>
			<input type=\"text\" name=\"adulti\" id=\"adulti\" maxlength=\"1\" value=".$valori{'adulti'}.">
            <p><input type=\"checkbox\" name=\"parcheggio\" value=\"true\"/ $valori{'parcheggio'}> Voglio usufruire del parcheggio coperto convenzionato (5&euro;/giorno).</p>
            <p><input type=\"checkbox\" name=\"pulizia\" value=\"true\"/ $valori{'pulizia'}> Pulizia giornaliera della camera (2&euro;/giorno).</p>
            <p><input type=\"checkbox\" name=\"navettaaereo\" value=\"true\"/ $valori{'navaereo'}> Servizio navetta Fiumicino - Hotel : 30&euro;</p>
            <p><input type=\"checkbox\" name=\"navettatreno\" value=\"true\"/ $valori{'navtreno'}> Servizio navetta Stazione Termini - Hotel : 30&euro;</p>

            <!--<input type=\"reset\" value=\"Reset\" />&nbsp;--><input type=\"submit\" id=\"prenota\" value=\"Prenota\" />

		</fieldset>

	</form>
	<form method=\"post\" action=\"ricerca_prenotazioni.pl\">
		<fieldset>
			<!--<legend>Ricerca Prenotazione</legend>-->
			<label for=\"numeroPrenotazione\">Numero Prenotazione</label>
			<input type=\"text\" name=\"numeroPrenotazione\" id=\"numeroPrenotazione\" value=".$valori{'npren'}.">

			<!--<input type=\"reset\" value=\"Reset\" />&nbsp;--><input type=\"submit\" id=\"ricerca\" value=\"Ricerca\" />


		</fieldset>
	</form>
</div>
";
}

sub PrintPren{
my($arrivo,$partenza,$adulti,$singole,$doppie,$prezzo,$numeroprenotazione,$parcheggio,$pulizia,$navaereo,$navtreno)=@_;
print "<h2>La tua prenotazione</h2>";
print "<p>Numero prenotazione: ".$numeroprenotazione."</p>";
print "<div id=\"richiesta\">";
print "<p>Data Arrivo: ".$arrivo->textContent."</p>";
print "<p>Data Partenza ".$partenza->textContent."</p>";
print "<p>Ospiti ".$adulti->textContent."</p>";
print "<p>La tua prenotazione comprende:</p>";
if($singole->textContent != 0){
print "<p>Camere singole: ".$singole->textContent."</p>";
}
if($doppie->textContent  != 0){
print "<p>Camere doppie: ".$doppie->textContent."</p>";
}
if($parcheggio->textContent == 1 || $pulizia->textContent == 1 || $navaereo->textContent == 1 || $navtreno->textContent == 1){
print"<p>La tua prenotazione comprende anche i seguenti servizi</p>";
 if($parcheggio->textContent == 1){
   print "<p>- Parcheggio</p>";
   }
   if($pulizia->textContent == 1){
   print "<p>- Pulizia Quotidiana</p>";
   }
   if($navaereo->textContent == 1){
   print "<p>- Navetta dall'Aeroporto</p>";
   }
   if($navtreno->textContent == 1){
   print "<p>- Navetta dalla Stazione</p>";
   }
}
print "<p>Totale: &euro;".$prezzo->textContent."</p>";
print "</div>";
}

sub Disp{
my($dataarrivo,$datapartenza,$numerocamere,$adulti,$doppie,$singole,$exdoppie,$exsingole)=@_;
print "<h2>La tua prenotazione \n</h2>";
print "<div id=\"richiesta\">";
print "<p>Data Arrivo ".$dataarrivo."\n</p>";
print "<p>Data Partenza ".$datapartenza."\n</p>";
print "<p>Adulti ".$adulti."\n</p>";
print "<p>Numero Camere ".$numerocamere."\n</p>";
# print "</div>";
# my $doppie = int($numerocamere / 2);
# my $singole = int($numerocamere % 2);
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
          $prdoppie = (30*$doppie);
          if($doppie == 1){
          print "<p>$doppie camera doppia &nbsp; &euro; 30 x $doppie = &euro; $prdoppie.</p>";
          }
          else{
            print "<p>$doppie camere doppie &nbsp; &euro; 30 x $doppie = &euro; $prdoppie.</p>";
          }
          }
      if($singole > 0){
          $prsingole = (20*$singole);
          if($singole == 1){
          print "<p>$singole camera singola &nbsp; 20 x $singole = &euro; $prsingole.</p>";
          }
          else{
          print "<p>$singole camere singole &nbsp; 20 x $singole = &euro; $prsingole.</p>";
          }
          }
      if($parcheggio eq "true"){
        my $prpark = "5";
          $prparcheggio = $prpark*$diff;
        print "<p>Parcheggio coperto = &euro; $prpark x $diff giorni = &euro; $prparcheggio</p>";
      }
      if($pulizia eq "true"){
        my $prpul = "2";
          $prpulizia = $prpul*$diff;
        print "<p>Pulizia quotidiana = &euro; $prpul x $diff giorni = &euro; $prpulizia</p>";
      }
      if($navettaaereo eq "true"){
          $prnavettaaereo = "30";
        print "<p>Navetta B&amp;B Navona - Aeroporto Fiumicino = &euro; $prnavettaaereo</p>";
      }

      if($navettatreno eq "true"){
          $prnavettatreno = "30";
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
my %valori;
my($dataarrivo,$datapartenza,$numerocamere,$adulti,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo, $navettatreno,$totale)=@_;
print "<div id=\"dati\">";
print "<h2>Inserisci i dati</h2>";
print "<p>Compila i seguenti campi per procedere con la prenotazione. Tutti i campi sono obbligatori.";
print "<form method=\"post\" action=\"prenotazione.pl\">
        <input type=\"text\" name=\"dataarrivo\" id=\"nascosto\" value=$dataarrivo readonly>
        
		<input type=\"text\" name=\"datapartenza\" id=\"nascosto\" value=$datapartenza readonly>
        
		<input type=\"text\" name=\"numerocamere\" id=\"nascosto\" value=$numerocamere readonly>
        
		<input type=\"text\" name=\"adulti\" id=\"nascosto\" value=$adulti readonly>
        
		<input type=\"text\" name=\"doppie\" id=\"nascosto\" value=$doppie readonly>
        
		<input type=\"text\" name=\"singole\" id=\"nascosto\" value=$singole readonly>

		<input type=\"text\" name=\"parcheggio\" id=\"nascosto\" value=$parcheggio readonly>
        
        <input type=\"text\" name=\"pulizia\" id=\"nascosto\" value=$pulizia readonly>
        
		<input type=\"text\" name=\"navettaaereo\" id=\"nascosto\" value=$navettaaereo>
		<input type=\"text\" name=\"navettatreno\" id=\"nascosto\" value=$navettatreno>
		<input type=\"text\" name=\"totale\" id=\"nascosto\" value=$totale>
		<p>Dati anagrafici</p>
        <fieldset>
            <div id=\"sinistra\">
                <p><label for=\"nome\">Nome </label></p>
                <p><input type=\"text\" name=\"nome\" id=\"nome\" value=".$valori{'nome'}."></p>
                <p><label for=\"cognome\">Cognome </label></p>
                <p><input type=\"text\" name=\"cognome\" id=\"cognome\" value=".$valori{'cognome'}."></p>
                <p><label for=\"dataNascita\">Data di Nascita </label></p>
                <p><input type=\"text\" name=\"dataNascita\" id=\"dataNascita\" maxlength=\"10\" placeholder=\"gg/mm/aaaa\" value=".$valori{'nascita'}."></p>
                <p><label for=\"citta\">Citt&agrave; </label></p>
                <p><input type=\"text\" name=\"citta\" id=\"citta\" value=".$valori{'citta'}."></p>
            </div>
            <div id=\"destra\">
                <p><label for=\"email\">E-mail </label></p>
                <p><input type=\"text\" name=\"email\" id=\"email\" value=".$valori{'email'}."></p>
                <p><label for=\"cemail\">Conferma E-mail </label></p>
                <p><input type=\"text\" name=\"cemail\" id=\"cemail\"></p>
                <p><label for=\"telefono\">Numero di cellulare </label></p>
                <p><input type=\"text\" name=\"telefono\" id=\"telefono\" value=".$valori{'telefono'}."></p>
            </div>
            </fieldset>
        <p>Dati di pagamento</p>
        <fieldset>
            <p><label for=\"pagamento\">Metodo di pagamento </label></p>
            <p><select name=\"pagamento\" id=\"pagamento\">
                <option value=\"Visa\">Visa</option>
                <option value=\"Mastercard\">Mastercard</option>
                <option value=\"American Express\">American Express</option>
            </select></p>
            <p><label for=\"numerocarta\">Numero carta </label></p>
			<p><input type=\"text\" name=\"numerocarta\" id=\"numerocarta\" maxlength=\"16\"></p>
            <p><label for=\"cvc\">CVC </label></p>
            <p><input type=\"text\" name=\"cvc\"id=\"cvc\" maxlength=\"3\"></p>
            <p><label for=\"intcarta\">Nome e Cognome dell'intestatario della carta</label></p>
            <p><input type=\"text\" name=\"intcarta\" id=\"intcarta\" value=".$valori{'intcarta'}."></p>
        </fieldset>
        <input type=\"submit\" id=\"prenota\" value=\"Prenota\">
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
