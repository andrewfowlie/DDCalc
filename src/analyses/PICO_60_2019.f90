MODULE PICO_60_2019

!=======================================================================
! PICO_60_2019 ANALYSIS ROUTINES
! Based upon arXiv:1902.04031.  
!=======================================================================

USE DDTypes
USE DDDetectors

IMPLICIT NONE

CONTAINS


!-----------------------------------------------------------------------
! Initializes a DetectorStruct to the PICO_60_2019 analysis.
!
FUNCTION PICO_60_2019_Init() RESULT(D)

  IMPLICIT NONE
  TYPE(DetectorStruct) :: D
  INTEGER, PARAMETER :: NE = 101
  INTEGER, PARAMETER :: NBINS = 0
  REAL*8, PARAMETER :: EMIN = 3.0d0
  INTEGER, PARAMETER :: NELEM = 2
  ! Efficiency curves energy tabulation points
  REAL*8, PARAMETER :: E(NE)                                            &
      =       (/ 3.16228d0, 3.27341d0, 3.38844d0, 3.50752d0, 3.63078d0, &
3.75837d0, 3.89045d0, 4.02717d0, 4.16869d0, 4.31519d0, 4.46684d0, &
4.62381d0, 4.7863d0, 4.9545d0, 5.12861d0, 5.30884d0, 5.49541d0, &
5.68853d0, 5.88844d0, 6.09537d0, 6.30957d0, 6.53131d0, 6.76083d0, &
6.99842d0, 7.24436d0, 7.49894d0, 7.76247d0, 8.03526d0, 8.31764d0, &
8.60994d0, 8.91251d0, 9.22571d0, 9.54993d0, 9.88553d0, 10.2329d0, &
10.5925d0, 10.9648d0, 11.3501d0, 11.749d0, 12.1619d0, 12.5893d0, &
13.0317d0, 13.4896d0, 13.9637d0, 14.4544d0, 14.9624d0, 15.4882d0, &
16.0325d0, 16.5959d0, 17.1791d0, 17.7828d0, 18.4077d0, 19.0546d0, &
19.7242d0, 20.4174d0, 21.1349d0, 21.8776d0, 22.6464d0, 23.4423d0, &
24.2661d0, 25.1189d0, 26.0016d0, 26.9154d0, 27.8612d0, 28.8403d0, &
29.8538d0, 30.903d0, 31.989d0, 33.1131d0, 34.2768d0, 35.4813d0, &
36.7282d0, 38.0189d0, 39.355d0, 40.738d0, 42.1697d0, 43.6516d0, &
45.1856d0, 46.7735d0, 48.4172d0, 50.1187d0, 51.88d0, 53.7032d0, &
55.5904d0, 57.544d0, 59.5662d0, 61.6595d0, 63.8264d0, 66.0693d0, &
68.3912d0, 70.7946d0, 73.2825d0, 75.8578d0, 78.5236d0, 81.2831d0, &
84.1395d0, 87.0964d0, 90.1571d0, 93.3254d0, 96.6051d0, 100.d0 /)
  ! The efficiency is obtained by convoluting the (time-dependent) energy
  ! threshold with the efficiency given for 13.6 keV.
  ! Efficiency (total)
  REAL*8, PARAMETER :: EFF_F(NE)                                        &
      =       (/ 0.d0, 0.d0, 0.d0, 0.d0, 0.05856d0, &
0.35036d0, 0.61399d0, 0.71881d0, 0.77991d0, 0.81294d0, 0.82965d0, &
0.84695d0, 0.86485d0, 0.88328d0, 0.90171d0, 0.92142d0, 0.94192d0, &
0.96316d0, 0.98766d0, 0.99208d0, 0.9921d0, 0.99212d0, 0.99214d0, &
0.99216d0, 0.99218d0, 0.9922d0, 0.99222d0, 0.99224d0, 0.99227d0, &
0.99229d0, 0.99232d0, 0.99234d0, 0.99237d0, 0.9924d0, 0.99243d0, &
0.99246d0, 0.99249d0, 0.99252d0, 0.99256d0, 0.99259d0, 0.99263d0, &
0.99267d0, 0.9927d0, 0.99274d0, 0.99279d0, 0.99283d0, 0.99287d0, &
0.99292d0, 0.99297d0, 0.99302d0, 0.99307d0, 0.99312d0, 0.99317d0, &
0.99323d0, 0.99329d0, 0.99335d0, 0.99341d0, 0.99348d0, 0.99354d0, &
0.99361d0, 0.99369d0, 0.99376d0, 0.99384d0, 0.99392d0, 0.994d0, &
0.99408d0, 0.99417d0, 0.99426d0, 0.99436d0, 0.99446d0, 0.99456d0, &
0.99466d0, 0.99477d0, 0.99489d0, 0.995d0, 0.99512d0, 0.99525d0, &
0.99538d0, 0.99551d0, 0.99565d0, 0.99579d0, 0.99594d0, 0.9961d0, &
0.99625d0, 0.99642d0, 0.99659d0, 0.99677d0, 0.99695d0, 0.99714d0, &
0.99733d0, 0.99754d0, 0.99775d0, 0.99796d0, 0.99819d0, 0.99842d0, &
0.99866d0, 0.99891d0, 0.99917d0, 0.99944d0, 0.99971d0, 1.d0 /)
  REAL*8, PARAMETER :: EFF_C(NE)                                        &
      =       (/ 0.d0, 0.d0, 0.d0, 0.d0, 0.d0, &
0.d0, 0.d0, 0.d0, 0.d0, 0.d0, 0.d0, &
0.d0, 0.d0, 0.d0, 0.d0, 0.d0, 0.d0, &
0.d0, 0.d0, 0.d0, 0.d0, 0.11028d0, 0.12084d0, &
0.13177d0, 0.2335d0, 0.25317d0, 0.27353d0, 0.2946d0, 0.31651d0, &
0.34223d0, 0.36929d0, 0.39483d0, 0.42094d0, 0.4503d0, 0.48361d0, &
0.5339d0, 0.59394d0, 0.66712d0, 0.72599d0, 0.77469d0, 0.82771d0, &
0.88417d0, 0.93728d0, 0.99301d0, 0.99305d0, 0.99309d0, 0.99313d0, &
0.99318d0, 0.99322d0, 0.99327d0, 0.99332d0, 0.99337d0, 0.99342d0, &
0.99348d0, 0.99353d0, 0.99359d0, 0.99365d0, 0.99372d0, 0.99378d0, &
0.99385d0, 0.99392d0, 0.99399d0, 0.99406d0, 0.99414d0, 0.99422d0, &
0.9943d0, 0.99439d0, 0.99447d0, 0.99457d0, 0.99466d0, 0.99476d0, &
0.99486d0, 0.99496d0, 0.99507d0, 0.99519d0, 0.9953d0, 0.99542d0, &
0.99555d0, 0.99568d0, 0.99581d0, 0.99595d0, 0.99609d0, 0.99624d0, &
0.99639d0, 0.99655d0, 0.99672d0, 0.99689d0, 0.99706d0, 0.99724d0, &
0.99743d0, 0.99763d0, 0.99783d0, 0.99804d0, 0.99826d0, 0.99848d0, &
0.99871d0, 0.99895d0, 0.9992d0, 0.99946d0, 0.99972d0, 1.d0 /)

  ! Efficiencies array (2D)
  REAL*8 :: EFF(NELEM,NE,0:NBINS)                        

  EFF(1,:,0:) = RESHAPE( (/ EFF_C(:) /), SHAPE(EFF(1,:,0:)) )
  EFF(2,:,0:) = RESHAPE( (/ EFF_F(:) /), SHAPE(EFF(2,:,0:)) )

  CALL SetDetector(D,mass=48.9d0,time=52.6d0,Nevents_tot=3,              &
                   Backgr_tot=0.0d0,Nelem=NELEM,                         &
                   Zelem=(/6,9/),stoich=(/3,8/),                         &
                   NE=NE,E=E,Nbins=NBINS,eff=EFF,                        &
                   Emin=EMIN)
  D%eff_file = '[PICO_60_2019]'
  
END FUNCTION


! C++ interface wrapper
INTEGER(KIND=C_INT) FUNCTION C_PICO_60_2019_Init() &
 BIND(C,NAME='C_DDCalc_pico_60_2019_init') 
  USE ISO_C_BINDING, only: C_BOOL, C_INT
  IMPLICIT NONE
  N_Detectors = N_Detectors + 1
  ALLOCATE(Detectors(N_Detectors)%p)
  Detectors(N_Detectors)%p = PICO_60_2019_Init()
  C_PICO_60_2019_Init = N_Detectors
END FUNCTION


END MODULE
