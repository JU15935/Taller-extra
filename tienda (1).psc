ALGORITMO Tienda
    // Este algoritmo simula un sistema de inventario para una tienda.
    // Permite visualizar los productos disponibles, agregar nuevos productos y registrar ventas.
    
    // Declaraci�n de constante y variables principales
    DEFINIR MAX_PRODUCTOS COMO ENTERO; // L�mite m�ximo de productos en el inventario
    DEFINIR opcion        COMO CARACTER; // Variable para almacenar la opci�n del usuario
    DEFINIR contador      COMO ENTERO; // Contador para el n�mero de productos registrados
    
    // Arreglos - datos de productos
    DEFINIR nombres COMO CADENA; // Almacena los nombres de los productos
    DEFINIR stocks COMO ENTERO; // Almacena la cantidad disponible de cada producto
    DEFINIR minStocks COMO ENTERO; // Almacena la cantidad m�nima recomendada de cada producto
    
    // Inicializaci�n de valores
    MAX_PRODUCTOS = 20; // Se establece un l�mite de 20 productos
    contador = 0; // Inicialmente no hay productos en el inventario
    
    // Declaraci�n de arrays para productos con el tama�o m�ximo definido
    DIMENSION nombres[MAX_PRODUCTOS];
    DIMENSION stocks[MAX_PRODUCTOS];
    DIMENSION minStocks[MAX_PRODUCTOS];
    
    // Bucle principal del programa que se repite hasta que el usuario decida salir
    REPETIR
        mostrarMenu(); // Muestra el men� de opciones
        LEER opcion; // Lee la opci�n ingresada por el usuario
        
        SI !esSalir(opcion) ENTONCES
            LIMPIAR PANTALLA;
        FINSI
        
		// Se ejecuta la opci�n seleccionada por el usuario
        SEGUN opcion HACER
            CASO "1":
                visualizarInventario(nombres, stocks, minStocks, contador);
            CASO "2":
                agregarProductos(nombres, stocks, minStocks, contador, MAX_PRODUCTOS);
            CASO "3":
                venderProductos(nombres, stocks, minStocks, contador);
            DE OTRO MODO:
                SI !esSalir(opcion) ENTONCES
                    ESCRIBIR "	ERROR: Opci�n inv�lida.";
                FINSI
        FINSEGUN
        
        SI !esSalir(opcion) ENTONCES
            pausarYLimpiar(); // Espera a que el usuario presione una tecla antes de limpiar la pantalla
        FINSI
    MIENTRAS QUE !esSalir(opcion);
FINALGORITMO

// Funci�n para verificar si el usuario desea salir del programa
FUNCION estado = esSalir(opcion)
    DEFINIR estado COMO LOGICO;
    estado = (opcion = "q") | (opcion = "Q"); // Si la opci�n ingresada es 'q' o 'Q', se sale del programa
FINFUNCION

// Subproceso para mostrar el men� principal
SUBPROCESO mostrarMenu
	LIMPIAR PANTALLA;
    ESCRIBIR "Bienvenido a la Tienda MISCELLANEOUS PEPITO";
    ESCRIBIR "";
    ESCRIBIR "Panel de Control:";
    ESCRIBIR "  1. Visualizar Inventario";
    ESCRIBIR "  2. Agregar Productos";
    ESCRIBIR "  3. Vender Productos";
    ESCRIBIR "";
    ESCRIBIR "Digite `q` para salir.";
    ESCRIBIR "";
FINSUBPROCESO

// Subproceso para pausar la ejecuci�n y limpiar la pantalla
SUBPROCESO pausarYLimpiar
    ESCRIBIR "";
    ESCRIBIR "Presione cualquier tecla para continuar...";
    ESPERAR TECLA;
    LIMPIAR PANTALLA;
FINSUBPROCESO

// Subproceso para visualizar el inventario
SUBPROCESO visualizarInventario(nombres, stocks, minStocks, contador)
    ESCRIBIR "Productos en inventario: " + CONVERTIRATEXTO(contador);
    SI contador > 0 ENTONCES
        mostrarTablaInventario(nombres, stocks, minStocks, contador);
    SINO
        ESCRIBIR "	ADVERTENCIA: No hay productos en el inventario.";
    FINSI
FINSUBPROCESO

// Funci�n para determinar el estado del stock
FUNCION estado = estadoStock(stock, minimo)
	DEFINIR estado COMO CADENA;
    SI stock <= 0 ENTONCES
        estado = "VACIO";
    SINO
        SI stock <= minimo ENTONCES
            estado = "BAJO";
        SINO
            estado = "NORMAL";
        FINSI
    FINSI
FINFUNCION

// Subproceso para mostrar la tabla de inventario
SUBPROCESO mostrarTablaInventario(nombres, stocks, minStocks, contador)
    DEFINIR i COMO ENTERO;
	DEFINIR estado COMO CADENA;
	
	ESCRIBIR "		+---------------+---------------+---------------+---------------+---------------+";
	ESCRIBIR "		|C�digo		|Nombre		|Stock		|M�nimo		|Estado		|";
	ESCRIBIR "		+===============+===============+===============+===============+===============+";
	
    PARA i = 0 HASTA (contador - 1) HACER
		estado = estadoStock(stocks[i], minStocks[i]);
		
		ESCRIBIR "		|" + CONVERTIRATEXTO(i) + "		|" + nombres[i] + "		|" + CONVERTIRATEXTO(stocks[i]) + "		|" + CONVERTIRATEXTO(minStocks[i]) + "		|" + estado + "		|";
		ESCRIBIR "		+---------------+---------------+---------------+---------------+---------------+";
    FINPARA
FINSUBPROCESO

// Subproceso para leer los datos de un producto
SUBPROCESO leerDatosProducto(nombres, stocks, minStocks, indice)
    ESCRIBIR SIN SALTAR "Ingrese el nombre del producto: ";
    LEER nombres[indice];
    ESCRIBIR SIN SALTAR "Ingrese la cantidad del producto: ";
    LEER stocks[indice];
    ESCRIBIR SIN SALTAR "Ingrese el m�nimo de stock del producto: ";
    LEER minStocks[indice];
    LIMPIAR PANTALLA;
FINSUBPROCESO

// Subproceso para agregar productos al inventario
SUBPROCESO agregarProductos(nombres, stocks, minStocks, contador POR REFERENCIA, MAX_PRODUCTOS)
    DEFINIR disponibles, cant, i COMO ENTERO;
    disponibles = MAX_PRODUCTOS - contador;
    
    SI disponibles <= 0 ENTONCES
        ESCRIBIR "	ERROR: El inventario est� lleno.";
    SINO
        ESCRIBIR SIN SALTAR "�Cu�ntos productos desea agregar? (M�ximo " + CONVERTIRATEXTO(disponibles) + "): ";
        LEER cant;
        SI (cant > disponibles) | (cant <= 0) ENTONCES
            ESCRIBIR "	ERROR: Cantidad inv�lida. El m�ximo permitido es " + CONVERTIRATEXTO(disponibles);
        SINO
            LIMPIAR PANTALLA;
            PARA i = 0 HASTA (cant - 1) HACER
                ESCRIBIR "Producto #" + CONVERTIRATEXTO(contador + 1);
                ESCRIBIR "";
                leerDatosProducto(nombres, stocks, minStocks, contador);
                contador = contador + 1;
            FINPARA
            ESCRIBIR "Se han agregado " + CONVERTIRATEXTO(cant) + " productos exitosamente.";
        FINSI
    FINSI
FINSUBPROCESO

// Funci�n para validar el c�digo del producto
FUNCION valido = validarCodigo(codigo, contador)
	DEFINIR valido COMO LOGICO;
    valido = (codigo >= 0) & (codigo < contador);
FINFUNCION

// Funci�n para validar la cantidad a vender
FUNCION valido = validarCantidadVenta(cantidad, stockDisponible)
	DEFINIR valido COMO LOGICO;
    valido = (cantidad > 0) & (cantidad <= stockDisponible);
FINFUNCION

// Subproceso que refresca el inventario (encabezado) antes de operaciones
SUBPROCESO encabezadoInventario(nombres, stocks, minStocks, contador)
    LIMPIAR PANTALLA;
    visualizarInventario(nombres, stocks, minStocks, contador);
    ESCRIBIR "";
FINSUBPROCESO

// Subproceso para procesar la venta de productos
SUBPROCESO venderProductos(nombres, stocks, minStocks, contador)
    SI contador = 0 ENTONCES
        ESCRIBIR "	ADVERTENCIA: No hay productos para vender.";
    SINO
        DEFINIR cantTipos, codigo, cantVenta, ventas COMO ENTERO;
        encabezadoInventario(nombres, stocks, minStocks, contador);
        ESCRIBIR SIN SALTAR "�Cu�ntos productos desea vender? (M�ximo " + CONVERTIRATEXTO(contador) + "): ";
        LEER cantTipos;
        ventas = 0;
        
        SI (cantTipos <= 0) | (cantTipos > contador) ENTONCES
            ESCRIBIR "	ERROR: Cantidad de productos inv�lida.";
        SINO 
            MIENTRAS ventas < cantTipos HACER
                encabezadoInventario(nombres, stocks, minStocks, contador);
                ESCRIBIR SIN SALTAR "C�digo del producto para venta (" + CONVERTIRATEXTO(ventas + 1) + " de " + CONVERTIRATEXTO(cantTipos) + "): ";
                LEER codigo;
                
                SI !validarCodigo(codigo, contador) ENTONCES
                    ESCRIBIR "	ERROR: C�digo de producto inv�lido.";
                    pausarYLimpiar();
                SINO
                    ESCRIBIR SIN SALTAR "Ingrese la cantidad a vender de " + nombres[codigo] + ": ";
                    LEER cantVenta;
                    
                    SI !validarCantidadVenta(cantVenta, stocks[codigo]) ENTONCES
                        SI cantVenta <= 0 ENTONCES
                            ESCRIBIR "	ERROR: La cantidad debe ser mayor a 0.";
                        SINO
                            ESCRIBIR "	ERROR: Stock insuficiente para " + nombres[codigo] + ". Stock actual: " + CONVERTIRATEXTO(stocks[codigo]);
                        FINSI
                        pausarYLimpiar();
                    SINO
                        stocks[codigo] = stocks[codigo] - cantVenta;
                        ESCRIBIR "";
                        ESCRIBIR "Venta realizada: " + CONVERTIRATEXTO(cantVenta) + " unidades de " + nombres[codigo];
                        SI stocks[codigo] <= minStocks[codigo] ENTONCES
                            ESCRIBIR "	ADVERTENCIA: El producto " + nombres[codigo] + " ha alcanzado su stock m�nimo.";
                        FINSI
                        ventas = ventas + 1;
                        SI ventas < cantTipos ENTONCES
                            pausarYLimpiar();
                        FINSI
                    FINSI
                FINSI
            FINMIENTRAS
        FINSI
    FINSI
FINSUBPROCESO
