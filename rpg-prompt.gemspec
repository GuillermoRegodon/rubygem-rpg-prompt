# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "rpg-prompt"
  spec.version       = '1.0'
  spec.authors       = ["Guillermo Regodón"]
  spec.email         = ["guillermoregodon@gmail.com"]
  spec.summary       = %q{Helper Prompt for playing Role Playing Games}
  spec.description   = %q{Prompt that facilitates the management of characters and actions in a Role Playing Game. The set of rules can be programmed in Ruby to match your favourite set of rules. I have included an easy set of rules as an example, although in my games I use a commercial set of rules that I do not include for copyright reasons.}
  spec.homepage      = "https://github.com/GuillermoRegodon/rubygem-rpg-prompt"
  spec.license       = "MIT"

  spec.files         = ['lib/rpg-prompt/parse_line.rb',
                        'lib/rpg-prompt/commands.rb',
                        'lib/rpg-prompt/manage_command.rb',
                        'lib/rpg-prompt/message.rb',
                        'lib/rpg-prompt/keypress.rb',
                        'lib/rpg-prompt/rules_default.rb',
                        'lib/rpg-prompt/rules_sheet.rb',
                        'lib/rpg-prompt/save.rb',
                        'lib/rpg-prompt/texts_prompt.rb',
                        'lib/rpg-prompt/texts_default.rb',
                        'lib/rpg-prompt/rules_default_hashes.rb',
                        'data/rpg-prompt/rules_default.rb',
                        'data/rpg-prompt/rules_default_hashes.rb',
                        'data/rpg-prompt/texts_default.rb',
                        'data/rpg-prompt/example.txt',
                        'data/rpg-prompt/help.txt']
  spec.executables   = ['rpg-prompt']
  spec.test_files    = ['tests/test_rpg-prompt.rb']
  spec.require_paths = ["lib", "data"]
end
