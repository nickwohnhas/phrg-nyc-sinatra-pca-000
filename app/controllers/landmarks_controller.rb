# frozen_string_literal: true

class LandmarksController < ApplicationController
  get "/landmarks" do
    @landmarks = Landmark.all
    # binding.pry
    erb :'/landmarks/index'
  end

  get "/landmarks/new" do
    erb :'/landmarks/new'
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find(params["id"])
    erb :'/landmarks/show'
  end

  post "/landmarks" do
    @landmark = Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"])
    redirect to "/landmarks/#{@landmark.id}"
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params["id"])
    erb :'/landmarks/edit'
  end

  patch "/landmarks/:id" do
    @landmark = Landmark.find(params["id"])
    @landmark.name = params["name"]
    @landmark.year_completed = params["year_completed"]
    @landmark.save
    # binding.pry
    redirect to "landmarks/#{@landmark.id}"
  end
end
