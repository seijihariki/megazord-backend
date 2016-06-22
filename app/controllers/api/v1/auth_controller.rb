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
          ldap.host = '192.168.240.92'
          ldap.port = 389
          ldap.auth "cn=admin,dc=linux,dc=ime,dc=usp,dc=br", "123"
          if ldap.bind
            print "success"
          else
            print "fail"
          end
          
        end
      end

    end
  end
end 