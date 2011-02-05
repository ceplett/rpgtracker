class CampaignsController < ApplicationController
  respond_to :html
  before_filter :require_current_user
  before_filter :require_ownership, :only => [:edit, :update]

  def show
    @campaign = Campaign.find(params[:id])
    respond_with @campaign
  end

  def new
    @campaign = current_user.campaigns.build
    respond_with @campaign
  end

  def create
    @campaign = current_user.campaigns.build(params[:campaign])
    if @campaign.save
      redirect_to @campaign, :notice => 'Campaign was successfully created.'
    else
      render :action => :new
    end
  end

  def edit
    @campaign = current_campaign
  end

  def update
    @campaign = current_campaign
    if @campaign.update_attributes(params[:campaign])
      redirect_to @campaign, :notice => 'Campaign was successfully updated.'
    else
      render :action => :edit
    end
  end

private

  def current_campaign
    @current_campaign ||= Campaign.find(params[:id])
  end

  def require_ownership
    camp = current_campaign
    redirect_to campaign_url(camp) unless current_user == camp.gm
  end

end
