Factory.define :character do |character|
  character.sheet { File.new('test/fixtures/Immilzin.dnd4e') }
end
