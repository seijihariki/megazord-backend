require 'net/ldap'

module API
    module V1
    class UserController < Grape::API
      version 'v1'
      format :json

      desc 'JWT Authentication'
      resource :user do
        desc 'Receives user and password, returns jwt access token'
        params do
          optional :user, type: String
          optional :fields, type: String
        end
        post do

        end
      end
    end
  end
end
