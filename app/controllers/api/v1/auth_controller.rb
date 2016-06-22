module API
	module V1
    class AuthController < Grape::API
      version 'v1'
      format :json

      resource :user do
        desc 'Retorna o usuario logado'
        get do
          request.env['REMOTE_USER']
        end
      end

    end
  end
end 