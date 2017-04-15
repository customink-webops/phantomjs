require 'berkshelf'
require 'chefspec'

Berkshelf.ui.mute {
  Berkshelf::Berksfile.from_file('Berksfile').install(path: 'vendor/cookbooks')
}

module ChefSpec
  module Matchers
    RSpec::Matchers.define :install_ark do |package_name|
      match do |chef_run|
        chef_run.resources.any? do |resource|
          resource_type(resource) == 'ark' and resource.name == package_name
        end
      end
    end
  end
end
