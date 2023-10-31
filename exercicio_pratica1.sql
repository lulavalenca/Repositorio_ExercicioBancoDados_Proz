use escola;

CREATE TABLE ALUNO(
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome varchar(50),
    Email varchar(100),
    Endereco varchar(200)
);

select * from aluno;