#
# Cookbook Name:: feedback-factory
# Attribute:: default
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

node.default["feedback-factory"]["windows"]["docker"]["toolbox_url"] =
  "https://github.com/docker/toolbox/releases/download/v1.8.1b/DockerToolbox-1.8.1b.exe"
node.default["feedback-factory"]["windows"]["docker"]["toolbox_display_name"] =
  "Docker Toolbox version 1.8.1b"
node.default["feedback-factory"]["windows"]["docker"]["toolbox_checksum"] =
  "235e4f64a1a7fdb5695e30245bab3681bd457c8c8c0ae7881f621a5d073ff2de"
node.default["feedback-factory"]["windows"]["docker"]["vm_name"] = "remote"
