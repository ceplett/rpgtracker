class InvitationsController < ApplicationController
  respond_to :js

  before_filter :require_current_campaign

  def index
    @invitations = current_campaign.invitations
    respond_with @invitations
  end

  def create
    @invitation = current_campaign.invitations.create(params[:invitation])
    respond_with @invitation, :location => campaign_invitations_path(current_campaign)
  end

private

  def current_campaign
    @current_campaign ||= Campaign.find_by_id(params[:campaign_id])
  end

  def require_current_campaign
    render_not_found unless current_campaign
  end

end
