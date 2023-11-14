CREATE DATABASE Biblioteca;

use Biblioteca;

CREATE TABLE Autores(
	AutorID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Nacionalidade VARCHAR(30)
);

DROP TABLE IF EXISTS Livros;

CREATE TABLE Livros (
   LivroID INT PRIMARY KEY,
   Titulo VARCHAR(100) NOT NULL,
   AnoPublicacao INT,
   AutorID INT,
   FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

INSERT INTO Livros (LivroID, Titulo, AnoPublicacao, AutorID) VALUES
    (101, 'Dom Casmurro', 1899, 1),
    (102, 'Orgulho e Preconceito', 1813, 2),
    (103, 'Hamlet', 1603, 3),
    (104, 'Othello', 1603, 3),
    (105, 'Romeu e Julieta', 1597, 3);

INSERT INTO Autores (AutorID, Nome, Nacionalidade) VALUES
    (1, 'Machado de Assis', 'Brasileiro'),
    (2, 'Jane Austen', 'Inglesa'),
    (3, 'William Shakespeare');

select * from livros;

select * from autores;

select livros.titulo, livros.A

