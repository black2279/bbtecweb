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

#sub inserisciDatiXML{
#use XML::LibXML;
#my $file = '../data/tariffe.xml';

#my $parser = XML::LibXML->new();
#my $id = -1;

#my $doc=$parser->parse_file($file);

#my %prenotazione = @_;
#my $dataarrivo = $prenotazione{"dataArrivo"};
#my $datapartenza = $prenotazione{"dataPartenza"};
#my $notti = "\n\t\t<notti>".$prenotazione{'notti'}."</notti>";
#my $numerocamere = $prenotazione{"numeroCamere"};
#my $adulti = $prenotazione{"adulti"};
#my $tipocamera = "\n\t\t<tipoCamera>".$prenotazione{'tipoCamera'}."</tipoCamera>";
#my $parcheggio = $prenotazione{"parcheggio"};
#my $pulizia = $prenotazione{"pulizia"};
#my $navettaaereo = $prenotazione{"navettaereo"};
#my $navettatreno = $prenotazione{"navettatreno"};
#print "Il numero della prenotazione &egrave; $id\n";

#}


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
my $datapartenza = $page->param("dataPartenza");
my $numerocamere = $page->param("numeroCamere");
my $adulti = $page->param("adulti");
my $parcheggio = $page->param("parcheggio");
my $pulizia = $page->param("pulizia");
my $navettaaereo = $page->param("navettaaereo");
my $navettatreno = $page->param("navettatreno");
my $doppie = int($adulti / 2);
my $singole = int($adulti % 2);
#my $exdoppie="";
#my $exsingole="";

my $error=0;




if(!isvaliddate($dataarrivo)){
	$error=1;
	print "La data di arrivo contiene un errore\n";
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
  print "Data di arrivo non valida\n ";
  }
}

if(!isvaliddate($datapartenza)){
	$error=1;
	print "La data di partenza contiene un errore\n";
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
  print "Data di partenza non valida\n ";
  }
}



#if ($notti !~ /\d/){
#	$error=1;
#	print "Notti non pu� contentere caratteri\n";
#}elsif ($notti>=10){
#	$error=1;
#    print "Non puoi pernottare per pi� di 10 notti\n";
#}elsif($notti == 0){
#    $error=1;
#	print "Il numero di notti non pu� essere pari a 0\n";
#}

if($datapartenza < $dataarrivo){
    $error=1;
    print "<p>La data di partenza non pu&ograve; essere precedente a quella di arrivo</p>";
    # my $testo = enc($text);
    # print $text;

}
if($numerocamere > $adulti){
    $error=1;
    print "<p>Il numero delle camere non pu&ograve; essere superiore al numero di adulti</p>"
}

#if ($adulti !~ /\d/){
#	$error=1;
#	print "Adulti non pu&ograve; contentere caratteri\n";
#}elsif ($adulti>3){
#	$error=1;
#    print "Non esistono camere per pi&ugrave; di 3 adulti\n";
#}elsif($adulti == 0){
#	$error=1;
#	print "Il numero di adulti non pu&ograve; essere pari a 0\n";
#}

# if ($tipocamera !~ /singola|doppia|singoladoppia/){
# 	$error=1;
# 	print "Non esiste questo tipo di camera\n";
# }elsif ( ($tipocamera eq "singola" and $adulti > 1 ) or ( $tipocamera eq "doppia" and $adulti > 2 ) or ( $tipocamera eq "singoladoppia" # and $adulti > 3 ) ){
# 	print "Troppi adulti per il tipo di camera\n";
# 	$error=1;
# }elsif ( ( $tipocamera eq "doppia" and $adulti < 2 ) or ( $tipocamera eq "singoladoppia" and $adulti < 3 )){
# 	print "Pochi adulti per il tipo di camera\n";
# 	$error=1;
# }


# if ($error){
# 	print "Dati non corretti";
# }else{
	# inserisciDatiXML($page->Vars);
# }

if(!$error){
    #print "no error";
    Std::Disp($dataarrivo,$datapartenza,$numerocamere,$adulti,$doppie,$singole);
    my $diff = Std::DiffData($dataarrivo,$datapartenza);
    my $totale = Std::Prezzi($dataarrivo,$datapartenza,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo,$navettatreno, $diff);
    if($parcheggio eq "true" || $pulizia eq "true" || $navettaaereo eq "true" || $navettatreno eq "true"){
      Std::Servizi($parcheggio,$pulizia,$navettaaereo, $navettatreno);
    }
    #inserisciDatiXML($page->Vars);
    Std::Dati($dataarrivo,$datapartenza,$numerocamere,$adulti,$doppie,$singole,$parcheggio,$pulizia,$navettaaereo, $navettatreno,$totale);
}
else{
    print "<form action=\"../prenotazioni.html\" method=\"post\">
    <input type=\"submit\" value=\"Indietro\" 
         name=\"Submit\" />
</form>";
}
# sub enc {
#     return Encode::encode('UTF-8', $_[0]);
# }

#Std::EndHtml();
