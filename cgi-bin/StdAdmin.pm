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
}
print "Ti trovi qui: <a href=\"home.pl\"><span lang=\"en\">Home</span></a> &gt;&gt; $percorso[0]
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
		<span lang=\"en\">Username</span>
		<input id=\"username\" name=\"username\" type=\"text\"  />
		<span lang=\"en\">Password</span>
		<input id=\"psw\" name=\"psw\" type=\"password\" />
		<input type=\"submit\" value=\"Login\"/> 
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
	<p>Benvenuto nel Pannello di Amministrazione del <strong>Navona - Bed &amp; Breakfast</strong>.
	<p>Qui potrai visualizzare e modificare le caratteristiche del tuo Bed &amp Breakfast, personalizzare le tariffe 
	e vedere lo stato delle prenotazioni in corso.</p>
	";
}

sub Logout{
	print"
	<a id=\"logout\" href=\"logout.pl\">Logout</a>
	";
}

sub CamereDisponibili{
	print CGI::h2("Camere");
	#possibile lettura db e stampa di tutte le camere
	print "<form id=\"bbForm\" method=\"post\" action=\"bb.pl\" >";
	print CGI::div(CGI::span("Numero camere singole: ".Utils::getNumeroCamere('SINGOLA')).
				"<input id=\"nsingole\" name=\"nsingole\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />"
				);
	print CGI::div(CGI::span("Numero camere doppie: ".Utils::getNumeroCamere('DOPPIA')).
				"<input id=\"ndoppie\" name=\"ndoppie\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	
	print "</form>";
}

sub FormTariffe{
	print CGI::h1("Tariffe");
	#possibile lettura db e stampa di tutte le camere
	print CGI::h2("Camere");
	print "<form id=\"tariffeForm\" method=\"post\" action=\"tariffe.pl\" >";
	print CGI::div(CGI::span("Prezzo Singola ".Tariffe::getPrezzoCamera('SINGOLA')."&euro;").
				"<input id=\"psingola\" name=\"psingola\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />"
				);
	print CGI::div(CGI::span("Prezzo Doppia: ".Tariffe::getPrezzoCamera('DOPPIA')."&euro;").
				"<input id=\"pdoppie\" name=\"pdoppia\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	print CGI::h2("Servizi");
	print CGI::div(CGI::span("Prezzo Parcheggio: ".Tariffe::getPrezzoParcheggio()."&euro;").
				"<input id=\"pparcheggio\" name=\"pparcheggio\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	print CGI::div(CGI::span("Prezzo Pulizie: ".Tariffe::getPrezzoPulizie()."&euro;").
				"<input id=\"ppulizie\" name=\"ppulizie\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	print CGI::div(CGI::span("Prezzo Navetta per Aeroporto: ".Tariffe::getPrezzoNavettaAeroporto()."&euro;").
				"<input id=\"pnavaereo\" name=\"pnavaereo\" type=\"text\" maxlength=\"3\" />
				<input type=\"submit\" value=\"Modifica\" />
				");
	print CGI::div(CGI::span("Prezzo Navetta per Treno: ".Tariffe::getPrezzoNavettaTreno()."&euro;").
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
	print "<table id=\"t_stato_pren\">";
	foreach my $prenotazione (@prenotazioni) {
	  my $children = $prenotazione->nonBlankChildNodes();
	  if(!($firstline)){
		print "<tr>";
		print "<th>Codice</th>";
		foreach my $child ($children->get_nodelist()){
			print "<th>".$child->localname."</th>";
		}
		print "</tr>";
		$firstline = 1;
	  }
	  print "<tr class=".statoPrenotazione($prenotazione).">";
	  print "<td><a href=\"dettaglio_prenotazione.pl?id=".($prenotazione->attributes())[0]->getValue()."\">".
	  ($prenotazione->attributes())[0]->getValue()."</a></td>";
	  foreach my $child ($children->get_nodelist()){
			print "<td>".$child->textContent."</td>";
		}
	  print "</tr>";
	}
	print "</table>";
	}else{
		print "Nessuna prenotazione presente";
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
	print CGI::h2("Stato Prenotazioni");
	#possibile lettura db e stampa di tutte le camere
	print "<form id=\"spForm\" method=\"post\" action=\"stato_prenotazioni.pl\" >";
	print CGI::div(
				"<span>Da</span><input id=\"da\" name=\"da\" type=\"text\" maxlength=\"10\" />
				<span>A</span><input id=\"a\" name=\"a\" type=\"text\" maxlength=\"10\" />
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