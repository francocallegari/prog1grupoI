//El programa de Gestión de Stock y Ventas del comercio Ferreteria
//le permitirá realizar al usuario las cargas, control y búsqueda de mercadería/ventas. 

//- Alta, Baja y Modificación del stock (Articulos - Unidades - Precios).
//- Búsqueda por Nombre del Artículo.

//El Versionado del programa se encuentra en el siguiente repositorio:
//https://github.com/francocallegari/prog1grupoI.git

Proceso gestionFerreteria
	Definir ventasDiarias como cadena //Areglo de registro de ventas
	Dimension ventasDiarias[350,5]
	definir indiceVenta Como Entero
	indiceVenta = 0
	
	definir productosDescripcion como cadena
	dimension productosDescripcion[200,2] //200 como maximo de productos
	// 0        1     
	//Codigo   Nombre 
	
	definir productosPreciosCantidades como real
	dimension productosPreciosCantidades[200,3] 
	// 0        1                  2
	//Codigo   Precio por unidad  Cantidad/Stock
	
	//PRECARGO 4 PRODUCTOS EN EL ARREGLO
	productosDescripcion[0,0] <- "1" //PRECARGO 4 PRODUCTOS EN EL ARREGLO
	productosDescripcion[0,1] <- "Tornillo"
	productosPreciosCantidades[0,0] <- 1
	productosPreciosCantidades[0,1] <- 10
	productosPreciosCantidades[0,2] <- 247
	
	productosDescripcion[1,0] <- "2"
	productosDescripcion[1,1] <- "Lija"
	productosPreciosCantidades[1,0] <- 2
	productosPreciosCantidades[1,1] <- 55.40
	productosPreciosCantidades[1,2] <- 183
	
	productosDescripcion[2,0] <- "4"
	productosDescripcion[2,1] <- "Martillo"
	productosPreciosCantidades[2,0] <- 4
	productosPreciosCantidades[2,1] <- 345.99
	productosPreciosCantidades[2,2] <- 32
	
	productosDescripcion[3,0] <- "3"
	productosDescripcion[3,1] <- "Enduido"
	productosPreciosCantidades[3,0] <- 3
	productosPreciosCantidades[3,1] <- 255.30
	productosPreciosCantidades[3,2] <- 17
	
	definir cantidadProductosRegistrados como entero //Cantidad de productos que estan registrados, va a aumentar en caso de agregar nuevos
	cantidadProductosRegistrados <- 4
	
	
	Repetir //Bucle para el menu
		opcionMenu <- menu();
		Segun opcionMenu Hacer
			1: //Registrar Venta
			2: //Ver listado de productos ordenados por código
				ordernarArregloTextoASC(productosDescripcion,cantidadProductosRegistrados,2,0) //Se utilizan dos ordenamientos, uno para texto otro para reales.
				ordernarArregloRealesASC(productosPreciosCantidades,cantidadProductosRegistrados,3,0)
				listadoProductos(productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados) //Se muestra el arreglo ordenado
			3: //Ver resumen de ventas (Debe haber una venta registrada)
			4: //Modificacion del stock (Artículos, unidades, precios)
			5: //Buscar artículo por nombre
			6: //Salir
				Escribir "¡Saludos!"
		Fin Segun
	Hasta Que opcionMenu == 6
FinProceso


Funcion return<-menu() //Retorna eleccion en el menu
	Definir op_menu Como Entero;
	Repetir
		Escribir "Seleccione la opción que desee realizar: "
		Escribir "1. Registrar Venta"
		Escribir "2. Ver listado de productos ordenados por código"
		Escribir "3. Ver resumen de ventas"
		Escribir "4. Modificacion del stock (Artículos, unidades, precios)"
		Escribir "5. Buscar artículo por nombre"
		Escribir "6. Salir"
		Leer op_menu
	Mientras Que (op_menu<1 o op_menu>6)
	return <- op_menu
FinFuncion


SubProceso ordernarArregloTextoASC(array,n,m,columnaAOrdenar) //Ordenamiento de array de texto segun columna X
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

SubProceso ordernarArregloRealesASC(array,n,m,columnaAOrdenar) //Ordenamiento de array de reales segun columna X
	Definir aux Como real; //cambiar el tipo de dato según el tipo de datos del array
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


Funcion return<- buscarPrecioProducto(listaDeProductos,n,elementoABuscar) //Busqueda de producto para precio
	Definir i Como Entero;
	i<-0;
	elementoEncontrado <- Falso;
	Mientras i <= n-1 y no elementoEncontrado
		si listaDeProductos[i,0] == elementoABuscar Entonces //DEFINIR PARAMETROS DE BUSQUEDA
			elementoEncontrado <- Verdadero; //fuerzo la salida del bucle
			precioProducto <- listaDeProductos[i,1] //DEFINIR PARAMETROS DE BUSQUEDA
		FinSi
		i <- i +1; 
	FinMientras
	return	<- precioProducto
FinFuncion


SubProceso listadoProductos(descripcion, preciosCantidades, n) //Se muestra la lista de productos
	Escribir "Listado de productos: "
	Escribir "COD  -  NOMBRE  -  PRECIO  -  STOCK ";
	Para i<-0 Hasta n-1 Hacer
		Escribir descripcion[i,0], "    ", descripcion[i,1], "    ",preciosCantidades[i,1],"    ",preciosCantidades[i,2]
	Fin Para
	Escribir "-----------------------------------";
FinSubProceso


SubProceso registrarVenta(ventasDiarias, indiceVenta Por Referencia) //FALTA AGREGAR PARAMETROS E INCLUIRLO EN MENU
	Definir codProducto, cantidad, medioPago Como Entero;
	Definir dniCliente Como Caracter;
	definir verListado Como Logico
	verListado <- Falso
	definir iva Como Real
	iva <- 0.21
	Repetir
		Escribir "Ingrese el dni del cliente";
		Leer dniCliente;
	Mientras Que Longitud(dniCliente)<6 o Longitud(dniCliente)>8
	
	Escribir "¿Desea ver el listado de productos? Escriba V/F"
	Leer verListado
	si verListado == Verdadero Entonces
		listadoProductos(productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados)
	FinSi
	
	Repetir
		Escribir "Ingrese el codigo del producto";
		Leer codProducto;
	Mientras Que codProducto<1 o codProducto>cantidadProductosRegistrados
	
	Escribir "Ingrese la cantidad pedida"; //HABRIA QUE PONER ALGO QUE BUSQUE SI TIENE STOCK DISPONIBLE, Y TAMBIEN ALGO QUE VAYA RESTANDO EL STOCK A MEDIDA QUE VENDEMOS.
	Leer cantidad;
	
	Repetir
		Escribir "Ingrese el medio de pago 0-Efectivo, 1-Debito, 2-Credito"
		Leer medioPago;
	Mientras Que medioPago<0 o medioPago>2
	
	si medioPago == 0 Entonces
		descuento <- 0.05
	sino si medioPago == 1 entonces
			descuento <- 0.03
		sino descuento = 0
		FinSi
	FinSi
	
	precioProducto <- buscarPrecioProducto(productosPrecio,cantidadProductosRegistrados,codProducto); //Recupero el precio del producto con el codigo que ingreso el usuario
	precioFinal <- ((precioProducto-(precioProducto*descuento))*cantidad)+(((precioProducto-(precioProducto*descuento))*cantidad)*iva) //REVISAR SI ESTA OK LA ECUACION
	//                Precio producto -  Descuento       *    Cantidad  (+   IVA de ese total)
	ventasDiarias[indiceVenta,0]<-dniCliente
	ventasDiarias[indiceVenta,1]<-ConvertirATexto(medioPago)
	ventasDiarias[indiceVenta,2]<-ConvertirATexto(codProducto)
	ventasDiarias[indiceVenta,3]<-ConvertirATexto(cantidad)
	ventasDiarias[indiceVenta,4]<-ConvertirATexto(precioFinal) //CALCULO EL MONTO FINAL
	
	indiceVenta<-indiceVenta+1;
	Limpiar Pantalla;
	Escribir "Su venta ha sido registrada"
	Escribir "-----------------------------------"
FinSubProceso
