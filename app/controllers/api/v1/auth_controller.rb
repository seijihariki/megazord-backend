require 'net/ldap'

module API
	module V1
    class AuthController < Grape::API
      version 'v1'
      format :json

      desc 'Operações de usuário'
      resource :user do
        desc 'Retorna o usuario logado'
        get do
          request.env['REMOTE_USER']
        end

        desc 'Busca no LDAP'
        get 'ldap' do

          ldap = Net::LDAP.new
          ldap.host = 'overwatch.linux.ime.usp.br'
          ldap.port = 6002
          ldap.auth "cn=admin,dc=linux,dc=ime,dc=usp,dc=br", "adoroPassatempo"
          if ldap.bind
            p "success"
          else
            p "fail"
          end
          
        end
      end

    end
  end
end 