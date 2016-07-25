#!/usr/bin/perl
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
<!DOCTYPE html PUBLIC \\'-//W3C//DTD XHTML 1.0 Strict//EN'' \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
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
    <img src=\"../img/Logo-bn.png\" alt=\"logo B&B\" id=\"logo\">
<!--<h1>Bed and Breakfast Navona - Roma</h1>-->
</div>

<div id=\"menu\">
	<ul>
		<li><a href=\"index.html\"><span lang=\"en\">Home</span></a></li>

    	<li><a href=\"chisiamo.html\">Chi siamo</a></li>

    	<li><a href=\"galleria.html\">Galleria</a></li>

    	<li><a href=\"servizi.html\">Servizi</a></li>

    	<li><a href=\"tariffe.html\">Tariffe</a></li>

    	<li id=\"currentLink\"><a href=\"prenotazioni.html\">Prenotazioni</a></li>

    	<li><a href=\"contatti.html\">Contatti</a></li>
	</ul>
</div>

<div id=\"breadcrumb\">
<p>Ti trovi qui :<a href=\"index.html\"><span lang=\"en\">Home</span></a> &gt;&gt; <a href=\"prenotazioni.html\"><span lang=\"en\">Prenotazioni</span></a> &gt;&gt; Disponibilit&agrave;</p>
</div>
";
}

sub PrintPren{
my($arrivo,$notti,$adulti,$camera,$prezzo,$numeroprenotazione)=@_;
print "<h2>La tua prenotazione \n</h2>";
print "Numero prenotazione".$numeroprenotazione."\n";
print "<div id=\"prenotazione\">";
 print "Data Arrivo ".$arrivo->textContent."\n";
print "Notti ".$notti->textContent."\n";
print "Adulti ".$adulti->textContent."\n";
print "Tipo Camera ".$camera->textContent."\n";
print "Totale €: ".$prezzo->textContent."\n";
print "</div>";
}

sub Disp{
my($dataarrivo,$datapartenza,$numerocamere,$adulti,$doppie,$singole,$exdoppie,$exsingole)=@_;
print "<h2>La tua prenotazione \n</h2>";
print "Data Arrivo ".$dataarrivo."\n";
print "Data Partenza ".$datapartenza."\n";
print "Adulti ".$adulti."\n";
print "Numero Camere ".$numerocamere."\n";
# my $doppie = int($numerocamere / 2);
# my $singole = int($numerocamere % 2);
my $exdoppie="";
my $exsingole="";
if($doppie != 0){
    if($doppie == 1){
    $exdoppie="$doppie camera doppia e ";
    }
    else{
    $exdoppie="$doppie camere doppie e ";
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

print "La tua prenotazione comprende: $exdoppie $exsingole.";
#print "Totale €: ".$prezzo->textContent."\n";
#print "</div>";
}

sub Servizi{
my ($parcheggio,$pulizia,$navettaaereo, $navettatreno)=@_;
   if($parcheggio eq "true"){
   print "Hai richiesto il parcheggio";
   }
   if($pulizia eq "true"){
   print "Hai richiesto la pulizia quotidiana";
   }
   if($navettaaereo eq "true"){
   print "Hai richiesto la navetta dall'aeroporto";
   }
   if($navettatreno eq "true"){
   print "Hai richiesto la navetta dalla stazione";
   }
}

sub Prezzi{
    my($doppie,$singole,$parcheggio,$pulizia,$navettaaereo,$navettatreno)=@_;
    if ($doppie > 0) {
      print "$doppie camere doppie &nbsp; 30 x $doppie = ".(30*$doppie).".";
    }
}

sub EndHtml{
print "<div id=\"footer\">
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
