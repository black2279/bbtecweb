#!/usr/bin/perl
#print "Content type: text/html; charset=UTF-8\n\n";

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
my $error=0;

my %valori;

$valori{'arrivo'} = $dataarrivo;
$valori{'partenza'} = $datapartenza;
$valori{'numerocamere'} = $numerocamere;
$valori{'adulti'} = $adulti;
if($parcheggio eq "true"){
    $valori{'parcheggio'} = "checked";
}
if($pulizia eq "true"){
    $valori{'pulizia'} = "checked";
}
if($navettaaereo eq "true"){
    $valori{'navaereo'} = "checked";
}
if($navettatreno eq "true"){
    $valori{'navtreno'} = "checked";
}


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
    Std::FormPren(%valori);
    #print "<form action=\"../cgi-bin/prenotazioni.pl\" method=\"post\">
    #<input type=\"submit\" value=\"Indietro\" 
    #     name=\"Submit\" />
#</form>";
}

#Std::EndHtml();
