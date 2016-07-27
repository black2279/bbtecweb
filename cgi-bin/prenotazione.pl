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
my $percorso = "<a href=\"prenotazioni.pl\">Prenotazioni</a> &gt;&gt; Disponibilit&agrave;";

Std::Breadcrumb($percorso);


my $page = new CGI;
my $nome = $page->param("nome");
my $cognome = $page->param("cognome");
my $dataNascita = $page->param("dataNascita");
my $citta = $page->param("citta");
my $email = $page->param("email");
my $cemail = $page->param("cemail");
my $telefono = $page->param("telefono");
my $pagamento = $page->param("pagamento");
my $numerocarta = $page->param("numerocarta");
my $cvc = $page->param("cvc");
my $intcarta = $page->param("intcarta");
my $dataarrivo = $page->param("dataarrivo");
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

my $error=0;

my %valori;
$valori{'nome'} = $nome;
$valori{'cognome'} = $cognome;
$valori{'nascita'} = $dataNascita;
$valori{'citta'} = $citta;
$valori{'email'} = $email;
$valori{'telefono'} = $telefono;
$valori{'intcarta'} = $intcarta

if($cvc !~ /\d/ ){
    $error=1;
    print "<p>Il codice CVC deve contenere solo cifre.</p>";
}
if($nome =~ /\d/){
    $error=1;
    print "<p>Il nome pu&ograve; contenere solo lettere.</p>";
}
if($numerocarta !~ /\d/ ){
    $error=1;
    print "<p>Il numero della carta deve contenere solo cifre.</p>"
}

if($pagamento eq "Visa" && (length $numerocarta != 16)){
    $error=1;
    print "<p>Il numero della carta non &egrave; valido.</p>";
}

if($pagamento eq "Mastercard" &&  length $numerocarta != 16){
    $error=1;
    print "<p>Il numero della carta non &egrave; valido.</p>";
}

if($pagamento eq "American Express" && length $numerocarta != 15){
    $error=1;
    print "<p>Il numero della carta non &egrave; valido.</p>";
}

sub ricercaDatiXML{
use XML::LibXML;
my $file = '../data/prenotazioni.xml';
my $parser = XML::LibXML->new();

if(-e($file)){

my $doc=$parser->parse_file($file);

my %prenotazione = @_;
my $numeroprenotazione = $prenotazione{'numeroPrenotazione'};
my @set = ('0' ..'9', 'A' .. 'M', 'N' .. 'Z');
my $str = join '' => map $set[rand @set], 1 .. 6;

while(my $node = $doc->findnodes("//prenotazione[\@id = \"$str\"]")->get_node(1)){
   my @set = ('0' ..'9', 'A' .. 'F');
   my $str = join '' => map $set[rand @set], 1 .. 6;
}
return $str;
}
}



sub inserisciDatiXML{
use XML::LibXML;
my $file = '../data/prenotazioni.xml';
my $parser = XML::LibXML->new();
my $id = -1;
my $pren = ricercaDatiXML($page->Vars);

if(!(-e($file))){
open(OUT, ">$file");
print OUT '<?xml version="1.0" encoding="UTF-8"?>';
#evitare di inserire namespace (xmlns=....) genera problemi con espressioni XPath
print OUT "\n<prenotazioni></prenotazioni>";
close(OUT);
$id=0;
}

my $doc=$parser->parse_file($file);

my %prenotazione = @_;
my $dataarrivo = "\n\t\t<dataArrivo>".$prenotazione{'dataarrivo'}."</dataArrivo>";
my $datapartenza = "\n\t\t<dataPartenza>".$prenotazione{'datapartenza'}."</dataPartenza>";
my $adulti = "\n\t\t<adulti>".$prenotazione{'adulti'}."</adulti>";
my $singole = "\n\t\t<singole>".$prenotazione{'singole'}."</singole>";
my $doppie = "\n\t\t<doppie>".$prenotazione{'doppie'}."</doppie>";
my $parcheggio = "\n\t\t<parcheggio>".$prenotazione{'parcheggio'}."</parcheggio>";
my $pulizia = "\n\t\t<pulizia>".$prenotazione{'pulizia'}."</pulizia>";
my $navaereo = "\n\t\t<navaereo>".$prenotazione{'navetaaereo'}."</navaereo>";
my $navtreno = "\n\t\t<navtreno>".$prenotazione{'navettatreno'}."</navtreno>";
my $totale = "\n\t\t<totale>".$prenotazione{'totale'}."</totale>";


if(my $lastnode = $doc->findnodes("//prenotazione[last()]")->get_node(1)){
my $lastid = $lastnode->getAttribute("id");
$id = $pren;
}else{
$id=0;
}

my $pren_el="\n\t<prenotazione id=\"$id\" >$dataarrivo$datapartenza$adulti$singole$doppie$parcheggio$pulizia$navaereo$navtreno$totale\n\t</prenotazione>\n";

my $frammento = $parser->parse_balanced_chunk($pren_el) or die("nodo non ben formato");

my $padre = $doc->findnodes("/prenotazioni")->get_node(1) or die("nodo non trovato");
$padre->appendChild($frammento) or die("nodo non inserito");


open(OUT, ">$file");
print OUT $doc->toString;
close(OUT);

print "Prenotazione Inserita\n";
print "Il numero della prenotazione &egrave; $pren\n";

}



if(!$error){
inserisciDatiXML($page->Vars,);}

else{
    Std::Disp($dataarrivo,$datapartenza,$numerocamere,$adulti,$doppie,$singole);
    my $diff = Std::DiffData($dataarrivo,$datapartenza);
    my $totale = Std::Prezzi($dataarrivo,$datapartenza,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo,$navettatreno, $diff);
    if($parcheggio eq "true" || $pulizia eq "true" || $navettaaereo eq "true" || $navettatreno eq "true"){
      Std::Servizi($parcheggio,$pulizia,$navettaaereo, $navettatreno);
    }
    #inserisciDatiXML($page->Vars);
    Std::Dati($dataarrivo,$datapartenza,$numerocamere,$adulti,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo, $navettatreno,$totale);
}
# sub enc {
#     return Encode::encode('UTF-8', $_[0]);
# }

#Std::EndHtml();
