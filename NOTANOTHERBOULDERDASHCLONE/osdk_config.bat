@ECHO ON
 
echo osdk_config.bat
::
:: Set the build paremeters
::

::
::
::%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SET OSDKNAME=notanotherboulderdashclone
SET OSDKFILE=buldashoric buldashoric_data buldashoric_music buldashoric_fonts buldashoric_sprites buldashoric_routines buldashoric_routines2 buldashoric_routines3
::        
SET OSDKADDR=$800
SET OSDKBRIEF=""
::%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

::set OSDKNAME=testay
::set OSDKFILE=test_ay

::set OSDKNAME=magicstripes
::set OSDKFILE=  magicstripes  magicstripes_asm magicstripes_routines2

::set OSDKNAME=horse
::set OSDKFILE=horse main_horse

:: SET OSDKNAME=aysequencer
 ::SET OSDKFILE=ayseq_main ayseq_asm ayseq_asm2 keyboard

::SET OSDKNAME=pixelmove
::SET OSDKFILE=pixelmove_main pixelmove

:: SET OSDKNAME=scroll_lookup
:: SET OSDKFILE=scroll_lookup scroll_lookup_main   


::SET OSDKNAME=fastclr
::SET OSDKFILE=fastclr fastclr_main 	 
	


::SET OSDKNAME=fastfixedpoint
::SET OSDKFILE=main_ffp 


:: SET OSDKNAME=parti
:: SET OSDKFILE=main_parti parti




:: SERIAL MODEM DECOMPRESSION + IMAGE TRANSFERT 
::SET OSDKNAME=compression
::SET OSDKFILE=serial_asm main_compression asm_dec2 futurafont  
::SET OSDKNAME=serialsoft
::SET OSDKFILE=softserial main_softserial
 


 SET OSDKCOMP=-O3
::SET OSDKADDR=$1000
::SET OSDKNAME=ORIC_SPI
::SET OSDKFILE= oric_spi main_oric_spi 

  ::  SET OSDKADDR=$a000
  :: SET OSDKLINK=-B
  ::  SET OSDKNAME=SPI_LOAD
 ::  SET OSDKFILE=    oric_spi_load 
 