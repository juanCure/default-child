/* Mi script para agregar nueva funcionalidad al default-child theme */

var acc = document.getElementsByClassName("acc-header");
// Llamando a la función open_acc_body para siempre mostrar el primer
// elemento del accordion abierto.
// open_acc_body.call(acc[0]);

fixed_anchors();

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

/* Función para fijar la caja con anclas en la vista Acerca de */
function fixed_anchors() {
  var fixed_anchors = $("#fixed_anchors");
  var reference = $(".block_language");
  var startPosition = reference.offset().top;

  $(document).scroll(function(){
    var y = $(this).scrollTop();
    if(y > startPosition) {
      fixed_anchors.addClass("fixed-anchors");
    } else {
      fixed_anchors.removeClass("fixed-anchors");
    }
  });
}

/* Agregando el script para hacer funcionar el menú hamburguesa */

$(function(){
  $("#hamburguesa").click(function(){
    //Qué hago?
    $("#menuPhone").slideToggle("slow");
  });

  $("#menuPhone li").click(function(){
    //Qué hago
    ("#menuPhone").slideUp();
  });
});