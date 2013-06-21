#
# Cookbook Name:: phantomjs
# Recipe:: package
#
# Copyright 2012-2013, Seth Vargo (sethvargo@gmail.com)
# Copyright 2012-2013, CustomInk
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
# Install PhantomJS as a package
#

case node['platform_family']
when 'windows'
  include_recipe 'chocolatey'
  chocolatey   node['phantomjs']['package_name']
else
  package   node['phantomjs']['package_name']
end
