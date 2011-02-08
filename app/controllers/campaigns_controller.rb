class CampaignsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!
  before_filter :require_ownership, :only => [:edit, :update]

  def index
    @campaigns = Campaign.scoped
    respond_with @campaigns
  end

  def show
    @campaign = Campaign.find(params[:id])
    respond_with @campaign
  end

  def new
    @campaign = current_user.campaigns.build
    respond_with @campaign
  end

  def create
    @campaign = current_user.campaigns.create(params[:campaign])
    respond_with @campaign
  end

  def edit
    @campaign = current_campaign
    respond_with @campaign
  end

  def update
    @campaign = current_campaign
    @campaign.update_attributes(params[:campaign])
    respond_with @campaign
  end

private

  def current_campaign
    @current_campaign ||= Campaign.find(params[:id])
  end

  def require_ownership
    camp = current_campaign
    render_not_found(:unauthorized) unless current_user == camp.gm
  end

end
