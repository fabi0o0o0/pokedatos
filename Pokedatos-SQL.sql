CREATE TABLE Entrenadores(
    id_trainer INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    nombre_trainer VARCHAR(50),
    rate_experiencia_trainer INT CHECK (rate_experiencia_trainer >= 0 AND rate_experiencia_trainer <= 5),
    unique_detail_trainer VARCHAR(50)
);

INSERT INTO Entrenadores(nombre_trainer, rate_experiencia_trainer, unique_detail_trainer) VALUES
( 'Hassan', 5, 'No habla'),
( 'Pedro', 3, 'Muy entusiasta'),
( 'Juan', 4, 'Violento'),
( 'Matias', 1, 'Sabe mucho');

CREATE TABLE Pokemones(
    id_pokemon INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    nombre_pokemon VARCHAR(50),
    tipo_pokemon VARCHAR(50),
    habilidad_pokemon VARCHAR(50),
    id_trainer INT FOREIGN KEY REFERENCES Entrenadores(id_trainer)
);

INSERT INTO Pokemones(nombre_pokemon, tipo_pokemon, habilidad_pokemon, id_trainer) VALUES
('Pepe', 'Bicho', 'Cacofonía', 1),
('Toto', 'Dragón', 'Flexibilidad', 4),
('Tutu', 'Eléctrico', 'Humedad', 2),
('pikachu', 'Hada', 'Robustez', 3),
('Tito', 'Lucha', 'Armadura batalla', 1),
('Coca', 'Fuego', 'Impulso', 4),
('Coke', 'Volador', 'Llovizna', 2),
('Susi', 'Fantasma', 'Hedor', 3);

/*Bicho, Dragón, Eléctrico, Hada, Lucha, Fuego, Volador, Fantasma*/
/*Cacofonía, Flexibilidad, Humedad, Robustez, Armadura batalla, Impulso, Llovizna, Hedor*/

CREATE TABLE Estadisticas_pokemones(
    id_estadistica INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    ataque_rate_pokemon INT CHECK (ataque_rate_pokemon >= 0 AND ataque_rate_pokemon <= 100),
    defensa_rate_pokemon INT CHECK (defensa_rate_pokemon >= 0 AND defensa_rate_pokemon <= 100),
    velocidad_rate_pokemon INT CHECK (velocidad_rate_pokemon >= 0 AND velocidad_rate_pokemon <= 100),
    id_pokemon INT FOREIGN KEY REFERENCES Pokemones(id_pokemon)
);

INSERT INTO Estadisticas_pokemones (ataque_rate_pokemon, defensa_rate_pokemon, velocidad_rate_pokemon, id_pokemon) VALUES
(36, 66, 85, 2),
(47, 52, 96, 3),
(90, 41, 27, 6),
(52, 30, 63, 5),
(40, 25, 70, 1),
(55, 32, 65, 7),
(70, 15, 80, 4),
(85, 90, 36, 8);

CREATE TABLE Batallas(
    id_batalla INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
    id_trainer1 INT FOREIGN KEY REFERENCES Entrenadores(id_trainer),
    id_trainer2 INT FOREIGN KEY REFERENCES Entrenadores(id_trainer),
    id_pokemon1 INT FOREIGN KEY REFERENCES Pokemones(id_pokemon),
    id_pokemon2 INT FOREIGN KEY REFERENCES Pokemones(id_pokemon),
    fecha_batalla DATE,
    resultado VARCHAR(50)
);

INSERT INTO Batallas(id_trainer1, id_trainer2, id_pokemon1, id_pokemon2, fecha_batalla, resultado) VALUES
(1, 4, 1, 6, '2024-07-20', 'Victoria Equipo 1'),
(2, 3, 5, 8, '2024-07-21', 'Victoria Equipo 1'),
(3, 1, 7, 2, '2024-07-22', 'Empate'),
(4, 2, 8, 5, '2024-07-23', 'Victoria Equipo 2');

SELECT p.nombre_pokemon, p.tipo_pokemon, p.habilidad_pokemon, e.nombre_trainer
FROM Pokemones p
JOIN Entrenadores e ON p.id_trainer = e.id_trainer;

SELECT b.fecha_batalla, 
       e1.nombre_trainer AS entrenador1, 
       e2.nombre_trainer AS entrenador2, 
       p1.nombre_pokemon AS pokemon1, 
       p2.nombre_pokemon AS pokemon2, 
       b.resultado
FROM Batallas b
JOIN Entrenadores e1 ON b.id_trainer1 = e1.id_trainer
JOIN Entrenadores e2 ON b.id_trainer2 = e2.id_trainer
JOIN Pokemones p1 ON b.id_pokemon1 = p1.id_pokemon
JOIN Pokemones p2 ON b.id_pokemon2 = p2.id_pokemon;

DELETE Batallas
FROM Batallas
JOIN Pokemones ON Batallas.id_pokemon1 = Pokemones.id_pokemon OR Batallas.id_pokemon2 = Pokemones.id_pokemon
WHERE Pokemones.id_pokemon = 6;





/*DROP TABLE IF EXISTS Estadisticas_pokemones;
DROP TABLE IF EXISTS Pokemones;
DROP TABLE IF EXISTS Batallas;

SELECT * FROM Entrenadores
SELECT * FROM Pokemones
SELECT * FROM Estadisticas_pokemones
SELECT * FROM Batallas */