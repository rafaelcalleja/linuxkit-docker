default: start

start:
	sudo linuxkit run qemu -disk size=4096M -arch x86_64 -disk size=4096M -publish 2376:2376 -publish 2222:22 -fw /usr/share/ovmf/OVMF.fd -data-file ./metadata.json -iso -uefi docker-efi.iso

start-mac:
	linuxkit run hyperkit -networking=vpnkit -vsock-ports=2376 -disk size=4096M -data-file ./metadata.json -iso -uefi docker-for-mac-efi.iso

build:
	linuxkit build -format iso-efi docker.yml

build-mac:
	linuxkit build -format iso-efi docker-for-mac.yml

docker-use:
	@docker context create linuxkit --docker "host=tcp://127.0.0.1:2376" || true
	@docker context use linuxkit

docker-stop:
	@docker context use default
