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
	 StdAdmin::BedBreakfast();
	 print "Compila almeno un campo";
	}else{
		if($nsingole){
			Utils::setNumeroCamere('SINGOLA',$nsingole);
			}
		if($ndoppie){
			Utils::setNumeroCamere('DOPPIA',$ndoppie);
			}
		StdAdmin::BedBreakfast();
		}
	}else{
	  StdAdmin::BedBreakfast();
	}
}