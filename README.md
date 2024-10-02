# Desafio: Lista de Pedidos

O projeto consiste em uma aplicação que deverá consumir a API que retornará uma Lista de Pedidos.  
A consulta da API retornará os seguintes dados: cliente, endereço de entrega, itens e parcelas de pagamento.  
Os dados deverão ser armazenados em banco de dados utilizando Hive para persistência de dados, para posteriormente serem manipulados nas telas.

### Tecnologias utilizadas

- **Flutter**
- **Dart**
- **Hive** (para persistência de dados)
- **GetIt** (para injeção de dependências)
- **HTTP** (para requisições à API)
- **Padrão MVC**
- **ChangeNotifier** (para gerenciamento de estado)

### Instalação e configuração

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu-usuario/seu-repositorio.git


2. Acesse a pasta do projeto:

````bash
cd lista-de-pedidos
````
3. Instale as dependências:
````
bash
flutter pub get
````
4. Execute o projeto:
````
bash
flutter run
````
### Descrição do Projeto
- URL da API: https://desafiotecnicosti3.azurewebsites.net/pedido

- Tela Inicial
A tela inicial contém um menu lateral com as opções: Pedidos e Relatórios.

- Tela de Pedidos
Na tela de pedidos, tem um botão Consultar, que ao ser clicado, consume o webservice para trazer uma lista de pedidos que é armazenada no banco de dados.
Tem um campo Pesquisa, que busca no banco de dados pelo nome do cliente, e uma tabela abaixo com as seguintes colunas: Número, Data, Cliente, Status, Valor Total.
Cada item da lista corresponde a um pedido de um cliente, com 1 ou vários produtos e 1 ou várias parcelas.

Ao clicar 1x no item da lista, exibi na coluna lateral todos os dados do pedido correspondente.
Ao clicar 2x ou no botão Detalhes, abre um modal para exibir os dados dos produtos e parcelas correspondentes ao pedido selecionado.
Tela de Relatórios (Desafio Extra)
Nesta tela tem um combo box / dropdowm para selecionar as seguintes opções e apresentar os seguintes dados numa tabela abaixo:

- Listagem de Produtos mais vendidos: Produto, Quantidade e Valor Médio
- Totalização de Formas de Pagamento por Dia: Data do Pedido, Forma de Pagamento e Valor