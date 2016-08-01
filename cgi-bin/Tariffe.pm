#!/usr/bin/perl
use strict;
use warnings;
use XML::LibXML;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
package Tariffe;

sub getPrezzoCamera{
	my($tipo)=@_;
	my $nodo='unknown';
	if ($tipo eq 'DOPPIA'){
		$nodo='doppia';
	}elsif($tipo eq 'SINGOLA'){
		$nodo='singola';
	}else{
		print "Tipo camera sconosciuto";
	}
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/$nodo")->get_node(1)->textContent;
	return $prezzo;
}

sub getPrezzoParcheggio(){
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/parcheggio")->get_node(1)->textContent;
	return $prezzo;
}

sub getPrezzoNavettaAeroporto(){
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/navettaaeroporto")->get_node(1)->textContent;
	return $prezzo;
}

sub getPrezzoNavettaTreno(){
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/navettatreno")->get_node(1)->textContent;
	return $prezzo;
}

sub getPrezzoPulizie(){
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/pulizie")->get_node(1)->textContent;
	return $prezzo;
}

1;