#!/bin/sh

ARCH="$(uname -m)"

RED='\033[0;31m'
TERMINAL_WIDTH="${COLUMNS:-80}"
DIVIDING_LINE=$(printf '%*s' "$TERMINAL_WIDTH" '' | tr ' ' '-')

#busybox_utils=$(busybox --list | xargs)
#utils="7z file curl zsync $busybox_utils"
utils="7z \
ar \
base64 basename bzip2 \
chmod chown chroot clear column cp curl cut \
dd dirname \
echo \
file fold \
gawk grep \
head \
id \
kill killall \
less ln ls \
mawk md5sum mkdir more mount mv \
printf \
readlink realpath rev rm \
sed sh sha1sum sha256sum sha512sum sleep sort strace strings strip swapoff swapon \
tail tar tee test tput top touch tr tty \
umount uname uncompress uniq unshare unzip uptime \
watch wc wget which whoami \
xargs xz xzcat \
yes \
zcat zsync"

# --------------------- ONELF

_onelf() {
	if ! command -v onelf 1>/dev/null; then
		if [ ! -f ./onelf ]; then
			echo " Downloading onelf..." && curl -#Lo onelf https://github.com/QaidVoid/onelf/releases/download/0.2.5/onelf-"$ARCH"-linux && chmod a+x ./onelf || exit 1
		fi
		./onelf "$@"
	else
		onelf "$@"
	fi
}

_use_onelf() {
	mkdir -p am-bins
	_onelf bundle-libs bins/"$b" --from-binary "$binpath"
	_onelf pack bins/"$b" -o "$b".bin --command bin/"$b" --level 22
	mv "$b".bin am-bins/"$b"
}

# --------------------- QUICK-SHARUN

_quick_sharun() {
	if ! command -v quick-sharun 1>/dev/null; then
		if [ ! -f ./quick-sharun ]; then
			echo " Downloading quick-sharun..." && curl -#Lo quick-sharun https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh && chmod a+x ./quick-sharun || exit 1
		fi
		./quick-sharun "$@"
	else
		quick-sharun "$@"
	fi
}

_use_quick_sharun() {
	_quick_sharun --make-static-bin --dst-dir am-bins "$binpath"
}

# --------------------- SHARUN

_sharun() {
	if ! command -v sharun 1>/dev/null; then
		if [ ! -f ./sharun ]; then
			echo " Downloading sharun..." && curl -#Lo sharun https://github.com/VHSgunzo/sharun/releases/download/v0.8.1/sharun-"$ARCH" && chmod a+x ./sharun || exit 1
		fi
		./sharun "$@"
	else
		sharun "$@"
	fi
}

_use_sharun() {
	_sharun lib4bin --with-wrappe --dst-dir am-bins "$binpath"
}

# --------------------- RUN ONE BETWEEN ONELF AND SHARUN

for b in $utils; do
	name="$b"
	pkgname=$(dpkg -S "$(which "$b")" 2>/dev/null | awk -F':' '{print $1}' | head -1)
	pkgver=$(apt-cache show "$pkgname" 2>/dev/null | grep -i version | awk '{print $2}' | head -1 | tr ':' '\n' | tail -1)
	if [ -n "$pkgver" ]; then
		cmd_type="$(file "$(which "$b" | head -1)")"
		if echo "$cmd_type" | grep -q POSIX; then
			binpath=$(strace -f -e execve "$b" 2>&1 | grep execve | tr '" ' '\n' | grep "^/.*/$b$" | tail -1)
		else
			binpath=$(which "$b" | head -1)
		fi
		#_use_onelf
		_use_quick_sharun
		#_use_sharun
		cp ./am-bins/"$b" ./"$b"_"$pkgver"-"${ARCH}"-static || exit 1
		cp ./am-bins/"$b" ./"$b"-"${ARCH}"-static || exit 1
	else
		printf "%b%b\n\n 💀 ERROR: cannot create %b \n\n%b\033[0m" "${RED}" "$DIVIDING_LINE" "$bin" "$DIVIDING_LINE"
	fi
done

echo "Success!"
