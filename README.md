# Encontre Buffet

## Introdução


## Inicialização

### Setup
Essa aplicação usa a versão do __Ruby 3.2.3__ e a versão do __Rails 7.1.3__.

Após baixar a aplicação na sua máquina, acesse o diretório e faça o setup executando o seguinte comando no terminal:

```
$ bin/setup
```

### Populando Banco de Dados
Após terminar o setup, você pode popular o seu banco de dados com o comando:

```
$ rails db:seed
```

### Executando a aplicação local

Para executar a aplicação local, use o comando

```
$ rails server
```

ou

```
$ rails s
```

Acesse o endereço [localhost:3000](localhost:3000) no seu navegador

<br>

---
---

<br>



# API Buffet

## Introdução

Bem-vindo a API Buffet. Com essa API você poderá:
* Ver todos os Buffets cadastrados no sistema
* Ver os detalhes do Buffet
* Eventos que cada Buffet realiza
* Buscar um Buffet pelo nome
* Fazer um pré-agendamento com um Buffet

## Autenticação
Nosso sistema não exige autenticação.

## Buffets

### Sucesso:
Para conseguir visualizar todos os buffets cadastrados faça uma requisição

Verbo HTTP: `GET`

URL: `http://localhost:300/api/v1/buffets`

Retorna:

```json
[
  {
    "id": 1,
    "brand_name": "Teenage Mutant Ninja Turtles",
    "city": "São Paulo",
    "state": "SP"
  },
  {
    "id": 2,
    "brand_name": "Os Cavaleiro dos Zodíacos",
    "city": "São Paulo",
    "state": "SP"
  },
  {
    "id": 3,
    "brand_name": "Teen Titans",
    "city": "Florianópolis",
    "state": "SC"
  }
]
```

- `id`: ID do Buffet
- `brand_name`: Nome do Buffet
- `city`: Cidade
- `state`: Estado

### Sem Buffet cadastrado:
Caso não tenha nehum Buffet cadastrado, terá o seguinte retorno

```json
[]
```

### Buscar por um Buffet

Pode procuar um Buffet passando o nome. Não é case-sensitive

Verbo HTTP: `GET`

URL: `http://localhost:300/api/v1/buffets`

params: `{ brand_name: 'buffet name' }`

Retorna:

```json
[
  {
    "id": 1,
    "brand_name": "Teenage Mutant Ninja Turtles",
    "city": "São Paulo",
    "state": "SP"
  },
  {
    "id": 3,
    "brand_name": "Teen Titans",
    "city": "Florianópolis",
    "state": "SC"
  }
]
```

### Detalhes do Buffet

Para ver os detalhes do Buffet, passe o ID na URL

Verbo HTTP: `GET`

URL: `http://localhost:300/api/v1/buffets/:id_buffet`

Retorna:

```json
{
  "id": 1,
  "brand_name": "Teenage Mutant Ninja Turtles",
  "phone": "11912341234",
  "email": "contato@tmntsplinter.com",
  "address": "Rua Estados Unidos, 1030 - Jardins",
  "city": "São Paulo",
  "state": "SP",
  "zip_code": "01234123",
  "description": "Melhor Buffet da região. Cowabunga",
  "payment": "PIX, Cartão de Débito"
}
```

- `id`: ID do Buffet
- `brand_name`: Nome do Buffet
- `phone`: Telefone para contato
- `email`: E-mail para contato
- `address`: Endereço
- `city`: Cidade
- `state`: Estado
- `zip_code`: CEP
- `description`: Descrição, mais informações
- `payment`: Formas de pagamento aceita

### Erros:

Caso tenha algum erro interno retorna o status:
*  **500 - Internal Server Error**
 
