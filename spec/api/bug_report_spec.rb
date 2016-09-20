describe 'Categoria de Bug Report' do

	it 'cria uma categoria nova' do
		post '/api/v1/bug_report_categories', { name: 'CategoriaTeste' }
		expect(response.status).to eq(201)
		expect(BugReportCategory.where(name: 'CategoriaTeste')).to exist
	end

	context 'sem nenhuma categoria de bug report cadastrado' do
		it 'retorna um array vazio' do
			get '/api/v1/bug_report_categories'
			expect(response.status).to eq(200)
  			expect(JSON.parse(response.body)).to eq []
		end
	end

	context 'se já existir uma categoria cadastrada' do

		before do
			@cat1 = BugReportCategory.create({ name: 'Categoria1'})
			@cat2 = BugReportCategory.create({ name: 'Categoria2'})
		end

		it 'deleta uma categoria' do
			category = BugReportCategory.where(name: 'Categoria1').first
			delete "/api/v1/bug_report_categories/#{@cat1.id}"
			expect(response.status).to eq(200)
			expect(BugReportCategory.count).to eq(1)
		end

		it 'retorna todas as categorias' do
			get '/api/v1/bug_report_categories'
			expect(response.status).to eq(200)
  			expect(JSON.parse(response.body)).to eq [{"id"=>1, "name"=>"Categoria1"}, {"id"=>2, "name"=>"Categoria2"}]
		end

		it 'edita uma categoria' do
			put "/api/v1/bug_report_categories/#{@cat1.id}", { name: 'Categoria3' }
			expect(response.status).to eq(200)
			expect(BugReportCategory.where(name: 'Categoria3')).to exist
		end
	end

end