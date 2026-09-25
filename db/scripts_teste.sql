 -- Ativa as chaves estrangeiras do SQlite--
PRAGMA foreign_keys = 1 ;

--Verifica se as chaves estrangeiras estão ativas --
PRAGMA foreign_keys;

CREATE TABLE cargo (
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_cargo TEXT NOT NULL COLLATE NOCASE UNIQUE,
status INTEGER NOT NULL DEFAULT 1
)STRICT;

CREATE TABLE funcionario (
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_funcionario TEXT NOT NULL COLLATE NOCASE,
id_cargo INTEGER NOT NULL,
status INTEGER NOT NULL DEFAULT 1,
data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
FOREIGN KEY (id_cargo) REFERENCES cargo(id) ON
UPDATE
	CASCADE ON
	DELETE
		CASCADE,
		UNIQUE(id, id_cargo)
) STRICT;


INSERT INTO CARGO (nome_cargo) VALUES ('Gerente'),('Atendente'),('Técnico');

INSERT
	INTO
	funcionario (nome_funcionario,
	id_cargo)
VALUES
('Marcos Ferreira',
1),
-- Gerente
('Juliana Alves',
2),
-- Atendente
('Rafael Costa',
2),
-- Atendente
('Bruno Lima',
3),
-- Técnico
('Carla Mendes',
3),
-- Técnico
('Diego Rocha',
3);          -- Técnico

CREATE TABLE cliente(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_cliente TEXT NOT NULL COLLATE NOCASE,
email TEXT NOT NULL  UNIQUE,
status INTEGER NOT NULL DEFAULT 1,
id_funcionario INTEGER NOT NULL,
--Check: avalia se o usuário inserido tem o id de cargo definido na tabela de funcionário.--
id_funcionario_cargo INTEGER NOT NULL CHECK(id_funcionario_cargo = 1 OR id_funcionario_cargo = 2 ),
data_cadastro TEXT NOT NULL  DEFAULT (DATETIME('now','localtime')),
FOREIGN KEY(id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;


INSERT INTO cliente(nome_cliente, email, id_funcionario, id_funcionario_cargo)
VALUES ('João','João@email.com', 2 , (SELECT id_cargo FROM funcionario WHERE id=2));





