#!/usr/bin/perl
#print "Content type: text/html; charset=UTF-8\n\n";

#possibile modifica per gestire auto_increment,
#creare attributo su tag prenotazioni con contatore prenotazioni;

use DateTime;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
# use Encode qw(encode);
use strict;
use warnings;
use Std;
binmode STDOUT, ":utf8";

Std::HtmlCode();



my $page = new CGI;
my $dataarrivo = $page->param("dataarrivo");
my $datapartenza = $page->param("datapartenza");
my $numerocamere = $page->param("numerocamere");
my $adulti = $page->param("adulti");
my $doppie = $page->param("doppie");
my $singole = $page->param("singole");
my $parcheggio = $page->param("parcheggio");
my $pulizia = $page->param("pulizia");
my $navettaaereo = $page->param("navettaaereo");
my $navettatreno = $page->param("navettatreno");
#my $exdoppie="";
#my $exsingole="";

my $error=0;

if(!$error){
    #print "no error";
   print "<h2>Riepilogo prenotazione</h2>";
   print "<p>Controlla se i dati sono corretti e premi il tasto 'Conferma', altrimenti clicca 'Modifica'.";
  Std::Disp($dataarrivo,$datapartenza,$numerocamere,$adulti,$doppie,$singole,);
    my $diff = Std::DiffData($dataarrivo,$datapartenza);
    Std::Prezzi($dataarrivo,$datapartenza,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo,$navettatreno, $diff);
    if($parcheggio eq "true" || $pulizia eq "true" || $navettaaereo eq "true" || $navettatreno eq "true"){
      Std::Servizi($parcheggio,$pulizia,$navettaaereo, $navettatreno);
    }
}
else{
    print "<form action=\"../cgi-bin/prenotazioni.pl\" method=\"post\">
    <input type=\"submit\" value=\"Indietro\" 
         name=\"Submit\" />
</form>";
}
# sub enc {
#     return Encode::encode('UTF-8', $_[0]);
# }

#Std::EndHtml();
