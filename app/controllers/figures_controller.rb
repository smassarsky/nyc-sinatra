class FiguresController < ApplicationController
  
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    title = params[:title]
    landmark = params[:landmark]
    @figure = Figure.new(params[:figure])
    @figure.titles << Title.create(name: title[:name]) if !title[:name].empty?
    @figure.landmarks << Landmark.create(name: landmark[:name], year_completed: landmark[:year]) if !landmark[:name].empty?
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    figure = params[:figure]
    title = params[:title]
    landmark = params[:landmark]

    if !figure[:title_ids]
      figure[:title_ids] = []
    elsif !figure[:landmark_ids]
      figure[:landmark_ids] = []
    end

    @figure = Figure.find(params[:id])
    @figure.update(figure)
    @figure.titles << Title.create(name: title[:name]) if !title[:name].empty?
    @figure.landmarks << Landmark.create(name: landmark[:name], year_completed: landmark[:year]) if !landmark[:name].empty?

    redirect "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
  end

end
