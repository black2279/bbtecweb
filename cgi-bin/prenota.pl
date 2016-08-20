#!/usr/bin/perl

#print "Content type: text/html; charset=UTF-8\n\n";

#possibile modifica per gestire auto_increment,
#creare attributo su tag prenotazioni con contatore prenotazioni;

use DateTime;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
binmode STDOUT, ":utf8";

Std::HtmlCode();

sub inserisciDatiXML{
use XML::LibXML;
my $file = '../data/prenotazioni.xml';
my $parser = XML::LibXML->new();
my $id = -1;

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
my $dataarrivo = "\n\t\t<dataArrivo>".$prenotazione{'dataArrivo'}."</dataArrivo>";
my $notti = "\n\t\t<notti>".$prenotazione{'notti'}."</notti>";
my $adulti = "\n\t\t<adulti>".$prenotazione{'adulti'}."</adulti>";
my $tipocamera = "\n\t\t<tipoCamera>".$prenotazione{'tipoCamera'}."</tipoCamera>";
if ($tipocamera eq "singola"){
    my $prezzo = 
}


if(my $lastnode = $doc->findnodes("//prenotazione[last()]")->get_node(1)){
my $lastid = $lastnode->getAttribute("id");
$id = $lastid + 1;
}else{
$id=0;
}

my $pren_el="\n\t<prenotazione id=\"$id\" >$dataarrivo$notti$adulti$tipocamera\n\t</prenotazione>\n";

my $frammento = $parser->parse_balanced_chunk($pren_el) or die("nodo non ben formato");

my $padre = $doc->findnodes("/prenotazioni")->get_node(1) or die("nodo non trovato");
$padre->appendChild($frammento) or die("nodo non inserito");


open(OUT, ">$file");
print OUT $doc->toString;
close(OUT);

print "Prenotazione Inserita\n";
print "Il numero della prenotazione � $id\n";

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


my $page = new CGI;
my $dataarrivo = $page->param("dataArrivo");
my $notti = $page->param("notti");;
my $adulti = $page->param("adulti");
my $tipocamera = $page->param("tipoCamera");

my $error=0;




if(!isvaliddate($dataarrivo)){
	$error=1;
	print "La data contiene un errore\n";
}else{
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
  my $dt2 = DateTime->now(time_zone=>'local');
  if(DateTime->compare($dt1, $dt2) == -1){
  $error=1;
  print "Data non valida\n ";
  }
}

if ($notti !~ /\d/){
	$error=1;
	print "Notti non pu� contentere caratteri\n";
}elsif ($notti>=10){
	$error=1;
    print "Non puoi pernottare per pi� di 10 notti\n";
}elsif($notti == 0){
    $error=1;
	print "Il numero di notti non pu� essere pari a 0\n";
}

if ($adulti !~ /\d/){
	$error=1;
	print "Adulti non pu� contentere caratteri\n";
}elsif ($adulti>3){
	$error=1;
    print "Non esistono camere per pi� di 3 adulti\n";
}elsif($adulti == 0){
	$error=1;
	print "Il numero di adulti non pu� essere pari a 0\n";
}

if ($tipocamera !~ /singola|doppia|singoladoppia/){
	$error=1;
	print "Non esiste questo tipo di camera\n";
}elsif ( ($tipocamera eq "singola" and $adulti > 1 ) or ( $tipocamera eq "doppia" and $adulti > 2 ) or ( $tipocamera eq "singoladoppia" and $adulti > 3 ) ){
	print "Troppi adulti per il tipo di camera\n";
	$error=1;
}elsif ( ( $tipocamera eq "doppia" and $adulti < 2 ) or ( $tipocamera eq "singoladoppia" and $adulti < 3 )){
	print "Pochi adulti per il tipo di camera\n";
	$error=1;
}


if ($error){
	print "Dati non corretti";
}else{
	inserisciDatiXML($page->Vars);
}
