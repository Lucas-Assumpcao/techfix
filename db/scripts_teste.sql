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

CREATE TABLE categoria(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_categoria TEXT NOT NULL COLLATE NOCASE UNIQUE,
status INTEGER NOT NULL DEFAULT 1,
data_cadastro TEXT NOT NULL  DEFAULT (DATETIME('now','localtime')),
id_funcionario INTEGER NOT NULL,
id_funcionario_cargo INTEGER NOT NULL CHECK(id_funcionario_cargo = 1),
FOREIGN KEY(id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;


INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('celulares', 1,(SELECT id_cargo FROM funcionario f WHERE id= 1));

CREATE TABLE servico(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_servico TEXT NOT NULL COLLATE NOCASE UNIQUE,
id_categoria INTEGER NOT NULL,
preco INTEGER NOT NULL,
hora_trabalhada REAL NOT NULL  ,
id_funcionario INTEGER NOT NULL,
id_funcionario_cargo INTEGER NOT NULL CHECK(id_funcionario_cargo = 1),
data_cadastro TEXT NOT NULL  DEFAULT (DATETIME('now','localtime')),
status INTEGER NOT NULL DEFAULT 1,
FOREIGN KEY(id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo),
FOREIGN KEY(id_categoria) REFERENCES categoria(id)
) STRICT;

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('acessórios', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('áudio', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('baterias', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('carcaças', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('componentes', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('eletrônica avançada', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('informática', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('insumos', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('recuperação de dados', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('redes', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('smart tvs', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('telas', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('tvs', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO categoria(nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('videogames', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT INTO servico (nome_servico, id_categoria, preco, hora_trabalhada, id_funcionario, id_funcionario_cargo) VALUES
('Formatação e Instalação de Sistema Operacional', 1, 12000, 2.0, 1, 1),
('Limpeza Interna e Troca de Pasta Térmica', 1, 15000, 1.5, 1, 1),
('Upgrade de Hardware (RAM/SSD)', 1, 8000, 1.0, 1, 1),
('Remoção de Vírus e Malwares', 1, 10000, 1.5, 1, 1),
('Troca de Tela de Notebook', 1, 18000, 1.5, 1, 1),
('Troca de Display/Frontal de Celular', 2, 15000, 1.0, 1, 1),
('Troca de Bateria de Smartphone', 2, 9000, 0.5, 1, 1),
('Desoxidação após Contato com Líquido', 2, 20000, 3.0, 1, 1),
('Reparo em Conector de Carga (Micro USB / Type-C)', 2, 11000, 1.5, 1, 1),
('Troca de Barra de LED de Smart TV', 13, 35000, 3.0, 1, 1),
('Reparo na Placa Principal de Smart TV', 13, 28000, 2.5, 1, 1),
('Conserto de Fonte de Alimentação Interna (TV)', 13, 22000, 2.0, 1, 1),
('Configuração de Rede e Roteador Wi-Fi', 12, 9000, 1.0, 1, 1),
('Higienização e Troca de Metal Líquido / Pasta Térmica (Console)', 16, 22000, 2.0, 1, 1),
('Reparo de Drift em Analógico de Controle (Joy-Con / DualSense / Xbox)', 16, 8000, 1.0, 1, 1),
('Substituição de HDMI / Conector de Vídeo (Console)', 16, 25000, 2.5, 1, 1),
('Troca de Bateria de Caixa de Som Portátil (Bluetooth)', 4, 12000, 1.5, 1, 1),
('Troca de Almofadas / Reparo de Cabo de Headset Gamer', 4, 7000, 1.0, 1, 1),
('Recuperação de Dados de HD / SSD / Pendrive Danificado', 11, 30000, 4.0, 1, 1),
('Rebaling / Reparo de BGA em Placa Mãe ou Placa de Vídeo', 8, 45000, 5.0, 1, 1),
('Gravação e Reprogramação de BIOS Eprom (Notebook / Desktop)', 8, 16000, 2.0, 1, 1),
('Troca de Vidro Traseiro de Smartphone a Laser / Manual', 2, 18000, 2.5, 1, 1),
('Reparo e Solda de Conector Jack P2/P10 de Mesa de Som ou Amplificador', 4, 9500, 1.0, 1, 1);

CREATE TABLE pecas(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_pecas TEXT NOT NULL COLLATE NOCASE UNIQUE,
id_categoria INTEGER NOT NULL,
preco_compra INTEGER NOT NULL,
preco_venda INTEGER NOT NULL,
estoque TEXT NOT NULL COLLATE NOCASE,
id_funcionario INTEGER NOT NULL,
id_funcionario_cargo INTEGER NOT NULL CHECK(id_funcionario_cargo = 1),
data_cadastro TEXT NOT NULL  DEFAULT (DATETIME('now','localtime')),
status INTEGER NOT NULL DEFAULT 1,
FOREIGN KEY(id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo),
FOREIGN KEY(id_categoria) REFERENCES categoria(id)
) STRICT;

INSERT INTO pecas (nome_pecas, id_categoria, preco_compra, preco_venda, estoque, id_funcionario, id_funcionario_cargo) VALUES
-- Informática / Computadores
('SSD NVMe 512GB M.2', 9, 14000, 26000, 15, 1, 1),
('SSD SATA III 480GB 2.5"', 9, 11000, 21000, 20, 1, 1),
('Memória RAM DDR4 8GB 2666MHz (Notebook)', 9, 9000, 17000, 12, 1, 1),
('Memória RAM DDR4 16GB 3200MHz (Desktop)', 9, 18000, 32000, 8, 1, 1),
('Pasta Térmica de Alta Performance (Bisnaga 4g)', 10, 2500, 6000, 25, 1, 1),
('Fonte ATX 500W 80 Plus Bronze', 9, 19000, 34000, 6, 1, 1),
('Bateria Célula Moeda CR2032 (Cartela c/ 5)', 10, 800, 2500, 30, 1, 1),
('Cooler para Processador Socket Universal', 9, 4500, 9500, 10, 1, 1),
('Cabo SATA III 6Gbps 50cm', 3, 300, 1500, 50, 1, 1),
('Tela LED 15.6" Slim 30 Pinos Full HD', 14, 28000, 48000, 5, 1, 1),

-- Smartphones / Celulares
('Display Frontal Completo iPhone 11', 14, 18000, 35000, 4, 1, 1),
('Display Frontal Completo Samsung Galaxy A54', 14, 16000, 31000, 6, 1, 1),
('Display Frontal Completo Motorola Moto G84', 14, 14000, 28000, 5, 1, 1),
('Bateria Compatível iPhone 11 (3110mAh)', 5, 7500, 16000, 8, 1, 1),
('Bateria Compatível Samsung Galaxy A32', 5, 6000, 13000, 7, 1, 1),
('Bateria Compatível Moto G30', 5, 5500, 12000, 6, 1, 1),
('Conector de Carga Type-C Universal (Unidade)', 7, 250, 2000, 100, 1, 1),
('Conector de Carga Micro USB V8', 7, 150, 1500, 100, 1, 1),
('Flex de Carga e Microfone Moto G9 Play', 7, 1800, 5500, 10, 1, 1),
('Tampa Traseira de Vidro iPhone 12', 6, 4000, 11000, 4, 1, 1),
('Câmera Traseira Principal Redmi Note 11', 7, 6500, 14000, 3, 1, 1),
('Alto-Falante Auricular Universal', 7, 500, 2500, 40, 1, 1),

-- Smart TVs
('Barra de LED TV Samsung 50" (Kit com 3 barras)', 15, 11000, 23000, 4, 1, 1),
('Barra de LED TV LG 43" (Kit com 3 barras)', 15, 9500, 19500, 5, 1, 1),
('Placa Fonte TV Samsung UN50TU8000', 15, 16000, 31000, 2, 1, 1),
('Placa Principal TV LG 43UP7500', 15, 21000, 42000, 2, 1, 1),
('Cabo Flat T-Con para Display TV 55"', 15, 2200, 6500, 8, 1, 1),
('Receptor Infravermelho para Controle Remoto TV', 7, 400, 2000, 15, 1, 1),

-- Insumos e Componentes Genéricos
('Solda em Fio Sn60/Pb40 0.8mm (Carretel 500g)', 10, 8500, 15000, 3, 1, 1),
('Álcool Isopropílico 99.8% 1 Litro', 10, 2200, 4500, 12, 1, 1),
('Fita Kapton Térmica 10mm x 33m', 10, 1200, 3000, 15, 1, 1),
('Fita Dupla Face Fixação de Telas (3mm x 50m)', 10, 1500, 3500, 10, 1, 1),
('Fusível de Louça 5A 250V (Pacote c/ 10)', 7, 500, 1800, 20, 1, 1),
('Capacitor Eletrolítico 1000uF x 25V', 7, 80, 500, 150, 1, 1);

SELECT *FROM pecas WHERE preco_venda >= 10000;

CREATE VIEW VW_preco_venda  AS 
SELECT id, nome_pecas, preco_venda, estoque FROM pecas WHERE preco_venda >= 10000;

SELECT * FROM VW_preco_venda;

-- 9. Tabela marca
CREATE TABLE IF NOT EXISTS marca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_marca TEXT NOT NULL COLLATE NOCASE,
    status INTEGER NOT NULL DEFAULT 1,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime'))
);

-- 10. Tabela modelo
CREATE TABLE IF NOT EXISTS modelo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_marca TEXT NOT NULL COLLATE NOCASE,
    status INTEGER NOT NULL DEFAULT 1,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime'))
);

-- 11. Tabela tipo
CREATE TABLE IF NOT EXISTS tipo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_marca TEXT NOT NULL COLLATE NOCASE,
    status INTEGER NOT NULL DEFAULT 1,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL,
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime'))
);

-- 12. Tabela situacao
CREATE TABLE IF NOT EXISTS situacao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_situacao TEXT NOT NULL COLLATE NOCASE UNIQUE,
    status INTEGER NOT NULL DEFAULT 1
);

-- 1. Tabela forma_pagamento
CREATE TABLE forma_pagamento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_forma_pagamento TEXT NOT NULL COLLATE NOCASE UNIQUE,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
    status INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY(id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
);

-- 5. Tabela ordem
CREATE TABLE IF NOT EXISTS ordem (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipamento INTEGER NOT NULL,
    id_funcionario_abertura INTEGER NOT NULL,
    id_funcionario_cargo_abertura INTEGER NOT NULL,
    data_abertura TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
    id_situacao_atual INTEGER NOT NULL,
    data_fechamento TEXT,
    descricao_defeito TEXT NOT NULL COLLATE NOCASE,
    descricao_constatado TEXT COLLATE NOCASE,
    valor_total INTEGER,
    id_forma_pagamento INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),
    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento (id),
    FOREIGN KEY (id_situacao_atual) REFERENCES situacao (id),
    FOREIGN KEY (id_tecnico) REFERENCES funcionario (id)
);

-- 6. Tabela ordem_situacao
CREATE TABLE IF NOT EXISTS ordem_situacao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ordem INTEGER NOT NULL,
    id_situacao INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),
    data_situacao TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
    FOREIGN KEY (id_ordem) REFERENCES ordem (id),
    FOREIGN KEY (id_situacao) REFERENCES situacao (id),
    FOREIGN KEY (id_tecnico) REFERENCES funcionario (id)
);

-- 7. Tabela ordem_pecas
CREATE TABLE IF NOT EXISTS ordem_pecas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ordem INTEGER NOT NULL,
    id_pecas INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    valor_unitario INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),
    data_saida TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
    FOREIGN KEY (id_ordem) REFERENCES ordem (id),
    FOREIGN KEY (id_pecas) REFERENCES pecas (id),
    FOREIGN KEY (id_tecnico) REFERENCES funcionario (id)
);

-- 8. Tabela ordem_servico
CREATE TABLE IF NOT EXISTS ordem_servico (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_ordem INTEGER NOT NULL,
    id_servico INTEGER NOT NULL,
    id_tecnico INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    valor_unitario INTEGER NOT NULL,
    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),
    data_execucao TEXT NOT NULL,
    FOREIGN KEY (id_ordem) REFERENCES ordem (id),
    FOREIGN KEY (id_servico) REFERENCES servicos (id),
    FOREIGN KEY (id_tecnico) REFERENCES funcionario (id)
);
