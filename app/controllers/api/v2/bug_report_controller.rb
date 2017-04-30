module API
	module V2
    class BugReportController < Grape::API
      version 'v2'
      format :json

      resource :bug_report_categories do

        desc 'Retorna todas as categorias de BugReport'
        get do
          BugReportCategory.select(:id, :name)
        end

        desc 'Retorna a categoria escolhida'
        params do
          requires :id, type: Integer
        end
        get ':id' do
          BugReportCategory.find(params[:id])
        end

        desc 'Cria uma categoria de BugReport'
        params do
          requires :name, type: String
        end
        post do
          BugReportCategory.create!({ name: params[:name] })
        end

        desc 'Deleta uma categoria de BugReport'
        params do
          requires :id, type: Integer
        end
        delete ':id' do
          BugReportCategory.find(params[:id]).destroy!
        end

        desc 'Edita uma categoria'
        params do
          requires :id, type: Integer
          requires :name, type: String
        end
        put ':id' do
          BugReportCategory.find(params[:id]).update!({
            name: params[:name]
          })
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
