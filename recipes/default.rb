#
# Cookbook Name:: phantomjs
# Recipe:: default
#
# Copyright 2012, CustomInk
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Packages
case node['platform']
when 'ubuntu'
  %w(fontconfig libfreetype6).each do |package|
    package package
  end
when 'centos'
  %w(fontconfig freetype).each do |package|
    package package
  end
end

# Download the tarball
remote_file "/usr/local/src/phantomjs-#{node['phantomjs']['version']}.tar.bz2" do
  action :create_if_missing
  backup false
  checksum 'b429c15007e1ddcb43dfbb4b4b72f3e22906aad2'
  mode '0644'
  source "http://phantomjs.googlecode.com/files/phantomjs-#{node['phantomjs']['version']}.tar.bz2"
end

# Install phantomjs
execute 'Install phantomjs' do
  command "tar -xvjf /usr/local/src/phantomjs-#{node['phantomjs']['version']}.tar.bz2 -C /usr/local/"
  not_if "test -e /usr/local/phantomjs-#{node['phantomjs']['version']}"
end

# Set up the symbolic link
link '/usr/local/bin/phantomjs' do
  link_type :symbolic
  to "/usr/local/phantomjs-#{node['phantomjs']['version']}/bin/phantomjs"
end
