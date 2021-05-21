KPL/MK

   This meta-kernel lists a subset of kernels from the meta-kernel
   cas_2000_v24.tm provided in the CO-S/J/E/V-SPICE-6-V1.0 SPICE PDS3 archive,
   covering the whole or a part of the customer requested time period
   from 2000-11-01T02:44:02.847 to 2000-11-01T02:44:03.167.

   The documentation describing these kernels can be found in the
   complete CO-S/J/E/V-SPICE-6-V1.0 SPICE PDS3 archive available at this URL

   https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000

   To use this meta-kernel users may need to modify the value of the
   PATH_VALUES keyword to point to the actual location of the archive's
   ``data'' directory on their system. Replacing ``/'' with ``\''
   and converting line terminators to the format native to the user's
   system may also be required if this meta-kernel is to be used on a
   non-UNIX workstation.

   This meta-kernel was created by the NAIF node's SPICE PDS archive
   subsetting service version 2.1 on Thu May 20 04:49:30 PDT 2021.

 
   \begindata
 
      PATH_VALUES     = (
                         './data'
                        )
 
      PATH_SYMBOLS    = (
                         'KERNELS'
                        )
 
      KERNELS_TO_LOAD = (
                         '$KERNELS/lsk/naif0012.tls'
                         '$KERNELS/pck/pck00010.tpc'
                         '$KERNELS/fk/cas_rocks_v18.tf'
                         '$KERNELS/fk/cas_mimi_v202.tf'
                         '$KERNELS/fk/cas_dyn_v03.tf'
                         '$KERNELS/fk/cas_v41.tf'
                         '$KERNELS/ik/cas_caps_v03.ti'
                         '$KERNELS/ik/cas_cda_v01.ti'
                         '$KERNELS/ik/cas_cirs_v09.ti'
                         '$KERNELS/ik/cas_inms_v02.ti'
                         '$KERNELS/ik/cas_iss_v10.ti'
                         '$KERNELS/ik/cas_mag_v01.ti'
                         '$KERNELS/ik/cas_mimi_v11.ti'
                         '$KERNELS/ik/cas_radar_v11.ti'
                         '$KERNELS/ik/cas_rpws_v01.ti'
                         '$KERNELS/ik/cas_rss_v03.ti'
                         '$KERNELS/ik/cas_sru_v02.ti'
                         '$KERNELS/ik/cas_uvis_v06.ti'
                         '$KERNELS/ik/cas_vims_v06.ti'
                         '$KERNELS/sclk/cas00172.tsc'
                         '$KERNELS/spk/180927AP_RE_90165_18018.bsp'
                         '$KERNELS/spk/140809BP_IRRE_00256_25017.bsp'
                         '$KERNELS/spk/sat359_97288_04003.bsp'
                         '$KERNELS/spk/co_1999312_01066_o_cru_v1.bsp'
                         '$KERNELS/ck/00275_01001rc.bc'
                         '$KERNELS/ck/cas_cda_20070309.bc'
                         '$KERNELS/ck/cas_lemms_00306_00335_v2.bc'
                        )
 
   \begintext
 

