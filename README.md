# TechFix

## Visão geral

O TechFix é um projeto de banco de dados para gestão de uma assistência técnica especializada em equipamentos eletrônicos. A estrutura foi pensada para organizar o controle de clientes, funcionários, estoque de peças, serviços realizados e ordens de serviço (OS), refletindo o fluxo real de uma loja/assistência técnica.

Este projeto foi desenvolvido como uma modelagem de banco de dados em SQLite, com foco em:

- cadastro de clientes e equipamentos;
- controle de funcionários e cargos;
- gestão de estoque de peças;
- registro de serviços prestados;
- acompanhamento de ordens de serviço;
- histórico de status e movimentações;
- organização financeira e de pagamento.

A proposta principal é demonstrar a estrutura de dados e a lógica de negócio de uma operação de manutenção técnica, de forma clara e compreensível para estudo e apresentação em portfólio.

## Objetivo do projeto

O objetivo deste banco é representar o funcionamento de uma assistência técnica, incluindo:

- cadastro do cliente e do equipamento recebido;
- registro do defeito relatado e do diagnóstico;
- vinculação de técnicos responsáveis;
- uso de peças e serviços na manutenção;
- controle de estoque e valores;
- acompanhamento do status da OS até a entrega.

## Contexto de negócio

A empresa atendeu clientes com problemas em diversos tipos de dispositivos, como:

- smartphones;
- notebooks;
- TVs;
- videogames;
- equipamentos de informática e eletrônica.

Além do reparo técnico, o sistema também contempla a comercialização de peças, a reposição de estoque e a gestão de pagamentos, tornando a base de dados útil para operações de assistência técnica e loja de componentes.

## Estrutura do repositório

- `db/` — scripts SQL e arquivos de banco SQLite
- `documentos/` — documentos e materiais do projeto
- `modelos/` — diagramas conceituais e lógicos
- `README.md` — documentação geral do projeto

## Arquivos principais

### Banco SQLite

- `db/techfix.sqlite` — banco principal do projeto
- `db/script completo.sqlite` — cópia/arquivo auxiliar do banco
- `db/mercadinho.sqlite` — banco de teste ou referência

### Scripts SQL

- `db/scripts_teste.sql` — script com criação das tabelas, dados iniciais, views, triggers e consultas de teste
- `db/script completo` — arquivo encontrado vazio, sem conteúdo definido no momento da análise

## Estrutura lógica do banco

A modelagem foi organizada em cinco blocos principais:

### 1. Cadastro e organização

- `cargo`: cargos da empresa
- `funcionario`: colaboradores, com vínculo a um cargo
- `cliente`: clientes atendidos
- `categoria`: categorias de peças e serviços
- `marca`, `modelo`, `tipo`: classificação dos equipamentos

### 2. Equipamentos e manutenção

- `equipamento`: aparelho recebido ou cadastrado para atendimento
- `ordem`: ordem de serviço associada ao equipamento
- `situacao`: status da ordem
- `ordem_situacao`: histórico de mudança de status da OS

### 3. Estoque e peças

- `peca`: catálogo de peças disponíveis
- `entrada_peca`: entrada de mercadoria em estoque
- `saida_peca`: saída de peça para uso ou descarte

### 4. Serviços e valores

- `servico`: serviços oferecidos pela assistência
- `forma_pagamento`: formas de pagamento aceitas
- `ordem_peca`: peças associadas a uma ordem
- `ordem_servico`: serviços executados em uma ordem

### 5. Controle financeiro e histórico

- `valor_total` na tabela `ordem`
- registros de preço congelado em `ordem_peca` e `ordem_servico`
- rastreio de datas de abertura e fechamento da ordem

## Entidades principais e seu papel

### `cargo`

Representa os papéis dentro da empresa, como gerente, atendente e técnico.

### `funcionario`

Armazena os colaboradores e relaciona cada um ao seu cargo. Esse relacionamento é essencial para controlar quem pode realizar determinadas ações dentro do sistema.

### `cliente`

Guarda os clientes atendidos pela assistência, com vínculo ao funcionário que realizou o cadastro.

### `categoria`

Organiza itens como acessórios, bateria, telas, eletrônica avançada, redes e componentes.

### `marca`

Lista as marcas dos equipamentos, como Apple, Samsung, Motorola, Dell, LG e Sony.

### `modelo`

Define os modelos específicos dos equipamentos, como iPhone 11, Galaxy A54, IdeaPad 3 e Smart TV 43.

### `tipo`

Classifica o tipo de equipamento, por exemplo: smartphone, notebook, desktop, smart TV e console.

### `equipamento`

É o centro do atendimento técnico. Cada equipamento está associado a um cliente, uma marca, um modelo e um tipo.

### `ordem`

Representa a ordem de serviço aberta para atender um defeito ou manutenção de um equipamento.

### `situacao`

Define o estágio da ordem, como:

- Aberto
- Em Diagnóstico
- Orçamento Aprovado
- Em Reparo
- Pronto
- Entregue
- Cancelado
- Descarte por Defeito/Avaria

### `ordem_situacao`

Mantém o histórico de mudança de status da ordem, permitindo acompanhar todas as etapas do processo.

### `peca`

Contém o catálogo de peças disponíveis para venda ou uso em reparos.

### `entrada_peca`

Registra a compra ou reposição de peças no estoque.

### `saida_peca`

Registra a baixa de peças do estoque, seja por uso em reparo ou descarte.

### `servico`

Lista os serviços prestados pela assistência, com preço e tempo estimado de execução.

### `ordem_peca`

Relaciona as peças consumidas em uma ordem específica e guarda o valor congelado no momento da utilização.

### `ordem_servico`

Relaciona os serviços executados em uma ordem e guarda também o preço praticado.

### `forma_pagamento`

Controla as formas de pagamento aceitas, como dinheiro, PIX, débito, crédito e boleto.

## Fluxo operacional do sistema

O banco representa o seguinte fluxo de operação da assistência:

1. O cliente leva um equipamento para manutenção.
2. O atendente registra o cliente e o equipamento.
3. A ordem de serviço é aberta com o defeito relatado.
4. O técnico realiza o diagnóstico e registra o defeito constatado.
5. O status da ordem muda ao longo do processo.
6. O técnico utiliza peças e executa serviços necessários.
7. O valor total da ordem é atualizado automaticamente.
8. A ordem é finalizada com pagamento e entrega do equipamento.

## Regras de negócio observadas

O script também demonstra regras importantes implementadas por meio de constraints e triggers:

- um funcionário deve ter um cargo válido;
- algumas tabelas exigem o cargo específico do responsável;
- um cliente só pode ser cadastrado por atendente ou gerente;
- a ordem deve ter um técnico responsável do cargo correto;
- peças só podem ser usadas se houver estoque suficiente;
- a ordem deve possuir status válido durante o processo;
- o valor total da ordem é atualizado automaticamente com peças e serviços;
- o estoque da peça é reduzido quando ocorre uso ou baixa;
- a data de fechamento da ordem é registrada quando a OS é entregue ou cancelada.

## Views e consultas de teste

O script inclui views para facilitar a análise de dados, como:

- `vw_preco_venda_maior_100` — peças com preço de venda acima de R$ 100,00
- `vw_estoque_baixo` — peças com estoque reduzido

Também há consultas de teste para verificar:

- estoque por faixa de preço;
- cargos e funcionários;
- ordens em aberto;
- histórico de status por OS;
- associação de equipamentos, modelos e situações.

## Triggers implementados

O projeto mostra uso de triggers para automatizar regras do sistema. Alguns exemplos:

- atualização do valor total da ordem ao inserir serviço;
- atualização do valor total ao inserir peça;
- baixa automática de estoque;
- registro inicial da situação da ordem;
- atualização da data de fechamento ao concluir a OS;
- validação de estoque insuficiente antes de vincular peça.

Essas automações tornam o banco mais próximo de um ambiente real de operação da assistência técnica.

## Observações importantes

- O banco foi modelado em SQLite.
- A estrutura usa `PRAGMA foreign_keys = 1;` para ativar integridade referencial.
- O arquivo `db/script completo` foi lido e confirmado como vazio, sem nenhuma alteração de conteúdo.
- O script `db/scripts_teste.sql` é uma base funcional para compreensão do modelo e do funcionamento do sistema.

## Status do projeto

Este projeto está em fase de estruturação e modelagem funcional do banco de dados, com foco em demonstrar a lógica de negócio de uma assistência técnica. O script contém estrutura, dados iniciais e regras que permitam entender o funcionamento do sistema de forma didática e profissional.

## Conclusão

O TechFix representa uma modelagem completa para gestão de uma assistência técnica, combinando cadastro, manutenção, produção de serviços, controle de estoque e acompanhamento financeiro. A base foi organizada para ser clara, didática e profissional, servindo como um excelente exemplo de banco de dados aplicado ao cenário real de uma loja/assistência tecnológica.
