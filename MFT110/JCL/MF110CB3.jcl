//MFTR113 JOB ,                                                         JOB04372
// MSGCLASS=H,MSGLEVEL=(1,1),TIME=(,4),REGION=144M,COND=(16,LT),
// NOTIFY=MFTR110
//*THIS JCL USED TO COMPILE MF110CB3 COBOL PROGRAM
//P0000 EXEC PROC=ELAXFCOP,
//        DBRMDSN=MFTR110.DB2DBRM,
//        DBRMMEM=MF110CB3,
// PARM.COBPRE=('APOSTSQL,APOST,COBOL3,DATE,HOST(ASM|SQLPL),SQL(ALL)')
//COBPRE.SYSLIB DD DSN=MFTR110.SOURCE.COPYLIB,DISP=SHR
//COBPRE.SYSIN DD DISP=SHR,
//        DSN=MFTR110.SOURCE.COBOL(MF110CB3)
//STP0000 EXEC PROC=ELAXFCOC,
// CICS=,
// DB2=,
// COMP=
//COBOL.SYSDEBUG DD DISP=SHR,
//        DSN=MFTR110.COBOL.SYSDEBUG(MF110CB3)
//COBOL.SYSLIN DD DISP=SHR,
//        DSN=MFTR110.COBOBJS.OBJ(MF110CB3)
//COBOL.SYSLIB DD DISP=SHR,
//        DSN=MFTR110.SOURCE.COPYLIB
//COBOL.SYSXMLSD DD DUMMY
//COBOL.SYSIN DD DISP=(OLD,DELETE),
//        DSN=&&DSNHOUT
//*
//******* ADDITIONAL JCL FOR COMPILE HERE ******
//LKED EXEC PROC=ELAXFLNK
//LINK.SYSLIB DD DSN=MFTR110.COBOBJS.OBJ,
//        DISP=SHR
//        DD DSN=CEE.SCEELKED,
//        DISP=SHR
//        DD DSN=DFH540.CICS.SDFHLOAD,
//        DISP=SHR
//        DD DSN=DSNB10.SDSNLOAD,
//        DISP=SHR
//LINK.OBJ0000 DD DISP=SHR,
//        DSN=MFTR110.COBOBJS.OBJ(MF110CB3)
//LINK.SYSLIN DD *
     INCLUDE OBJ0000
/*
//LINK.SYSLMOD   DD  DISP=SHR,
//        DSN=ASHISSA.ZDEVOPS.LOADLIB(MF110CB3)
//*
//******* ADDITIONAL JCL FOR LINK HERE ******
//BIND EXEC PGM=IKJEFT01
//SYSPRINT DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//DBRMLIB  DD  DSN=MFTR110.DB2DBRM,DISP=SHR
//STEPLIB DD DSN=DSNB10.SDSNLOAD,DISP=SHR
//*UNCOMMENT AND TAILOR THE FOLLOWING CODE IF YOUR SYSTSIN STATEMENT**
//*CONTAINS BIND INSTRUCTIONS:
//SYSTSIN DD *
     DSN SYSTEM(DBCG)
     BIND PACKAGE(DALLASC.MFTR110) -
     OWNER (MFTR110) -
     MEMBER(MF110CB3) -
     LIBRARY('MFTR110.DB2DBRM') -
     ACTION(REP) -
     VALIDATE(BIND)
     BIND PLAN(MF110CB3) -
     PKLIST(DALLASC.MFTR110.*)
     END
//* OR
//*UNCOMMENT AND TAILOR THE FOLLOWING CODE IF YOUR SYSTSIN STATEMENT**
//*POINTS TO A DATA SET CONTAINING BIND INSTRUCTIONS
//*//SYSTSIN DD DSN=USERID.BIND(MEMBER),DISP=SHR
//*
/*