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
case node['platform_family']
when 'debian'
  %w(fontconfig libfreetype6).each do |package|
    package package
  end
when 'fedora','rhel'
  %w(fontconfig freetype).each do |package|
    package package
  end
when 'gentoo'
  %w{media-libs/fontconfig media-libs/freetype}.each do |package|
    package package
  end
end

src_dir = '/usr/local/src'
basename = "phantomjs-#{node['phantomjs']['version']}-linux-#{node['kernel']['machine']}"

# ensure the directory exists
directory src_dir do
  action :create
  mode '0755'
  owner 'root'
  group 'root'
end

# Download the tarball
remote_file "#{src_dir}/#{basename}.tar.bz2" do
  action :create_if_missing
  backup false
  mode '0644'
  checksum node['phantomjs']['checksum'] if node['phantomjs']['checksum']
  source "https://phantomjs.googlecode.com/files/#{basename}.tar.bz2"
end

# Install phantomjs
execute 'Install phantomjs' do
  command "tar -xvjf #{src_dir}/#{basename}.tar.bz2 -C /usr/local/"
  not_if "test -d /usr/local/#{basename}"
end

# Set up the symbolic link
link '/usr/local/bin/phantomjs' do
  to "/usr/local/#{basename}/bin/phantomjs"
end
