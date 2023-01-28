# add one directory above to path
import sys
sys.path.append("..")

# import other modules
import mitgcm_python
import MITgcmutils
from mitgcm_python.ics_obcs import *

# pressure load anomaly
# --- this seems to be very slow (it took about 2.5 hours on ARCHER2)
calc_load_anomaly('../../grid/', 
                  '../initial_conditions/pload_gyre', 
                  ini_temp_file='../initial_conditions/THETA_BSOSE.ini', 
                  ini_salt_file='../initial_conditions/SALT_BSOSE.ini', 
                  constant_t=-1.9, 
                  constant_s=34.4,
                  eosType='JMD95',
                  rhoConst=1035)
