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
<h1>Bed and Breakfast Navona - Roma</h1>
</div>

<div id=\"menu\">
	<ul>
		<li id=\"currentLink\"><a href=\"index.html\"><span lang=\"en\">Home</span></a></li>

    	<li><a href=\"chisiamo.html\">Chi siamo</a></li>

    	<li><a href=\"galleria.html\">Galleria</a></li>

    	<li><a href=\"servizi.html\">Servizi</a></li>

    	<li><a href=\"tariffe.html\">Tariffe</a></li>

    	<li><a href=\"prenotazioni.html\">Prenotazioni</a></li>

    	<li><a href=\"contatti.html\">Contatti</a></li>
	</ul>
</div>
";
}

sub PrintPren{
my($arrivo,$notti,$adulti,$camera,$numeroprenotazione)=@_;
print "<h2>La tua prenotazione \n</h2>";
print "Numero prenotazione".$numeroprenotazione."\n";
print "<div id=\"prenotazione\">";
 print "Data Arrivo ".$arrivo->textContent."\n";
print "Notti ".$notti->textContent."\n";
print "Adulti ".$adulti->textContent."\n";
print "Tipo Camera ".$camera->textContent."\n";
print "</div>";
}

sub EndHtml{
print "</div>
</body>
</html>";
}
