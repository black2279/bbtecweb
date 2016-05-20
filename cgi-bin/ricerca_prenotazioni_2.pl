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

sub ricercaDatiXML{
use XML::LibXML;
my $file = '../data/prenotazioni.xml';
my $parser = XML::LibXML->new();

if(-e($file)){

my $doc=$parser->parse_file($file);

my %prenotazione = @_;
my $numeroprenotazione = $prenotazione{'numeroPrenotazione'};

if(my $node = $doc->findnodes("//prenotazione[\@id=".$numeroprenotazione."]")->get_node(1)){
my @childnodes = $node->nonBlankChildNodes();
my $arrivo = $childnodes[0];
my $notti = $childnodes[1];
my $adulti = $childnodes[2];
my $camera = $childnodes[3];
my $prezzo = $childnodes[4];

Std::PrintPren($arrivo,$notti,$adulti,$camera,$prezzo,$numeroprenotazione);
#print "Data Arrivo ".$childnodes[0]->textContent."\n";
#print "Notti ".$childnodes[1]->textContent."\n";
#print "Adulti ".$childnodes[2]->textContent."\n";
#print "Tipo Camera ".$childnodes[3]->textContent."\n";
}else{
print "Il numero di prenotazione non corrisponde";
}
Std::EndHtml();
}else{

print "Nessuna prenotazione trovata\n";

}

}

my $page = new CGI;
my $numeroprenotazione = $page->param("numeroPrenotazione");

my $error=0;

if($numeroprenotazione !~ /\d/ ){
$error=1;
print "Il numero di prenotazione non pu� contenere caratteri\n";
}


if ($error){
	print "Dati non corretti";
}else{
	ricercaDatiXML($page->Vars);
}
