from neuron import h, load_mechanisms
from nrnutils import Section, Mechanism 
from Morphology import AxonWithBoutons

# It is not possible to consistently get the path of a Jupyter notebook. But this may work most of the time.
# If not, paste the absolute path to the folder containing the mod files (not the compiled files)
import os
current_path = os.getcwd()
load_mechanisms(os.path.join(current_path, "mod"))


def without_ih():
    
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
    
    # Instantiate model
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
    
    # Global hoc variables
    h.vShift_Kv1 = 25
    h.vShift_inact_Kv1 = -15
    h.speed_Kv1 = 2.3
    h.vShift_nax = 20
    h.vShift_inact_nax = 10
    h.q10_nax = 4
    h.q10h_nax = 4
    
    return model


