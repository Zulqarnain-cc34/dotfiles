#!/usr/bin/env sh

OLD_PWD="${OLDPWD}"
PACKAGE_DIR="${HOME}/kube-packages/$( date +%Y-%m-%d )"

mkdir -p "${PACKAGE_DIR}"

for p in kubectl-bin kubelet-bin kubeadm-bin cni-plugins-bin; do
    cd "${PACKAGE_DIR}"

    echo "> Fetching ${p} ..."
    curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/${p}.tar.gz
    tar zxvf ${p}.tar.gz

    cd "${PACKAGE_DIR}/${p}"
    echo "> Building ${p} ..."
    makepkg

    echo "> Installing ${p} ..."
    sudo pacman --noconfirm -U *.tar.zst
done

cd "${OLD_PWD}"
echo "> Done"
