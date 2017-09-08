mbed-builder
====

command line builder for mbed 

usage
----
`projects/build.sh` acts as compiler!

```bash
K_atc% ./projects/build.sh 
usage: ./projects/build.sh SOURCE_DIR TARGET_BARD [MOUNT_POINT]
usage: ./projects/build.sh clean
TARGET_BARD = DISCO_F746NG, NUCLEO_L152RE, RZ_A1H (GR-PEAH),  ...
MOUNT_POINT = /media/mbed
```

### sample usage

```bash
cd projects
./build.sh test-gr-peach RZ_A1H
```

binary locates in `DIR/bin`:

```
K_atc% file test-gr-peach/build/test-gr-peach.{bin,elf}
test-gr-peach/build/test-gr-peach.bin: data
test-gr-peach/build/test-gr-peach.elf: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped
```
