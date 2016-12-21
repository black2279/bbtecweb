#!/usr/bin/perl

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
	my $c = CGI::Cookie->new(-name    =>  'CGISESSID',
                             -value   =>  '',
                             -expires =>  '-1d',
                             -path    =>  '/',
	                    );
	print "Set-Cookie: $c\n";
	$session->delete();
	print $page->redirect("login.pl");
}