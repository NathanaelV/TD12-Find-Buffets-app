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

Status: `200`

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

Status: `200`

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

### Erros:

Caso tenha algum erro interno retorna o status:
*  **500 - Internal Server Error**

## Detalhes do Buffet

Para ver os detalhes do Buffet, passe o ID na URL

Verbo HTTP: `GET`

URL: `http://localhost:300/api/v1/buffets/:id_buffet`

Retorna:

Status: `200`

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

Se buscar por um Buffet que não existe
* **404 - Not Found**

## Eventos

### Buscar eventos de um Buffet

Ver todos os eventos que um Buffet faz. É necessário saber o ID do buffet e passar no lugar de `:id_buffet`:

Verbo HTTP: `GET`

URL: `http://localhost:300/api/v1/buffets/:id_buffet/events`

Retorna:

Status: `200`

```json
[
  {
    "id": 1,
    "name": "Festa infantil",
    "description": "Festa para crianças com temática TMNT",
    "buffet": {
      "id": 1,
      "brand_name": "Teenage Mutant Ninja Turtles"
    }
  },
  {
    "id": 2,
    "name": "Festa de casamento",
    "description": "Festa de casamento dos sonhos",
    "buffet": {
      "id": 1,
      "brand_name": "Teenage Mutant Ninja Turtles"
    }
  }
]
```

- `id`: ID do evento
- `name`: Nome do evento
- `description`: Descrição
- `buffet`: informações do Buffet
    - `id`: ID do buffet
    - `brand_name`: Nome do Buffet


### Sem eventos cadastrados

Caso não tenha nenhum buffet cadastrado, retornará um Array vazio

Verbo HTTP: `GET`

URL: `http://localhost:300/api/v1/buffets/:id_buffet/events`

Retorna:

```json
[]
```

### Erros:

Caso tenha algum erro interno retorna o status:
*  **500 - Internal Server Error**

Se buscar os eventos de um Buffet que não existe
* **404 - Not Found**

## Detalhes do Evento

Ver detalhes do evento. É necessário saber o ID do buffet e passar no lugar de `:id_buffet` e passar o ID do evento no lugar de `:id_event`:

Verbo HTTP: `GET`

URL: `http://localhost:300/api/v1/buffets/:id_buffet/events/:id_event`

Retorna:

Status: `200`

```json
{
  "id": 1,
  "name": "Festa infantil",
  "description": "Festa para crianças com temática TMNT",
  "min_people": 10,
  "max_people": 100,
  "duration": 300,
  "menu": "Pizza",
  "alcoholic_beverages": false,
  "decoration": true,
  "parking": true,
  "parking_valet": false,
  "customer_space": true
}
```

- `id`: ID do evento
- `name`: Nome do evento
- `description`: Descrição
- `min_people`: Mínimo de pessoas
- `max_people`: Máximo de pessoas que o espaço suporta
- `duration`: Duração máxima do evento
- `menu`: Cardápio
- `alcoholic_beverages`: Presença de bebida alcólica, ou não. `true` tem, `false` não
- `decoration`: Buffet tem decoração própria
- `parking`: Se o Buffet tem estacionamento ou não
- `parking_valet`: Se o Buffet tem serviço de Valet
- `customer_space`: Se o Buffet também faz evento no espaço do cliente


### Erros:

Caso tenha algum erro interno retorna o status:
*  **500 - Internal Server Error**

Se buscar por um evento que não existe
* **404 - Not Found**

## Pedido

O Cliente pode consultar a disponibilidade de um Buffet para um evento. 

Verbo HTTP: `POST`

URL: `http://localhost:300/api/v1/buffets/:id_buffet/events/:id_event/orders`

Parametros: `{ order: { event_date: '01/01/2020', people: 80 } }`

- `event_date`: Data no padrão dd/mm/aaaa. (Obrigatório)
- `people`: Número de pessoas que vai na festa. (Obrigatório)

Caso o objeto seja criado Retorna:

Status: `201`

```json
{ "advance_price": "R$ 13800.00" }
```

- `advance_price`: Valor prévio do pedido

### Erros:

Caso tenha algum erro interno retorna o status:
*  **500 - Internal Server Error**

Caso tente criar um evento sem passar a data ou a quantidade de pessoas
* **412 - Precondition Failed**

```json
{
    "errors": [
        "Data do evento não pode ficar em branco",
        "Quantidade de pessoas não pode ficar em branco"
    ]
}
```

Caso tente criar um evento sem passar os parametros
* **412 - Precondition Failed**

```json
{
    "errors": [
        "Order não pode ficar em branco"
    ]
}
```

Caso já tenha um evento marcado para a data que foi passada
* **412 - Precondition Failed**

```json
{
    "errors": [
        "Buffet indisponível na data escolhida"
    ]
}
```
