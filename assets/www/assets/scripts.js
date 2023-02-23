/**
 * Description: UTPL-TEC
 * Author: Ediloja Digital
 *
 * Summary:
 *
 *    1. SECTION TAB
 */

function run_fun_ec() {
    /* ==========================================================================
    1. SECTION TAB
    ========================================================================== */
    var tab1 = document.querySelectorAll('.contenedor-tec .contenedor-tab.primer-bimestre a');
    var tab2 = document.querySelectorAll('.contenedor-tec .contenedor-tab.segundo-bimestre a');


    tab1.forEach(function (link) {
        link.addEventListener('click', function () {
            tab1.forEach(function (link) {
                link.classList.remove('activo');
            });

            this.classList.add('activo');

            // Contenido
            activoContenido(link, 1);
        });
    });

    tab2.forEach(function (link) {
        link.addEventListener('click', function () {
            tab2.forEach(function (link) {
                link.classList.remove('activo');
            });

            this.classList.add('activo');

            // Contenido
            activoContenido(link, 2);
        });
    });

    /* ==========================================================================
    1. SECTION ACORDEON
    ========================================================================== */

 /*   var accordion = document.querySelectorAll('.contenedor-tec .contenedor-acordeon');

    for (let i = 0; i < accordion.length; i++) {
        accordion[i].addEventListener('click', function () {
            this.classList.toggle('activo');
        });
    }*/

       /*---------ACORDEON  LEER MAS-------*/
 
      var acc = document.getElementsByClassName("accordeon");
      for (i = 0; i < acc.length; i++) {
          acc[i].addEventListener("click", function() {
              this.classList.toggle("activado");
              var panel = this.nextElementSibling;
       if (panel.style.maxHeight) {
         panel.style.maxHeight = null;
      } else {
          panel.style.maxHeight = panel.scrollHeight + "px";
      }
      });
  }

    /*---------FIN ACORDEON LEER MAS_____*/
      
     /*---------ACORDEON INFORMACION GENERAL--------------*/

    var acc = document.getElementsByClassName("titulo-acordeon");
    var i;

    var accp = document.getElementsByClassName("contenido-acordeon");



    for (i = 0; i < acc.length; i++) {


      acc[i].addEventListener("click", function() {
        
        for(n=0; n < acc.length;n++){
            acc[n].classList.remove("activador");
        }
      //document.getElementsByClassName("panel").style.display = "none";
        
        this.classList.toggle("activador");
        var panel = this.nextElementSibling;
        if (panel.style.maxHeight) {
         
          for (i = 0; i < accp.length; i++) {

          accp[i].style.maxHeight = null;
         accp[i].style.padding= 0 + "em";
          acc[i].classList.remove("activador");
          }
          panel.style.maxHeight = null;
          panel.style.padding= 0 + "em";
          
        } else {
        
        for (i = 0; i < accp.length; i++) {
          accp[i].style.maxHeight = null;
          accp[i].style.padding= 0 + "em";
          }
          panel.style.maxHeight = panel.scrollHeight + "px";
          panel.style.padding= 1+"em";
          
        }
      });
    }

     /*---------FIN ACORDEON INFORMACIONN GENERAL-------*/
}


function activoContenido(menu, bimestre) {
    if (bimestre == 1) {
        var contenido = document.querySelectorAll('.contenedor-planificacion.primer-bimestre div.item-menu');
    } else {
        var contenido = document.querySelectorAll('.contenedor-planificacion.segundo-bimestre div.item-menu');
    }

    contenido.forEach(function (texto) {
        texto.classList.remove('activo');
    });

    var id = menu.id
    var numero = id.substr(id.length - 1);
    var idContenido = "#itemContenido" + numero;
    var activoContenido = document.querySelector(idContenido);
    activoContenido.classList.add('activo');
}

var var_ec_hd = setInterval(function () {
    window.onload = function () { run_fun_ec(); }
}, 600);

clearInterval(var_ec_hd);

var ec_hd = setInterval(function () {

    run_fun_ec();

    clearInterval(ec_hd);

}, 600);


/*---------BLOQUEAR CURSO---------*/
setInterval("comprobar()", 6000);
var cont = 0;

function comprobar() {
    mensaje = "Estimado estudiante, le informamos que el curso se ha bloqueado debido a que ha finalizado el periodo académico."
    fecha_actual = new Date();
    fecha_cierre = new Date(2023, 03, 01);
    if (fecha_actual > fecha_cierre) {
        if (cont < 1) {
            alert(mensaje);
            cont = 2;
        }
        document.getElementById("bloquear").style.display = "flex";
        document.getElementById("app").style.display = "none";
    }
}
/*---------CONEXION ON-LINE Y OFF-LINE---------*/
setInterval("verificar_conexion()", 600);

function verificar_conexion() {
    if (navigator.onLine) {
        var ocultar = document.getElementsByClassName("off-line");
        for (i = 0; i < ocultar.length; i++) {
            ocultar[i].style.display = "none";
        }
        var mostrar = document.getElementsByClassName("on-line");
        for (j = 0; j < mostrar.length; j++) {
            mostrar[j].style.display = "block";
        }
    } else {
        var ocultar = document.getElementsByClassName("off-line");
        for (i = 0; i < ocultar.length; i++) {
            ocultar[i].style.display = "block";
        }
        var mostrar = document.getElementsByClassName("on-line");
        for (j = 0; j < mostrar.length; j++) {
            mostrar[j].style.display = "none";
        }
    }
}