class CharactersController < ApplicationController
  respond_to :html

  def index
    @characters = Character.scoped
    respond_with @characters
  end

  def show
    @character = Character.find(params[:id])
    respond_with @character
  end

  def new
    @character = Character.new
    respond_with @character
  end

  def create
    @character = Character.create(params[:character])
    respond_with @character
  end

  def edit
    @character = Character.find(params[:id])
    respond_with @character
  end

  def update
    @character = Character.find(params[:id])
    @character.update_attributes(params[:character])
    respond_with @character
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy if @character
    respond_with @character
  end

end
