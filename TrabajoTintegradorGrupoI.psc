//El programa de Gestión de Stock y Ventas del comercio Ferreteria
//le permitirá realizar al usuario las cargas, control y búsqueda de mercadería/ventas. 

//- Alta, Baja y Modificación del stock (Articulos - Unidades - Precios).
//- Búsqueda por Nombre del Artículo.

//El Versionado del programa se encuentra en el siguiente repositorio:
//https://github.com/francocallegari/prog1grupoI.git

Proceso gestionFerreteria
	
	
	
	
	Repetir //Bucle para el menu
		opcionMenu <- menu();
		Segun opcionMenu Hacer
			1:
			2:
			3:
			4:
			5:
			6:
				Escribir "¡Saludos!"
		Fin Segun
	Hasta Que opcionMenu == 6
FinProceso

Funcion return<-menu() //Retorna eleccion en el menu
	Definir op_menu Como Entero;
	Repetir
		Escribir "Elija una opcion correcta: "
		Escribir "1. Registrar Venta"
		Escribir "2. Ver listado de productos ordenados por nombre"
		Escribir "3. Ver resumen de ventas"
		Escribir "4. Modificacion del stock (Artículos, unidades, precios)"
		Escribir "5. Buscar artículo por nombre"
		Escribir "6. Salir"
		Leer op_menu
	Mientras Que (op_menu<1 o op_menu>6)
	return <- op_menu
FinFuncion

SubProceso ordernarArregloASC(array,n,m,columnaAOrdenar) //Ordenamiento de array segun columna X
	Definir aux Como Texto; //cambiar el tipo de dato según el tipo de datos del array
	para i<-0 hasta n-2 Hacer //recorro las filas del array hasta la penultima
		para k<-i+1 hasta n-1 Hacer //recorro las filas del array hasta la última
			si array[i,columnaAOrdenar]>array[k,columnaAOrdenar] Entonces
				Para j<-0 Hasta m-1 Hacer //recorro las columnas del array
					aux <- array[i,j];
					array[i,j] <- array[k,j]; 
					array[k,j] <- aux; 
				Fin Para
			FinSi
		FinPara
	FinPara
FinSubProceso

SubProceso mostrarArray(array,n,m) //Muestra array bidimensional
	Para i<-0 Hasta n-1 Hacer
		Para j<-0 Hasta m-1 Hacer
			Escribir Sin Saltar array[i,j] "      ";
		Fin Para
		Escribir "";
	Fin Para
FinSubProceso

Funcion return<- buscarProducto(listaDeProductos,n,elementoABuscar) //Busqueda de producto por nombre
	Definir i Como Entero;
	i<-0;
	elementoEncontrado <- Falso;
	Mientras i <= n-1 y no elementoEncontrado
		si listaDeProductos[i,j] == elementoABuscar Entonces //DEFINIR PARAMETROS DE BUSQUEDA
			elementoEncontrado <- Verdadero; //fuerzo la salida del bucle
			detalleProducto <- listaDeProductos[i,j] //DEFINIR PARAMETROS DE BUSQUEDA
		FinSi
		i <- i +1; 
	FinMientras
	return	<- detalleProducto
FinFuncion

	
