#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use XML::LibXML;
use Time::Piece;
use DateTime;
use Tariffe;
package StdAdmin;

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
	<link rel=\"shortcut icon\" href=\"../img/favicon.ico\" />


    </head>
    <body>
    <div id=\"wrapper\">
    <div id=\"header\">
        <img src=\"../img/Logo-bn.png\" alt=\"logo B&amp;B\" id=\"logo\"/>
    <!--<h1>Bed and Breakfast Navona - Roma</h1>-->
    </div>
"}

sub Menu {

 print"
 <div id=\"menu\">
        <ul>
            <li><a href=\"home.pl\"><span lang=\"en\">Home</span></a></li>

            <li><a href=\"bb.pl\">Bed &amp; Breakfast</a></li>

            <li><a href=\"stato_prenotazioni.pl\">Stato Prenotazioni</a></li>

            <li><a href=\"tariffe.pl\">Tariffe</a></li>
        </ul>
    </div>"
}

sub Breadcrumb{
my ($logged,@percorso) = @_;
print "<div id=\"breadcrumb\">";
if($logged){
Logout();
	if($percorso[0] eq "Home"){
		print "Ti trovi qui: <span lang=\"en\">Home</span>";
	}else{
		print "Ti trovi qui: <a href=\"home.pl\"><span lang=\"en\">Home</span></a> &gt;&gt; $percorso[0]";
	}
}else{
print "Ti trovi qui: <span lang=\"en\">Login</span>";
}
print "
</div>
<div id=\"content\">
";
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

sub Login{
my($esito)=@_;
print"
	<div id=\"login\">
		<form id=\"formLogin\" method=\"post\" action=\"login.pl\" >
		<div>
		<label for=\"username\"><span lang=\"en\">Username</span></label>
		<input id=\"username\" name=\"username\" type=\"text\"  />
		<label for=\"psw\"><span lang=\"en\">Password</span></label>
		<input id=\"psw\" name=\"psw\" type=\"password\" />
		<input type=\"submit\" value=\"Login\"/> 
		</div>
		</form>";
		if(!$esito){
		print "<span>Username o Password non corretti</span>";
		}
print 
"</div>
";
}

sub Benvenuto{
	my($username)=@_;
	print"
	<h2>Ben ritornato $username</h2>
	<p>Benvenuto nel Pannello di Amministrazione del <strong>Navona - Bed &amp; Breakfast</strong>.</p>
	<p>Qui potrai visualizzare e modificare le caratteristiche del tuo Bed &amp; Breakfast, personalizzare le tariffe 
	e vedere lo stato delle prenotazioni in corso.</p>
	";
}

sub Logout{
	print"
	<a id=\"logout\" href=\"logout.pl\"><span lang=\"en\" >Logout</span></a>
	";
}

sub CamereDisponibili{
	print CGI::h1("Camere");
	#possibile lettura db e stampa di tutte le camere
	print "<form id=\"bbForm\" method=\"post\" action=\"bb.pl\" >";
	print CGI::div(CGI::span("<label for=\"nsingole\" >Numero camere singole: ".Utils::getNumeroCamere('SINGOLA')."</label>").
				"<input id=\"nsingole\" name=\"nsingole\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />"
				);
	print CGI::div(CGI::span("<label for=\"ndoppie\" >Numero camere doppie: ".Utils::getNumeroCamere('DOPPIA')."</label>").
				"<input id=\"ndoppie\" name=\"ndoppie\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	
	print "</form>";
}

sub FormTariffe{
	print CGI::h1("Tariffe");
	#possibile lettura db e stampa di tutte le camere
	print "<form id=\"tariffeForm\" method=\"post\" action=\"tariffe.pl\" >";
	print CGI::h2("Camere");
	print CGI::div(CGI::span("<label for=\"psingola\">Prezzo Singola ".Tariffe::getPrezzoCamera('SINGOLA')."&euro;</label>").
				"<input id=\"psingola\" name=\"psingola\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />"
				);
	print CGI::div(CGI::span("<label for=\"pdoppie\">Prezzo Doppia: ".Tariffe::getPrezzoCamera('DOPPIA')."&euro;</label>").
				"<input id=\"pdoppie\" name=\"pdoppia\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	print CGI::h2("Servizi");
	print CGI::div(CGI::span("<label for=\"pparcheggio\">Prezzo Parcheggio: ".Tariffe::getPrezzoParcheggio()."&euro;</label>").
				"<input id=\"pparcheggio\" name=\"pparcheggio\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	print CGI::div(CGI::span("<label for=\"ppulizie\">Prezzo Pulizie: ".Tariffe::getPrezzoPulizie()."&euro;</label>").
				"<input id=\"ppulizie\" name=\"ppulizie\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	print CGI::div(CGI::span("<label for=\"pnavaereo\">Prezzo Navetta per Aeroporto: ".Tariffe::getPrezzoNavettaAeroporto()."&euro;</label>").
				"<input id=\"pnavaereo\" name=\"pnavaereo\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	print CGI::div(CGI::span("<label for=\"pnavtreno\">Prezzo Navetta per Treno: ".Tariffe::getPrezzoNavettaTreno()."&euro;</label>").
				"<input id=\"pnavtreno\" name=\"pnavtreno\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	
	print "</form>";
}

sub ordinaPrenotazioni{
   my $fmt = "%d/%m/%Y";
   my $dataArrivo_1 = Time::Piece->strptime($a->findnodes('dataArrivo')->get_node(1)->textContent, $fmt);
   my $dataPartenza_1 = Time::Piece->strptime($a->findnodes('dataPartenza')->get_node(1)->textContent, $fmt);
   my $dataArrivo_2 = Time::Piece->strptime($b->findnodes('dataArrivo')->get_node(1)->textContent, $fmt);
   my $dataPartenza_2 = Time::Piece->strptime($b->findnodes('dataPartenza')->get_node(1)->textContent, $fmt);
   if($dataArrivo_1 eq $dataArrivo_2){
		return $dataPartenza_1 <=> $dataPartenza_2;
   }else{
		return $dataArrivo_1 <=> $dataArrivo_2;
   }
}

sub Prenotazioni{
	my($inizio, $fine)=@_;
	#definire pagina per il dettaglio di una prenotazione
	#aggiungere nomi agli elementi tramite attributi
	my $firstline = 0;
	my @prenotazioni = Utils::ricercaPrenotazioni($inizio,$fine);
	@prenotazioni = sort ordinaPrenotazioni @prenotazioni;
	@prenotazioni = reverse @prenotazioni;
	if(@prenotazioni){
	my $summary = "Questa tabella presenta le prenotazioni presenti nel database per un dato intervallo di tempo. 
	Le prenotazioni sono suddivise in tre categorie: le prenotazioni successive alla data odierna, le prenotazioni in corso e quelle scadute.";
	print "<table id=\"t_stato_pren\" summary=\"$summary\">";
	print "<caption>Prenotazioni presenti nel database</caption>";
	my $alternate = 0;
	my @intestazione = ("Data Arrivo","Data Partenza","Adulti","Email","Telefono","Nome","Cognome","Totale"); 
	my @chiavi = ("dataArrivo", "dataPartenza", "adulti", "email", "telefono", "nome", "cognome", "totale");
	foreach my $prenotazione (@prenotazioni) {
	  if(!($firstline)){
		print "<thead><tr>";
		print "<th scope=\"col\" >Codice</th>";
		foreach my $header (@intestazione){
			print "<th scope=\"col\">".$header."</th>";
		}
		print "</tr></thead><tbody>";
		$firstline = 1;
	  }
	  if($alternate%2 == 0){
	  print "<tr class=\"".statoPrenotazione($prenotazione)."\">";
	  }else{
	  print "<tr class=\"".statoPrenotazione($prenotazione)." alternate\">";
	  }
	  print "<td><a href=\"dettaglio_prenotazione.pl?id=".($prenotazione->attributes())[0]->getValue()."\">".
	  ($prenotazione->attributes())[0]->getValue()."</a></td>";
	  foreach my $chiave (@chiavi){
			print "<td>".$prenotazione->findnodes($chiave)->get_node(0)->textContent."</td>";
		}
	  print "</tr>";
	  $alternate++;
	}
	print "</tbody></table>";
	}else{
		print "<p>Nessuna prenotazione presente</p>";
	}
}

sub statoPrenotazione{
	my($prenotazione)=@_;
	my $fmt = "%d/%m/%Y";
	my $dataArrivo = Time::Piece->strptime($prenotazione->findnodes('dataArrivo')->get_node(1)->textContent, $fmt);
	my $dataPartenza = Time::Piece->strptime($prenotazione->findnodes('dataPartenza')->get_node(1)->textContent, $fmt);
	my $now = Time::Piece->strptime(DateTime->now()->dmy("/"), $fmt);
   if($dataArrivo > $now and $dataPartenza > $now){
		return 'prossima';
   }elsif($dataArrivo <= $now and $dataPartenza >= $now ){
		return 'incorso';
   }elsif($dataArrivo < $now and $dataPartenza < $now){
		return 'scaduta';
   }else{
		return '';
   }
}



sub PrintFormRicerca{
	print CGI::h1("Stato Prenotazioni");
	#possibile lettura db e stampa di tutte le camere
	print "<form id=\"spForm\" method=\"post\" action=\"stato_prenotazioni.pl\" >";
	print CGI::div(
				"<span><label for=\"da\">Da </label></span><input id=\"da\" name=\"da\" type=\"text\" maxlength=\"10\" />
				<span><label for=\"a\">A </label></span><input id=\"a\" name=\"a\" type=\"text\" maxlength=\"10\" />
				<input type=\"submit\" value=\"Ricerca\" />"
				);
	print "</form>";
}

sub PrintLogin{
 my($esito)=@_;
 HtmlCode();
 Breadcrumb();
 Login($esito);
 EndHtml();
}

sub PrintHome{
 my($username)=@_;
 HtmlCode();
 Menu();
 Breadcrumb(1,"Home");
 Benvenuto($username);
 EndHtml();
}

sub BedBreakfast{
 my($errore) = @_;
 HtmlCode();
 Menu();
 Breadcrumb(1,"Bed &amp; Breakfast");
 CamereDisponibili();
 if($errore){
	print $errore;
 }
 EndHtml();
}

sub StatoPrenotazioni{
	my($inizio,$fine)=@_;
	 HtmlCode();
	 Menu();
	 Breadcrumb(1,"Stato Prenotazioni");
	 PrintFormRicerca();
	 if(ControlloDate($inizio,$fine)){
		Prenotazioni($inizio,$fine);
	 }
	 EndHtml();

}

sub Tariffe{
 my($errore) = @_;
 HtmlCode();
 Menu();
 Breadcrumb(1,"Tariffe");
 FormTariffe();
 if($errore){
	print $errore;
 }
 EndHtml();
}

sub ControlloDate{
	my($da,$a)=@_;
	if($da and $a){
	if(isvaliddate($da) and isvaliddate($a)){
	my $fmt="%d/%m/%Y";
	my $d1 = Time::Piece->strptime($da,$fmt);
	my $d2 = Time::Piece->strptime($a,$fmt);
	if ($d2 <= $d1){
		print "<p>La data A deve essere maggiore</p>";
		return 0;
	}else{
		return 1;
		}
	}else{
	   if(!(isvaliddate($da))){
		print "<p>La data DA non &egrave valida</p>";
	    }
		if(!(isvaliddate($a))){
		print "<p>La data A non &egrave valida</p>";
		}
		return 0;
	}
	}elsif($da eq undef and $a eq undef){
		return 1;
	}elsif($da eq undef){
		if(isvaliddate($a)){
			return 1;
		}else{
			print "<p>La data A non &egrave valida</p>";
			return 0;
			}
	}elsif($a eq undef){
		if(isvaliddate($da)){
			return 1;
		}else{
			print "<p>La data DA non &egrave valida</p>";
			return 0;
		}
	}
}

sub PrintPren{
my($id)=@_;
my $prenotazione = Utils::ricercaPrenotazioneConId($id);
if($prenotazione){
my $arrivo = $prenotazione->findnodes("dataArrivo")->get_node(0);
my $partenza = $prenotazione->findnodes("dataPartenza")->get_node(0);
my $adulti = $prenotazione->findnodes("adulti")->get_node(0);
my $singole = $prenotazione->findnodes("singole")->get_node(0);
my $doppie = $prenotazione->findnodes("doppie")->get_node(0);
my $parcheggio = $prenotazione->findnodes("parcheggio")->get_node(0);
my $pulizia = $prenotazione->findnodes("pulizia")->get_node(0);
my $navaereo = $prenotazione->findnodes("navaereo")->get_node(0);
my $navtreno = $prenotazione->findnodes("navtreno")->get_node(0);
my $prezzo = $prenotazione->findnodes("totale")->get_node(0);
my $nome = $prenotazione->findnodes("nome")->get_node(0);
my $cognome = $prenotazione->findnodes("cognome")->get_node(0);
my $email =  $prenotazione->findnodes("email")->get_node(0);
my $numero =  $prenotazione->findnodes("numero")->get_node(0);
my $datanascita = $prenotazione->findnodes("dataNascita")->get_node(0);
my $citta = $prenotazione->findnodes("citta")->get_node(0);

print "<h2>La tua prenotazione</h2>";
#print "<div id=\"centrale\">";
print "<p>Numero prenotazione: $id</p>";
print "<div id=\"richiesta\">";
print "<p>Data Arrivo $arrivo</p>";
print "<p>Data Partenza $partenza</p>";
print "<p>Ospiti $adulti</p>";
print "<p>La tua prenotazione comprende:</p>";
if($singole->textContent != 0){
$singole = $singole->textContent;
print "<p>Camere singole $singole</p>";
}
if($doppie->textContent  != 0){
$doppie = $doppie->textContent;
print "<p>Camere doppie $doppie</p>";
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
print "<p>Totale &euro; $prezzo</p>";
print "<p><strong>Contatti</strong></p>";
print "<p>Nome $nome</p>";
print "<p>Cognome $cognome</p>";
print "<p>Data nascita $datanascita</p>";
print "<p>Email $email</p>";
print "<p>Numero $numero</p>";
print "<p>Citt&agrave $citta</p>";
#print "</div>";
print "</div>";
print "<div class=\"separatore\"></div>"
}else{
print "<p>Nessuna prenotazione presente</p>";
}
}

sub DettaglioPrenotazione{
	my($id)=@_;
	 HtmlCode();
	 Menu();
	 Breadcrumb(1,"Dettaglio Prenotazione");
	 PrintPren($id);
	 EndHtml();
}

sub isvaliddate {
  my $input = shift;
  if ($input =~ m!^(0[1-9]|[12][0-9]|3[01])[/](0[1-9]|1[012])[/]((19|20)\d\d)$!) {
    # At this point, $1 holds the day, $2 the month and $3 the year of the date entered
    if ($1 == 31 and ($2 == 4 or $2 == 6 or $2 == 9 or $2 == 11)) {
      return 0; # 31st of a month with 30 days
    } elsif ($1 >= 30 and $2 == 2) {
      return 0; # February 30th or 31st
    } elsif ($2 == 2 and $1 == 29 and not ($3 % 4 == 0 and ($3 % 100 != 0 or $3 % 400 == 0))) {
      return 0; # February 29th outside a leap year
    } else {
      return 1; # Valid date
    }
  } else {
    return 0; # Not a date
  }
}