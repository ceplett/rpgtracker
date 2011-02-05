Factory.define :user do |user|
  user.sequence(:name)        { |n| "John Q Gamer the #{n.ordinalize}" }
  user.sequence(:email)       { |n| "user#{n}@somedomain.com" }
  # user.password               'password'
  # user.password_confirmation  'password'
end

Factory.define :campaign do |campaign|
  campaign.title        'A Cool Campaign'
  campaign.description  'A journey into madness. MADNESS, I SAY!'
  campaign.association  :gm, :factory => :user
end

Factory.define :character do |character|
  character.sequence(:name) { |n| "Grabthar the #{n.ordinalize}" }
  character.association     :player, :factory => :user
  character.association     :campaign
end
