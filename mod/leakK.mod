TITLE passive K+ leak current

UNITS {
	(mV) = (millivolt)
	(mA) = (milliamp)
	(S) = (siemens)
}

NEURON {
	SUFFIX leakK
 	USEION k READ ek WRITE ik
	RANGE g
}



PARAMETER {
	g = .001	(pS/um2)
	
}

ASSIGNED {
	v (mV)
	ik (mA/cm2)
	ek (mV)
}

BREAKPOINT {
	ik = g*(v - ek)*(1e-4) 	: define  g as pS/um2 instead of mllimho/cm2
}
