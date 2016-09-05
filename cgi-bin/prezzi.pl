#!/usr/bin/perl

#print "Content type: text/html; charset=UTF-8\n\n";

#possibile modifica per gestire auto_increment,
#creare attributo su tag prenotazioni con contatore prenotazioni;

use DateTime;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
# use Encode qw(encode);
use strict;
use warnings;
use Std;
binmode STDOUT, ":utf8";

Std::HtmlCode();
my $pagina = "Tariffe";
Std::Breadcrumb($pagina);
Std::Tariffe();

Std::EndHtml();
