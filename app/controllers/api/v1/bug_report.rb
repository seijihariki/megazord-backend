module API
	module V1
    class BugReport < Grape::API
      version 'v1'
      format :json

      resource :bug_report_categories do
        desc 'Retorna todas as categorias de BugReport'
        get do
          BugReportCategory.all
        end
      end
    end
  end
end 