#!/usr/bin/perl
use DateTime;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use strict;
use warnings;
use StdAdmin;
use Utils;
use CGI::Session;
binmode STDOUT, ":utf8";
my $page = new CGI;
my $session = Utils::start_session($page);

if($session->param("logged") == 0){
print $page->redirect("login.pl");
}elsif($session->param("logged") == 1){
	
	if($ENV{'CONTENT_LENGTH'}){
	my $nsingole = $page->param("nsingole");
	my $ndoppie = $page->param("ndoppie");
	if($nsingole eq undef && $ndoppie eq undef){
	 my $errore="<p>Compila almeno un campo</p>";
	 StdAdmin::BedBreakfast($errore);
	}else{
		my $errsingole = undef;
		my $errdoppie = undef;
		my $errore = "";
		if($nsingole =~ /^\d+$/){
				Utils::setNumeroCamere('SINGOLA',$nsingole);
		}elsif($nsingole){
				$errsingole="<p>Il campo singole deve essere un numero</p>";
		}
		if($ndoppie =~ /^\d+$/){
			Utils::setNumeroCamere('DOPPIA',$ndoppie);
		}elsif($ndoppie){
				$errdoppie="<p>Il campo doppie deve essere un numero</p>";
		}
		if($errsingole){
			$errore=$errore.$errsingole;
		}
		if($errdoppie){
			$errore=$errore.$errdoppie;
		}
		StdAdmin::BedBreakfast($errore);
		}
	}else{
	  StdAdmin::BedBreakfast();
	}
}
