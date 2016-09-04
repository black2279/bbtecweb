#!/usr/bin/perl
use DateTime;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use strict;
use warnings;
use StdAdmin;
use Tariffe;
use Utils;
use CGI::Session;
binmode STDOUT, ":utf8";

my $page = new CGI;
my $session = Utils::start_session($page);

if($session->param("logged") == 0){
print $page->redirect("login.pl");
}elsif($session->param("logged") == 1){
	
	if($ENV{'CONTENT_LENGTH'}){
	my $psingola = $page->param("psingola");
	my $pdoppia = $page->param("pdoppia");
	my $pparcheggio = $page->param("pparcheggio");
	my $ppulizie = $page->param("ppulizie");
	my $pnavaereo = $page->param("pnavaereo");
	my $pnavtreno = $page->param("pnavtreno");
	if($psingola eq undef && $pdoppia eq undef && $pparcheggio eq undef 
	&& $ppulizie eq undef && $pnavaereo eq undef && $pnavtreno eq undef){
	 my $errore="<p>Compila almeno un campo</p>";
	 StdAdmin::Tariffe($errore);
	}else{
		my $errore = "";
		if($psingola =~ /^\d+$/){
			Tariffe::setPrezzoCamera('SINGOLA',$psingola);
		}elsif($psingola){
			$errore = $errore."<p>Il campo Prezzo Singola deve essere un numero</p>";
		}
		if($pdoppia =~ /^\d+$/){
			Tariffe::setPrezzoCamera('DOPPIA',$pdoppia);
		}elsif($pdoppia){
			$errore= $errore."<p>Il campo Prezzo Doppia deve essere un numero</p>";
		}
		if($pparcheggio =~ /^\d+$/){
			Tariffe::setPrezzoParcheggio($pparcheggio);
		}elsif($pparcheggio){
				$errore= $errore."<p>Il campo Prezzo Parcheggio deve essere un numero</p>";
		}
		if($ppulizie =~ /^\d+$/){
			Tariffe::setPrezzoPulizie($ppulizie);
		}elsif($ppulizie){
				$errore= $errore."<p>Il campo Prezzo Pulizie deve essere un numero</p>";
		}
		if($pnavaereo =~ /^\d+$/){
			Tariffe::setPrezzoNavettaAeroporto($pnavaereo);
		}elsif($pnavaereo){
				$errore= $errore."<p>Il campo Prezzo Navetta per Aeroporto deve essere un numero</p>";
		}
		if($pnavtreno =~ /^\d+$/){
			Tariffe::setPrezzoNavettaTreno($pnavtreno);
		}elsif($pnavtreno){
				$errore= $errore."<p>Il campo Prezzo Navetta per Treno deve essere un numero</p>";
		}
		StdAdmin::Tariffe($errore);
		}
	}else{
	  StdAdmin::Tariffe();
	}
}