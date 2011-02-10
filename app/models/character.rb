require 'rexml/document'

class Character < ActiveRecord::Base
  belongs_to :player, :class_name => 'User'
  belongs_to :campaign

  has_attached_file :token, :styles => {:tiny => '32x32>', :small => '64x64>'}
  has_attached_file :portrait
  has_attached_file :sheet

  after_sheet_post_process :store_sheet_for_import
  before_validation :import_sheet

  validates :name, :presence => true
  validates :player, :presence => true
  validates :campaign, :presence => true

  def to_s
    name
  end

private

  def import_sheet
    return if @doc.blank?
    elt = @doc.root.elements['/D20Character/CharacterSheet/Details/name']
    self.name = elt.text
  end

  def store_sheet_for_import
    file = sheet.queued_for_write[:original]
    @doc = REXML::Document.new file
  end

end
