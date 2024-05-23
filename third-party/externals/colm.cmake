# Copyright 2023 The PBC Authors

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set(name colm)
set(source_dir ${CMAKE_CURRENT_BINARY_DIR}/${name}/source)
set(MEMKIND_PREFIX "")
ExternalProject_Add(
    ${name}
    URL https://github.com/adrian-thurston/colm/archive/refs/tags/0.14.7.tar.gz
    URL_HASH MD5=213a9ddf207c5732f04941852ca8db62
    TIMEOUT 120
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/${name}
    TMP_DIR ${BUILD_INFO_DIR}
    STAMP_DIR ${BUILD_INFO_DIR}
    DOWNLOAD_DIR ${DOWNLOAD_DIR}
    SOURCE_DIR ${source_dir}
    CONFIGURE_COMMAND
        ./autogen.sh
    COMMAND
        ${common_configure_envs}
		./configure --disable-manual ${common_configure_args}
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND make install
    LOG_CONFIGURE TRUE
    LOG_BUILD TRUE
    LOG_INSTALL TRUE
    DOWNLOAD_NO_PROGRESS 1
)

ExternalProject_Add_Step(${name} clean
    EXCLUDE_FROM_MAIN TRUE
    ALWAYS TRUE
    DEPENDEES configure
    COMMAND make clean -j
    COMMAND rm -f ${BUILD_INFO_DIR}/${name}-build
    WORKING_DIRECTORY ${source_dir}
)

ExternalProject_Add_StepTargets(${name} clean)
