Factory.sequence(:email) { |n| "user.#{n}@somedomain.com" }

Factory.define :user do |user|
  user.sequence(:name)        { |n| "John Q Gamer the #{n.ordinalize}" }
  user.email                  { Factory.next :email }
  user.password               'password'
  user.password_confirmation  'password'
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

Factory.define :invitation do |invite|
  invite.association        :campaign
  invite.email              { Factory.next :email }
end
