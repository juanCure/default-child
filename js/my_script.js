/* Mi script para agregar nueva funcionalidad al default-child theme */

var acc = document.getElementsByClassName("acc-header");
// Llamando a la función open_acc_body para siempre mostrar el primer
// elemento del accordion abierto.
open_acc_body.call(acc[0]);

var i;
for (i = 0; i < acc.length; i++) {
  acc[i].onclick = function() {
  	open_acc_body.call(this); 
  }
}
/* Función para abrir el cuerpo del accordion */
function open_acc_body(){
	this.classList.toggle("active");
  var panel = this.nextElementSibling;
  if (panel.style.maxHeight){
    panel.style.maxHeight = null;
  } else {
    panel.style.maxHeight = panel.scrollHeight + "px";
  } 
}

function close_div(id) {
  $("#" + id).fadeOut("slow");
}