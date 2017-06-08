MODULE Xenon1T_2017

!=======================================================================
! Xenon1T 2017 ANALYSIS ROUTINES
! Based upon arXiv:1705.06655.  
!=======================================================================

USE DDTypes
USE DDDetectors

IMPLICIT NONE

CONTAINS


!-----------------------------------------------------------------------
! Initializes a DetectorStruct to the Xenon1T 2017 analysis.
! 
FUNCTION Xenon1T_2017_Init(intervals) RESULT(D)

  IMPLICIT NONE
  TYPE(DetectorStruct) :: D
  LOGICAL, INTENT(IN) :: intervals
  INTEGER, PARAMETER :: NE = 101
  INTEGER, PARAMETER :: NEFF = 1
  REAL*8, PARAMETER :: EMIN = 1.5d0
  ! Efficiency curves energy tabulation points
  REAL*8, PARAMETER :: E(NE)                                            &
      =       (/ 1.5d0,     1.55353d0, 1.60897d0, 1.66639d0, 1.72586d0, &
      1.78746d0, 1.85125d0, 1.91731d0, 1.98574d0, 2.0566d0,  2.13d0,    &
      2.20601d0, 2.28474d0, 2.36628d0, 2.45072d0, 2.53818d0, 2.62877d0, &
      2.72258d0, 2.81974d0, 2.92037d0, 3.02459d0, 3.13253d0, 3.24433d0, &
      3.36011d0, 3.48002d0, 3.60422d0, 3.73284d0, 3.86606d0, 4.00403d0, &
      4.14692d0, 4.29492d0, 4.44819d0, 4.60694d0, 4.77135d0, 4.94163d0, &
      5.11798d0, 5.30063d0, 5.4898d0,  5.68572d0, 5.88863d0, 6.09878d0, &
      6.31643d0, 6.54185d0, 6.77531d0, 7.0171d0,  7.26753d0, 7.52689d0, &
      7.79551d0, 8.07371d0, 8.36184d0, 8.66025d0, 8.96932d0, 9.28941d0, &
      9.62093d0, 9.96428d0, 10.3199d0, 10.6882d0, 11.0696d0, 11.4647d0, &
      11.8738d0, 12.2975d0, 12.7364d0, 13.191d0,  13.6617d0, 14.1493d0, &
      14.6542d0, 15.1772d0, 15.7188d0, 16.2798d0, 16.8608d0, 17.4625d0, &
      18.0857d0, 18.7311d0, 19.3996d0, 20.0919d0, 20.809d0,  21.5516d0, &
      22.3207d0, 23.1173d0, 23.9423d0, 24.7967d0, 25.6817d0, 26.5982d0, &
      27.5474d0, 28.5305d0, 29.5487d0, 30.6032d0, 31.6954d0, 32.8265d0, &
      33.998d0,  35.2113d0, 36.4679d0, 37.7694d0, 39.1173d0, 40.5133d0, &
      41.9591d0, 43.4565d0, 45.0074d0, 46.6136d0, 48.2771d0, 50.d0 /)
  ! LOWER 50% NR BAND >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ! Efficiency (total)
  REAL*8, PARAMETER :: EFF0(NE)                                         &
      =       (/ 0.00282d0, 0.00332d0, 0.00393d0, 0.00468d0, 0.00561d0, &
      0.00676d0, 0.00820d0, 0.01002d0, 0.01234d0, 0.01530d0, 0.01911d0, &
      0.02407d0, 0.03057d0, 0.03915d0, 0.05059d0, 0.06300d0, 0.07433d0, &
      0.08822d0, 0.10535d0, 0.12660d0, 0.14983d0, 0.16580d0, 0.18413d0, &
      0.20525d0, 0.22969d0, 0.25070d0, 0.27290d0, 0.29798d0, 0.32586d0, &
      0.33837d0, 0.35184d0, 0.36636d0, 0.37548d0, 0.38184d0, 0.38855d0, &
      0.38886d0, 0.38575d0, 0.38255d0, 0.37691d0, 0.37102d0, 0.36388d0, &
      0.35532d0, 0.34829d0, 0.34846d0, 0.34829d0, 0.34352d0, 0.33895d0, &
      0.33694d0, 0.33850d0, 0.35081d0, 0.36779d0, 0.38980d0, 0.39747d0, &
      0.40780d0, 0.42637d0, 0.43564d0, 0.44277d0, 0.44735d0, 0.44509d0, &
      0.43989d0, 0.43820d0, 0.43413d0, 0.42996d0, 0.43134d0, 0.43642d0, &
      0.44454d0, 0.44410d0, 0.44471d0, 0.45266d0, 0.45550d0, 0.45655d0, &
      0.45251d0, 0.43798d0, 0.42712d0, 0.42893d0, 0.41773d0, 0.41291d0, &
      0.41587d0, 0.42159d0, 0.42712d0, 0.42874d0, 0.42186d0, 0.41342d0, &
      0.41568d0, 0.42180d0, 0.41894d0, 0.41573d0, 0.40397d0, 0.39158d0, &
      0.35895d0, 0.30764d0, 0.25281d0, 0.18872d0, 0.13198d0, 0.08680d0, &
      0.04785d0, 0.02016d0, 0.00696d0, 0.00216d0, 0.00032d0, 0.0d0 /)
  ! Efficiency (first and only interval)
  REAL*8, PARAMETER :: EFF1(NE) = EFF0
  ! Efficiencies array (2D)
  REAL*8, PARAMETER :: EFF(NE,0:NEFF)                                   &
      = RESHAPE( (/ EFF0(:), EFF1(:) /) ,SHAPE(EFF))

  CALL SetDetector(D,mass=1042.0d0,time=34.2d0,Nevents=0,               &
                   background=0.36d0,Nelem=1,Zelem=(/54/),              &
                   NEeff=NE,Eeff=E,Neff=NEFF,eff=EFF,                   &
                   intervals=intervals,Emin=EMIN)
  D%eff_file = '[Xenon1T 2017]'
  
END FUNCTION


! C++ interface wrapper
INTEGER(KIND=C_INT) FUNCTION C_Xenon1T_2017_Init(intervals) &
 BIND(C,NAME='C_DDCalc_xenon1t_2017_init') 
  USE ISO_C_BINDING, only: C_BOOL, C_INT
  IMPLICIT NONE
  LOGICAL(KIND=C_BOOL), INTENT(IN) :: intervals
  N_Detectors = N_Detectors + 1
  ALLOCATE(Detectors(N_Detectors)%p)
  Detectors(N_Detectors)%p = Xenon1T_2017_Init(LOGICAL(intervals))
  C_Xenon1T_2017_Init = N_Detectors
END FUNCTION


END MODULE
