# app_julietaom
NumeroX es un juego en el que debes adivinar un número aleatorio. 

El juego se basa en que se decide un número aleatorio que se mantiene en secreto para el usuario, este debe de ingresar un número el cual es comparado con el número secreto y se muestra una pista de que tan cerca se está del número secreto en una escala de frío caliente, estos números se guardan en una lista y el proceso se repite hasta que se adivine el número secreto. 

La app crea una variable llamada secret que elige un número aleatorio que se debe de adivinar, la app empieza cuando el usuario escribe un número en Text field cuando se presiona el boton se llama a una función llamada checkNumber, esta función primero lee la entrada convierte texto a numero y si falla se denomina como cero, luego valida que el numero se encuentre entre 1 y 1000, despues se calcula la diferencia entre el intento y el numero secreto, con esto se obtinen la pista, se calcula la proximidad y se actualiza la interfaz para poder realizar un nuevo intento. 
Para obtener la pista se usa la función getHint, que convierte la diferencia en una pista, y la función getColor la cual asigna color a la pista. 

En cada intento se guarda en una lista: (ejemplo)
numero: 500
hint: ardiendo
color: color.red
proximity: 0.9

Para la apariencia de la app se usa scaffold para la estructura como el app bar donde está el título, se utilizan columnas para acomodar el cuerpo, al igual que se utiliza el text field para ingresar el texto y el botón para correr el programa, se usa una vista de lista para mostrar los intentos con su información y una barra de proximidad. 