#!/usr/bin/perl
use strict;
use warnings;
use XML::LibXML;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use CGI::Session;
package Utils;

sub ricercaPrenotazioni{
	my ($dataarrivo,$datapartenza)=@_;
	$dataarrivo =~ s/\//-/g; #sostituisce / con -
	$datapartenza =~ s/\//-/g; #sostituisce / con -
	my $dataArrivo ="number(concat(substring(dataArrivo,7,4),substring(dataArrivo,4,2),substring(dataArrivo,1,2)))"; 
	my $dataPartenza ="number(concat(substring(dataPartenza,7,4),substring(dataPartenza,4,2),substring(dataPartenza,1,2)))";

	my $file = '../data/prenotazioni.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	if($dataarrivo eq undef && $datapartenza eq undef){
		return $doc->findnodes("//prenotazione");
	}elsif($dataarrivo eq undef){
		$datapartenza ="number(concat(substring('$datapartenza',7,4),substring('$datapartenza',4,2),substring('$datapartenza',1,2)))";
		return $doc->findnodes("//prenotazione[
	($dataArrivo <= $datapartenza and $dataPartenza >= $datapartenza) or
	($dataArrivo <= $datapartenza and $dataPartenza <= $datapartenza) ]");
	}elsif($datapartenza eq undef){
		$dataarrivo ="number(concat(substring('$dataarrivo',7,4),substring('$dataarrivo',4,2),substring('$dataarrivo',1,2)))";
		return $doc->findnodes("//prenotazione[
	($dataArrivo <= $dataarrivo and $dataPartenza >= $dataarrivo) or
	($dataArrivo >= $dataarrivo and $dataPartenza >= $dataarrivo) ]");
	}else{
		return $doc->findnodes("//prenotazione[
	($dataArrivo <= $dataarrivo and $dataPartenza <= $datapartenza and $dataPartenza >= $dataarrivo) or
	($dataArrivo >= $dataarrivo and $dataPartenza <= $datapartenza) or
	($dataArrivo >= $dataarrivo and $dataArrivo <= $datapartenza and $dataPartenza >= $datapartenza) or
	($dataArrivo <= $dataarrivo and $dataPartenza >= $datapartenza) ]");
	}
}

sub ricercaPrenotazioneConId{
	my ($id)=@_;
	my $file = "../data/prenotazioni.xml";
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	return $doc->findnodes("//prenotazione[\@id=\'$id\']")->get_node(0);
}

sub getNumeroCamerePrenotate{
	my($prenotazioni,$tipo)=@_;
	my $nodo='unknown';
	my $numero_camere=0;
	if ($tipo eq 'DOPPIA'){
		$nodo='doppie';
	}elsif($tipo eq 'SINGOLA'){
		$nodo='singole';
	}else{
		print "Tipo camera sconosciuto";
	}
	foreach my $prenotazione ($prenotazioni->get_nodelist()) {
	  $numero_camere = $prenotazione->findnodes("$nodo")->get_node(1)->textContent + $numero_camere;
	}
	
	return $numero_camere;
}

sub getNumeroCamere{
	my($tipo)=@_;
	my $nodo='unknown';
	if ($tipo eq 'DOPPIA'){
		$nodo='doppie';
	}elsif($tipo eq 'SINGOLA'){
		$nodo='singole';
	}else{
		print "Tipo camera sconosciuto";
	}
	my $file = '../data/bb.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $numero_camere = $doc->findnodes("/bb/$nodo")->get_node(1)->textContent;
	return int($numero_camere);
}


sub login{
	my($username,$password,$database)=@_;
	my $file = "../data/$database.xml";
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $utente = $doc->findnodes("child::".$database."/child::*[username='$username']");
	if($utente){
		my $pw_db=$utente->get_node(1)->findnodes("password");
		if ($password eq $pw_db){
			return 1;
		}else{
			return 0;
			}
	}else{
	 return 0;
	}
}

sub start_session{
	my($page)=@_;
	my $sid = $page->cookie('CGISESSID') || undef;
	my $session = new CGI::Session("driver:File", $sid, {Directory=>File::Spec->tmpdir});
	if ($sid eq undef){
		my $cookie = $page->cookie(CGISESSID => $session->id);
		print "Set-Cookie: $cookie\n";
		#print $page->header( -cookie => $cookie );
		$session->param("logged", 0);
	}
	return $session;
}

sub setNumeroCamere{
	my($tipo,$numero)=@_;
	my $nodo='unknown';
	if ($tipo eq 'DOPPIA'){
		$nodo='doppie';
	}elsif($tipo eq 'SINGOLA'){
		$nodo='singole';
	}else{
		print "Tipo camera sconosciuto";
	}
	my $file = '../data/bb.xml';
	my $parser = XML::LibXML->new();
	my $doc=$parser->parse_file($file);
	my $numero_camere = $doc->findnodes("/bb/$nodo/text()")->get_node(1);
	$numero_camere->setData($numero);
	open(OUT, ">$file");
	print OUT $doc->toString;
	close(OUT);
}

1;
