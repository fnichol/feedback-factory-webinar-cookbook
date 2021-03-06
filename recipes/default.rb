#
# Cookbook Name:: feedback-factory
# Recipe:: default
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

include_recipe 'apt'
include_recipe 'git'

if platform_family?('windows')
  include_recipe 'feedback-factory::_chocolatey'
  include_recipe 'feedback-factory::_docker'

  windows_path 'update_path_for_ssh' do
    action :add
    path "#{ENV['ProgramFiles(x86)']}\\Git\\bin"
  end
else
  package "vim"

  include_recipe 'feedback-factory::_aws'
end

include_recipe 'feedback-factory::_profile'
include_recipe 'feedback-factory::_kitchen'
