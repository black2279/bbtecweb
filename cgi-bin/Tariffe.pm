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

sub setPrezzoCamera{
	my($tipo,$prezzo)=@_;
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
	my $prezzo_camera = $doc->findnodes("/tariffe/$nodo/text()")->get_node(1);
	$prezzo_camera->setData($prezzo);
	open(OUT, ">$file");
	print OUT $doc->toString;
	close(OUT);
}

sub getPrezzoParcheggio(){
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/parcheggio")->get_node(1)->textContent;
	return $prezzo;
}

sub setPrezzoParcheggio{
	my($p)=@_;
	my $nodo = "parcheggio";
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/$nodo/text()")->get_node(1);
	$prezzo->setData($p);
	open(OUT, ">$file");
	print OUT $doc->toString;
	close(OUT);
}

sub getPrezzoNavettaAeroporto(){
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/navettaaeroporto")->get_node(1)->textContent;
	return $prezzo;
}

sub setPrezzoNavettaAeroporto{
	my($p)=@_;
	my $nodo = "navettaaeroporto";
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/$nodo/text()")->get_node(1);
	$prezzo->setData($p);
	open(OUT, ">$file");
	print OUT $doc->toString;
	close(OUT);
}

sub getPrezzoNavettaTreno(){
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/navettatreno")->get_node(1)->textContent;
	return $prezzo;
}

sub setPrezzoNavettaTreno{
	my($p)=@_;
	my $nodo = "navettatreno";
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/$nodo/text()")->get_node(1);
	$prezzo->setData($p);
	open(OUT, ">$file");
	print OUT $doc->toString;
	close(OUT);
}

sub getPrezzoPulizie(){
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/pulizie")->get_node(1)->textContent;
	return $prezzo;
}

sub setPrezzoPulizie{
	my($p)=@_;
	my $nodo = "pulizie";
	my $file = '../data/tariffe.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $prezzo = $doc->findnodes("/tariffe/$nodo/text()")->get_node(1);
	$prezzo->setData($p);
	open(OUT, ">$file");
	print OUT $doc->toString;
	close(OUT);
}


1;