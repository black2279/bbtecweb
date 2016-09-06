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
Std::Menu();



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
#my $numerocamere = $page->param("numerocamere");
my $adulti = $page->param("adulti");
my $singole = $page->param("singole");
my $doppie = $page->param("doppie");
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
$valori{'intcarta'} = $intcarta;
if ($pagamento eq "Visa"){
    $valori{'Vpag'} = "selected = \"selected\"";
}
if ($pagamento eq "Mastercard"){
    $valori{'Mpag'} = "selected = \"selected\"";
}
if ($pagamento eq "American Express"){
    $valori{'Apag'} = "selected = \"selected\"";
}

if(length ($nome) == 0){
    $error = 1;
    $valori{'ernome'} = "Il campo nome non pu&ograve; essere vuoto."
} else {
    if($nome =~ /\d/){
        $error=1;
        $valori{'ernome'} = "Il nome pu&ograve; contenere solo lettere.";
    }
}

if($cognome eq undef){
    $error = 1;
    $valori{'ercognome'} = "Il campo cognome non pu&ograve; essere vuoto."
} else{
    if($cognome =~ /\d/){
    $error = 1;
    $valori{'ercognome'} = "Il cognome pu&ograve; contenere solo lettere";
    }
}

if($dataNascita eq undef){
    $error = 1;
    $valori{'ernascita'} = "Il campo Data di nascita non pu&ograve; essere vuoto."
}

if($citta eq undef){
    $error = 1;
    $valori{'ercitta'} = "Il campo Citt&agrave; non pu&ograve; essere vuoto."
} else {
    if($citta =~ /\d/){
    $error = 1;
    $valori{'ercitta'} = "Il campo Citt&agrave; pu&ograve; contenere solo lettere";
    }
}

if($email eq undef){
    $error = 1;
    $valori{'eremail'} = "Il campo <span lang=\"en\">email</span> non pu&ograve; essere vuoto.";
}

if($cemail eq undef){
    $error = 1;
    $valori{'ercemail'} = "&Egrave; necessario riscrivere l'<span lang=\"en\">email</span>.";
}

if($email !~ m/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{1,63}/){
    $valori{'eremail'} = "Inserire un'email valida."
} else {
if($email ne $cemail){
    $error = 1;
    $valori{'eremail'} = "Le email non coincidono.";
}
}

if($telefono eq undef){
    $error = 1;
    $valori{'ertel'} = "Il campo Numero di telefono non pu&ograve; essere vuoto.";
}

if($numerocarta eq undef){
    $error = 1;
    $valori{'ernumcarta'} = "Il campo numero della carta non pu&ograve; essere vuoto.";
} else {
    if($numerocarta =~ /\D/ ){
    $error=1;
    $valori{'ernumcarta'} = "Il numero della carta deve contenere solo cifre.";
    }
    else{
    
            if($pagamento eq "Visa" && (length $numerocarta != 16)){
                $error=1;
                $valori{'ercifre'} = "Il numero della carta non &egrave; valido.";
            }

            if($pagamento eq "Mastercard" &&  length $numerocarta != 16){
                $error=1;
                $valori{'ercifre'} = "Il numero della carta non &egrave; valido.";
            }

            if($pagamento eq "American Express" && length $numerocarta != 15){
                $error=1;
                $valori{'ercifre'} = "Il numero della carta non &egrave; valido.";
            }
            
            if($pagamento eq "Visa" && substr($numerocarta, 0, 1) != "4"){
                $error=1;
                $valori{'ermet'} = "Controlla che il metodo di pagamento sia corretto.";
            }

            if($pagamento eq "Mastercard" && substr($numerocarta, 0, 1) != "5"){
                $error=1;
                $valori{'ermet'} = "Controlla che il metodo di pagamento sia corretto.";
            }
            
            if($pagamento eq "American Express" && substr($numerocarta, 0, 1) != "3"){
                $error=1;
                $valori{'ermet'} = "Controlla che il metodo di pagamento sia corretto.";
            }

    }
}

if($cvc eq undef){
    $error = 1;
    $valori{'ercvc'} = "Il campo CVC non pu&ograve; essere vuoto.";
} else {
    if($cvc =~ /\D/ ){
    $error=1;
    $valori{'ercvc'} = "Il codice CVC deve contenere solo cifre.";
    }
}


if($intcarta eq undef){
    $error = 1;
    $valori{'erintcarta'} = "Il campo Intestatario della carta non pu&ograve; essere vuoto.";
} else {
    if($intcarta =~ /\d/){
    $error = 1;
    $valori{'erintcarta'} = "Il nome dell'intestatario pu&ograve; contenere solo lettere";
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
if($dataNascita ne undef && !isvaliddate($dataNascita)){
	$error=1;
	$valori{'ernascita'} = "Data di nascita non valida.";
}



sub ricercaDatiXML{
use XML::LibXML;
my $file = '../data/prenotazioni.xml';
my $parser = XML::LibXML->new();

if(-e($file)){

my $doc=$parser->parse_file($file);

my %prenotazione = @_;
my $numeroprenotazione = $prenotazione{'numeroPrenotazione'};
my @set = ('1' ..'9', 'A' .. 'N', 'P' .. 'Z');
my $str = join '' => map $set[rand @set], 1 .. 6;

while(my $node = $doc->findnodes("//prenotazione[\@id = \"$str\"]")->get_node(1)){
   my @set = ('1' ..'9', 'A' .. 'N', 'P' .. 'Z');
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

my $dataarrivo = "\n\t\t<dataArrivo>$prenotazione{'dataarrivo'}</dataArrivo>";
my $datapartenza = "\n\t\t<dataPartenza>$prenotazione{'datapartenza'}</dataPartenza>";
my $adulti = "\n\t\t<adulti>$prenotazione{'adulti'}</adulti>";
my $singole = "\n\t\t<singole>$singole</singole>";
my $doppie = "\n\t\t<doppie>$doppie</doppie>";
my $parcheggio = "\n\t\t<parcheggio>$prenotazione{'parcheggio'}</parcheggio>";
my $pulizia = "\n\t\t<pulizia>$prenotazione{'pulizia'}</pulizia>";
my $navaereo = "\n\t\t<navaereo>$prenotazione{'navettaaereo'}</navaereo>";
my $navtreno = "\n\t\t<navtreno>$prenotazione{'navettatreno'}</navtreno>";
my $totale = "\n\t\t<totale>$prenotazione{'totale'}</totale>";
my $nome = "\n\t\t<nome>$prenotazione{'nome'}</nome>";
my $cognome = "\n\t\t<cognome>$prenotazione{'cognome'}</cognome>";
my $dataNascita = "\n\t\t<dataNascita>$prenotazione{'dataNascita'}</dataNascita>";
my $citta = "\n\t\t<citta>$prenotazione{'citta'}</citta>";
my $email = "\n\t\t<email>$prenotazione{'email'}</email>";
my $telefono = "\n\t\t<telefono>$prenotazione{'telefono'}</telefono>";


if(my $lastnode = $doc->findnodes("//prenotazione[last()]")->get_node(1)){
my $lastid = $lastnode->getAttribute("id");
$id = $pren;
}else{
$id=0;
}

my $pren_el="\n\t<prenotazione id=\"$id\" >$dataarrivo$datapartenza$adulti$singole$doppie$parcheggio$pulizia$navaereo$navtreno$totale$nome$cognome$dataNascita$citta$email$telefono\n\t</prenotazione>\n";

my $frammento = $parser->parse_balanced_chunk($pren_el) or die("nodo non ben formato");

my $padre = $doc->findnodes("/prenotazioni")->get_node(1) or die("nodo non trovato");
$padre->appendChild($frammento) or die("nodo non inserito");


open(OUT, ">$file");
print OUT $doc->toString;
close(OUT);

#print "Prenotazione Inserita";
#print "Il numero della prenotazione &egrave; $pren";
return $pren;
}



if(!$error){
my $percorso = "<a href=\"prenotazioni.pl\">Prenotazioni</a> &gt;&gt; Disponibilit&agrave; &gt;&gt; Conferma";
Std::Breadcrumb($percorso);
my $pren = inserisciDatiXML($page->Vars);
print "<h2>La prenotazione &egrave; andata a buon fine.</h2>
        <p>Il codice di prenotazione &egrave; $pren .</p>
        <h2>La tua prenotazione</h2>";
Std::Disp($dataarrivo,$datapartenza,$adulti,$doppie,$singole);
    my $diff = Std::DiffData($dataarrivo,$datapartenza);
	if($parcheggio eq "true" || $pulizia eq "true" || $navettaaereo eq "true" || $navettatreno eq "true"){
     Std::Servizi($parcheggio,$pulizia,$navettaaereo, $navettatreno);
    }
    my $totale = Std::Prezzi($dataarrivo,$datapartenza,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo,$navettatreno, $diff);
	#possibile rimozione
	print "<div class=\"separatore\"></div>"
}
else{
my $percorso = "<a href=\"prenotazioni.pl\">Prenotazioni</a> &gt;&gt; Disponibilit&agrave;";
Std::Breadcrumb($percorso);
    print "<h2>La tua prenotazione</h2>";
    Std::Disp($dataarrivo,$datapartenza,$adulti,$doppie,$singole);
    my $diff = Std::DiffData($dataarrivo,$datapartenza);
	if($parcheggio eq "true" || $pulizia eq "true" || $navettaaereo eq "true" || $navettatreno eq "true"){
	 Std::Servizi($parcheggio,$pulizia,$navettaaereo, $navettatreno);
	}
    my $totale = Std::Prezzi($dataarrivo,$datapartenza,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo,$navettatreno, $diff);
    Std::Dati($dataarrivo,$datapartenza,$adulti,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo, $navettatreno,$totale,%valori);
}
# sub enc {
#     return Encode::encode('UTF-8', $_[0]);
# }

Std::EndHtml();
