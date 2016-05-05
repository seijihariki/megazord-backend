module API
	module V1
    class BugReportController < Grape::API
      version 'v1'
      format :json

      resource :bug_report_categories do

        desc 'Retorna todas as categorias de BugReport'
        get do
          BugReportCategory.pluck(:id, :name)
        end
      end

      resource :bug_report do

        desc 'Cria um bug reporting de um usuario'
        params do
          requires :user, type: String
          requires :category, type: Integer
          requires :description, type: String
        end
        post do
          BugReport.create!({
            user: params[:user],
            bug_report_category_id: params[:category],
            status: 'aberto',
            description: params[:description]
          })
        end

        desc 'Lista todos os reports não concluidos/fechados dos usuarios'
        get do
          BugReport
            .where("status <> 'concluido'")
            .where("status <> 'fechado'")
            .order(created_at: :desc)
        end

        desc 'Lista todos os reports, incluindo fechados/concluidos'
        get 'all' do
          BugReport.all.order(created_at: :desc)
        end

        desc 'Retorna o report escolhido'
        params do
          requires :id, type: Integer
        end
        get ':id' do
          BugReport.find(params[:id])
        end

        desc 'Deleta um report'
        params do
          requires :id, type: Integer
        end
        delete ':id' do
          BugReport.find(params[:id]).destroy!
        end

        desc 'Atualiza o status de um report'
        params do
          requires :id, type: Integer
          requires :status, type: String
        end
        put ':id' do
          BugReport.find(params[:id]).update!({
            status: params[:status]
          })
        end        
        
      end
    end
  end
end 