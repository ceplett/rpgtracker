class String
  def normalize
    self.downcase.split.compact.join('_')
  end
end

class Character
  class Sheet < Nokogiri::XML::SAX::Document
    KNOWN_STATS = Character::ABILITIES + Character::DEFENSES + Character::DAMAGE_STATS +
                  Character::ABILITIES.map { |abil| "#{abil}_modifier".to_sym } +

    KNOWN_RULES_ELTS = [:race, :klass, :build]

    def initialize(character)
      @character = character
      @text_buffer = ''
    end

    def start_element(name, attributes=[])
      handle_tag name, true, attributes
    end

    def end_element(name)
      handle_tag name, false
    end

    def characters(string)
      @text_buffer += string
    end

    def handle_tag(name, start, attributes=[])
      handler = "handle_#{name.downcase}".to_sym
      attributes = attributes.inject({}) do |result, pair|
        result[pair[0]] = pair[1]
        result
      end
      send(handler, start, attributes) if respond_to?(handler)
    end

    def handle_details(start, attributes)
      @in_details = start
    end

    def handle_name(start, attributes)
      return unless @in_details
      if start
        @text_buffer = ''
      else
        @character.name = @text_buffer.strip
      end
    end

    def handle_level(start, attributes)
      return unless @in_details
      if start
        @text_buffer = ''
      else
        @character.level = @text_buffer.strip.to_i
      end
    end

    def handle_stat(start, attributes)
      @current_stat_value = start ? attributes['value'].to_i : nil
    end

    def handle_alias(start, attributes)
      return unless @current_stat_value && start
      stat = attributes['name'].normalize.to_sym
      @character.send("#{stat}=".to_sym, @current_stat_value) if KNOWN_STATS.include?(stat)
    end

    def handle_ruleselementtally(start, attributes)
      @in_rules_elements = start
    end

    def handle_ruleselement(start, attributes)
      return unless @in_rules_elements && start
      type = attributes['type'].normalize.to_sym
      type = :klass if type == :class
      case type
      when :power
        name = attributes['name']
        @character.powers_to_save[name] ||= {}
        @character.powers_to_save[name].merge!({
          :name           => name,
          :compendium_url => attributes['url']
        })
      else
        @character.send("#{type}=".to_sym, attributes['name']) if KNOWN_RULES_ELTS.include?(type)
      end
    end

    def handle_power(start, attributes)
      @current_power = start ? attributes['name'] : nil
      if @current_power
        @character.powers_to_save[@current_power] ||= {}
        @character.powers_to_save[@current_power].merge!({
          :name => @current_power
        })
      end
    end

    def handle_specific(start, attributes)
      return unless @current_power
      if start
        @text_buffer = ''
        @specific_name = attributes['name'].normalize.to_sym
      else
        @character.powers_to_save[@current_power] ||= {}
        @character.powers_to_save[@current_power].merge!({
          @specific_name => @text_buffer.strip
        })
      end
    end
  end
end
