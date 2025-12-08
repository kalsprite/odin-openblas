package f77

import "core:c"

when ODIN_OS == .Windows {
	foreign import lib "../../vendor/linalg/windows-x64/lib/openblas64.lib"
} else when ODIN_OS == .Linux {
	// Use ILP64 version of OpenBLAS (64-bit integers)
	foreign import lib "system:openblas64"
}

// F77BLAS_H ::

/*Set the threading backend to a custom callback.*/
openblas_dojob_callback :: proc "c" (job_id: c.int, data: rawptr, thread_id: c.int)

openblas_threads_callback :: proc "c" (num_threads: c.int, job_func: openblas_dojob_callback, num_jobs: c.int, data_size: c.size_t, data: rawptr, thread_id: c.int)

// NOTE: you _must_ use cstring for blas ops; the f77 lapack apis have the length param, but blas do not

@(default_calling_convention = "c", link_prefix = "")
foreign lib {
	xerbla_ :: proc(srname: cstring, info: ^Info, len: blasint) -> c.int ---
	openblas_set_num_threads_ :: proc(num_threads: ^c.int) ---
	sdot_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) -> f32 ---
	sdsdot_ :: proc(n: ^blasint, sb: ^f32, sx: [^]f32, incx: ^blasint, sy: [^]f32, incy: ^blasint) -> f32 ---
	dsdot_ :: proc(n: ^blasint, sx: [^]f32, incx: ^blasint, sy: [^]f32, incy: ^blasint) -> f64 ---
	ddot_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) -> f64 ---
	qdot_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) -> f64 ---
	sbdot_ :: proc(n: ^blasint, x: [^]bfloat16, incx: ^blasint, y: [^]bfloat16, incy: ^blasint) -> f32 ---
	sbstobf16_ :: proc(n: ^blasint, src: [^]f32, incx: ^blasint, dst: [^]bfloat16, incy: ^blasint) ---
	sbdtobf16_ :: proc(n: ^blasint, src: [^]f64, incx: ^blasint, dst: [^]bfloat16, incy: ^blasint) ---
	sbf16tos_ :: proc(n: ^blasint, src: [^]bfloat16, incx: ^blasint, dst: [^]f32, incy: ^blasint) ---
	dbf16tod_ :: proc(n: ^blasint, src: [^]bfloat16, incx: ^blasint, dst: [^]f64, incy: ^blasint) ---
	cdotu_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) -> openblas_complex_float ---
	cdotc_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) -> openblas_complex_float ---
	zdotu_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) -> openblas_complex_double ---
	zdotc_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) -> openblas_complex_double ---
	xdotu_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) -> openblas_complex_xdouble ---
	xdotc_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) -> openblas_complex_xdouble ---
	saxpy_ :: proc(n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) ---
	daxpy_ :: proc(n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	qaxpy_ :: proc(n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	caxpy_ :: proc(n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) ---
	zaxpy_ :: proc(n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	xaxpy_ :: proc(n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	caxpyc_ :: proc(n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) ---
	zaxpyc_ :: proc(n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	xaxpyc_ :: proc(n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	scopy_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) ---
	dcopy_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	qcopy_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	ccopy_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) ---
	zcopy_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	xcopy_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	sswap_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) ---
	dswap_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	qswap_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	cswap_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint) ---
	zswap_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	xswap_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint) ---
	sasum_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	scasum_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dasum_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qasum_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	dzasum_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qxasum_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	ssum_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	scsum_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dsum_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qsum_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	dzsum_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qxsum_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	isamax_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> blasint ---
	idamax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	iqamax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	icamax_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> blasint ---
	izamax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	ixamax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	ismax_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> blasint ---
	idmax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	iqmax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	icmax_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> blasint ---
	izmax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	ixmax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	isamin_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> blasint ---
	idamin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	iqamin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	icamin_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> blasint ---
	izamin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	ixamin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	ismin_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> blasint ---
	idmin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	iqmin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	icmin_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> blasint ---
	izmin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	ixmin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> blasint ---
	samax_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	damax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qamax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	scamax_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dzamax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qxamax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	samin_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	damin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qamin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	scamin_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dzamin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qxamin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	smax_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dmax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qmax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	scmax_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dzmax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qxmax_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	smin_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dmin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qmin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	scmin_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dzmin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qxmin_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	sscal_ :: proc(n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint) ---
	dscal_ :: proc(n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint) ---
	qscal_ :: proc(n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint) ---
	cscal_ :: proc(n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint) ---
	zscal_ :: proc(n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint) ---
	xscal_ :: proc(n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint) ---
	csscal_ :: proc(n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint) ---
	zdscal_ :: proc(n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint) ---
	xqscal_ :: proc(n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint) ---
	snrm2_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	scnrm2_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint) -> f32 ---
	dnrm2_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qnrm2_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	dznrm2_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	qxnrm2_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint) -> f64 ---
	srot_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, c: ^f32, s: ^f32) ---
	drot_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, c: ^f64, s: ^f64) ---
	qrot_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, c: ^f64, s: ^f64) ---
	csrot_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, c: ^f32, s: ^f32) ---
	zdrot_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, c: ^f64, s: ^f64) ---
	xqrot_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, c: ^f64, s: ^f64) ---
	srotg_ :: proc(a: ^f32, b: ^f32, c: ^f32, s: ^f32) ---
	drotg_ :: proc(a: ^f64, b: ^f64, c: ^f64, s: ^f64) ---
	qrotg_ :: proc(a: ^f64, b: ^f64, c: ^f64, s: ^f64) ---
	crotg_ :: proc(a: [^]f32, b: [^]f32, c: ^f32, s: [^]f32) ---
	zrotg_ :: proc(a: [^]f64, b: [^]f64, c: ^f64, s: [^]f64) ---
	xrotg_ :: proc(a: [^]f64, b: [^]f64, c: ^f64, s: [^]f64) ---
	srotmg_ :: proc(d1: ^f32, d2: ^f32, x1: ^f32, y1: ^f32, param: [^]f32) ---
	drotmg_ :: proc(d1: ^f64, d2: ^f64, x1: ^f64, y1: ^f64, param: [^]f64) ---
	srotm_ :: proc(n: ^blasint, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, param: [^]f32) ---
	drotm_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, param: [^]f64) ---
	qrotm_ :: proc(n: ^blasint, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, param: [^]f64) ---

	/* Level 2 routines */
	sger_ :: proc(m: ^blasint, n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, A: [^]f32, lda: ^blasint) ---
	dger_ :: proc(m: ^blasint, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	qger_ :: proc(m: ^blasint, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	cgeru_ :: proc(m: ^blasint, n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, A: [^]f32, lda: ^blasint) ---
	cgerc_ :: proc(m: ^blasint, n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, A: [^]f32, lda: ^blasint) ---
	zgeru_ :: proc(m: ^blasint, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	zgerc_ :: proc(m: ^blasint, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	xgeru_ :: proc(m: ^blasint, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	xgerc_ :: proc(m: ^blasint, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	sbgemv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]bfloat16, lda: ^blasint, x: [^]bfloat16, incx: ^blasint, beta: ^f32, y: [^]f32, incy: ^blasint) ---
	sgemv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: ^f32, y: [^]f32, incy: ^blasint) ---
	dgemv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	qgemv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	cgemv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: [^]f32, y: [^]f32, incy: ^blasint) ---
	zgemv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	xgemv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	strsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint) ---
	dtrsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	qtrsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	ctrsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint) ---
	ztrsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	xtrsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	strmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint) ---
	dtrmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	qtrmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	ctrmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint) ---
	ztrmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	xtrmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	stpsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f32, x: [^]f32, incx: ^blasint) ---
	dtpsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f64, x: [^]f64, incx: ^blasint) ---
	qtpsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f64, x: [^]f64, incx: ^blasint) ---
	ctpsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f32, x: [^]f32, incx: ^blasint) ---
	ztpsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f64, x: [^]f64, incx: ^blasint) ---
	xtpsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f64, x: [^]f64, incx: ^blasint) ---
	stpmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f32, x: [^]f32, incx: ^blasint) ---
	dtpmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f64, x: [^]f64, incx: ^blasint) ---
	qtpmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f64, x: [^]f64, incx: ^blasint) ---
	ctpmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f32, x: [^]f32, incx: ^blasint) ---
	ztpmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f64, x: [^]f64, incx: ^blasint) ---
	xtpmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, Ap: [^]f64, x: [^]f64, incx: ^blasint) ---
	stbmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint) ---
	dtbmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	qtbmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	ctbmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint) ---
	ztbmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	xtbmv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	stbsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint) ---
	dtbsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	qtbsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	ctbsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint) ---
	ztbsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	xtbsv_ :: proc(uplo: ^u8, trans: ^u8, diag: ^u8, n: ^blasint, k: ^blasint, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint) ---
	ssymv_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: ^f32, y: [^]f32, incy: ^blasint) ---
	dsymv_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	qsymv_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	csymv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: [^]f32, y: [^]f32, incy: ^blasint) ---
	zsymv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	xsymv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	sspmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f32, Ap: [^]f32, x: [^]f32, incx: ^blasint, beta: ^f32, y: [^]f32, incy: ^blasint) ---
	dspmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, Ap: [^]f64, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	qspmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, Ap: [^]f64, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	cspmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, Ap: [^]f32, x: [^]f32, incx: ^blasint, beta: [^]f32, y: [^]f32, incy: ^blasint) ---
	zspmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, Ap: [^]f64, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	xspmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, Ap: [^]f64, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	ssyr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, A: [^]f32, lda: ^blasint) ---
	dsyr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, A: [^]f64, lda: ^blasint) ---
	qsyr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, A: [^]f64, lda: ^blasint) ---
	csyr_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, A: [^]f32, lda: ^blasint) ---
	zsyr_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, A: [^]f64, lda: ^blasint) ---
	xsyr_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, A: [^]f64, lda: ^blasint) ---
	ssyr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, A: [^]f32, lda: ^blasint) ---
	dsyr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	qsyr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	csyr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, A: [^]f32, lda: ^blasint) ---
	zsyr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	xsyr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	sspr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, Ap: [^]f32) ---
	dspr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, Ap: [^]f64) ---
	qspr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, Ap: [^]f64) ---
	cspr_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, Ap: [^]f32) ---
	zspr_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, Ap: [^]f64) ---
	xspr_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, Ap: [^]f64) ---
	sspr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, Ap: [^]f32) ---
	dspr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, Ap: [^]f64) ---
	qspr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, Ap: [^]f64) ---
	cspr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, Ap: [^]f32) ---
	zspr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, Ap: [^]f64) ---
	xspr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, Ap: [^]f64) ---
	cher_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, A: [^]f32, lda: ^blasint) ---
	zher_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, A: [^]f64, lda: ^blasint) ---
	xher_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, A: [^]f64, lda: ^blasint) ---
	chpr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, Ap: [^]f32) ---
	zhpr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, Ap: [^]f64) ---
	xhpr_ :: proc(uplo: ^u8, n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, Ap: [^]f64) ---
	cher2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, A: [^]f32, lda: ^blasint) ---
	zher2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	xher2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, A: [^]f64, lda: ^blasint) ---
	chpr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, x: [^]f32, incx: ^blasint, y: [^]f32, incy: ^blasint, Ap: [^]f32) ---
	zhpr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, Ap: [^]f64) ---
	xhpr2_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, x: [^]f64, incx: ^blasint, y: [^]f64, incy: ^blasint, Ap: [^]f64) ---
	chemv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: [^]f32, y: [^]f32, incy: ^blasint) ---
	zhemv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	xhemv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	chpmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f32, Ap: [^]f32, x: [^]f32, incx: ^blasint, beta: [^]f32, y: [^]f32, incy: ^blasint) ---
	zhpmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, Ap: [^]f64, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	xhpmv_ :: proc(uplo: ^u8, n: ^blasint, alpha: [^]f64, Ap: [^]f64, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	snorm_ :: proc(norm: ^u8, m: ^blasint, n: ^blasint, A: [^]f32, lda: ^blasint) -> c.int ---
	dnorm_ :: proc(norm: ^u8, m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint) -> c.int ---
	cnorm_ :: proc(norm: ^u8, m: ^blasint, n: ^blasint, A: [^]f32, lda: ^blasint) -> c.int ---
	znorm_ :: proc(norm: ^u8, m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint) -> c.int ---
	sgbmv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, kl: ^blasint, ku: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: ^f32, y: [^]f32, incy: ^blasint) ---
	dgbmv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, kl: ^blasint, ku: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	qgbmv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, kl: ^blasint, ku: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	cgbmv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, kl: ^blasint, ku: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: [^]f32, y: [^]f32, incy: ^blasint) ---
	zgbmv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, kl: ^blasint, ku: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	xgbmv_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, kl: ^blasint, ku: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	ssbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: ^f32, y: [^]f32, incy: ^blasint) ---
	dsbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	qsbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	csbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: [^]f32, y: [^]f32, incy: ^blasint) ---
	zsbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	xsbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	chbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, x: [^]f32, incx: ^blasint, beta: [^]f32, y: [^]f32, incy: ^blasint) ---
	zhbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---
	xhbmv_ :: proc(uplo: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, x: [^]f64, incx: ^blasint, beta: [^]f64, y: [^]f64, incy: ^blasint) ---

	/* Level 3 routines */
	sbgemm_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: ^f32, A: [^]bfloat16, lda: ^blasint, B: [^]bfloat16, ldb: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	sgemm_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	dgemm_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	qgemm_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	cgemm_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zgemm_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	xgemm_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	cgemm3m_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zgemm3m_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	xgemm3m_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	sgemmt_ :: proc(uplo: ^u8, transa: ^u8, transb: ^u8, n: ^blasint, k: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	dgemmt_ :: proc(uplo: ^u8, transa: ^u8, transb: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	cgemmt_ :: proc(uplo: ^u8, transa: ^u8, transb: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zgemmt_ :: proc(uplo: ^u8, transa: ^u8, transb: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	sge2mm_ :: proc(transa: ^u8, transb: ^u8, transc: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) -> c.int ---
	dge2mm_ :: proc(transa: ^u8, transb: ^u8, transc: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) -> c.int ---
	cge2mm_ :: proc(transa: ^u8, transb: ^u8, transc: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) -> c.int ---
	zge2mm_ :: proc(transa: ^u8, transb: ^u8, transc: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) -> c.int ---
	strsm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint) ---
	dtrsm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	qtrsm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	ctrsm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint) ---
	ztrsm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	xtrsm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	strmm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint) ---
	dtrmm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	qtrmm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	ctrmm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint) ---
	ztrmm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	xtrmm_ :: proc(side: ^u8, uplo: ^u8, transa: ^u8, diag: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	ssymm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	dsymm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	qsymm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	csymm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zsymm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	xsymm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	csymm3m_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zsymm3m_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	xsymm3m_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	ssyrk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	dsyrk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	qsyrk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	csyrk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zsyrk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	xsyrk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	ssyr2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	dsyr2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	qsyr2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	csyr2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zsyr2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	xsyr2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	chemm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zhemm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	xhemm_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	chemm3m_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zhemm3m_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	xhemm3m_ :: proc(side: ^u8, uplo: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	cherk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	zherk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	xherk_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	cher2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	zher2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	xher2k_ :: proc(uplo: ^u8, trans: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
	cher2m_ :: proc(uplo: ^u8, transa: ^u8, transb: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) -> c.int ---
	zher2m_ :: proc(uplo: ^u8, transa: ^u8, transb: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) -> c.int ---
	xher2m_ :: proc(uplo: ^u8, transa: ^u8, transb: ^u8, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) -> c.int ---
	sgemt_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint) -> c.int ---
	dgemt_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) -> c.int ---
	cgemt_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint) -> c.int ---
	zgemt_ :: proc(trans: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) -> c.int ---
	sgema_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, beta: ^f32, C: [^]f32, ldc: ^blasint) -> c.int ---
	dgema_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, beta: ^f64, C: [^]f64, ldc: ^blasint) -> c.int ---
	cgema_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, beta: [^]f32, C: [^]f32, ldc: ^blasint) -> c.int ---
	zgema_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, beta: [^]f64, C: [^]f64, ldc: ^blasint) -> c.int ---
	sgems_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, beta: ^f32, C: [^]f32, ldc: ^blasint) -> c.int ---
	dgems_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, beta: ^f64, C: [^]f64, ldc: ^blasint) -> c.int ---
	cgems_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, beta: [^]f32, C: [^]f32, ldc: ^blasint) -> c.int ---
	zgems_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, beta: [^]f64, C: [^]f64, ldc: ^blasint) -> c.int ---
	sgemc_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, C: [^]f32, ldc: ^blasint, beta: ^f32, D: [^]f32, ldd: ^blasint) -> c.int ---
	dgemc_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, C: [^]f64, ldc: ^blasint, beta: ^f64, D: [^]f64, ldd: ^blasint) -> c.int ---
	qgemc_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, C: [^]f64, ldc: ^blasint, beta: ^f64, D: [^]f64, ldd: ^blasint) -> c.int ---
	cgemc_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, C: [^]f32, ldc: ^blasint, beta: [^]f32, D: [^]f32, ldd: ^blasint) -> c.int ---
	zgemc_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, C: [^]f64, ldc: ^blasint, beta: [^]f64, D: [^]f64, ldd: ^blasint) -> c.int ---
	xgemc_ :: proc(transa: ^u8, transb: ^u8, m: ^blasint, n: ^blasint, k: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, C: [^]f64, ldc: ^blasint, beta: [^]f64, D: [^]f64, ldd: ^blasint) -> c.int ---

	/* Lapack routines */
	sgetf2_ :: proc(m: ^blasint, n: ^blasint, A: [^]f32, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	dgetf2_ :: proc(m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	qgetf2_ :: proc(m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	cgetf2_ :: proc(m: ^blasint, n: ^blasint, A: [^]f32, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	zgetf2_ :: proc(m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	xgetf2_ :: proc(m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	sgetrf_ :: proc(m: ^blasint, n: ^blasint, A: [^]f32, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	dgetrf_ :: proc(m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	qgetrf_ :: proc(m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	cgetrf_ :: proc(m: ^blasint, n: ^blasint, A: [^]f32, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	zgetrf_ :: proc(m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	xgetrf_ :: proc(m: ^blasint, n: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, info: ^Info) -> c.int ---
	slaswp_ :: proc(n: ^blasint, A: [^]f32, lda: ^blasint, k1: ^blasint, k2: ^blasint, ipiv: [^]blasint, incx: ^blasint) -> c.int ---
	dlaswp_ :: proc(n: ^blasint, A: [^]f64, lda: ^blasint, k1: ^blasint, k2: ^blasint, ipiv: [^]blasint, incx: ^blasint) -> c.int ---
	qlaswp_ :: proc(n: ^blasint, A: [^]f64, lda: ^blasint, k1: ^blasint, k2: ^blasint, ipiv: [^]blasint, incx: ^blasint) -> c.int ---
	claswp_ :: proc(n: ^blasint, A: [^]complex64, lda: ^blasint, k1: ^blasint, k2: ^blasint, ipiv: [^]blasint, incx: ^blasint) -> c.int ---
	zlaswp_ :: proc(n: ^blasint, A: [^]complex128, lda: ^blasint, k1: ^blasint, k2: ^blasint, ipiv: [^]blasint, incx: ^blasint) -> c.int ---
	xlaswp_ :: proc(n: ^blasint, A: [^]f64, lda: ^blasint, k1: ^blasint, k2: ^blasint, ipiv: [^]blasint, incx: ^blasint) -> c.int ---
	sgetrs_ :: proc(trans: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f32, lda: ^blasint, ipiv: [^]blasint, B: [^]f32, ldb: ^blasint, info: ^Info) -> c.int ---
	dgetrs_ :: proc(trans: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	qgetrs_ :: proc(trans: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	cgetrs_ :: proc(trans: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f32, lda: ^blasint, ipiv: [^]blasint, B: [^]f32, ldb: ^blasint, info: ^Info) -> c.int ---
	zgetrs_ :: proc(trans: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	xgetrs_ :: proc(trans: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	sgesv_ :: proc(n: ^blasint, nrhs: ^blasint, A: [^]f32, lda: ^blasint, ipiv: [^]blasint, B: [^]f32, ldb: ^blasint, info: ^Info) -> c.int ---
	dgesv_ :: proc(n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	qgesv_ :: proc(n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	cgesv_ :: proc(n: ^blasint, nrhs: ^blasint, A: [^]f32, lda: ^blasint, ipiv: [^]blasint, B: [^]f32, ldb: ^blasint, info: ^Info) -> c.int ---
	zgesv_ :: proc(n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	xgesv_ :: proc(n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, ipiv: [^]blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	spotf2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	dpotf2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	qpotf2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	cpotf2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	zpotf2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	xpotf2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	spotrf_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	dpotrf_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	qpotrf_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	cpotrf_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	zpotrf_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	xpotrf_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	spotri_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	dpotri_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	qpotri_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	cpotri_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	zpotri_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	xpotri_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	spotrs_ :: proc(uplo: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, info: ^Info) -> c.int ---
	dpotrs_ :: proc(uplo: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	qpotrs_ :: proc(uplo: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	cpotrs_ :: proc(uplo: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint, info: ^Info) -> c.int ---
	zpotrs_ :: proc(uplo: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	xpotrs_ :: proc(uplo: ^u8, n: ^blasint, nrhs: ^blasint, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint, info: ^Info) -> c.int ---
	slauu2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	dlauu2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	qlauu2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	clauu2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	zlauu2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	xlauu2_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	slauum_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	dlauum_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	qlauum_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	clauum_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	zlauum_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	xlauum_ :: proc(uplo: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	strti2_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	dtrti2_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	qtrti2_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	ctrti2_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	ztrti2_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	xtrti2_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	strtri_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	dtrtri_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	qtrtri_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	ctrtri_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f32, lda: ^blasint, info: ^Info) -> c.int ---
	ztrtri_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	xtrtri_ :: proc(uplo: ^u8, diag: ^u8, n: ^blasint, A: [^]f64, lda: ^blasint, info: ^Info) -> c.int ---
	slamch_ :: proc(cmach: ^u8) -> f32 ---
	dlamch_ :: proc(cmach: ^u8) -> f64 ---
	qlamch_ :: proc(cmach: ^u8) -> f64 ---
	slamc3_ :: proc(a: ^f32, b: ^f32) -> f32 ---
	dlamc3_ :: proc(a: ^f64, b: ^f64) -> f64 ---
	qlamc3_ :: proc(a: ^f64, b: ^f64) -> f64 ---

	/* BLAS extensions */
	saxpby_ :: proc(n: ^blasint, alpha: ^f32, x: [^]f32, incx: ^blasint, beta: ^f32, y: [^]f32, incy: ^blasint) ---
	daxpby_ :: proc(n: ^blasint, alpha: ^f64, x: [^]f64, incx: ^blasint, beta: ^f64, y: [^]f64, incy: ^blasint) ---
	caxpby_ :: proc(n: ^blasint, alpha: rawptr, x: [^]f32, incx: ^blasint, beta: rawptr, y: [^]f32, incy: ^blasint) ---
	zaxpby_ :: proc(n: ^blasint, alpha: rawptr, x: [^]f64, incx: ^blasint, beta: rawptr, y: [^]f64, incy: ^blasint) ---
	somatcopy_ :: proc(order: ^u8, trans: ^u8, rows: ^blasint, cols: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint) ---
	domatcopy_ :: proc(order: ^u8, trans: ^u8, rows: ^blasint, cols: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	comatcopy_ :: proc(order: ^u8, trans: ^u8, rows: ^blasint, cols: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, B: [^]f32, ldb: ^blasint) ---
	zomatcopy_ :: proc(order: ^u8, trans: ^u8, rows: ^blasint, cols: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, B: [^]f64, ldb: ^blasint) ---
	simatcopy_ :: proc(order: ^u8, trans: ^u8, rows: ^blasint, cols: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, ldb: ^blasint) ---
	dimatcopy_ :: proc(order: ^u8, trans: ^u8, rows: ^blasint, cols: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, ldb: ^blasint) ---
	cimatcopy_ :: proc(order: ^u8, trans: ^u8, rows: ^blasint, cols: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, ldb: ^blasint) ---
	zimatcopy_ :: proc(order: ^u8, trans: ^u8, rows: ^blasint, cols: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, ldb: ^blasint) ---
	sgeadd_ :: proc(m: ^blasint, n: ^blasint, alpha: ^f32, A: [^]f32, lda: ^blasint, beta: ^f32, C: [^]f32, ldc: ^blasint) ---
	dgeadd_ :: proc(m: ^blasint, n: ^blasint, alpha: ^f64, A: [^]f64, lda: ^blasint, beta: ^f64, C: [^]f64, ldc: ^blasint) ---
	cgeadd_ :: proc(m: ^blasint, n: ^blasint, alpha: [^]f32, A: [^]f32, lda: ^blasint, beta: [^]f32, C: [^]f32, ldc: ^blasint) ---
	zgeadd_ :: proc(m: ^blasint, n: ^blasint, alpha: [^]f64, A: [^]f64, lda: ^blasint, beta: [^]f64, C: [^]f64, ldc: ^blasint) ---
}
