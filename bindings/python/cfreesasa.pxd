from libc.stdio cimport FILE


cdef extern from "freesasa.h":
    ctypedef struct freesasa_t:
        pass
    ctypedef enum freesasa_algorithm:
        FREESASA_LEE_RICHARDS, FREESASA_SHRAKE_RUPLEY
    ctypedef enum freesasa_class:
        FREESASA_POLAR, FREESASA_APOLAR,
        FREESASA_NUCLEICACID, FREESASA_CLASS_UNKNOWN
    ctypedef enum freesasa_verbosity:
        FREESASA_V_NORMAL, FREESASA_V_SILENT

    cdef int FREESASA_NAME_LIMIT
    cdef int FREESASA_DEF_PROBE_RADIUS
    cdef int FREESASA_DEF_SR_N
    cdef double FREESASA_DEF_LR_D
    cdef int FREESASA_SUCCESS
    cdef int FREESASA_FAIL
    cdef int FREESASA_WARN
    
    # init
    freesasa_t* freesasa_init()
    void freesasa_free(freesasa_t *self)

    # calculate
    void freesasa_copy_param(freesasa_t *target, const freesasa_t *source)
    int freesasa_calc_coord(freesasa_t  *self, const double *coord,
                            const double *r, size_t n)
    int freesasa_calc_pdb(freesasa_t *self, FILE *pdb_file)
    int freesasa_calc_atoms(freesasa_t *self, const double *coord,
                            const char **residueNames, 
                            const char **atomNames, size_t n)
    int freesasa_link_coord(freesasa_t *self, const double *coord,
                            double *radii, size_t n)
    int freesasa_refresh(freesasa_t *self)

    # protein info
    double freesasa_radius(const char *residueName, const char *atomName)
    size_t freesasa_n_atoms(const freesasa_t *self)

    # calculation settings
    int freesasa_set_algorithm(freesasa_t *s, freesasa_algorithm alg)
    freesasa_algorithm freesasa_get_algorithm(const freesasa_t *s)
    const char* freesasa_algorithm_name(const freesasa_t *self)
    int freesasa_set_probe_radius(freesasa_t *self,double r)
    double freesasa_get_probe_radius(const freesasa_t *self)
    int freesasa_set_sr_points(freesasa_t *self, int n)
    int freesasa_get_sr_points(const freesasa_t *self)
    int freesasa_set_lr_delta(freesasa_t *self, double delta)
    double freesasa_get_lr_delta(const freesasa_t *self)
    int freesasa_set_nthreads(freesasa_t *self,int n)
    int freesasa_get_nthreads(const freesasa_t *self)
    void freesasa_set_proteinname(freesasa_t *self,const char *name)
    const char* freesasa_get_proteinname(const freesasa_t *self)

    # access results
    double freesasa_area_total(const freesasa_t *self)
    double freesasa_area_class(const freesasa_t *self, freesasa_class c)
    double freesasa_area_residue(const freesasa_t *self, const char *residueName)
    double freesasa_area_atom(const freesasa_t *self, int atom)
    const double* freesasa_area_atom_array(const freesasa_t *self)
    double freesasa_radius_atom(const freesasa_t *self, int atom)
    const double* freesasa_radius_atom_array(const freesasa_t *self)

    # write results to output
    int freesasa_write_pdb(FILE *output, const freesasa_t *self);
    int freesasa_per_residue_type(FILE *output, const freesasa_t *self)
    int freesasa_per_residue(FILE *output, const freesasa_t *self)

    int freesasa_set_verbosity(freesasa_verbosity v)
    freesasa_verbosity freesasa_get_verbosity() 