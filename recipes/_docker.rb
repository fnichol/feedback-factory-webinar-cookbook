#
# Cookbook Name:: feedback-factory
# Recipe:: _docker
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

docker = node['feedback-factory']['windows']['docker']
docker_key = "C:\\docker.key"
docker_machine = "C:\\Program Files\\Docker Toolbox\\docker-machine.exe"

windows_package docker['toolbox_display_name'] do
  source docker['toolbox_url']
  checksum docker['toolbox_checksum']
  installer_type :inno
end

file docker_key do
  content docker['ssh_key'].gsub("\\n", "\n")
end

execute 'create-docker-machine' do
  command %W["#{docker_machine}" create
    --driver generic
    --generic-ip-address #{docker["ip_address"]}
    --generic-ssh-user #{docker["ssh_user"]}
    --generic-ssh-port #{docker["ssh_port"]}
    --generic-ssh-key #{docker_key}
    #{docker['vm_name']}
  ].join(" ")
  not_if %{"#{docker_machine}" status #{docker['vm_name']}}
end
