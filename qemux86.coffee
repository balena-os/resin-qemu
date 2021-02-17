deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

QEMU_RUNNING_INSTRUCTIONS = '''
	Run the following to start the image:
	<br>
	On systems with KVM support:
	<br>
	<code>qemu-system-i386 -drive file=resin-image-qemux86.img,media=disk,cache=none,format=raw -net nic,model=virtio -net user -m 512 -nographic -machine type=pc,accel=kvm -smp 4 -cpu host</code>
	<br>
	On systems without KVM support:
	<br>
	<code>qemu-system-i386 -drive file=resin-image-qemux86.img,media=disk,cache=none,format=raw -net nic,model=virtio -net user -m 512 -nographic -machine type=pc -smp 4</code>
	<br>
	Tweak <code>-smp</code> and <code>-cpu</code> parameters based on the CPU of the machine qemu is running on. <code>-cpu</code> parameter needs to be dropped on OSX and Windows.
	<br>
	Tweak <code>-nographic</code> and <code>-m 512</code> to set the display of qemu and memory respectively.

'''

module.exports =
	version: 1
	slug: 'qemux86'
	name: 'QEMU X86 32bit'
	arch: 'i386'
	state: 'released'

	instructions: [
		QEMU_RUNNING_INSTRUCTIONS
	]
	gettingStartedLink:
		windows: 'https://www.balena.io/docs/learn/getting-started/qemux86/nodejs/'
		osx: 'https://www.balena.io/docs/learn/getting-started/qemux86/nodejs/'
		linux: 'https://www.balena.io/docs/learn/getting-started/qemux86/nodejs/'
	supportsBlink: true

	yocto:
		machine: 'qemux86'
		image: 'resin-image'
		fstype: 'resinos-img'
		version: 'yocto-dunfell'
		deployArtifact: 'resin-image-qemux86.resinos-img'
		compressed: true


	configuration:
		config:
			partition:
				primary: 1
			path: '/config.json'

	initialization: commonImg.initialization
