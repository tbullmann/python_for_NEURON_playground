from neuron import h 
from nrnutils import Section      

class AxonWithBoutons(object):
        
    def __init__(self, axNum=15, axon_mechanisms=list(), bouton_mechanisms=list(), all_ena=55, all_ek=-97):
        
        self.axNum = axNum
        
        #See comment below on measuring the total ion currents
        #if add_charge:
        #    axon_mechanisms.append(Mechanism("charge_", tmin=charge_start, tmax=charge_end))   
        #    bouton_mechanisms.append(Mechanism("charge_", tmin=charge_start, tmax=charge_end))   
        
        # Define axon
        self.axons = [Section(nseg = 5 if i < axNum else 20, 
                              L = 35 if i < axNum else 150, 
                              diam = 0.8, 
                              cm = 0.9/10,
                              mechanisms=axon_mechanisms)
                 for i in range(axNum+1)]
        
        self.boutons = [Section(nseg=1,
                                L=8,
                                diam=8,
                                cm=0.9,
                                mechanisms=bouton_mechanisms)
                 for i in range(axNum)]

        # Connectivity
        for axon, bouton in zip(self.axons, self.boutons):
            bouton.connect(axon)       # connect bouton 0-end to preceeding axon 1-end
        for bouton, axon in zip(self.boutons, self.axons[1:]):
            axon.connect(bouton(1),0)  # connect axon 0-end to preceeding bouton 1-end

        # Someting for all
        h.celsius = 37   
        h.Ra = 120
        for section in h.allsec():
            section.ena = all_ena
            section.ek = all_ek


           