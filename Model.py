from neuron import h, load_mechanisms
from nrnutils import Section, Mechanism 
from Morphology import AxonWithBoutons

# It is not possible to consistently get the path of a Jupyter notebook. But this may work most of the time.
# If not, paste the absolute path to the folder containing the mod files (not the compiled files)
import os
current_path = os.getcwd()
load_mechanisms(os.path.join(current_path, "mod"))

# Parameters 
myena = 55
myek = -97
nax_bouton = 1000 
nax_axon = 0
Kv1_bouton = 2000 
Kv1_axon = 0
leakK_bouton = 0.18 #.08
leakK_axon = leakK_bouton/10
leakNa_bouton = leakK_bouton/13
leakNa_axon = leakNa_bouton/10

# Global hoc variables
h.vShift_Kv1 = 25
h.vShift_inact_Kv1 = -15
h.speed_Kv1 = 2.3
h.vShift_nax = 20
h.vShift_inact_nax = 10
h.q10_nax = 4
h.q10h_nax = 4


def without_ih():
    # Model with standard potassium und sodium currents
    
    model = AxonWithBoutons(axon_mechanisms  =[Mechanism('nax', gbar = nax_axon),
                                               Mechanism('Kv1', gbar = Kv1_axon),
                                               Mechanism('leakNa', g = leakNa_axon),
                                               Mechanism('leakK', g = leakK_axon),],
                            bouton_mechanisms=[Mechanism('nax', gbar = nax_bouton),
                                               Mechanism('Kv1', gbar = Kv1_bouton),
                                               Mechanism('leakNa', g = leakNa_bouton),
                                               Mechanism('leakK', g = leakK_bouton),],
                            all_ena=myena, all_ek=myek
                                      )    
    return model


def with_ih():
    # Model with ih current
    
    pass


def with_ih_cAMP():
    # Model with ih current increased by cAMP

    pass


def only_input():
    # Effect of low membrane resistance only

    pass


def only_depol():
    # Effect of depolarized membrane potential only

    pass
