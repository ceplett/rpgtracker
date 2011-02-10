class CharactersController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!
  before_filter :require_current_campaign, :only => [:new, :create]
  before_filter :require_current_character, :except => [:new, :create]
  before_filter :require_ownership, :only => [:edit, :update]

  def show
    @character = current_character
    respond_with @character
  end

  def new
    @character = current_campaign.characters.build :player => current_user
    respond_with @character
  end

  def create
    @character = current_campaign.characters.create(params[:character].merge(:player => current_user))
    respond_with @character
  end

  def edit
    @character = current_character
    respond_with @character
  end

  def update
    @character = current_character
    @character.update_attributes(params[:character])
    respond_with @character
  end

private

  def current_campaign
    @current_campaign ||= Campaign.find_by_id(params[:campaign_id])
  end

  def current_character
    @current_character ||= Character.find_by_id(params[:id])
  end

  def require_current_character
    render_not_found unless current_character
  end

  def require_current_campaign
    render_not_found unless current_campaign
  end

  def require_ownership
    render_not_found(:unauthorized) unless current_user == current_character.player
  end

end
