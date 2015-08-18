#
# Cookbook Name:: feedback-factory
# Recipe:: _profile
#
# Copyright 2015 Chef Software Inc.
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

if platform_family?('windows')
  profile = Chef::Util::Powershell::Cmdlet.new(node, '$PROFILE').
    run.return_value.chomp
  vm_name = node['feedback-factory']['windows']['docker']['vm_name']

  directory File.dirname(profile) do
    recursive true
  end

  file profile do
    content <<-PROFILE.gsub(/^ {6}/, '')
      docker-machine env --shell powershell #{vm_name} | iex
      chef shell-init powershell | iex
    PROFILE
  end
else
  file ::File.join(ENV['HOME'], '.bash_aliases') do
    content <<-PROFILE.gsub(/^ {6}/, '')
      eval $(chef shell-init bash)
    PROFILE
  end
end
