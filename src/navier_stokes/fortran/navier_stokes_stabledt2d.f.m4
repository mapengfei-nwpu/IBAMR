define(NDIM,2)dnl
define(REAL,`double precision')dnl
define(INTEGER,`integer')dnl
include(SAMRAI_FORTDIR/pdat_m4arrdim2d.i)dnl
c
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c
c     Determine the timestep size corresponding to a unit CFL number.
c
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c
      subroutine navier_stokes_stabledt2d(
     &     dx,
     &     ifirst0,ilast0,ifirst1,ilast1,
     &     ngc0,ngc1,
     &     U0,U1,
     &     stabdt)
c
      implicit none
c
c     Input.
c
      INTEGER ifirst0,ilast0,ifirst1,ilast1

      INTEGER ngc0,ngc1

      REAL dx(0:NDIM-1)

      REAL U0(CELL2dVECG(ifirst,ilast,ngc))
      REAL U1(CELL2dVECG(ifirst,ilast,ngc))
c
c     Input/Output.
c
      REAL stabdt
c
c     Local variables.
c
      INTEGER i0,i1,d
      REAL maxspeed(0:NDIM-1)
c
c     Determine the unit CFL number on the patch.
c
      do d = 0,NDIM-1
         maxspeed(d) = 1.0d-12   ! avoid division by zero
      enddo

      do i1 = ifirst1,ilast1
         do i0 = ifirst0,ilast0
            maxspeed(0) = dmax1(maxspeed(0), dabs(U0(i0,i1)))
         enddo
      enddo

      do i1 = ifirst1,ilast1
         do i0 = ifirst0,ilast0
            maxspeed(1) = dmax1(maxspeed(1), dabs(U1(i0,i1)))
         enddo
      enddo

      stabdt = dmin1((dx(0)/maxspeed(0)),(dx(1)/maxspeed(1)))
c
      return
      end
c
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
