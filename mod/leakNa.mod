TITLE passive Na+ leak current

UNITS {
	(mV) = (millivolt)
	(mA) = (milliamp)
	(S) = (siemens)
}

NEURON {
	SUFFIX leakNa
    USEION na READ ena WRITE ina
	RANGE g
}



PARAMETER {
	g = .001	(pS/um2)
}

ASSIGNED {
	v (mV)
	ina (mA/cm2)
	ena (mV)
}

BREAKPOINT {
	ina = g*(v - ena)*(1e-4) 	: define  g as pS/um2 instead of mllimho/cm2
}
