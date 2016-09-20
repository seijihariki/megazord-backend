# Megazord (Backend)

Sistema Megazord da Rede Linux baseado em *SOA* para gerenciar usuarios e computadores da Rede

## Requisitos

- Ruby **>= 2.1**
- Rails **>= 4.0**

## Bibliotecas
- `grape-swagger-rails` para documentação
- `net-ldap` para comunicação LDAP nos testes
- `sqlite3` como banco de dados
- `capistrano` ferramenta de deploy
- `rspec` testes automatizados

## Instalação

    bundle install
    bundle exec rake db:migrate
    bundle exec rake db:seed

## Uso

`rails server`

https://localhost:3000/api/docs para consultar as chamadas da API

## Testes

    rake db:migrate RAILS_ENV=test
    bundle exec rspec

