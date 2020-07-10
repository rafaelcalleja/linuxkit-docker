# linuxkit-docker
sudo apt install qemu-system-x86 ovmf

sudo /usr/bin/qemu-system-x86_64 -smp 1 -m 1024 -uuid ed0fa469-5b5f-4d38-9db7-805e62f9aa21 -pidfile vpnkit-forwarder-efi-state/qemu.pid -machine q35,accel=kvm:tcg -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -boot d -cdrom docker-efi.iso -drive if=pflash,format=raw,file=/usr/share/ovmf/OVMF.fd -device virtio-net-pci,netdev=t0,mac=62:ce:22:a0:60:54 -netdev user,id=t0,hostfwd=tcp::2222-:22 -nographic -fsdev local,security_model=passthrough,id=fsdev0,path=/home/$USER/ -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare

/usr/bin/qemu-system-x86_64 -smp 1 -m 1024 -uuid 7f632caf-f2dd-48c2-8852-65712d584f92 -pidfile docker-efi-state/qemu.pid -machine q35,accel=kvm:tcg -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -drive file=docker-efi-state/disk.img,format=qcow2,index=0,media=disk -boot d -cdrom docker-efi.iso -drive file=docker-efi-state/data.iso,index=3,media=cdrom -drive if=pflash,format=raw,file=/usr/share/ovmf/OVMF.fd -device virtio-net-pci,netdev=t0,mac=6a:69:29:68:df:98 -netdev user,id=t0,hostfwd=tcp::2376-:2376 -nographic -fsdev local,security_model=passthrough,id=fsdev0,path=/home/$USER/ -device virtio-9p-pci,id=fs0,fsdev=fsdev0,mount_tag=hostshare

ctr -n services.linuxkit task exec --tty --exec-id sh docker /bin/sh -l