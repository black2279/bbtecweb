#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
package StdAdmin;

use Exporter qw(import);
our @EXPORT = qw(HtmlCode);
sub HtmlCode{
  print "Content-type: text/html\n\n";

        print"
    <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
    <html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"it\" lang=\"it\">


    <head>
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />

    <title>Bed and Breakfast Navona</title>
    <meta name=\"title\" content=\"Bed and Breakfast Navona\"/>
    <meta name=\"description\" content=\"Sito del Bed and Breakfast Navona - Roma\" />
    <meta name=\"keywords\" content=\"bed and breakfast, bed, breakfast, Roma, Navona\" />
    <meta name=\"language\" content=\"italian it\" />
    <meta name=\"author\" content=\"Alba Matteo, Andrighetto Cristian, Zoso Leonardo\" />
    <link href=\"../style.css\" rel=\"stylesheet\" type=\"text/css\" />


    </head>
    <body>
    <div id=\"wrapper\">
    <div id=\"header\">
        <img src=\"../img/Logo-bn.png\" alt=\"logo B&amp;B\" id=\"logo\"/>
    <!--<h1>Bed and Breakfast Navona - Roma</h1>-->
    </div>
"}

sub Menu {

 print"
 <div id=\"menu\">
        <ul>
            <li><a href=\"home.pl\"><span lang=\"en\">Home</span></a></li>

            <li><a href=\"bb.pl\">Bed &amp; Breakfast</a></li>

            <li><a href=\"stato_prenotazioni.pl\">Stato Prenotazioni</a></li>

            <li><a href=\"tariffe.pl\">Tariffe</a></li>
        </ul>
    </div>"
}

sub Breadcrumb{
my ($logged,@percorso) = @_;
print "<div id=\"breadcrumb\">";
if($logged){
Logout();
}
print "Ti trovi qui: <a href=\"home.pl\"><span lang=\"en\">Home</span></a> &gt;&gt; $percorso[0]
</div>
<div id=\"content\">
";
}

sub EndHtml{
print "</div>
    <div id=\"footer\">
    <div id=\"left\">
    <p>Tutti i diritti riservati</p>
	<img class=\"imgValidCode\" src=\"../img/XMLvalido.png\" alt=\"XHTML valido\"/>
	<img class=\"imgValidCode\" src=\"../img/CSSvalido.gif\" alt=\"CSS valido\"/>
    </div>

    <div id=\"right\">
        <h3> Contatti </h3>
		<p>Via delle Pertiche, 11
    	    04323 Latina
            Roma (RM)</p>

        <p>Telefono 0093412534</p>
        <p>Email bbmichele\@gmail.com</p>
    </div>

</div>
</div>
</body>
</html>";
}

sub Login{
my($esito)=@_;
print"
	<div id=\"login\">
		<form id=\"formLogin\" method=\"post\" action=\"login.pl\" >
		<span lang=\"en\">Username</span>
		<input id=\"username\" name=\"username\" type=\"text\"  />
		<span lang=\"en\">Password</span>
		<input id=\"psw\" name=\"psw\" type=\"password\" />
		<input type=\"submit\" value=\"Login\"/> 
		</form>";
		if(!$esito){
		print "<span>Username o Password non corretti</span>";
		}
print 
"</div>
";
}

sub Benvenuto{
	my($username)=@_;
	print"
	<h2>Ben ritornato $username</h2>
	<p>Benvenuto nel Pannello di Amministrazione del <strong>Navona - Bed &amp; Breakfast</strong>.
	<p>Qui potrai visualizzare e modificare le caratteristiche del tuo Bed &amp Breakfast, personalizzare le tariffe 
	e vedere lo stato delle prenotazioni in corso.</p>
	";
}

sub Logout{
	print"
	<a id=\"logout\" href=\"logout.pl\">Logout</a>
	";
}


sub PrintLogin{
 my($esito)=@_;
 HtmlCode();
 Breadcrumb();
 Login($esito);
 EndHtml();
}

sub PrintHome{
 my($username)=@_;
 HtmlCode();
 Menu();
 Breadcrumb(1,"Home");
 Benvenuto($username);
 EndHtml();
}
