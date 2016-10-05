require 'net/ldap'

module API
	module V1
    class UserController < Grape::API
      version 'v1'
      format :json

      desc 'Operações de usuário'
      resource :user do
        desc 'Retorna informações de um usuário. Se o usuário não for especificado, retorna o usuário logado. Para filtrar os campos, separe por virgula'
        params do
          optional :user, type: String
          optional :fields, type: String
        end
        get do 
          # Possiveis infos do usuario
          fields = (params[:fields] || 'cn,loginShell,uidNumber,gidNumber,homeDirectory,uid,mail,pykotaBalance').split(',') 
          user = params[:user] || request.env['REMOTE_USER'] # Se usuario nao for especificado, escolhe o que estiver logado
          
          # Filtro de text do LDAP
          text = `bash #{ENV['scripts_path']}/user/find_user.sh -h #{ENV['ldap_host']} -p #{ENV['ldap_port']} -u #{user}`.scan(/^(?!objectClass)(?!#)([\w]+): ([^:].*)/)

          # Transforma texto em tabela de simbolos
          user = {}
          text.each do |line|
            user[line[0]] = line[1]
          end

          # Limpa algumas entradas desnecessarias
          user.delete("dn")
          user.delete("search")
          user.delete("result")
          user.delete("pykotaUserName")
          user.delete("pykotaOverCharge")
          user.delete("pykotaLimitBy")
          user.delete("pykotaLifeTimePaid")

          # Separa os e-mails em listas
          user["mail"] = user["mail"].split(' ')

          # Retorna usuario
          user.slice(*fields) # *fields seleciona os campos por parametro, se foi especificado
      
        end

        desc 'Verifica se o usuário especificado ou logado é admin'
        params do
          optional :user, type: String
        end
        get 'is_admin' do
          user = params[:user] || request.env['REMOTE_USER']
          (Integer(`bash #{ENV['scripts_path']}/user/is_admin.sh -h #{ENV['ldap_host']} -p #{ENV['ldap_port']} #{user}`) == 1).to_json
          # ldap = Net::LDAP.new
          # ldap.host = 'overwatch.linux.ime.usp.br'
          # ldap.port = 6002
          # ldap.auth "cn=admin,dc=linux,dc=ime,dc=usp,dc=br", "adoroPassatempo"
          # if ldap.bind
          #   p "success"
          # else
          #   p "fail"
          # end
          
        end
      end

    end
  end
end 