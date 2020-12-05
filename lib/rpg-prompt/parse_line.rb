# require "rpg-prompt/manage_command.rb"   # required at the en of the file
# require "rpg-prompt/commands.rb"         # required at the en of the file

module ParseLine
  class Line
    @@line_regexp_hash = nil
    @help = false

    def self.line_regexp_hash
      @@line_regexp_hash
    end

    def remove_extra_separators
      ret_line = @line.clone
      ret_line = ret_line.gsub(/\s+/, " ")
      ret_line = ret_line.gsub(/^\s*/, "")
      ret_line = ret_line.gsub(/\s*$/, "")
      ret_line = ret_line.gsub(/,/, "")
      @line = ret_line.clone
    end

    def initialize(line)
      if @@line_regexp_hash.nil?
        @@line_regexp_hash = Hash.new([/^$/,/^$/])
      end
      @line = line
    end

    def Line.add_command(symbol, command, options)
      if @@line_regexp_hash.nil?
        @@line_regexp_hash = Hash.new([/^$/,[]])
      end
      unless (symbol.class != Symbol) || (command.class != Regexp)
        o = "(?<options> [-"
        r = []
        options.each do |t|
          o += t
          r.push(Regexp.new("^" + t + "$"))
        end
        o += "]+)?"
        c = Regexp.new("^" + command.source + o + "$")
        @@line_regexp_hash[symbol] = [c, r]
      end
    end
    
    def parse
      c = ManageCommand::Command.new(:unkown_command, Hash.new, Hash.new)

      self.remove_extra_separators
      @@line_regexp_hash.each do |symbol, regex_constant|
        command_regex = regex_constant[0]
        options_array = regex_constant[1]

        if (@line.match(command_regex))
          line_array = @line.gsub(":", " : ").gsub("  "," ").split(" ")
          options = @line.match(command_regex)[:options]
          
          unless options.nil?
            is_known, options =  process_line_options(options, options_array)
            if is_known == :known_options
              line_array.pop
              c = ManageCommand::Command.new(symbol, line_array, options)
            elsif is_known == :unknown_options
              line_array.pop
              c = ManageCommand::Command.new(symbol, line_array, Hash.new())
            elsif is_known == :no_options
              c = ManageCommand::Command.new(symbol, line_array, Hash.new())
            end
          else
            c = ManageCommand::Command.new(symbol, line_array, Hash.new())
          end
        elsif @line.length == 0
          c = ManageCommand::Command.new(:empty, Hash.new, Hash.new)
        end
      end

      c
    end

    def process_line_options(options, regex)
      # there are options
      if (options.length > 1) && (options[1] == '-')
        l = options.length-1
        o = Array.new
        (0..l).each do |i|
          unless options[i].match(/^[- ]$/)
            o.push(options[i])
          end
        end

        valid_options = Hash.new(false)  # default, all are invalid
        o.each do |opt|
          regex.each do |reg|
            if opt.match(reg)
              valid_options[opt] = true  #only if they are valid
            end
          end
        end

        valid = (valid_options.length >= 1)  #tentatively
        o.each do |opt|
          # Only if all are valid, options are in fact known
          valid &&= valid_options[opt]
        end

        if valid
          return :known_options, o
        else
          # this should never occur, if the Regexp are well written
          return :unknown_options, Hash.new
        end

      # there are no options
      else
        return :no_options, Hash.new
      end

    end
  end
end

require "rpg-prompt/manage_command.rb"
require "rpg-prompt/commands.rb"