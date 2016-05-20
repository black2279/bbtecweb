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

print "<p>La tua prenotazione comprende: $exdoppie $exsingole.</p>";
print "</div>"
#print "Totale €: ".$prezzo->textContent."\n";
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
   print "<p>Navetta dalla Stazione</p>";
   }
   #print "</div>";
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
      if($doppie > 0){
          $prdoppie = (30*$doppie);
          if($doppie == 1){
          print "<p>$doppie camera doppia &nbsp; 30 x $doppie = &euro; $prdoppie.</p>";
          }
          else{
            print "<p>$doppie camere doppie &nbsp; 30 x $doppie = &euro; $prdoppie.</p>";
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
        print "<p>Navetta B&B Navona - Aeroporto Fiumicino = &euro; $prnavettaaereo</p>";
      }

      if($navettatreno eq "true"){
          $prnavettatreno = "30";
        print "<p>Navetta B&B Navona - Stazione Termini = &euro; $prnavettatreno</p>";
      }
      my $totale = $prdoppie + $prsingole + $prparcheggio + $prpulizia + $prnavettaaereo + $prnavettatreno;
      print "<p>Totale &euro; $totale</p>";
      print "</div>";
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
