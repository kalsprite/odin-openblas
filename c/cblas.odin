package openblas_c

import "core:c"


when ODIN_OS == .Windows {
	foreign import openblas "../OpenBLAS-0.3.30-x64-64/lib/libopenblas.lib"
	// foreign import openblas "../openblas.lib"
} else when ODIN_OS == .Linux {
	foreign import openblas "system:openblas_64"
}


/*Set the threading backend to a custom callback.*/
openblas_dojob_callback :: proc "c" (job_id: c.int, job_data: rawptr, thread_id: c.int)

openblas_threads_callback :: proc "c" (num_threads: c.int, dojob: openblas_dojob_callback, jobdata_elsize: c.int, jobdata_stride: c.size_t, jobdata: rawptr, num_jobs: c.int)

/* OpenBLAS is compiled for sequential use  */
SEQUENTIAL :: 0

/* OpenBLAS is compiled using normal threading model */
THREAD :: 1

/* OpenBLAS is compiled using OpenMP threading model */
OPENMP :: 2

// CONST ::

CBLAS_INDEX :: c.size_t

CBLAS_ORDER :: enum c.uint {
	RowMajor = 101,
	ColMajor = 102,
}

CBLAS_TRANSPOSE :: enum c.uint {
	NoTrans     = 111,
	Trans       = 112,
	ConjTrans   = 113,
	ConjNoTrans = 114,
}

CBLAS_UPLO :: enum c.uint {
	Upper = 121,
	Lower = 122,
}

CBLAS_DIAG :: enum c.uint {
	NonUnit = 131,
	Unit    = 132,
}

CBLAS_SIDE :: enum c.uint {
	Left  = 141,
	Right = 142,
}

CBLAS_LAYOUT :: CBLAS_ORDER

@(default_calling_convention = "c", link_prefix = "")
foreign openblas {
	/*Set the number of threads on runtime.*/
	openblas_set_num_threads :: proc(num_threads: c.int) ---
	goto_set_num_threads :: proc(num_threads: c.int) ---
	openblas_set_num_threads_local :: proc(num_threads: c.int) -> c.int ---

	/*Get the number of threads on runtime.*/
	openblas_get_num_threads :: proc() -> c.int ---

	/*Get the number of physical processors (cores).*/
	openblas_get_num_procs :: proc() -> c.int ---

	/*Get the build configure on runtime.*/
	openblas_get_config :: proc() -> cstring ---

	/*Get the CPU corename on runtime.*/
	openblas_get_corename :: proc() -> cstring ---
	openblas_set_threads_callback_function :: proc(callback: openblas_threads_callback) ---

	/* Get the parallelization type which is used by OpenBLAS */
	openblas_get_parallel :: proc() -> c.int ---

	cblas_sdsdot :: proc(n: blasint, alpha: f32, x: [^]f32, incx: blasint, y: [^]f32, incy: blasint) -> f32 ---
	cblas_dsdot :: proc(n: blasint, x: [^]f32, incx: blasint, y: [^]f32, incy: blasint) -> f64 ---
	cblas_sdot :: proc(n: blasint, x: [^]f32, incx: blasint, y: [^]f32, incy: blasint) -> f32 ---
	cblas_ddot :: proc(n: blasint, x: [^]f64, incx: blasint, y: [^]f64, incy: blasint) -> f64 ---
	cblas_cdotu :: proc(n: blasint, x: [^]complex64, incx: blasint, y: [^]complex64, incy: blasint) -> complex64 ---
	cblas_cdotc :: proc(n: blasint, x: [^]complex64, incx: blasint, y: [^]complex64, incy: blasint) -> complex64 ---
	cblas_zdotu :: proc(n: blasint, x: [^]complex128, incx: blasint, y: [^]complex128, incy: blasint) -> complex128 ---
	cblas_zdotc :: proc(n: blasint, x: [^]complex128, incx: blasint, y: [^]complex128, incy: blasint) -> complex128 ---
	cblas_cdotu_sub :: proc(n: blasint, x: [^]complex64, incx: blasint, y: [^]complex64, incy: blasint, ret: ^complex64) ---
	cblas_cdotc_sub :: proc(n: blasint, x: [^]complex64, incx: blasint, y: [^]complex64, incy: blasint, ret: ^complex64) ---
	cblas_zdotu_sub :: proc(n: blasint, x: [^]complex128, incx: blasint, y: [^]complex128, incy: blasint, ret: ^complex128) ---
	cblas_zdotc_sub :: proc(n: blasint, x: [^]complex128, incx: blasint, y: [^]complex128, incy: blasint, ret: ^complex128) ---

	cblas_sasum :: proc(n: blasint, x: [^]f32, incx: blasint) -> f32 ---
	cblas_dasum :: proc(n: blasint, x: [^]f64, incx: blasint) -> f64 ---
	cblas_scasum :: proc(n: blasint, x: [^]complex64, incx: blasint) -> f32 ---
	cblas_dzasum :: proc(n: blasint, x: [^]complex128, incx: blasint) -> f64 ---
	cblas_ssum :: proc(n: blasint, x: [^]f32, incx: blasint) -> f32 ---
	cblas_dsum :: proc(n: blasint, x: [^]f64, incx: blasint) -> f64 ---
	cblas_scsum :: proc(n: blasint, x: [^]complex64, incx: blasint) -> f32 ---
	cblas_dzsum :: proc(n: blasint, x: [^]complex128, incx: blasint) -> f64 ---

	cblas_snrm2 :: proc(N: blasint, X: [^]f32, incX: blasint) -> f32 ---
	cblas_dnrm2 :: proc(N: blasint, X: [^]f64, incX: blasint) -> f64 ---
	cblas_scnrm2 :: proc(N: blasint, X: [^]complex64, incX: blasint) -> f32 ---
	cblas_dznrm2 :: proc(N: blasint, X: [^]complex128, incX: blasint) -> f64 ---

	cblas_isamax :: proc(n: blasint, x: [^]f32, incx: blasint) -> c.size_t ---
	cblas_idamax :: proc(n: blasint, x: [^]f64, incx: blasint) -> c.size_t ---
	cblas_icamax :: proc(n: blasint, x: [^]complex64, incx: blasint) -> c.size_t ---
	cblas_izamax :: proc(n: blasint, x: [^]complex128, incx: blasint) -> c.size_t ---
	cblas_isamin :: proc(n: blasint, x: [^]f32, incx: blasint) -> c.size_t ---
	cblas_idamin :: proc(n: blasint, x: [^]f64, incx: blasint) -> c.size_t ---
	cblas_icamin :: proc(n: blasint, x: [^]complex64, incx: blasint) -> c.size_t ---
	cblas_izamin :: proc(n: blasint, x: [^]complex128, incx: blasint) -> c.size_t ---
	cblas_samax :: proc(n: blasint, x: [^]f32, incx: blasint) -> f32 ---
	cblas_damax :: proc(n: blasint, x: [^]f64, incx: blasint) -> f64 ---
	cblas_scamax :: proc(n: blasint, x: [^]complex64, incx: blasint) -> f32 ---
	cblas_dzamax :: proc(n: blasint, x: [^]complex128, incx: blasint) -> f64 ---
	cblas_samin :: proc(n: blasint, x: [^]f32, incx: blasint) -> f32 ---
	cblas_damin :: proc(n: blasint, x: [^]f64, incx: blasint) -> f64 ---
	cblas_scamin :: proc(n: blasint, x: [^]complex64, incx: blasint) -> f32 ---
	cblas_dzamin :: proc(n: blasint, x: [^]complex128, incx: blasint) -> f64 ---
	cblas_ismax :: proc(n: blasint, x: [^]f32, incx: blasint) -> c.size_t ---
	cblas_idmax :: proc(n: blasint, x: [^]f64, incx: blasint) -> c.size_t ---
	cblas_icmax :: proc(n: blasint, x: [^]complex64, incx: blasint) -> c.size_t ---
	cblas_izmax :: proc(n: blasint, x: [^]complex128, incx: blasint) -> c.size_t ---
	cblas_ismin :: proc(n: blasint, x: [^]f32, incx: blasint) -> c.size_t ---
	cblas_idmin :: proc(n: blasint, x: [^]f64, incx: blasint) -> c.size_t ---
	cblas_icmin :: proc(n: blasint, x: [^]complex64, incx: blasint) -> c.size_t ---
	cblas_izmin :: proc(n: blasint, x: [^]complex128, incx: blasint) -> c.size_t ---

	cblas_saxpy :: proc(n: blasint, alpha: f32, x: [^]f32, incx: blasint, y: [^]f32, incy: blasint) ---
	cblas_daxpy :: proc(n: blasint, alpha: f64, x: [^]f64, incx: blasint, y: [^]f64, incy: blasint) ---
	cblas_caxpy :: proc(n: blasint, alpha: ^complex64, x: [^]complex64, incx: blasint, y: [^]complex64, incy: blasint) ---
	cblas_zaxpy :: proc(n: blasint, alpha: ^complex128, x: [^]complex128, incx: blasint, y: [^]complex128, incy: blasint) ---
	cblas_caxpyc :: proc(n: blasint, alpha: ^complex64, x: [^]complex64, incx: blasint, y: [^]complex64, incy: blasint) ---
	cblas_zaxpyc :: proc(n: blasint, alpha: ^complex128, x: [^]complex128, incx: blasint, y: [^]complex128, incy: blasint) ---

	cblas_scopy :: proc(n: blasint, x: [^]f32, incx: blasint, y: [^]f32, incy: blasint) ---
	cblas_dcopy :: proc(n: blasint, x: [^]f64, incx: blasint, y: [^]f64, incy: blasint) ---
	cblas_ccopy :: proc(n: blasint, x: [^]complex64, incx: blasint, y: [^]complex64, incy: blasint) ---
	cblas_zcopy :: proc(n: blasint, x: [^]complex128, incx: blasint, y: [^]complex128, incy: blasint) ---

	cblas_sswap :: proc(n: blasint, x: [^]f32, incx: blasint, y: [^]f32, incy: blasint) ---
	cblas_dswap :: proc(n: blasint, x: [^]f64, incx: blasint, y: [^]f64, incy: blasint) ---
	cblas_cswap :: proc(n: blasint, x: [^]complex64, incx: blasint, y: [^]complex64, incy: blasint) ---
	cblas_zswap :: proc(n: blasint, x: [^]complex128, incx: blasint, y: [^]complex128, incy: blasint) ---

	cblas_srot :: proc(N: blasint, X: [^]f32, incX: blasint, Y: [^]f32, incY: blasint, _c: f32, s: f32) ---
	cblas_drot :: proc(N: blasint, X: [^]f64, incX: blasint, Y: [^]f64, incY: blasint, _c: f64, s: f64) ---
	cblas_csrot :: proc(n: blasint, x: [^]complex64, incx: blasint, y: [^]complex64, incY: blasint, _c: f32, s: f32) ---
	cblas_zdrot :: proc(n: blasint, x: [^]complex128, incx: blasint, y: [^]complex128, incY: blasint, _c: f64, s: f64) ---
	cblas_srotg :: proc(a: ^f32, b: ^f32, _c: ^f32, s: ^f32) ---
	cblas_drotg :: proc(a: ^f64, b: ^f64, _c: ^f64, s: ^f64) ---
	cblas_crotg :: proc(a: ^complex64, b: ^complex64, _c: ^f32, s: ^complex64) ---
	cblas_zrotg :: proc(a: ^complex128, b: ^complex128, _c: ^f64, s: ^complex128) ---
	cblas_srotm :: proc(N: blasint, X: [^]f32, incX: blasint, Y: [^]f32, incY: blasint, P: [^]f32) ---
	cblas_drotm :: proc(N: blasint, X: [^]f64, incX: blasint, Y: [^]f64, incY: blasint, P: [^]f64) ---
	cblas_srotmg :: proc(d1: ^f32, d2: ^f32, b1: ^f32, b2: f32, P: [^]f32) ---
	cblas_drotmg :: proc(d1: ^f64, d2: ^f64, b1: ^f64, b2: f64, P: [^]f64) ---

	cblas_sscal :: proc(N: blasint, alpha: f32, X: [^]f32, incX: blasint) ---
	cblas_dscal :: proc(N: blasint, alpha: f64, X: [^]f64, incX: blasint) ---
	cblas_cscal :: proc(N: blasint, alpha: ^complex64, X: [^]complex64, incX: blasint) ---
	cblas_zscal :: proc(N: blasint, alpha: ^complex128, X: [^]complex128, incX: blasint) ---
	cblas_csscal :: proc(N: blasint, alpha: f32, X: [^]complex64, incX: blasint) ---
	cblas_zdscal :: proc(N: blasint, alpha: f64, X: [^]complex128, incX: blasint) ---

	cblas_sgemv :: proc(order: CBLAS_ORDER, trans: CBLAS_TRANSPOSE, m: blasint, n: blasint, alpha: f32, a: [^]f32, lda: blasint, x: [^]f32, incx: blasint, beta: f32, y: [^]f32, incy: blasint) ---
	cblas_dgemv :: proc(order: CBLAS_ORDER, trans: CBLAS_TRANSPOSE, m: blasint, n: blasint, alpha: f64, a: [^]f64, lda: blasint, x: [^]f64, incx: blasint, beta: f64, y: [^]f64, incy: blasint) ---
	cblas_cgemv :: proc(order: CBLAS_ORDER, trans: CBLAS_TRANSPOSE, m: blasint, n: blasint, alpha: ^complex64, a: [^]complex64, lda: blasint, x: [^]complex64, incx: blasint, beta: ^complex64, y: [^]complex64, incy: blasint) ---
	cblas_zgemv :: proc(order: CBLAS_ORDER, trans: CBLAS_TRANSPOSE, m: blasint, n: blasint, alpha: ^complex128, a: [^]complex128, lda: blasint, x: [^]complex128, incx: blasint, beta: ^complex128, y: [^]complex128, incy: blasint) ---

	cblas_sger :: proc(order: CBLAS_ORDER, M: blasint, N: blasint, alpha: f32, X: [^]f32, incX: blasint, Y: [^]f32, incY: blasint, A: [^]f32, lda: blasint) ---
	cblas_dger :: proc(order: CBLAS_ORDER, M: blasint, N: blasint, alpha: f64, X: [^]f64, incX: blasint, Y: [^]f64, incY: blasint, A: [^]f64, lda: blasint) ---
	cblas_cgeru :: proc(order: CBLAS_ORDER, M: blasint, N: blasint, alpha: ^complex64, X: [^]complex64, incX: blasint, Y: [^]complex64, incY: blasint, A: [^]complex64, lda: blasint) ---
	cblas_cgerc :: proc(order: CBLAS_ORDER, M: blasint, N: blasint, alpha: ^complex64, X: [^]complex64, incX: blasint, Y: [^]complex64, incY: blasint, A: [^]complex64, lda: blasint) ---
	cblas_zgeru :: proc(order: CBLAS_ORDER, M: blasint, N: blasint, alpha: ^complex128, X: [^]complex128, incX: blasint, Y: [^]complex128, incY: blasint, A: [^]complex128, lda: blasint) ---
	cblas_zgerc :: proc(order: CBLAS_ORDER, M: blasint, N: blasint, alpha: ^complex128, X: [^]complex128, incX: blasint, Y: [^]complex128, incY: blasint, A: [^]complex128, lda: blasint) ---

	cblas_strsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, A: [^]f32, lda: blasint, X: [^]f32, incX: blasint) ---
	cblas_dtrsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, A: [^]f64, lda: blasint, X: [^]f64, incX: blasint) ---
	cblas_ctrsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, A: [^]complex64, lda: blasint, X: [^]complex64, incX: blasint) ---
	cblas_ztrsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, A: [^]complex128, lda: blasint, X: [^]complex128, incX: blasint) ---
	cblas_strmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, A: [^]f32, lda: blasint, X: [^]f32, incX: blasint) ---
	cblas_dtrmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, A: [^]f64, lda: blasint, X: [^]f64, incX: blasint) ---
	cblas_ctrmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, A: [^]complex64, lda: blasint, X: [^]complex64, incX: blasint) ---
	cblas_ztrmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, A: [^]complex128, lda: blasint, X: [^]complex128, incX: blasint) ---

	cblas_ssyr :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f32, X: [^]f32, incX: blasint, A: [^]f32, lda: blasint) ---
	cblas_dsyr :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f64, X: [^]f64, incX: blasint, A: [^]f64, lda: blasint) ---
	cblas_cher :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f32, X: [^]complex64, incX: blasint, A: [^]complex64, lda: blasint) ---
	cblas_zher :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f64, X: [^]complex128, incX: blasint, A: [^]complex128, lda: blasint) ---
	cblas_ssyr2 :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f32, X: [^]f32, incX: blasint, Y: [^]f32, incY: blasint, A: [^]f32, lda: blasint) ---
	cblas_dsyr2 :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f64, X: [^]f64, incX: blasint, Y: [^]f64, incY: blasint, A: [^]f64, lda: blasint) ---
	cblas_cher2 :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: ^complex64, X: [^]complex64, incX: blasint, Y: [^]complex64, incY: blasint, A: [^]complex64, lda: blasint) ---
	cblas_zher2 :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: ^complex128, X: [^]complex128, incX: blasint, Y: [^]complex128, incY: blasint, A: [^]complex128, lda: blasint) ---

	cblas_sgbmv :: proc(order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, M: blasint, N: blasint, KL: blasint, KU: blasint, alpha: f32, A: [^]f32, lda: blasint, X: [^]f32, incX: blasint, beta: f32, Y: [^]f32, incY: blasint) ---
	cblas_dgbmv :: proc(order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, M: blasint, N: blasint, KL: blasint, KU: blasint, alpha: f64, A: [^]f64, lda: blasint, X: [^]f64, incX: blasint, beta: f64, Y: [^]f64, incY: blasint) ---
	cblas_cgbmv :: proc(order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, M: blasint, N: blasint, KL: blasint, KU: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, X: [^]complex64, incX: blasint, beta: ^complex64, Y: [^]complex64, incY: blasint) ---
	cblas_zgbmv :: proc(order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, M: blasint, N: blasint, KL: blasint, KU: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, X: [^]complex128, incX: blasint, beta: ^complex128, Y: [^]complex128, incY: blasint) ---

	cblas_ssbmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, K: blasint, alpha: f32, A: [^]f32, lda: blasint, X: [^]f32, incX: blasint, beta: f32, Y: [^]f32, incY: blasint) ---
	cblas_dsbmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, K: blasint, alpha: f64, A: [^]f64, lda: blasint, X: [^]f64, incX: blasint, beta: f64, Y: [^]f64, incY: blasint) ---

	cblas_stbmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, K: blasint, A: [^]f32, lda: blasint, X: [^]f32, incX: blasint) ---
	cblas_dtbmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, K: blasint, A: [^]f64, lda: blasint, X: [^]f64, incX: blasint) ---
	cblas_ctbmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, K: blasint, A: [^]complex64, lda: blasint, X: [^]complex64, incX: blasint) ---
	cblas_ztbmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, K: blasint, A: [^]complex128, lda: blasint, X: [^]complex128, incX: blasint) ---

	cblas_stbsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, K: blasint, A: [^]f32, lda: blasint, X: [^]f32, incX: blasint) ---
	cblas_dtbsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, K: blasint, A: [^]f64, lda: blasint, X: [^]f64, incX: blasint) ---
	cblas_ctbsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, K: blasint, A: [^]complex64, lda: blasint, X: [^]complex64, incX: blasint) ---
	cblas_ztbsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, K: blasint, A: [^]complex128, lda: blasint, X: [^]complex128, incX: blasint) ---

	cblas_stpmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, Ap: [^]f32, X: [^]f32, incX: blasint) ---
	cblas_dtpmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, Ap: [^]f64, X: [^]f64, incX: blasint) ---
	cblas_ctpmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, Ap: [^]complex64, X: [^]complex64, incX: blasint) ---
	cblas_ztpmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, Ap: [^]complex128, X: [^]complex128, incX: blasint) ---

	cblas_stpsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, Ap: [^]f32, X: [^]f32, incX: blasint) ---
	cblas_dtpsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, Ap: [^]f64, X: [^]f64, incX: blasint) ---
	cblas_ctpsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, Ap: [^]complex64, X: [^]complex64, incX: blasint) ---
	cblas_ztpsv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, N: blasint, Ap: [^]complex128, X: [^]complex128, incX: blasint) ---

	cblas_ssymv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f32, A: [^]f32, lda: blasint, X: [^]f32, incX: blasint, beta: f32, Y: [^]f32, incY: blasint) ---
	cblas_dsymv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f64, A: [^]f64, lda: blasint, X: [^]f64, incX: blasint, beta: f64, Y: [^]f64, incY: blasint) ---

	cblas_chemv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, X: [^]complex64, incX: blasint, beta: ^complex64, Y: [^]complex64, incY: blasint) ---
	cblas_zhemv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, X: [^]complex128, incX: blasint, beta: ^complex128, Y: [^]complex128, incY: blasint) ---

	cblas_sspmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f32, Ap: [^]f32, X: [^]f32, incX: blasint, beta: f32, Y: [^]f32, incY: blasint) ---
	cblas_dspmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f64, Ap: [^]f64, X: [^]f64, incX: blasint, beta: f64, Y: [^]f64, incY: blasint) ---

	cblas_sspr :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f32, X: [^]f32, incX: blasint, Ap: [^]f32) ---
	cblas_dspr :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f64, X: [^]f64, incX: blasint, Ap: [^]f64) ---
	cblas_chpr :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f32, X: [^]complex64, incX: blasint, A: [^]complex64) ---
	cblas_zhpr :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f64, X: [^]complex128, incX: blasint, A: [^]complex128) ---
	cblas_sspr2 :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f32, X: [^]f32, incX: blasint, Y: [^]f32, incY: blasint, A: [^]f32) ---
	cblas_dspr2 :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: f64, X: [^]f64, incX: blasint, Y: [^]f64, incY: blasint, A: [^]f64) ---
	cblas_chpr2 :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: ^complex64, X: [^]complex64, incX: blasint, Y: [^]complex64, incY: blasint, Ap: [^]complex64) ---
	cblas_zhpr2 :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: ^complex128, X: [^]complex128, incX: blasint, Y: [^]complex128, incY: blasint, Ap: [^]complex128) ---

	cblas_chbmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, K: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, X: [^]complex64, incX: blasint, beta: ^complex64, Y: [^]complex64, incY: blasint) ---
	cblas_zhbmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, K: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, X: [^]complex128, incX: blasint, beta: ^complex128, Y: [^]complex128, incY: blasint) ---
	cblas_chpmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: ^complex64, Ap: [^]complex64, X: [^]complex64, incX: blasint, beta: ^complex64, Y: [^]complex64, incY: blasint) ---
	cblas_zhpmv :: proc(order: CBLAS_ORDER, Uplo: CBLAS_UPLO, N: blasint, alpha: ^complex128, Ap: [^]complex128, X: [^]complex128, incX: blasint, beta: ^complex128, Y: [^]complex128, incY: blasint) ---

	cblas_sgemm :: proc(Order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, N: blasint, K: blasint, alpha: f32, A: [^]f32, lda: blasint, B: [^]f32, ldb: blasint, beta: f32, C: [^]f32, ldc: blasint) ---
	cblas_dgemm :: proc(Order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, N: blasint, K: blasint, alpha: f64, A: [^]f64, lda: blasint, B: [^]f64, ldb: blasint, beta: f64, C: [^]f64, ldc: blasint) ---
	cblas_cgemm :: proc(Order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, N: blasint, K: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint, beta: ^complex64, C: [^]complex64, ldc: blasint) ---
	cblas_cgemm3m :: proc(Order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, N: blasint, K: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint, beta: ^complex64, C: [^]complex64, ldc: blasint) ---
	cblas_zgemm :: proc(Order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, N: blasint, K: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint, beta: ^complex128, C: [^]complex128, ldc: blasint) ---
	cblas_zgemm3m :: proc(Order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, N: blasint, K: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint, beta: ^complex128, C: [^]complex128, ldc: blasint) ---
	cblas_sgemmt :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, K: blasint, alpha: f32, A: [^]f32, lda: blasint, B: [^]f32, ldb: blasint, beta: f32, C: [^]f32, ldc: blasint) ---
	cblas_dgemmt :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, K: blasint, alpha: f64, A: [^]f64, lda: blasint, B: [^]f64, ldb: blasint, beta: f64, C: [^]f64, ldc: blasint) ---
	cblas_cgemmt :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, K: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint, beta: ^complex64, C: [^]complex64, ldc: blasint) ---
	cblas_zgemmt :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, K: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint, beta: ^complex128, C: [^]complex128, ldc: blasint) ---

	cblas_ssymm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, M: blasint, N: blasint, alpha: f32, A: [^]f32, lda: blasint, B: [^]f32, ldb: blasint, beta: f32, C: [^]f32, ldc: blasint) ---
	cblas_dsymm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, M: blasint, N: blasint, alpha: f64, A: [^]f64, lda: blasint, B: [^]f64, ldb: blasint, beta: f64, C: [^]f64, ldc: blasint) ---
	cblas_csymm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, M: blasint, N: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint, beta: ^complex64, C: [^]complex64, ldc: blasint) ---
	cblas_zsymm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, M: blasint, N: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint, beta: ^complex128, C: [^]complex128, ldc: blasint) ---

	cblas_ssyrk :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: f32, A: [^]f32, lda: blasint, beta: f32, C: [^]f32, ldc: blasint) ---
	cblas_dsyrk :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: f64, A: [^]f64, lda: blasint, beta: f64, C: [^]f64, ldc: blasint) ---
	cblas_csyrk :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, beta: ^complex64, C: [^]complex64, ldc: blasint) ---
	cblas_zsyrk :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, beta: ^complex128, C: [^]complex128, ldc: blasint) ---
	cblas_ssyr2k :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: f32, A: [^]f32, lda: blasint, B: [^]f32, ldb: blasint, beta: f32, C: [^]f32, ldc: blasint) ---
	cblas_dsyr2k :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: f64, A: [^]f64, lda: blasint, B: [^]f64, ldb: blasint, beta: f64, C: [^]f64, ldc: blasint) ---
	cblas_csyr2k :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint, beta: ^complex64, C: [^]complex64, ldc: blasint) ---
	cblas_zsyr2k :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint, beta: ^complex128, C: [^]complex128, ldc: blasint) ---

	cblas_strmm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, M: blasint, N: blasint, alpha: f32, A: [^]f32, lda: blasint, B: [^]f32, ldb: blasint) ---
	cblas_dtrmm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, M: blasint, N: blasint, alpha: f64, A: [^]f64, lda: blasint, B: [^]f64, ldb: blasint) ---
	cblas_ctrmm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, M: blasint, N: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint) ---
	cblas_ztrmm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, M: blasint, N: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint) ---
	cblas_strsm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, M: blasint, N: blasint, alpha: f32, A: [^]f32, lda: blasint, B: [^]f32, ldb: blasint) ---
	cblas_dtrsm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, M: blasint, N: blasint, alpha: f64, A: [^]f64, lda: blasint, B: [^]f64, ldb: blasint) ---
	cblas_ctrsm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, M: blasint, N: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint) ---
	cblas_ztrsm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, TransA: CBLAS_TRANSPOSE, Diag: CBLAS_DIAG, M: blasint, N: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint) ---

	cblas_chemm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, M: blasint, N: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint, beta: ^complex64, C: [^]complex64, ldc: blasint) ---
	cblas_zhemm :: proc(Order: CBLAS_ORDER, Side: CBLAS_SIDE, Uplo: CBLAS_UPLO, M: blasint, N: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint, beta: ^complex128, C: [^]complex128, ldc: blasint) ---

	cblas_cherk :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: f32, A: [^]complex64, lda: blasint, beta: f32, C: [^]complex64, ldc: blasint) ---
	cblas_zherk :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: f64, A: [^]complex128, lda: blasint, beta: f64, C: [^]complex128, ldc: blasint) ---
	cblas_cher2k :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: ^complex64, A: [^]complex64, lda: blasint, B: [^]complex64, ldb: blasint, beta: f32, C: [^]complex64, ldc: blasint) ---
	cblas_zher2k :: proc(Order: CBLAS_ORDER, Uplo: CBLAS_UPLO, Trans: CBLAS_TRANSPOSE, N: blasint, K: blasint, alpha: ^complex128, A: [^]complex128, lda: blasint, B: [^]complex128, ldb: blasint, beta: f64, C: [^]complex128, ldc: blasint) ---

	cblas_xerbla :: proc(p: blasint, rout: cstring, form: cstring, #c_vararg _: ..any) ---

	/*** BLAS extensions ***/
	cblas_saxpby :: proc(n: blasint, alpha: f32, x: [^]f32, incx: blasint, beta: f32, y: [^]f32, incy: blasint) ---
	cblas_daxpby :: proc(n: blasint, alpha: f64, x: [^]f64, incx: blasint, beta: f64, y: [^]f64, incy: blasint) ---
	cblas_caxpby :: proc(n: blasint, alpha: ^complex64, x: [^]complex64, incx: blasint, beta: ^complex64, y: [^]complex64, incy: blasint) ---
	cblas_zaxpby :: proc(n: blasint, alpha: ^complex128, x: [^]complex128, incx: blasint, beta: ^complex128, y: [^]complex128, incy: blasint) ---

	cblas_somatcopy :: proc(CORDER: CBLAS_ORDER, CTRANS: CBLAS_TRANSPOSE, crows: blasint, ccols: blasint, calpha: f32, a: [^]f32, clda: blasint, b: [^]f32, cldb: blasint) ---
	cblas_domatcopy :: proc(CORDER: CBLAS_ORDER, CTRANS: CBLAS_TRANSPOSE, crows: blasint, ccols: blasint, calpha: f64, a: [^]f64, clda: blasint, b: [^]f64, cldb: blasint) ---
	cblas_comatcopy :: proc(CORDER: CBLAS_ORDER, CTRANS: CBLAS_TRANSPOSE, crows: blasint, ccols: blasint, calpha: ^complex64, a: [^]complex64, clda: blasint, b: [^]complex64, cldb: blasint) ---
	cblas_zomatcopy :: proc(CORDER: CBLAS_ORDER, CTRANS: CBLAS_TRANSPOSE, crows: blasint, ccols: blasint, calpha: ^complex128, a: [^]complex128, clda: blasint, b: [^]complex128, cldb: blasint) ---

	cblas_simatcopy :: proc(CORDER: CBLAS_ORDER, CTRANS: CBLAS_TRANSPOSE, crows: blasint, ccols: blasint, calpha: f32, a: [^]f32, clda: blasint, cldb: blasint) ---
	cblas_dimatcopy :: proc(CORDER: CBLAS_ORDER, CTRANS: CBLAS_TRANSPOSE, crows: blasint, ccols: blasint, calpha: f64, a: [^]f64, clda: blasint, cldb: blasint) ---
	cblas_cimatcopy :: proc(CORDER: CBLAS_ORDER, CTRANS: CBLAS_TRANSPOSE, crows: blasint, ccols: blasint, calpha: ^complex64, a: [^]complex64, clda: blasint, cldb: blasint) ---
	cblas_zimatcopy :: proc(CORDER: CBLAS_ORDER, CTRANS: CBLAS_TRANSPOSE, crows: blasint, ccols: blasint, calpha: ^complex128, a: [^]complex128, clda: blasint, cldb: blasint) ---

	cblas_sgeadd :: proc(CORDER: CBLAS_ORDER, crows: blasint, ccols: blasint, calpha: f32, a: [^]f32, clda: blasint, cbeta: f32, _c: [^]f32, cldc: blasint) ---
	cblas_dgeadd :: proc(CORDER: CBLAS_ORDER, crows: blasint, ccols: blasint, calpha: f64, a: [^]f64, clda: blasint, cbeta: f64, _c: [^]f64, cldc: blasint) ---
	cblas_cgeadd :: proc(CORDER: CBLAS_ORDER, crows: blasint, ccols: blasint, calpha: ^complex64, a: [^]complex64, clda: blasint, cbeta: ^complex64, _c: [^]complex64, cldc: blasint) ---
	cblas_zgeadd :: proc(CORDER: CBLAS_ORDER, crows: blasint, ccols: blasint, calpha: ^complex128, a: [^]complex128, clda: blasint, cbeta: ^complex128, _c: [^]complex128, cldc: blasint) ---

	// EVERYTHING BELOW HERE IS NOT WRAPPED:
	cblas_sgemm_batch :: proc(Order: CBLAS_ORDER, TransA_array: [^]CBLAS_TRANSPOSE, TransB_array: [^]CBLAS_TRANSPOSE, M_array: [^]blasint, N_array: [^]blasint, K_array: [^]blasint, alpha_array: [^]f32, A_array: [^]^f32, lda_array: [^]blasint, B_array: [^]^f32, ldb_array: [^]blasint, beta_array: [^]f32, C_array: [^]^f32, ldc_array: [^]blasint, group_count: blasint, group_size: [^]blasint) ---
	cblas_dgemm_batch :: proc(Order: CBLAS_ORDER, TransA_array: [^]CBLAS_TRANSPOSE, TransB_array: [^]CBLAS_TRANSPOSE, M_array: [^]blasint, N_array: [^]blasint, K_array: [^]blasint, alpha_array: [^]f64, A_array: [^]^f64, lda_array: [^]blasint, B_array: [^]^f64, ldb_array: [^]blasint, beta_array: [^]f64, C_array: [^]^f64, ldc_array: [^]blasint, group_count: blasint, group_size: [^]blasint) ---
	cblas_cgemm_batch :: proc(Order: CBLAS_ORDER, TransA_array: [^]CBLAS_TRANSPOSE, TransB_array: [^]CBLAS_TRANSPOSE, M_array: [^]blasint, N_array: [^]blasint, K_array: [^]blasint, alpha_array: [^]complex64, A_array: [^][^]complex64, lda_array: [^]blasint, B_array: [^][^]complex64, ldb_array: [^]blasint, beta_array: [^]complex64, C_array: [^][^]complex64, ldc_array: [^]blasint, group_count: blasint, group_size: [^]blasint) ---
	cblas_zgemm_batch :: proc(Order: CBLAS_ORDER, TransA_array: [^]CBLAS_TRANSPOSE, TransB_array: [^]CBLAS_TRANSPOSE, M_array: [^]blasint, N_array: [^]blasint, K_array: [^]blasint, alpha_array: [^]complex128, A_array: [^][^]complex128, lda_array: [^]blasint, B_array: [^][^]complex128, ldb_array: [^]blasint, beta_array: [^]complex128, C_array: [^][^]complex128, ldc_array: [^]blasint, group_count: blasint, group_size: [^]blasint) ---

	/*** BFLOAT16 and INT8 extensions ***/
	/* convert float array to BFLOAT16 array by rounding */
	cblas_sbstobf16 :: proc(n: blasint, _in: [^]f32, incin: blasint, out: [^]bfloat16, incout: blasint) ---

	/* convert double array to BFLOAT16 array by rounding */
	cblas_sbdtobf16 :: proc(n: blasint, _in: [^]f64, incin: blasint, out: [^]bfloat16, incout: blasint) ---

	/* convert BFLOAT16 array to float array */
	cblas_sbf16tos :: proc(n: blasint, _in: [^]bfloat16, incin: blasint, out: [^]f32, incout: blasint) ---

	/* convert BFLOAT16 array to double array */
	cblas_dbf16tod :: proc(n: blasint, _in: [^]bfloat16, incin: blasint, out: [^]f64, incout: blasint) ---

	/* dot production of BFLOAT16 input arrays, and output as float */
	cblas_sbdot :: proc(n: blasint, x: [^]bfloat16, incx: blasint, y: [^]bfloat16, incy: blasint) -> f32 ---
	cblas_sbgemv :: proc(order: CBLAS_ORDER, trans: CBLAS_TRANSPOSE, m: blasint, n: blasint, alpha: f32, a: [^]bfloat16, lda: blasint, x: [^]bfloat16, incx: blasint, beta: f32, y: [^]f32, incy: blasint) ---
	cblas_sbgemm :: proc(Order: CBLAS_ORDER, TransA: CBLAS_TRANSPOSE, TransB: CBLAS_TRANSPOSE, M: blasint, N: blasint, K: blasint, alpha: f32, A: [^]bfloat16, lda: blasint, B: [^]bfloat16, ldb: blasint, beta: f32, C: [^]f32, ldc: blasint) ---
	cblas_sbgemm_batch :: proc(Order: CBLAS_ORDER, TransA_array: [^]CBLAS_TRANSPOSE, TransB_array: [^]CBLAS_TRANSPOSE, M_array: [^]blasint, N_array: [^]blasint, K_array: [^]blasint, alpha_array: [^]f32, A_array: [^]^bfloat16, lda_array: [^]blasint, B_array: [^]^bfloat16, ldb_array: [^]blasint, beta_array: [^]f32, C_array: [^]^f32, ldc_array: [^]blasint, group_count: blasint, group_size: [^]blasint) ---
}
