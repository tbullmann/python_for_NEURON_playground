TITLE Ih-current

COMMENT

Author: Stefan Hallermann 

Axonal Ih-currents as described in Byczkowicz et al. (2018; 37°C; cerebellar mossy fiber boutons of mice)
	
ENDCOMMENT

NEURON {
	SUFFIX ih_cAMP
 	USEION k READ ek WRITE ik
	USEION na READ ena WRITE ina
	RANGE ghdbar
}


UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(mM) = (milli/liter)

}

PARAMETER {
	v (mV)
	k_na_ratio = 0.5  			(mV) 		:ih-reversal potential			       
	ghdbar	 		(S/cm2)	: Ih conductance; 
}

STATE {
	qq
}

ASSIGNED {
	ik (mA/cm2)
	ek (mV)
	ina (mA/cm2)
	ena (mV)
}

INITIAL {
	qq=alpha(v)/(beta(v)+alpha(v))
}

BREAKPOINT {
	SOLVE state METHOD cnexp
	ina = (1-k_na_ratio)*ghdbar*qq*(v-ena)
	ik = k_na_ratio*ghdbar*qq*(v-ek)
}

FUNCTION alpha(v(mV)) {
	alpha = 0.001*7.5700403*exp(-(v+87.3143662)/31.463876646)			: (1/ms) parameters are estimated by direct fitting of HH model to activation time constants and voltage actication curve recorded at 37C
}

FUNCTION beta(v(mV)) {
	beta = 0.001*7.5700403*exp((v+87.3143662)/10.84065548)			
}

DERIVATIVE state {
	qq' = (1-qq)*alpha(v) - qq*beta(v)
}
