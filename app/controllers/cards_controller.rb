class CardsController < ApplicationController
  respond_to :html, :json

  def index
    # autocomplete searches only
    unless params[:search].nil?
      @cards = Card.find_titles_for_user params[:search], (current_user || nil)
    else @cards = []
    respond_with @cards
  end

  def show
    @cards = Card.find_all_for_user params[:title], (current_user || nil)
    respond_with @cards
  end

  def create
    @card = Card.create params[:card]
    respond_with @card
    # client will look at obj for errors, etc.
  end

  def destroy

  end
end
