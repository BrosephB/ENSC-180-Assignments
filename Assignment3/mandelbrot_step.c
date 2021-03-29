#include <math.h>
#include "mex.h"
void mexFunction( 
        int nlhs, // Number of expected output mxArrays (left-hand side), 2
        mxArray *plhs[], // Array of pointers to the expected output mxArrays
		int nrhs, // Number of input mxArrays (right-hand side), 4
        const mxArray *prhs[] // Array of pointers to the input mxArrays. 
        )

/* function [z,kz] = mandelbrot_step(z,kz,z0,d);
 * Take one step of the Mandelbrot iteration.
 * Complex arithmetic:
 *    z = z.^2 + z0
 *    kz(abs(z) < 2) == d
 * Real arithmetic:
 *    x <-> real(z); --> z (and plhs[0]) is prhs[0] 
 *    y <-> imag(z); 
 *    u <-> real(z0); --> z0 is prhs[2]
 *    v <-> imag(z0);
 *    [x,y] = [x.^2-y.^2+u, 2*x.*y+v];
 *    kz(x.^2+y.^2 < 4) = d; --> kz (and plhs[1]) is prhs[1], d is prhs[3]
 */
     
{ 
    double *x,*y,*u,*v,t; 
    unsigned short *kz,d;
    int j,n; 
    
    x = mxGetPr(prhs[0]); // Pointer to the first element of the real data. 
    y = mxGetPi(prhs[0]); // Pointer to the first element of the imaginary data.
    
    // Pointer to the first element of the (real) data.
    kz = (unsigned short *) mxGetData(prhs[1]); 
    
    u = mxGetPr(prhs[2]); 
    v = mxGetPi(prhs[2]);
    
    // Real component of first data element in array as type double
    // Note we are casting to an unsigned short.
    d = (unsigned short) mxGetScalar(prhs[3]);
    
    plhs[0] = prhs[0]; // pointer to z is first thing returned
    plhs[1] = prhs[1]; // pointer to kz is second thing returned

    n = mxGetN(prhs[0]); // Number of columns in array z
    for (j=0; j<n*n; j++) {
        if (kz[j] == d-1) {
            t = x[j];
            x[j] = x[j]*x[j] - y[j]*y[j] + u[j];
            y[j] = 2*t*y[j] + v[j];
            if (x[j]*x[j] + y[j]*y[j] < 4) {
                kz[j] = d;
            }
        }
    }
    return;
}
