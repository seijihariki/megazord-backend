module API
	module V2
    class Base < Grape::API

      mount API::V2::BugReportController
      mount API::V2::UserController

      add_swagger_documentation base_path: "/api",
                                api_version: 'v2',
                                hide_documentation_path: true,
                                info: {
                                  title: "Megazord API",
                                  description: "API responsável por gerenciar todos os processos de infraestrutura da Rede Linux - IME-USP",
                                }
    end
  end
end
