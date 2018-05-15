```bash
# detect serial ports
$ dmesg | grep tty
[    0.660749] 00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.681575] 00:08: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A

# run script and verify tx.log and rx.log are identical
$ sudo ./serial-test.sh /dev/ttyS0 /dev/ttyS1 115200
```
