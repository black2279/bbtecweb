#!/usr/bin/perl
#print "Content type: text/html; charset=UTF-8\n\n";

use DateTime;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
# use Encode qw(encode);
use strict;
use warnings;
use Std;
binmode STDOUT, ":utf8";

Std::HtmlCode();
Std::MenuPren();

my $pagina = "Prenotazioni";

Std::Breadcrumb($pagina);

Std::FormPren();

Std::EndHtml();

