#!/bin/sh

# Old distro
podman cp static-binaries-x86_64.zip  am-jessie-test:/opt/.
podman cp prep.sh am-jessie-test:/root/regress/.
podman cp test.sh am-jessie-test:/root/regress/.
podman cp am-jessie-test:/root/regress/binary_test.log binary_test-x86-64.log

# Musl distro
podman cp static-binaries-x86_64.zip  am-alpine-test:/opt/.
podman cp prep.sh am-alpine-test:/root/regress/.
podman cp test.sh am-alpine-test:/root/regress/.
podman cp am-alpine-test:/root/regress/binary_test.log binary_test-musl.log

# Musl aarch64 distro
podman cp static-binaries-aarch64.zip am-alpine-arm64-test:/opt/.
podman cp prep.sh am-alpine-arm64-test:/root/regress/.
podman cp test.sh am-alpine-arm64-test:/root/regress/.
podman cp am-alpine-arm64-test:/root/regress/binary_test.log binary_test-aarch64.log

