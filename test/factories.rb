Factory.define :character do |character|
  character.sheet { File.new(Rails.root.join('test/fixtures/Immilzin.dnd4e')) }
end
