module API
	module V1
    class Base < Grape::API

      mount API::V1::BugReportController
      mount API::V1::UserController

      add_swagger_documentation base_path: "/api",
                                api_version: 'v1',
                                hide_documentation_path: true,
                                info: {
                                  title: "Megazord API",
                                  description: "API responsável por gerenciar todos os processos de infraestrutura da Rede Linux - IME-USP",
                                }
    end
  end
end
