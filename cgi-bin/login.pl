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
my $username = $page->param("username");
my $password = $page->param("psw");
my $database = 'admins';
my $login = Utils::login($username,$password,$database);
if($login){
	$session->param("logged", 1);
	$session->param("username", $username);
	print $page->redirect("home.pl");
}else{
	if($username eq undef && $password eq undef){
		StdAdmin::PrintLogin(1);
	}else{
		StdAdmin::PrintLogin($login);
	}
}
}elsif($session->param("logged") == 1){
	print $page->redirect("home.pl");
}