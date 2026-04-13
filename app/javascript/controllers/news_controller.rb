class NewsController < ApplicationController
  def index
    @main   = News.find_by(category: "main_headline")
    @center = News.where(category: "center").order(:position)
    @briefs = News.where(category: "brief").order(:position)
  end
end