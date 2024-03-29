#!/usr/bin/perl

#print "Content type: text/html; charset=UTF-8\n\n";

#possibile modifica per gestire auto_increment,
#creare attributo su tag prenotazioni con contatore prenotazioni;

use DateTime;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use strict;
use warnings;
use Std;

binmode STDOUT, ":utf8";

Std::HtmlCode();
Std::Menu();
my $percorso = "Prenotazioni";

sub ricercaDatiXML{
my %valori;
my $error = 0;
use XML::LibXML;
my $file = '../data/prenotazioni.xml';
my $parser = XML::LibXML->new();
my %prenotazione = @_;
my $numeroprenotazione = $prenotazione{'numeroPrenotazione'};

if(-e($file)){
my $doc=$parser->parse_file($file);
$valori{'npren'} = $numeroprenotazione;
if(my $node = $doc->findnodes("//prenotazione[\@id=\"$numeroprenotazione\"]")->get_node(1)){
$percorso = "<a href=\"prenotazioni.pl\">Prenotazioni</a> &gt;&gt; Ricerca Prenotazione";
Std::Breadcrumb($percorso);
my @childnodes = $node->nonBlankChildNodes();
my $arrivo = $childnodes[0]->textContent;
my $partenza = $childnodes[1]->textContent;
my $adulti = $childnodes[2]->textContent;
my $singole = $childnodes[3];
my $doppie = $childnodes[4];
my $parcheggio = $childnodes[5];
my $pulizia = $childnodes[6];
my $navaereo = $childnodes[7];
my $navtreno = $childnodes[8];
my $prezzo = $childnodes[9]->textContent;

Std::PrintPren($arrivo,$partenza,$adulti,$singole,$doppie,$prezzo,$numeroprenotazione,$parcheggio,$pulizia,$navaereo,$navtreno);
print "<div class=\"separatore\" ></div>"; 
#print "Data Arrivo ".$childnodes[0]->textContent."\n";
#print "Notti ".$childnodes[1]->textContent."\n";
#print "Adulti ".$childnodes[2]->textContent."\n";
#print "Tipo Camera ".$childnodes[3]->textContent."\n";
}else{
Std::Breadcrumb($percorso);
if($numeroprenotazione eq undef){
    $valori{'erpren'} = "Inserire il codice della prenotazione da cercare."
}
else{
$valori{'erpren'} = "Nessuna prenotazione trovata";
}
Std::FormPren(%valori);
}
Std::EndHtml();
}else{
Std::Breadcrumb($percorso);
if($numeroprenotazione eq undef){
    $valori{'erpren'} = "Inserire il codice della prenotazione da cercare."
}
else{
$valori{'erpren'} = "Nessuna prenotazione trovata";
}
Std::FormPren(%valori);
}

}

my $page = new CGI;
#my $numeroprenotazione = $page->param("numeroPrenotazione");

my $error=0;

#if($numeroprenotazione !~ /\d/ ){
#$error=1;
#print "Il numero di prenotazione non pu� contenere #caratteri\n";
#}


#if ($error){
#	print "<p>Dati non corretti</p>";
#}else{
	ricercaDatiXML($page->Vars);
#}
