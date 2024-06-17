/*TRABLAS*/
/*
SELECT * FROM Area
SELECT * FROM Asignaturas
SELECT * FROM Encargado
SELECT * FROM Estudiantes
SELECT * FROM Profesiones
SELECT * FROM Staff
*/

/*1. Indicar cuántos cursos y carreras tiene el área de Data. 
Renombrar la nueva columna como cant_asignaturas. 
Keywords: Tipo, Área, Asignaturas.*/

SELECT * FROM Area
SELECT * FROM Asignaturas


SELECT COUNT(A.Tipo) AS Cantidad
FROM Asignaturas AS A
INNER JOIN Area AS AR ON AR.AreaID = A.Area
WHERE AR.Nombre = 'Data';

---

SELECT A.Tipo, COUNT(A.Tipo) AS Cantidad 
FROM Asignaturas AS A
INNER JOIN Area AS AR ON AR.AreaID = A.Area
WHERE AR.Nombre = 'Data'
GROUP BY A.Tipo;

---

SELECT A.Tipo, COUNT(A.Tipo) AS Cantidad
FROM Asignaturas AS A
INNER JOIN Area AS AR ON AR.AreaID = A.Area
WHERE AR.Nombre = 'Data'
GROUP BY A.Tipo
UNION ALL
SELECT 'Total', COUNT(A.Tipo) AS Cantidad
FROM Asignaturas AS A
INNER JOIN Area AS AR ON AR.AreaID = A.Area
WHERE AR.Nombre = 'Data';


/*2. Se requiere saber cual es el nombre, el documento de identidad 
y el teléfono de los estudiantes que son profesionales en agronomía 
y que nacieron entre el año 1970 y el año 2000. 
Keywords: Estudiantes, Profesión, Fecha de Nacimiento.*/

SELECT * FROM Estudiantes
SELECT * FROM Profesiones

SELECT E.Nombre, E.Documento, E.Telefono
FROM Estudiantes AS E
INNER JOIN Profesiones AS P ON P.ProfesionesID = E.Profesion
WHERE E.[Fecha de Nacimiento] BETWEEN '1970/01/01' AND '2000/12/31' 
AND P.Profesiones = 'Agronomo Agronoma';

---

SELECT Nombre, Documento, Telefono
FROM Estudiantes
WHERE Profesion= '6'
AND [Fecha de Nacimiento] BETWEEN '1970-01-01' AND '2000-12-31';


/*3. Se requiere un listado de los docentes que ingresaron en el año 2021 
y concatenar los campos nombre y apellido. El resultado debe utilizar un separador: 
guión (-). Ejemplo: Elba-Jimenez. Renombrar la nueva columna como Nombres_Apellidos. 
Los resultados de la nueva columna deben estar en mayúsculas. 
Keywords: Staff, Fecha Ingreso, Nombre, Apellido.*/

SELECT * FROM Staff

SELECT UPPER(CONCAT(Nombre, '_', Apellido)) AS Nombre_Apellidos
FROM Staff
WHERE YEAR([Fecha Ingreso]) = 2021;


/*4. Indicar la cantidad de encargados de docentes y de tutores. 
Renombrar la columna como CantEncargados. Quitar la palabra ”Encargado ”en cada uno de los registros. 
Renombrar la columna como NuevoTipo. 
Keywords: Encargado, tipo, Encargado_ID.*/

SELECT * FROM Encargado

SELECT REPLACE(Tipo, 'Encargado', '')AS Tipo, COUNT(Nombre) AS CantEncargados FROM Encargado
GROUP BY Tipo


/*5. Indicar cuál es el precio promedio de las carreras y los cursos por jornada. 
Renombrar la nueva columna como Promedio. Ordenar los promedios de Mayor a menor 
Keywords: Tipo, Jornada, Asignaturas.*/ 

SELECT * FROM Asignaturas

SELECT Tipo, Jornada, ROUND(AVG(Costo),2) AS Costo_Promedio FROM Asignaturas
GROUP BY Tipo, Jornada
ORDER BY Costo_Promedio DESC


/*6. Se requiere calcular la edad de los estudiantes en una nueva columna. 
Renombrar a la nueva columna Edad. Filtrar solo los que son mayores 
de 18 años. Ordenar de Menor a Mayor 
Keywords: Fecha de Nacimiento, Estudiantes.*/

SELECT *, DATEDIFF(year, [Fecha de Nacimiento], GETDATE()) AS Edad 
FROM Estudiantes
WHERE DATEDIFF(year, [Fecha de Nacimiento], GETDATE()) > 18
ORDER BY Edad DESC;


/*7. Se requiere saber el Nombre,el correo, la camada y la fecha de ingreso de personas
del staff que contienen correo .edu y su DocenteID se mayor o igual que 100 
Keywords: Staff, Nombre, Correo, Camada, Fecha Ingreso, DocentesID.*/
 
SELECT * FROM Staff

SELECT DocentesID, Nombre, Correo, Camada, [Fecha Ingreso] 
FROM Staff
WHERE Correo LIKE '%.edu' AND DocentesID >= 100;


/*8. Se requiere conocer el documento, el domicilio, el código postal y el nombre de los 
primeros estudiantes que se registraron en la plataforma. 
Keywords: Documento, Estudiantes, Fecha Ingreso.*/

SELECT * FROM Estudiantes

SELECT TOP 5 Nombre, Documento, Domicilio, [Codigo Postal]
FROM Estudiantes
ORDER BY [Fecha Ingreso];

---

SELECT Nombre, Documento, [Codigo Postal], Domicilio
FROM Estudiantes
WHERE [Fecha Ingreso] = (SELECT MIN ([Fecha Ingreso]) FROM Estudiantes)


/*9. Indicar el nombre, apellido y documento de identidad de los docentes y 
tutores que tienen asignaturas “UX” . 
Keywords: Staff, Asignaturas, Nombre, Apellido.*/

SELECT * FROM Staff
SELECT * FROM Asignaturas

SELECT S.Nombre, S.Apellido, S.Documento, A.Nombre 
FROM Staff AS S
INNER JOIN Asignaturas AS A ON
A.AsignaturasID = S.Asignatura
WHERE A.Nombre  IN ('Diseno UX/UI');

---

SELECT Nombre, Apellido, Documento  
FROM Staff
WHERE Asignatura IN (SELECT AsignaturasID FROM Asignaturas WHERE Nombre  LIKE '%UX%')



/*10. Se desea calcular el 25% de aumento para las asignaturas del área de marketing 
de la jornada mañana se deben traer todos los campos, mas el de los cálculos 
correspondientes el porcentaje y el Nuevo costo debe estar en decimal con 3 digitos. 
Renombrar el calculo del porcentaje con el nombre porcentaje y la suma del costo mas el porcentaje por NuevoCosto.
Keywords: Asignaturas, Costo, Área, Jornada, Nombre.*/

SELECT * FROM Area
SELECT * FROM Asignaturas

SELECT A.Nombre, ASIG.Jornada, ASIG.Costo,
    CASE
        WHEN A.Nombre = 'Marketing Digital' THEN ASIG.Costo * 1.25
        ELSE ASIG.Costo
    END AS Nuevo_Costo
FROM Asignaturas AS ASIG
INNER JOIN Area AS A ON A.AreaID = ASIG.Area;



