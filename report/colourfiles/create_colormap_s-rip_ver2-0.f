CCC create_colormap_s-rip_ver2-0.f (revised, July 2017) 

CCC create_colormap.f (revised, January 2015) (R1/R2 and JRA-55/25 swapped) 
CCC create_colormap.f : colormap for DCL --- for the S-RIP colour scheme 


CCC 00-09: from the original colormap_01.x11 
CCC 11-29: for the S-RIP colour scheme (see below) 
CCC 50-60: for gray tones (50: black;  60: white) 
CCC all others: black 
CCC
C      r,g,b,c,m,y,k,RGB Hexadecimal,reanalysis
C 11:  226, 31, 38,  0,86.28,83.19,11.37,  E21F26,  MERRA-2
C 12:  246, 153, 153,  0,37.8,37.8,3.53,  F69999,  MERRA
C 13:  41, 95, 138,  70.29,31.16,0,45.88,  295F8A,  ERA-Interim
C 14:  95, 152, 198,  52.02,23.23,0,22.35,  5F98C6,  ERA5
C 15:  175, 203, 227,  22.91,10.57,0,10.98,  AFCBE3,  ERA-40
C 16:  114, 59, 122,  6.56,51.64,0,52.16,  723B7A,  JRA-55
C 17:  173, 113, 181,  4.42,37.57,0,29.02,  AD71B5,  JRA-55C or JRA-55 AMIP
C 18:  214, 184, 218,  1.83,15.6,0,14.51,  D6B8DA,  JRA-25
C 19:  245, 126, 32,  0,48.57,86.94,3.92,  F57E20,  NCEP-R1
C 20:  253, 191, 110,  0,24.51,56.52,0.78,  FDBF6E,  NCEP-R2
C 21:  236, 0, 140,  0,100,40.68,7.45,  EC008C,  20CRv2c
C 22:  247, 153, 209,  0,38.06,15.38,3.14,  F799D1,  20CRv2
C 23:  0, 174, 239,  100,27.2,0,6.27,  00AEEF,  CERA-20C
C 24:  96, 200, 232,  58.62,13.79,0,9.02,  60C8E8,  ERA-20C
C 25:  52, 160, 72,  67.5,0,55,37.25,  34A048,  CFSR
C 26:  179, 91, 40,  0,49.16,77.65,29.8,  B35B28,  REM
C 27:  255,215,0,  0,15.69,100,0,  FFD700,  Other
C 28:  0, 0, 0,  0,0,0,100,  000000,  Obs
C 29:  119, 119, 119,  0,0,0,53.33,  777777,  Other Obs
CCC 
CCC [fuji@dew s-rip_clr]$ cp colormap_01.x11.s-rip colormap_01.x11
CCC [fuji@dew s-rip_clr]$ dclclr & 

      PROGRAM CREATE 
      IMPLICIT NONE 

      CHARACTER INFL*50 
      PARAMETER (INFL='srip-color-scale_mf3.csv') 
      CHARACTER OUTFL*50 
      PARAMETER (OUTFL='colormap_01.x11.s-rip2') 

      CHARACTER HEADLINE*50, 
     &     C00*50, C01*50, C02*50, C03*50, C04*50, 
     &     C05*50, C06*50, C07*50, C08*50, C09*50 
      PARAMETER (HEADLINE='100: NO._OF_COLORS') 
      PARAMETER (C00=' 65535 65535 65535 : C00') 
      PARAMETER (C01='     0     0     0 : C01') 
      PARAMETER (C02=' 65535     0     0 : C02') 
      PARAMETER (C03='     0 65535     0 : C03') 
      PARAMETER (C04='     0     0 65535 : C04') 
      PARAMETER (C05=' 65535 65535     0 : C05') 
      PARAMETER (C06=' 56797 41120 56797 : C06') 
      PARAMETER (C07='     0     0 32896 : C07') 
      PARAMETER (C08=' 65535 49344 52171 : C08') 
      PARAMETER (C09='     0 65535 65535 : C09') 

      INTEGER M, I 
      PARAMETER (M=100) 
      REAL R(M),G(M),B(M) 
      INTEGER IR(M),IG(M),IB(M) 

CCC 
      REAL FACTOR 
      PARAMETER (FACTOR=65535./255.) 
      ! 0-65535 (0-255) for DCL (S-RIP CS) scale (256x256=65536) 

CCC
CCC
CCC 

      DO I=1,M 
         R(I)=0. 
         G(I)=0. 
         B(I)=0. 
      END DO 

CCC 

      OPEN(10,FILE=INFL,STATUS='OLD') 
      READ(10,*) 
      DO I=11,29 
         READ(10,*)R(I),G(I),B(I) 
         write(*,*)i,r(i),g(i),b(i) 
      END DO 

CCC 

      DO I=50,60 ! Gray tones (black to white) 
         R(I)=(REAL(I-50)/REAL(60-50))*255. 
         G(I)=R(I) 
         B(I)=R(I) 
      END DO 

CCC 

      DO I=1,M 
         R(I)=R(I)*FACTOR 
         G(I)=G(I)*FACTOR 
         B(I)=B(I)*FACTOR 
         IR(I)=INT(R(I)) 
         IG(I)=INT(G(I)) 
         IB(I)=INT(B(I)) 
      END DO 


CCC 
CCC 
CCC 
      OPEN(20,FILE=OUTFL,STATUS='NEW') 
      WRITE(20,'(A18)')HEADLINE 
      WRITE(20,'(A24)')C00
      WRITE(20,'(A24)')C01
      WRITE(20,'(A24)')C02
      WRITE(20,'(A24)')C03
      WRITE(20,'(A24)')C04
      WRITE(20,'(A24)')C05
      WRITE(20,'(A24)')C06
      WRITE(20,'(A24)')C07
      WRITE(20,'(A24)')C08
      WRITE(20,'(A24)')C09
      DO I=10,M-1 
         WRITE(20,'(X,I5,X,I5,X,I5,A4,I2.2)')
     &        IR(I),IG(I),IB(I),' : C',I 
      END DO 
      CLOSE(20) 

CCC 
      STOP 
      END 
