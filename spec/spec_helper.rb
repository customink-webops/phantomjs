require 'berkshelf'
require 'chefspec'

Berkshelf.ui.mute {
  Berkshelf::Berksfile.from_file('Berksfile').install(path: 'vendor/cookbooks')
}
