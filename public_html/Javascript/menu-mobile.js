function menuMobile(){
	if(screen.width <= 1024){
	 var menu = document.getElementById("menu");
	 var wrapper = document.getElementById("wrapper");
	 var bar = document.createElement('div');
	 bar.setAttribute("onclick","openMenu()");
	 bar.id = 'hamburger-bar';
	 bar.innerText = '';
	 menu.style.display = 'none';
	 wrapper.insertBefore(bar,wrapper.childNodes[2]);
	}
}

function openMenu(){
 var menu = document.getElementById("menu");
 if(menu.style.display == 'none'){
	menu.style.display = 'block';
 }else{
	menu.style.display = 'none';
 }
}