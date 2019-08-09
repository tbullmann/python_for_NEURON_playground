TITLE Axonal voltage-gated potassium currentCOMMENT2 H gates

steeper inact 02

/Users/hallermann/Desktop/D/Projekte/on going/Kv1/C++/sim 27 mac M/Start3 M8 steeper inact 02/
ENDCOMMENTNEURON {	SUFFIX Kv1	USEION k READ ek WRITE ik	RANGE gkv1, ikv1, gbar	GLOBAL ninf, ntau	GLOBAL h1inf, h1tau	GLOBAL h2inf, h2tau	GLOBAL h3inf, h3tau, speed}UNITS {	(mV) = (millivolt)	(mA) = (milliamp)	(nA) = (nanoamp)	(pA) = (picoamp)	(S)  = (siemens)	(nS) = (nanosiemens)	(pS) = (picosiemens)	(um) = (micron)	(molar) = (1/liter)	(mM) = (millimolar)		}CONSTANT {:	ek = -98 (mV)	a1 = 35.914	:48.02279	a2 = 56.081	:42.662	b1 = 57.811	:58.44509	c1 = 11.846	:13.44182	c2 = 43.484	:49.38797

	ppow = 4	a1H1 = 0.347e-03	:1.300293e-03	a2H1 = 12.4	:6.247311	b2H1 = 61.1	:66.13843	c1H1 = 7.28	:8.611435	c2H1 = 2.76	:7.948768	a12H2fact = 1.60e-02	:1.554639e-02	propH2 = 0.82	:0.73157	sToMs = 0.001}PARAMETER {	v (mV):	celsius (degC)	vShift = 0	vShift_inact = 0
	gbar = 11 (pS/um2)   <0,1e9>
	speed = 1}ASSIGNED { 	ik (mA/cm2)  	ikv1 (mA/cm2) 	gkv1  (mho/cm2)	ek (mV)	ninf	ntau (ms)	nalpha (1/ms)	nbeta (1/ms)	h1inf	h1tau (ms)	h1alpha (1/ms)	h1beta (1/ms)	h2inf	h2tau (ms)	h2alpha (1/ms)	h2beta (1/ms)	h3inf	h3tau (ms)	h3alpha (1/ms)	h3beta (1/ms):	qt}STATE { 	n	h1	h2}INITIAL {:	qt = q10^((celsius-22 (degC))/10 (degC))	rates(v)	n = ninf	h1 = h1inf	h2 = h2inf}BREAKPOINT {	SOLVE states METHOD cnexp      	gkv1 = gbar * ( (1-propH2)*n^ppow*h1 + propH2*n^ppow*h2 )	ikv1 = (1e-4)*gkv1 * (v - ek)
	ik = ikv1}DERIVATIVE states {	rates(v)	n' = (ninf-n)/ntau	h1' = (h1inf-h1)/h1tau 	h2' = (h2inf-h2)/h2tau }PROCEDURE rates(v (mV)) {	nalpha = nalphafkt(v-vShift)	nbeta = nbetafkt(v-vShift)	ninf = nalpha/(nalpha+nbeta) 	ntau = 1/(nalpha + nbeta)	h1alpha = h1alphafkt(v-vShift-vShift_inact)	h1beta = h1betafkt(v-vShift-vShift_inact)	h1inf = h1alpha/(h1alpha+h1beta) 	h1tau = 1/(h1alpha + h1beta)	h2alpha = h2alphafkt(v-vShift-vShift_inact)	h2beta = h2betafkt(v-vShift-vShift_inact)	h2inf = h2alpha/(h2alpha+h2beta) 	h2tau = 1/(h2alpha + h2beta)}FUNCTION nalphafkt(v (mV)) (1/ms) {	nalphafkt = speed * sToMs * a1*(-(v+b1))/( exp(-(v+b1)/c1) -1)}FUNCTION nbetafkt(v (mV)) (1/ms) {	nbetafkt = speed * sToMs * a2*exp(-(v)/c2)}FUNCTION h1alphafkt(v (mV)) (1/ms) {	h1alphafkt = sToMs * a1H1*exp(-(v)/c1H1)}FUNCTION h1betafkt(v (mV)) (1/ms) {	h1betafkt = sToMs * a2H1/(exp(-(v+b2H1)/c2H1)+1)}FUNCTION h2alphafkt(v (mV)) (1/ms) {	h2alphafkt = sToMs * a12H2fact*a1H1*exp(-(v)/c1H1)}FUNCTION h2betafkt(v (mV)) (1/ms) {	h2betafkt = sToMs * a12H2fact*a2H1/(exp(-(v+b2H1)/c2H1)+1)}