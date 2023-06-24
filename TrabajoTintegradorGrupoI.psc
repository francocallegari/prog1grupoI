//El programa de Gestión de Stock y Ventas del comercio Ferreteria
//le permitirá realizar al usuario las cargas, control y búsqueda de mercadería/ventas. 

//- Alta, Baja y Modificación del stock (Articulos - Unidades - Precios).
//- Búsqueda por Nombre del Artículo.

//El Versionado del programa se encuentra en el siguiente repositorio:
//https://github.com/francocallegari/prog1grupoI.git

Proceso gestionFerreteria
	Definir opcionMenu, opcionMenuStock Como Entero;
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
	productosPreciosCantidades[1,1] <- 25.40
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
	cantidadProductosRegistrados <- 4 //AUMENTARÁ SI REGISTRAMOS NUEVOS ARTÍCULOS
	definir nombreABuscar como cadena
	
	Repetir //Bucle para el menu
		opcionMenu <- menu();
		Segun opcionMenu Hacer
			1: //Registrar Venta
				registrarVenta(ventasDiarias, indiceVenta, productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados)
			2: //Ver listado de productos ordenados por código
				ordernarArregloTextoASC(productosDescripcion,cantidadProductosRegistrados,2,0) //Se utilizan dos ordenamientos, uno para texto otro para reales.
				ordernarArregloRealesASC(productosPreciosCantidades,cantidadProductosRegistrados,3,0)
				listadoProductos(productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados) //Se muestra el arreglo ordenado
			3: //Ver resumen de ventas (Debe haber una venta registrada)
				si indiceVenta > 0 Entonces
					verResumenDiario(ventasDiarias,indiceVenta,5)
				SiNo
					Escribir "Debe registrar al menos una venta para ver el resumen";
				FinSi				
			4: //Modificacion del stock (Artículos, unidades, precios)
				modificarStock(productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados)
			5: //Buscar artículo por nombre
				Escribir "Ingrese el nombre del artículo a buscar:"
				Leer nombreABuscar
				nombreArticulo <- buscarElemento(productosDescripcion,cantidadProductosRegistrados, 1,nombreABuscar)
				Limpiar Pantalla
				mostrarProductoNombre(productosDescripcion, productosPreciosCantidades, nombreArticulo)
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


Funcion return<-menuStock() //Retorna eleccion en el menu de stock
	Definir op_menu Como Entero;
	Repetir
		Escribir "Seleccione la opción que desee realizar: "
		Escribir "1. Registrar nuevo producto"
		Escribir "2. Modificar unidades de un producto"
		Escribir "3. Modificar precio de un producto"
		Escribir "4. Modificar descripción de un producto"
		Escribir "5. Volver al menú principal"
		Leer op_menu
	Mientras Que (op_menu<1 o op_menu>5)
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
		si listaDeProductos[i,0] == elementoABuscar Entonces 
			elementoEncontrado <- Verdadero; //fuerzo la salida del bucle
			precioProducto <- listaDeProductos[i,1]
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


SubProceso registrarVenta(ventasDiarias, indiceVenta Por Referencia, productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados)
	Definir codProducto, cantidad, medioPago Como Entero;
	Definir dniCliente Como Caracter;
	definir verListado Como Logico
	verListado <- Falso
	definir iva Como Real
	iva <- 0.21
	Repetir
		Escribir "Ingrese el DNI del cliente";
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
	
	precioProducto <- buscarPrecioProducto(productosPreciosCantidades,cantidadProductosRegistrados,codProducto); //Recupero el precio del producto con el codigo que ingreso el usuario
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


SubProceso modificarStock(productosDescripcion, productosPreciosCantidades Por Referencia, cantidadProductosRegistrados Por Referencia )
	Limpiar Pantalla
	Repetir //Bucle para el menu stock
		opcionMenuStock <- menuStock();
		Segun opcionMenuStock Hacer
			1: //Registrar producto nuevo
				registrarProducto(productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados)
			2: //Modifica unidades de un producto
				modificarUnidadProducto(productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados)
			3: //Modificar precio de un producto
				Escribir "3. Modificar precio de un producto"
			4: //Modificar descripción de un producto
				Escribir "4. Modificar descripción de un producto"
			5: //Retorno al menu principal
				Escribir "Regresando al menu principal..."
		Fin Segun
	Hasta Que opcionMenuStock == 5
FinSubProceso


SubProceso registrarProducto(productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados Por Referencia)
	Limpiar Pantalla
	Definir codProducto, stockProducto Como Entero
	Definir nomProducto Como Caracter
	Definir precioProducto Como Real

	Escribir "Ingrese el nombre del artículo"
	Leer nomProducto

	Repetir
		Escribir "Ingrese el precio del producto";
		Leer precioProducto;
	Mientras Que precioProducto<=0
	
	Repetir
		Escribir "Ingrese el stock del producto";
		Leer stockProducto;
	Mientras Que stockProducto<=0
	
	productosDescripcion[cantidadProductosRegistrados,0] <- ConvertirATexto(cantidadProductosRegistrados+1)
	productosPreciosCantidades[cantidadProductosRegistrados,0] <- cantidadProductosRegistrados+1
	productosDescripcion[cantidadProductosRegistrados,1] <- nomProducto
	productosPreciosCantidades[cantidadProductosRegistrados,1] <- precioProducto
	productosPreciosCantidades[cantidadProductosRegistrados,2] <- stockProducto
	
	cantidadProductosRegistrados<-cantidadProductosRegistrados+1;
	Limpiar Pantalla;
	Escribir "Su producto ha sido registrado"
	Escribir "-----------------------------------"
FinSubProceso


SubProceso modificarUnidadProducto(productosDescripcion, productosPreciosCantidades Por Referencia, cantidadProductosRegistrados Por Referencia)
	Limpiar Pantalla	
	Definir codProducto, stockProducto, indiceProducto Como Entero
	definir verListado Como Logico
	verListado <- Falso
	indiceProducto <- -1;
	
	Escribir "¿Desea ver el listado de productos? Escriba V/F"
	Leer verListado
	si verListado == Verdadero Entonces
		listadoProductos(productosDescripcion, productosPreciosCantidades, cantidadProductosRegistrados)
	FinSi
	
	Repetir
		Escribir "Ingrese el codigo del producto que desea modificar";
		Leer codProducto;
	Mientras Que codProducto<1 o codProducto>cantidadProductosRegistrados
	
	Repetir
		Escribir "Ingrese el nuevo stock del producto";
		Leer stockProducto;
	Mientras Que stockProducto<=0
	
	indiceProducto <- buscarElemento(productosPreciosCantidades,cantidadProductosRegistrados,0,codProducto);
	
	Limpiar Pantalla;
	Si indiceProducto >= 0 Entonces //modifico el stock del producto seleccionado
		productosPreciosCantidades[indiceProducto,2] <- stockProducto
		Escribir "Su producto ha sido modificado exitosamente"
		Escribir "-----------------------------------"	
	SiNo
		Escribir "Producto no encontrado";
	FinSi
FinSubProceso


SubProceso verResumenDiario(ventas,n,m) //Muestra el resumen diario de ventas
	Limpiar Pantalla
	Escribir "Resumen diario: "
	Escribir "  DNI  -   MED PAGO - CODPROD -  CANT - $ TOTAL "
	mostrarArray(ventas,n,m);
	Escribir "-----------------------------------";
FinSubProceso


SubProceso mostrarProductoNombre(descripcion, preciosCantidades, nombreProd) //Muestra array bidimensional de unico producto
	i <- nombreProd
	
	Si nombreProd >= 0 Entonces //muestro el detalle del producto buscado
		Escribir "COD -  NOMBRE  -  PRECIO  -  STOCK "
		Escribir descripcion[i,0], "    ", descripcion[i,1], "    ",preciosCantidades[i,1],"    ",preciosCantidades[i,2]
		Escribir "-----------------------------------"
	SiNo
		Escribir "Producto no encontrado";
	FinSi
FinSubProceso


// RETORNO EL INDICE DEL ELEMENTO ENCONTRADO, EN CASO CONTRARIO (elemento no encontrado) RETORNO -1
Funcion return<- buscarElemento(array,n,columnaAbuscar,elementoABuscar)
	Definir i Como Entero;
	i<-0;
	elementoEncontrado <- Falso;
	Mientras i <= n-1 y no elementoEncontrado
		si array[i,columnaAbuscar] == elementoABuscar Entonces
			elementoEncontrado <- Verdadero;
		SiNo
			i <- i +1; 
		FinSi
	FinMientras
	Si elementoEncontrado Entonces
		return <- i;
	SiNo
		return <- -1;
	FinSi
FinFuncion
