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
	my $da = $page->param("da");
	my $a = $page->param("a");
	StdAdmin::StatoPrenotazioni($da,$a);
	}else{
	  StdAdmin::StatoPrenotazioni();
	}
}