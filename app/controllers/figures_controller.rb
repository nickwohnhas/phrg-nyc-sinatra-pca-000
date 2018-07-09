# frozen_string_literal: true

class FiguresController < ApplicationController
  get "/figures" do
    @figures = Figure.all

    erb :'/figures/index'
  end

  get "/figures/new" do
    erb :'/figures/new'
  end

  get "/figures/:id" do
    @figure = Figure.find(params["id"])
    erb :'/figures/show'
  end

  post "/figures" do
    @figure = Figure.new(name: params["figure"]["name"])

    if params["figure"]["title_ids"]
      @title = Title.find(title_id_stripper(params["figure"]["title_ids"][0]))
      @figure.titles << @title
    end

    if params["figure"]["landmark_ids"]
      @landmark = Landmark.find(landmark_id_stripper(params["figure"]["landmark_ids"][0]))
      @figure.landmarks << @landmark
    end

    if params["title"]["name"]
      @title = Title.new(name: params["title"]["name"])
      @figure.titles << @title
    end

    if params["landmark"]["name"]
      @landmark = Landmark.new(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params["id"])
    erb :'/figures/edit'
  end

  patch "/figures/:id" do
    @figure = Figure.find(params["id"])
    @figure.name = params["figure"]["name"]
    @landmark = Landmark.new(name: params["figure"]["landmark"])
    @figure.landmarks << @landmark
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  def title_id_stripper(string)
    id = string.slice(6, string.length).to_i
    id
  end

  def landmark_id_stripper(string)
    id = string.slice(9, string.length).to_i
    id
  end
end
