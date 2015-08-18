#
# Cookbook Name:: feedback-factory
# Recipe:: _kitchen
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

home = ENV['HOME']

global_tk_config = ::File.join(home, ".kitchen", "config.yml")
global_tk_config_content = if platform?("windows")
  driver = "kitchen-docker"
  home = home.gsub("/", "\\")
  vm_name = node['feedback-factory']['windows']['docker']['vm_name']

  <<-CONFIG
---
driver:
  name: docker
  tls_verify: true
  tls_cacert: #{home}\\.docker\\machine\\certs\\ca.pem
  tls_cert: #{home}\\.docker\\machine\\machines\\#{vm_name}\\cert.pem
  tls_key: #{home}\\.docker\\machine\\machines\\#{vm_name}\\key.pem
  provision_command: "bash -c 'curl -L https://www.chef.io/chef/install.sh | bash'"
  #{"http_proxy: #{node['http_proxy']}" if node['http_proxy']}
  CONFIG
else
  driver = "kitchen-ec2"
  kitchen = node['feedback-factory']['kitchen']
  username = node['feedback-factory']['username']

  <<-CONFIG
---
driver:
  name: ec2
#{YAML.dump(kitchen.to_hash).sub(/\A---\n/, "").gsub(/^/, "  ")}

transport:
  ssh_key: /home/#{username}/.ssh/id_rsa
  CONFIG
end

directory ::File.dirname(global_tk_config) do
  recursive true
end

file global_tk_config do
  content global_tk_config_content
end

chef_gem driver
