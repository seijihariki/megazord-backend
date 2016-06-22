# Megazord (Backend)

Sistema Megazord da Rede Linux baseado em *SOA* para gerenciar usuarios e computadores da Rede

## Requisitos

- Ruby **>= 2.1**
- Rails **>= 4.0**

## Instalação

    bundle install --deployment
    bundle exec rake db:migrate
    bundle exec rake db:seed

## Uso

`rails server`

https://localhost:3000/api/docs para consultar os chamadas da API
